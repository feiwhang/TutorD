from flask import Flask, jsonify
from db import db, Course

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://root:iccsroot@db/tutord"

db.init_app(app)

@app.route('/api/courses')
def get_courses():
    courses = Course.query.all()
    return jsonify([course.serialize() for course in courses])


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
