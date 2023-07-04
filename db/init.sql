USE tutord;

CREATE TABLE student (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tutor (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE course (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tutor_course (
    tutor_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (TutorID, CourseID),
    FOREIGN KEY (TutorID) REFERENCES tutor(id),
    FOREIGN KEY (CourseID) REFERENCES course(id)
);

INSERT INTO student(name, email) VALUES
    ('John Doe', 'john.doe@email.com'), 
    ('Jane Smith', 'jane.smith@email.com'),
    ('Michael Johnson', 'michael.johnson@email.com'),
    ('Emma Watson', 'emma.watson@email.com'),
    ('Oliver Jackson', 'oliver.jackson@email.com'),
    ('Sophia Evans', 'sophia.evans@email.com'),
    ('George Thompson', 'george.thompson@email.com'),
    ('Isabella Wilson', 'isabella.wilson@email.com'),
    ('Harry Taylor', 'harry.taylor@email.com'),
    ('Grace Brown', 'grace.brown@email.com'),
    ('Noah Davis', 'noah.davis@email.com'),
    ('Emily Miller', 'emily.miller@email.com'),
    ('Charlie Moore', 'charlie.moore@email.com'),
    ('Mia Thomas', 'mia.thomas@email.com'),
    ('Alfie Martin', 'alfie.martin@email.com'),
    ('Jessica Hall', 'jessica.hall@email.com'),
    ('Freddie Adams', 'freddie.adams@email.com'),
    ('Scarlett Baker', 'scarlett.baker@email.com'),
    ('Henry Clarke', 'henry.clarke@email.com'),
    ('Ella Wright', 'ella.wright@email.com');


INSERT INTO tutor(name, email) VALUES
    ('Dr. Alan Grant', 'alan.grant@email.com'),
    ('Dr. Ellie Sattler', 'ellie.sattler@email.com'),
    ('Dr. Ian Malcolm', 'ian.malcolm@email.com'),
    ('Prof. John Hammond', 'john.hammond@email.com'),
    ('Dr. Sarah Harding', 'sarah.harding@email.com'),
    ('Prof. Benjamin Lockwood', 'benjamin.lockwood@email.com'),
    ('Dr. Robert Burke', 'robert.burke@email.com'),
    ('Prof. Laura Sorkin', 'laura.sorkin@email.com'),
    ('Dr. Gerry Harding', 'gerry.harding@email.com'),
    ('Prof. Lewis Dodgson', 'lewis.dodgson@email.com');


INSERT INTO course(name) VALUES
    ('Introduction to Programming'),
    ('Data Structures and Algorithms'),
    ('Computer Networks'),
    ('Artificial Intelligence'),
    ('Database Systems'),
    ('Web Development'),
    ('Machine Learning'),
    ('Operating Systems'),
    ('Cyber Security'),
    ('Software Engineering');


INSERT INTO tutor_course(TutorID, CourseID) VALUES
    (1, 1), 
    (1, 2), 
    (2, 1), 
    (2, 3),
    (3, 2), 
    (3, 3), 
    (3, 4), 
    (4, 5),
    (5, 6), 
    (5, 7), 
    (6, 8), 
    (7, 9),
    (8, 10), 
    (9, 10), 
    (10, 1), 
    (10, 4);