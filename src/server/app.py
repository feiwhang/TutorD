from flask import Flask, jsonify, request
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash

from enums import VerificationStatus

from db import db, Course
from db import Student, Tutor, Admin, TutorCourse, Favourite
from enums import Role

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://root:iccsroot@db/tutord"

CORS(app, origins=['http://localhost:8000'])
app.config['CORS_HEADERS'] = 'Content-Type'

db.init_app(app)


@app.route('/api/courses')
def get_courses():
    courses = Course.query.all()
    return jsonify([course.serialize() for course in courses])


@app.route('/api/register', methods=['POST'])
def register():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')
    first_name = data.get('first_name')
    last_name = data.get('last_name')
    role = data.get('role')

    # hash the password for security
    hashed_password = generate_password_hash(password)

    # check if the email is already taken
    if Student.query.filter_by(email=email).first() is not None or Tutor.query.filter_by(email=email).first() is not None:
        return jsonify({'message': 'Email already in use'}), 409  # Conflict

    if role == Role.STUDENT.value:
        new_user = Student(email=email, password=hashed_password,
                           first_name=first_name, last_name=last_name)
    elif role == Role.TUTOR.value:
        new_user = Tutor(email=email, password=hashed_password,
                         first_name=first_name, last_name=last_name)
    else:
        return jsonify({'message': 'Invalid role'}), 400  # Bad Request

    try:
        db.session.add(new_user)
        db.session.commit()

        # Returns user data on successful registration
        return jsonify({
            'message': 'Registered successfully',
            'user': {
                'id': new_user.id,
                'first_name': new_user.first_name,
                'last_name': new_user.last_name,
                'email': new_user.email,
                'role': role
            }
        }), 201  # Created
    except:
        # Internal Server Error
        return jsonify({'message': 'Internal server error'}), 500


@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    user_types = [(Student, Role.STUDENT),
                  (Tutor, Role.TUTOR), (Admin, Role.ADMIN)]

    for user_model, role in user_types:
        user = user_model.query.filter_by(email=email).first()
        if user and check_password_hash(user.password, password):
            user_data = user.serialize()
            user_data.update({'role': role.value})
            return jsonify({
                'message': 'Logged in successfully',
                'user': user_data
            }), 200

    return jsonify({'message': 'Invalid email or password'}), 401


@app.route('/api/search', methods=['GET'])
def search():
    search_term = request.args.get('q')
    if not search_term:
        return jsonify({"error": "Missing search term"}), 400

    # Using ILIKE for case-insensitive search
    tutors = Tutor.query.filter(Tutor.first_name.ilike(
        f'%{search_term}%') | Tutor.last_name.ilike(f'%{search_term}%')).all()

    return jsonify([tutor.serialize() for tutor in tutors])


@app.route('/api/tutors/<int:tutor_id>/courses', methods=['GET'])
def get_tutor_courses(tutor_id):
    tutor_courses = (
        db.session.query(Course, TutorCourse.verification_status)
        .join(TutorCourse, Course.id == TutorCourse.course_id)
        .filter(TutorCourse.tutor_id == tutor_id)
        .all()
    )

    return jsonify([
        {
            **course.serialize(),
            'verification_status': status
        }
        for course, status in tutor_courses
    ])


@app.route('/api/students/<int:student_id>/favourites', methods=['GET'])
def get_favorites(student_id):
    favorites = Favourite.query.filter_by(student_id=student_id).all()
    favorite_tutors = [favorite.tutor_id for favorite in favorites]
    return jsonify(favorite_tutors)


@app.route('/api/students/<int:student_id>/favourites/detail', methods=['GET'])
def get_favorites_detail(student_id):
    favorite_tutors_ids = [favorite.tutor_id for favorite in Favourite.query.filter_by(
        student_id=student_id).all()]
    favorite_tutors = [tutor.serialize() for tutor in Tutor.query.filter(
        Tutor.id.in_(favorite_tutors_ids)).all()]
    return jsonify(favorite_tutors)


@app.route('/api/students/<int:student_id>/favourites', methods=['POST'])
def toggle_favourite(student_id):
    # Get the tutor_id from the request body
    tutor_id = request.json.get('tutor_id')
    if not tutor_id:
        return jsonify({"error": "Missing tutor_id in request body"}), 400

    # Find the student and tutor in the database
    student = Student.query.get(student_id)
    tutor = Tutor.query.get(tutor_id)
    if not student or not tutor:
        return jsonify({"error": "Student or tutor not found"}), 404

    # Check if the tutor is already a favourite
    favourite = Favourite.query.filter_by(
        student_id=student_id, tutor_id=tutor_id).first()
    if favourite:
        # If the tutor is already a favourite, remove them from favourites
        db.session.delete(favourite)
        action = "removed from"
    else:
        # Otherwise, add the tutor to the student's favourites
        new_favourite = Favourite(student_id=student_id, tutor_id=tutor_id)
        db.session.add(new_favourite)
        action = "added to"

    db.session.commit()

    return jsonify({"message": f"Tutor {action} favourites"}), 200


@app.route('/api/courses/<int:course_id>/tutors', methods=['GET'])
def get_course_tutors(course_id):
    tutors = db.session.query(Tutor).\
        join(TutorCourse, Tutor.id == TutorCourse.tutor_id).\
        filter(TutorCourse.course_id == course_id).all()

    return jsonify([tutor.serialize() for tutor in tutors])


@app.route('/api/tutors/<int:tutor_id>/courses', methods=['POST'])
def offer_course(tutor_id):
    course_id = request.json.get('course_id')
    if not course_id:
        return jsonify({"error": "Missing course_id in request body"}), 400

    # Ensure the tutor and course exist in the database
    tutor = Tutor.query.get(tutor_id)
    course = Course.query.get(course_id)
    if not tutor or not course:
        return jsonify({"error": "Tutor or course not found"}), 404

    # Check if the tutor is already offering the course
    tutor_course = TutorCourse.query.filter_by(
        tutor_id=tutor_id, course_id=course_id).first()
    if tutor_course:
        return jsonify({"error": "Tutor is already offering this course"}), 400

    # Create a new TutorCourse entry
    new_tutor_course = TutorCourse(
        tutor_id=tutor_id, course_id=course_id, verification_status=VerificationStatus.PENDING.value)
    db.session.add(new_tutor_course)
    db.session.commit()

    return jsonify({"message": "Course has been added for verification"}), 200


@app.route('/api/tutors/<int:tutor_id>/courses/<int:course_id>', methods=['DELETE'])
def remove_course(tutor_id, course_id):
    # Find the tutor_course record in the database
    tutor_course = TutorCourse.query.filter_by(
        tutor_id=tutor_id, course_id=course_id).first()

    if not tutor_course:
        return jsonify({"error": "Course not found for this tutor"}), 404

    # Remove the record from the database
    db.session.delete(tutor_course)
    db.session.commit()

    return jsonify({"message": "Course removed successfully"}), 200


@app.route('/api/admin/<int:admin_id>/tutors/<int:tutor_id>/courses/<int:course_id>', methods=['PUT'])
def verify_course(admin_id, tutor_id, course_id):
    # Ensure the user is an admin
    admin = Admin.query.get(admin_id)
    if not admin:
        return jsonify({"error": "Only admins can verify courses"}), 403

    # Get the status from the request body
    status = request.json.get('status')
    if status not in [status.value for status in VerificationStatus]:
        return jsonify({"error": "Invalid status"}), 400

    # Find the tutor_course record in the database
    tutor_course = TutorCourse.query.filter_by(
        tutor_id=tutor_id, course_id=course_id).first()
    if not tutor_course:
        return jsonify({"error": "Course not found for this tutor"}), 404

    # Update the record
    tutor_course.verification_status = VerificationStatus(status).value
    tutor_course.verified_by = admin_id
    db.session.commit()

    return jsonify({"message": "Course verification status updated successfully"}), 200


@app.route('/api/admin/tutors/courses', methods=['GET'])
def get_all_tutor_courses():
    tutor_courses = TutorCourse.query.all()
    serialized_data = []
    for tutor_course in tutor_courses:
        tutor = Tutor.query.get(tutor_course.tutor_id)
        course = Course.query.get(tutor_course.course_id)
        serialized_data.append({
            'tutor_id': tutor.id,
            'tutor_name': f"{tutor.first_name} {tutor.last_name}",
            'tutor_email': tutor.email,
            'course_id': course.id,
            'course_name': course.name,
            'verification_status': tutor_course.verification_status,
            'verified_by': tutor_course.verified_by
        })
    return jsonify(serialized_data), 200


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
