from flask import Flask
from db import db, Student, Tutor

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://root:iccsroot@db/tutord"

db.init_app(app)


@app.route('/')
def index():
    students = Student.query.all()
    tutors = Tutor.query.all()
    return '<br>'.join([f'{student.id}: {student.first_name} {student.last_name} ({student.email})' for student in students] + [f'{tutor.id}: {tutor.first_name} {tutor.last_name} ({tutor.email})' for tutor in tutors])


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
