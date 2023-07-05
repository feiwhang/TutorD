USE tutord;

DROP TABLE IF EXISTS tutor_course;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS tutor;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS admin;

CREATE TABLE student (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(128) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tutor (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(128) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE course (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE favourite (
    id INT NOT NULL AUTO_INCREMENT,
    student_id INT NOT NULL,
    tutor_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (tutor_id) REFERENCES tutor(id)
);

CREATE TABLE tutor_course (
    id INT NOT NULL AUTO_INCREMENT,
    tutor_id INT NOT NULL,
    course_id INT NOT NULL,
    verification_status ENUM('Unverified', 'Awaiting', 'Verified') NOT NULL,
    verified_by INT,
    PRIMARY KEY (id),
    FOREIGN KEY (tutor_id) REFERENCES tutor(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE admin (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(128) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO course(name) VALUES
    ('Thai Language'),
    ('English Language'),
    ('Mandarin Chinese'),
    ('Japanese Language'),
    ('Korean Language'),
    ('French Language'),
    ('German Language'),
    ('Spanish Language'),
    ('Italian Language'),
    ('Russian Language'),
    ('Mathematics'),
    ('Advanced Mathematics'),
    ('Physics'),
    ('Chemistry'),
    ('Biology'),
    ('Science'),
    ('Computer Science'),
    ('Information Technology'),
    ('Economics'),
    ('Business Studies'),
    ('Accounting'),
    ('Finance'),
    ('Marketing'),
    ('Management'),
    ('Human Resource Management'),
    ('Art'),
    ('Music'),
    ('Dance'),
    ('Drama'),
    ('History'),
    ('Geography'),
    ('Social Studies'),
    ('Psychology'),
    ('Sociology'),
    ('Political Science'),
    ('Philosophy'),
    ('Literature'),
    ('Creative Writing'),
    ('Journalism'),
    ('Media Studies'),
    ('Environmental Studies'),
    ('Health and Physical Education'),
    ('Home Economics'),
    ('Religious Studies'),
    ('Tourism and Hospitality'),
    ('Engineering'),
    ('Medical Studies'),
    ('Law');