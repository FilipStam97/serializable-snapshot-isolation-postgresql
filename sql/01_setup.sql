DROP TABLE IF EXISTS doctors;

CREATE TABLE doctors (
    id INT PRIMARY KEY,
    name TEXT NOT NULL,
    on_call BOOLEAN NOT NULL
);

INSERT INTO doctors (id, name, on_call) VALUES
(1, 'Ana', TRUE),
(2, 'Marko', TRUE);

SELECT * FROM doctors ORDER BY id;


