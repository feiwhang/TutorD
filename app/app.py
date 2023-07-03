from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://root:iccsroot@db/tutord"

db = SQLAlchemy(app)


class Student(db.Model):
    __tablename__ = 'student'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(255), nullable=False)


@app.route('/')
def index():
    students = Student.query.all()
    return '<br>'.join([f'{student.id}: {student.name} ({student.email})' for student in students])


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
