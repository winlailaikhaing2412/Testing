CREATE TABLE User (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role ENUM('admin', 'participant') DEFAULT 'participant'
);


CREATE TABLE Participant (
    participant_ID INT AUTO_INCREMENT PRIMARY KEY,
    user_ID INT NOT NULL,
    quiz_ID INT NOT NULL,
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP,
    FOREIGN KEY (user_ID) REFERENCES User(userID) ON DELETE CASCADE,
    FOREIGN KEY (quiz_ID) REFERENCES Quiz(quiz_ID) ON DELETE CASCADE
);


CREATE TABLE Result (
    resultID INT AUTO_INCREMENT PRIMARY KEY,
    participant_ID INT NOT NULL,
    score INT NOT NULL, -- e.g., total score the user achieved
    passed BOOLEAN NOT NULL, -- true if the user passed the quiz
    FOREIGN KEY (participant_ID) REFERENCES Participant(participant_ID) ON DELETE CASCADE
);


CREATE TABLE Quiz (
    quiz_ID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100) NOT NULL, -- e.g., Vocabulary, Kanji, Grammar
    level VARCHAR(10) NOT NULL, -- e.g., N1, N2, N3, N4, N5
    test_no INT NOT NULL, -- Test number for a specific category & level
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (category, level, test_no) -- Prevents duplicate tests in the same category & level
);
ALTER TABLE Quiz ADD COLUMN created_by INT;
ALTER TABLE Quiz ADD FOREIGN KEY (created_by) REFERENCES User(userID) ON DELETE SET NULL;


CREATE TABLE Answer (
    answer_ID INT AUTO_INCREMENT PRIMARY KEY,
    participant_ID INT NOT NULL,
    question_ID INT NOT NULL,
    selectedOption_ID INT NOT NULL,
    FOREIGN KEY (participant_ID) REFERENCES Participant(participant_ID) ON DELETE CASCADE,
    FOREIGN KEY (question_ID) REFERENCES Question(question_ID) ON DELETE CASCADE,
    FOREIGN KEY (selectedOption_ID) REFERENCES Options(option_ID) ON DELETE CASCADE
);


CREATE TABLE Options (
    option_ID INT AUTO_INCREMENT PRIMARY KEY,
    question_ID INT NOT NULL,
    option_text VARCHAR(255) NOT NULL,
    is_correct BOOLEAN NOT NULL, -- 1 correct, 0 incorrect
    FOREIGN KEY (question_ID) REFERENCES Question(question_ID) ON DELETE CASCADE
);


CREATE TABLE Question (
    question_ID INT AUTO_INCREMENT PRIMARY KEY,
    quiz_ID INT NOT NULL,
    question_text TEXT NOT NULL,
    FOREIGN KEY (quiz_ID) REFERENCES Quiz(quiz_ID) ON DELETE CASCADE
);

CREATE TABLE Submission (
    submission_ID INT AUTO_INCREMENT PRIMARY KEY,
    participant_ID INT NOT NULL,
    quiz_ID INT NOT NULL,  -- Replacing test_ID with quiz_ID
    score INT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (participant_ID) REFERENCES Participant(participant_ID) ON DELETE CASCADE,
    FOREIGN KEY (quiz_ID) REFERENCES Quiz(quiz_ID) ON DELETE CASCADE  -- Linking to Quiz table
);


select * from quiz;