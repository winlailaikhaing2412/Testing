<%@ page import="java.util.*" %>
<%
session.setMaxInactiveInterval(24 * 60 * 60);
    String category = (String) request.getAttribute("category");
    String level = (String) request.getAttribute("level");
    List<Integer> testNumbers = (List<Integer>) request.getAttribute("testNumbers");
    List<String> quizTitle = (List<String>) request.getAttribute("quizTitle");
    String username = (String) session.getAttribute("username");
    
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Select Test</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align : center;
            
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .test-link {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 5px 15px;
            margin: 5px 0;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .test-link:hover {
            background-color: #45a049;
            
        }
        .no-tests {
            text-align: center;
            color: #888;
            font-size: 14px;
        }
        .dropdown:hover .dropdown-menu {
            display: block;
            margin-top: 0;
        }
        .back-button {
		    display: inline-block;
		    background-color: #6c757d; /* Bootstrap secondary color */
		    color: white;
		    padding: 8px 15px;
		    margin: 20px 0 0;
		    text-decoration: none;
		    border-radius: 4px;
		    font-weight: bold;
		    font-size: 14px;
		    transition: background-color 0.3s;
		}
		.back-button:hover {
		    background-color: #5a6268;
		}
		.test-row {
		    display: flex;
		    justify-content: left;
		    align-items: center;
		    padding: 5px;
		}
		
		.test-no {
		    font-size: 16px;
		    font-weight: normal;
		    min-width: 10px; /* Increase the minimum width for better alignment */
		    padding-right: 20px; /* Add extra padding to ensure there is space between columns */
		    justify-content: center;
		    
		}     
    </style>
    
    
</head>
<body>
<!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="index.jsp">JLPT Quiz</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item active"><a class="nav-link" href="quizzes.jsp">Quizzes</a></li>
                <li class="nav-item"><a class="nav-link" href="profile.jsp"><%= username %></a></li>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </nav>
<div class="container">
    <h2 align="center">Select Test for <%= category %> - Level <%= level %></h2>
    <%-- <%
    /* out.println("testNumbers: " + testNumbers);
    out.println("quizTitle: " + quizTitle); */
    if (testNumbers != null) {
        out.println("testNumbers.size(): " + testNumbers.size());
    }
    if (quizTitle != null) {
        out.println("quizTitle.size(): " + quizTitle.size());
    }
%>
    --%> 

    <%
    if (testNumbers != null && quizTitle != null && testNumbers.size() == quizTitle.size()) {
%>
    <div class="row justify-content-left">
    <%
        for (int i = 0; i < testNumbers.size(); i++) {
            Integer testNo = testNumbers.get(i);
            String quiztitle = quizTitle.get(i);
    %>
        <div class="col-12">
            <div class="test-row">
                <span class="test-no">Test Number - <%= testNo %> : &nbsp;&nbsp;&nbsp;&nbsp;<%= quiztitle %></span>
                <span class="test-no"><a class="test-link" href="QuizServlet?category=<%= category %>&level=<%= level %>&test=<%= testNo %>">
                    Start Test
                </a>
                </span>
            </div>
        </div>
        <br>
    <%
        }
    %>
</div>

<%
    } else {
%>
    <p class="no-tests">No tests available for this category and level.</p>
<%
    }
%>

    
    <br><a class="back-button" href="quizzes.jsp">Back</a>


</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html> i want to make the navigation bar sitcky for this page too