use tutord;

CREATE TABLE student (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO student(name, email) VALUES
    ('John Doe', 'john.doe@email.com'), 
    ('Jane Doe', 'jane.doe@email.com');
