from flask import Flask, jsonify, request
from flask_cors import CORS
from werkzeug.security import generate_password_hash

from db import db, Course
from db import Student, Tutor
from enums import Role

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://root:iccsroot@db/tutord"
CORS(app, origins=['http://localhost:8000'])

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
        return jsonify({'message': 'Email already in use'}), 400

    if role == Role.STUDENT.value:
        new_user = Student(email=email, password=hashed_password, first_name=first_name, last_name=last_name)
    elif role == Role.TUTOR.value:
        new_user = Tutor(email=email, password=hashed_password, first_name=first_name, last_name=last_name)
    else:
        return jsonify({'message': 'Invalid role'}), 400

    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message': 'Registered successfully'}), 201


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
