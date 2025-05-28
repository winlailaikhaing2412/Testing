<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Add any required CSS -->
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <div class="container">
        <header>
            <h1>Admin Dashboard</h1>
        </header>

        <nav>
            <ul>
                <li><a href="addQuiz.jsp">Add New Quiz</a></li>
                <li><a href="viewQuizzes.jsp">View Quizzes</a></li>
            </ul>
        </nav>

        <!-- Displaying error or success messages directly using request attributes -->
        <%
            String errorMessage = request.getParameter("error");
            if (errorMessage != null) {
        %>
            <div class="alert alert-danger">
                <strong>Error:</strong> <%= errorMessage %>
            </div>
        <%
            }

            String successMessage = request.getParameter("success");
            if (successMessage != null) {
        %>
            <div class="alert alert-success">
                <strong>Success:</strong> <%= successMessage %>
            </div>
        <%
            }
        %>

        <section>
            <h2>Quiz Management</h2>
            <p>Manage your quizzes here. Add new quizzes, view existing quizzes, or modify them.</p>

            <!-- Add any additional dashboard features -->
            <div>
                <h3>Upcoming Tasks</h3>
                <ul>
                    <li>Review quiz submissions</li>
                    <li>Check quiz results</li>
                </ul>
            </div>
        </section>
    </div>

    <!-- Optional footer -->
    <footer>
        <p>&copy; 2025 Quiz Admin Panel</p>
    </footer>

</body>
</html>
