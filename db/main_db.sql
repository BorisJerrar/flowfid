CREATE EXTENSION IF NOT EXISTS unaccent;
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE Manager
(
    managerID UUID PRIMARY KEY,
    userName VARCHAR(25),
    adminName VARCHAR(35),
    firstName VARCHAR(25),
    lastName VARCHAR(35),
    phoneNumber VARCHAR(10),
    email VARCHAR(100) UNIQUE NOT NULL,
    managerPassword VARCHAR(64),
    subsciptionType VARCHAR(20),
    accountCreationDate date
);

CREATE TABLE UploadedImage
(
    imageID UUID PRIMARY KEY,
    imageName VARCHAR(65),
    uploadDate date
);
CREATE TABLE UploadedImageByManager
(
    imageManagerID UUID PRIMARY KEY,
    managerID UUID,
    imageID UUID,
    FOREIGN KEY (managerID) REFERENCES Manager (managerID) ON DELETE CASCADE,
    FOREIGN KEY (imageID) REFERENCES UploadedImage (imageID) ON DELETE CASCADE
);
CREATE TABLE Quizz
(
    quizzID UUID PRIMARY KEY,
    title VARCHAR(35),
    active boolean,
    byDefault boolean,
    quizzCreationDate date
);
CREATE TABLE QuizzByManager
(
    quizzManagerID UUID PRIMARY KEY,
    managerID UUID,
    quizzID UUID,
    FOREIGN KEY (managerID) REFERENCES Manager (managerID) ON DELETE CASCADE,
    FOREIGN KEY (quizzID) REFERENCES Quizz (quizzID) ON DELETE CASCADE
);
CREATE TABLE Comment
(
    commentID UUID PRIMARY KEY,
    quizzManagerID UUID,
    tag VARCHAR(20),
    content VARCHAR(1000),
    commentDate date,
    FOREIGN KEY (quizzManagerID) REFERENCES QuizzByManager (quizzManagerID) ON DELETE CASCADE
);
CREATE TABLE Question
(
    questionID UUID PRIMARY KEY,
    quizzManagerID UUID,
    questionContent VARCHAR(1000),
    FOREIGN KEY (quizzManagerID) REFERENCES QuizzByManager (quizzManagerID) ON DELETE CASCADE
);
CREATE TABLE Vote
(
    voteID UUID PRIMARY KEY,
    questionID UUID,
    answer CHAR(3),
    voteDate date,
    FOREIGN KEY (questionID) REFERENCES Question (questionID) ON DELETE CASCADE
);

INSERT INTO Manager
    (managerID, userName, adminName, firstName, lastName, phoneNumber, email, managerPassword, subsciptionType, accountCreationDate)
VALUES
('7ee763a8-1856-41b7-b284-0db456ba0f8c', 'starbucks', 'starbucksADMIN', 'Boris', 'Jerrar', '0608920701', 'contact@starbucks.com', '**********', 'full','2020-07-21');