/*DROP SCHEMA KEYCARD;*/
CREATE SCHEMA IF NOT EXISTS KEYCARD;
USE KEYCARD;

CREATE TABLE GROUPS (ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, NAME VARCHAR(255) );
CREATE TABLE USERS (ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, NAME VARCHAR(255), GROUP_ID INT, foreign key (GROUP_ID) REFERENCES GROUPS(ID));
CREATE TABLE ROOMS (ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, NAME VARCHAR(255) );
CREATE TABLE GROUPS_ROOMS (  GROUP_ID INT NOT NULL, 
FOREIGN KEY (GROUP_ID) REFERENCES GROUPS(ID),
 ROOM_ID INT NOT NULL, 
FOREIGN KEY (ROOM_ID) REFERENCES ROOMS(ID) );

INSERT INTO GROUPS (NAME) VALUES ('I.T.'), ('Sales'), ('Administration'), ('Operations');
INSERT INTO ROOMS (NAME) VALUES ('101'), ('102'), ('Auditorium A'), ('Auditurium B');
INSERT INTO GROUPS_ROOMS (GROUP_ID, ROOM_ID) VALUES (1,1),(1,2),(2,2),(2,3);
INSERT INTO USERS (NAME, GROUP_ID) VALUES ('Modesto', 1), ('Ayine', 1), ('Christopher', 2), ('Cheong woo', 2), ('Saulat', 3), ('Heidy', NULL);

/*All groups, and the users in each group. A group should appear even if there are no users assigned to the group.*/
SELECT * FROM GROUPS G LEFT JOIN USERS U ON G.ID = U.GROUP_ID;

/*All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
assigned to them*/
SELECT * FROM ROOMS R LEFT OUTER JOIN GROUPS_ROOMS GR ON R.ID = GR.ROOM_ID LEFT OUTER JOIN GROUPS G ON GR.GROUP_ID = G.ID;

/*A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
alphabetically by user, then by group, then by room*/
SELECT * FROM USERS U LEFT OUTER JOIN GROUPS G ON U.GROUP_ID = G.ID 
LEFT OUTER JOIN GROUPS_ROOMS GR ON U.GROUP_ID = GR.GROUP_ID LEFT OUTER JOIN ROOMS R ON GR.ROOM_ID = R.ID
ORDER BY U.NAME, G.NAME, R.NAME;
