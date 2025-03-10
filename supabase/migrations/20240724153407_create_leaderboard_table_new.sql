CREATE TABLE leaderboard
(
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(255) NOT NULL,
    number        INTEGER      NOT NULL,
    position      INTEGER      NOT NULL,
    distance      INTEGER      NOT NULL,
    vehicle_class VARCHAR(50)  NOT NULL
);

INSERT INTO leaderboard (name, number, position, distance, vehicle_class)
VALUES ('Solar Team Twente', 21, 1, 3555, 'challenger'),
       ('Innoptus Solar Team', 8, 2, 3535, 'challenger'),
       ('Vattenfall Solar Team', 3, 3, 3435, 'challenger'),
       ('Onda Solar', 9, 1, 2535, 'cruiser');