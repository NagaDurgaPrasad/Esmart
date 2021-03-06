CREATE TABLE BLOCKS(
BLOCK_ID VARCHAR2(10) PRIMARY KEY,
BLOCK_NAME VARCHAR2(15) UNIQUE,
AVAIL_ROOMS NUMBER(4),
LOCATION VARCHAR2(20));

CREATE TABLE BRANCHES(
BRANCH_ID VARCHAR2(10) PRIMARY KEY,
BRANCH_NAME VARCHAR2(50),
BLOCK_ID VARCHAR2(10) REFERENCES BLOCKS(BLOCK_ID));

CREATE TABLE ROOMS(
ROOM_ID VARCHAR2(10) PRIMARY KEY,
ROOM_NO NUMBER(4),
NO_ROWS NUMBER(2),
NO_COLUMNS NUMBER(2),
BLOCK_ID VARCHAR2(10) REFERENCES BLOCKS(BLOCK_ID),
BRANCH_ID VARCHAR2(5) REFERENCES BRANCHES(BRANCH_ID));


CREATE TABLE EXAMS(
EXAM_ID VARCHAR2(10) PRIMARY KEY,
EXAM_NAME VARCHAR2(25),
ACADEMIC_YEAR VARCHAR2(7),
MONTH VARCHAR2(9),
STATUS VARCHAR2(10),
CR_TIME DATE);

CREATE TABLE SEATING_PLANS(
EXAM_ID VARCHAR2(10) REFERENCES EXAMS(EXAM_ID),
ROOM_ID VARCHAR2(10) REFERENCES ROOMS(ROOM_ID),
BRANCH_ID VARCHAR2(10) REFERENCES BRANCHES(BRANCH_ID),
START_NO VARCHAR2(10),
END_NO VARCHAR2(10),
ORDERED VARCHAR2(5),
FLAG VARCHAR2(5),
NO_ROWS NUMBER(2),
NO_COLUMNS NUMBER(2),
NO_STU NUMBER(3),
BRANCH_ORDER NUMBER(2),
PRIMARY KEY(EXAM_ID,ROOM_ID,BRANCH_ID));

CREATE TABLE MISSING_NUMBERS(
EXAM_ID VARCHAR2(10) REFERENCES EXAMS(EXAM_ID),
BRANCH_ID VARCHAR2(10) REFERENCES BRANCHES(BRANCH_ID),
ROLL_NO VARCHAR2(10));

CREATE TABLE ADDITIONAL_NUMBERS(
EXAM_ID VARCHAR2(10) REFERENCES EXAMS(EXAM_ID),
BRANCH_ID VARCHAR2(10) REFERENCES BRANCHES(BRANCH_ID),
ROLL_NO VARCHAR2(10));

CREATE TABLE EXAM_DATES(
EXAM_ID VARCHAR2(10) REFERENCES EXAMS(EXAM_ID),
EXAM_DATE DATE,
NEW_DATE DATE,
START_TIME VARCHAR2(5),
END_TIME VARCHAR2(5));

CREATE TABLE STAFF(
STAFF_ID VARCHAR2(10) PRIMARY KEY,
NAME VARCHAR2(25),
GENDER VARCHAR(1),
DOJ DATE,
ROLE VARCHAR2(20),
MOBILE NUMBER(10),
STATUS NUMBER(1),
BRANCH_ID VARCHAR2(10) REFERENCES BRANCHES(BRANCH_ID));

CREATE TABLE INVIGILATION(
EXAM_ID VARCHAR2(10) REFERENCES EXAMS(EXAM_ID),
STAFF_ID VARCHAR2(10) REFERENCES STAFF(STAFF_ID),
ROOM_ID VARCHAR2(10) REFERENCES ROOMS(ROOM_ID),
INVIG_DATE DATE,
PAY_STATUS NUMBER(1) DEFAULT(NULL));

CREATE TABLE USERS(
USER_ID VARCHAR2(10) PRIMARY KEY,
PASSWORD VARCHAR2(25),
NAME VARCHAR2(30),
DOB DATE,
GENDER VARCHAR2(6),
ROLE VARCHAR2(15),
DEPT VARCHAR2(10) REFERENCES BRANCHES(BRANCH_ID),
MOBILE NUMBER(10),
EMAIL VARCHAR2(50),
QUES VARCHAR2(50),
ANS VARCHAR2(20));

CREATE TABLE INVIG_REQUESTS(
RID VARCHAR2(15),
REQUESTED_TO VARCHAR2(10) REFERENCES USERS(USER_ID),
EXAM_ID VARCHAR2(10) REFERENCES EXAMS(EXAM_ID),
INVIG_DATE DATE,
NOP NUMBER(3),
REQ_DATE DATE,
PRIMARY KEY(EXAM_ID,INVIG_DATE,REQUESTED_TO));

CREATE TABLE VISITED_LIST (
USER_ID VARCHAR2(15) REFERENCES USERS(USER_ID),
RID VARCHAR2(15) NOT NULL,
VISITED_ON TIMESTAMP,
DELETED_STATUS NUMBER(1) DEFAULT(0),
PRIMARY KEY(USER_ID,RID));

CREATE TABLE SUPPLY_NUMS(
EXAM_ID VARCHAR2(10) REFERENCES EXAMS(EXAM_ID),
BRANCH_ID VARCHAR2(10) REFERENCES BRANCHES(BRANCH_ID),
ROLL_NO VARCHAR2(10));

CREATE TABLE INVIG_PAYMENTS(
EXAM_ID VARCHAR2(10) REFERENCES EXAMS(EXAM_ID),
AMT_PER_HEAD NUMBER(4),
NO_OF_PERSONS NUMBER(3),
PAID_DATE DATE);