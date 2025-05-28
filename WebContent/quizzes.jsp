<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quizzes - Online Quiz System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .quiz-button {
            margin: 10px;
            width: 200px;
        }
        .dropdown-menu {
            min-width: 200px;
        }
        .quiz-section {
            margin-top: 40px;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Online Quiz</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="quizzes.jsp">Quizzes</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
            </ul>
        </div>
    </nav>

    <!-- Quiz Categories Section -->
    <div class="container quiz-section text-center">
        <h1>Select a Quiz</h1>
        <p>Choose a quiz to start testing your knowledge. Select a level from the dropdown.</p>

        <div class="row justify-content-center">
            <!-- Vocabulary Quiz with Dropdown for JLPT Levels -->
            <div class="col-md-3">
                <div class="dropdown quiz-button">
                    <button class="btn btn-primary dropdown-toggle btn-block" type="button" id="vocabularyDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Vocabulary Quiz
                    </button>
                    <div class="dropdown-menu" aria-labelledby="vocabularyDropdown">
                        <a class="dropdown-item" href="QuizServlet?category=vocabulary&level=n1">JLPT N1</a>
                        <a class="dropdown-item" href="QuizServlet?category=vocabulary&level=n2">JLPT N2</a>
                        <a class="dropdown-item" href="QuizServlet?category=vocabulary&level=n3">JLPT N3</a>
                        <a class="dropdown-item" href="QuizServlet?category=vocabulary&level=n4">JLPT N4</a>
                        <a class="dropdown-item" href="QuizServlet?category=vocabulary&level=n5">JLPT N5</a>
                    </div>
                </div>
            </div>

            <!-- Kanji Quiz with Dropdown for JLPT Levels -->
            <div class="col-md-3">
                <div class="dropdown quiz-button">
                    <button class="btn btn-primary dropdown-toggle btn-block" type="button" id="kanjiDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Kanji Quiz
                    </button>
                    <div class="dropdown-menu" aria-labelledby="kanjiDropdown">
                        <a class="dropdown-item" href="QuizServlet?category=kanji&level=n1">JLPT N1</a>
                        <a class="dropdown-item" href="QuizServlet?category=kanji&level=n2">JLPT N2</a>
                        <a class="dropdown-item" href="QuizServlet?category=kanji&level=n3">JLPT N3</a>
                        <a class="dropdown-item" href="QuizServlet?category=kanji&level=n4">JLPT N4</a>
                        <a class="dropdown-item" href="QuizServlet?category=kanji&level=n5">JLPT N5</a>
                    </div>
                </div>
            </div>

            <!-- Grammar Quiz with Dropdown for JLPT Levels -->
            <div class="col-md-3">
                <div class="dropdown quiz-button">
                    <button class="btn btn-primary dropdown-toggle btn-block" type="button" id="grammarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Grammar Quiz
                    </button>
                    <div class="dropdown-menu" aria-labelledby="grammarDropdown">
                        <a class="dropdown-item" href="QuizServlet?category=grammar&level=n1">JLPT N1</a>
                        <a class="dropdown-item" href="QuizServlet?category=grammar&level=n2">JLPT N2</a>
                        <a class="dropdown-item" href="QuizServlet?category=grammar&level=n3">JLPT N3</a>
                        <a class="dropdown-item" href="QuizServlet?category=grammar&level=n4">JLPT N4</a>
                        <a class="dropdown-item" href="QuizServlet?category=grammar&level=n5">JLPT N5</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
