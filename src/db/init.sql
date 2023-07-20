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

CREATE TABLE admin (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(128) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tutor_course (
    id INT NOT NULL AUTO_INCREMENT,
    tutor_id INT NOT NULL,
    course_id INT NOT NULL,
    verification_status ENUM('unverified', 'pending', 'verified') NOT NULL,
    verified_by INT,
    PRIMARY KEY (id),
    FOREIGN KEY (tutor_id) REFERENCES tutor(id),
    FOREIGN KEY (course_id) REFERENCES course(id),
    FOREIGN KEY (verified_by) REFERENCES admin(id)
);

INSERT INTO student (first_name, last_name, email, password) VALUES
('James', 'Smith', 'james.smith@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Emma', 'Johnson', 'emma.johnson@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Ethan', 'Williams', 'ethan.williams@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92');

INSERT INTO tutor (first_name, last_name, email, password) VALUES
('Olivia', 'Brown', 'olivia.brown@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Liam', 'Miller', 'liam.miller@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Sophia', 'Davis', 'sophia.davis@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Mason', 'Garcia', 'mason.garcia@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Ava', 'Rodriguez', 'ava.rodriguez@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Noah', 'Wilson', 'noah.wilson@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Isabella', 'Martinez', 'isabella.martinez@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Lucas', 'Anderson', 'lucas.anderson@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Mia', 'Thomas', 'mia.thomas@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92'),
('Benjamin', 'Jackson', 'benjamin.jackson@email.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92');

INSERT INTO admin (first_name, last_name, email, password) VALUES
('Admin', '', 'admin@tutord.com', 'pbkdf2:sha256:600000$npLqHjrAENetexlN$621551cc2e7b3cecb888ce6dd733f2ab7e3ded0bd6a284255508ba3a68cf9f92');

INSERT INTO course (name) VALUES
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

INSERT INTO tutor_course (tutor_id, course_id, verification_status, verified_by) VALUES
    (1, 1, 'verified', 1),
    (1, 2, 'unverified', NULL),
    (1, 3, 'pending', NULL),
    (2, 2, 'verified', 1),
    (2, 3, 'verified', 1),
    (2, 4, 'unverified', NULL),
    (3, 1, 'pending', NULL),
    (3, 5, 'verified', 1),
    (3, 6, 'unverified', NULL),
    (4, 3, 'verified', 1),
    (4, 7, 'pending', NULL),
    (4, 8, 'verified', 1),
    (5, 4, 'verified', 1),
    (5, 9, 'unverified', NULL),
    (5, 10, 'verified', 1),
    (6, 5, 'verified', 1),
    (6, 6, 'pending', NULL),
    (6, 11, 'unverified', NULL),
    (7, 6, 'verified', 1),
    (7, 12, 'unverified', NULL),
    (7, 13, 'pending', NULL),
    (8, 7, 'verified', 1),
    (8, 14, 'pending', NULL),
    (8, 15, 'verified', 1),
    (9, 8, 'verified', 1),
    (9, 16, 'unverified', NULL),
    (9, 17, 'pending', NULL),
    (10, 9, 'verified', 1),
    (10, 18, 'verified', 1),
    (10, 19, 'unverified', NULL);
