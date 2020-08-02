DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS orggroups;
DROP TABLE IF EXISTS urgAssignment;



CREATE TABLE users
(
user_id int AUTO_INCREMENT PRIMARY KEY,
user varchar(100) NOT NULL
);


CREATE TABLE rooms
(
room_id int AUTO_INCREMENT PRIMARY KEY,
room varchar(100) NOT NULL
);


CREATE TABLE orggroups
(
group_id int AUTO_INCREMENT PRIMARY KEY,
groupname varchar(100) NOT NULL
);


INSERT INTO users (user)
VALUES
('Modesto'),
    ('Ayine'),
    ('Christopher'),
    ('Cheong woo'),
    ('Saulat'),
    ('Heidy');
   
INSERT INTO rooms (room)
VALUES
('101'),
    ('102'),
    ('Auditorium A'),
    ('Auditorium B');

INSERT INTO orggroups (groupname)
VALUES
('I.T.'),
    ('Sales'),
    ('Administration'),
    ('Operations');

 CREATE TABLE urgAssignment
 (
   user_id int REFERENCES users(user_id),
   group_id int REFERENCES orggroups(group_id),
   room_id int REFERENCES rooms(room_id),
   CONSTRAINT urg UNIQUE KEY(user_id, group_id, room_id)
 );
 
INSERT INTO urgAssignment
VALUES
    (1, 1, 1),
    (1, 1, 2),
    (2, 1, 1),
    (2, 1, 2),
    (3, 2, 2),
    (3, 2, 3),
    (4, 2, 2),
    (4, 2, 3),
    (5, 3, NULL);
   
SELECT DISTINCT g.groupname, u.user
FROM orggroups g
LEFT JOIN urgAssignment
ON g.group_id = urgAssignment.group_id
LEFT JOIN users u
ON urgAssignment.user_id = u.user_id;

SELECT DISTINCT r.room, g.groupname
FROM rooms r
LEFT JOIN urgAssignment
ON urgAssignment.room_id = r.room_id
LEFT JOIN orggroups g
ON g.group_id = urgAssignment.group_id;

SELECT u.user, g.groupname, r.room
FROM users u
LEFT JOIN urgAssignment
ON urgAssignment.user_id = u.user_id
LEFT JOIN orggroups g
ON g.group_id = urgAssignment.group_id
LEFT JOIN rooms r
ON urgAssignment.room_id = r.room_id
ORDER BY u.user, g.groupname, r.room;