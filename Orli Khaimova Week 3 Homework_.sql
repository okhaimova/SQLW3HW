
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS orggroups;
DROP TABLE IF EXISTS GroupAssignment;


CREATE TABLE users
(
user_id int AUTO_INCREMENT PRIMARY KEY,
user varchar(100) NOT NULL
);

CREATE TABLE rooms
(
room_id int AUTO_INCREMENT PRIMARY KEY,
room varchar(100) NULL UNIQUE
);

CREATE TABLE orggroups
(
group_id int AUTO_INCREMENT PRIMARY KEY,
groupname varchar(100) NULL 
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

 CREATE TABLE GroupAssignment
 (
   user_id int REFERENCES users(user_id),
   group_id int REFERENCES orggroups(group_id),
   CONSTRAINT ga UNIQUE KEY(user_id, group_id)
 );

INSERT INTO  GroupAssignment (user_id, group_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 3),
    (6, NULL);
    
 CREATE TABLE RoomAssignment
 (
   group_id int REFERENCES orggroups(group_id),
   room_id int REFERENCES rooms(room_id),
   CONSTRAINT ra UNIQUE KEY(group_id, room_id)
 );
 
INSERT INTO  RoomAssignment (group_id, room_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 2),
    (2, 3);
   
SELECT g.groupname, u.user
FROM orggroups g
LEFT JOIN GroupAssignment
ON g.group_id = GroupAssignment.group_id
LEFT JOIN users u
ON GroupAssignment.user_id = u.user_id;

SELECT r.room, g.groupname
FROM rooms r
LEFT JOIN RoomAssignment
ON RoomAssignment.room_id = r.room_id
LEFT JOIN orggroups g
ON g.group_id = RoomAssignment.group_id;

SELECT u.user, g.groupname, r.room
FROM users u
LEFT JOIN GroupAssignment
ON GroupAssignment.user_id = u.user_id
LEFT JOIN orggroups g
ON g.group_id = GroupAssignment.group_id
LEFT JOIN RoomAssignment
ON g.group_id = RoomAssignment.group_id
LEFT JOIN rooms r
ON RoomAssignment.room_id = r.room_id
ORDER BY u.user, g.groupname, r.room;