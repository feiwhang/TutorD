from flask import Flask, jsonify, request
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash

from db import db, Course
from db import Student, Tutor, Admin
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
        new_user = Student(email=email, password=hashed_password, first_name=first_name, last_name=last_name)
    elif role == Role.TUTOR.value:
        new_user = Tutor(email=email, password=hashed_password, first_name=first_name, last_name=last_name)
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
        return jsonify({'message': 'Internal server error'}), 500  # Internal Server Error


@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    user_types = [(Student, Role.STUDENT), (Tutor, Role.TUTOR), (Admin, Role.ADMIN)]

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
    tutors = Tutor.query.filter(Tutor.first_name.ilike(f'%{search_term}%') | Tutor.last_name.ilike(f'%{search_term}%')).all()

    return jsonify([tutor.serialize() for tutor in tutors])


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
