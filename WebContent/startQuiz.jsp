<%@ page import="java.util.*, Model.Question" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Start Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .question-container {
            margin-bottom: 25px;
        }
        .question-container h3 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }
        .options-container {
            margin-top: 10px;
        }
        .options-container input {
            margin-right: 10px;
            margin-bottom: 5px;
            display: inline-block;
            font-size: 16px;
        }
        .submit-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .submit-button:hover {
            background-color: #45a049;
        }
        .question-number {
            font-weight: bold;
            color: #555;
        }
        .options-container {
            padding-left: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Start Quiz - <%= request.getAttribute("category") %> - Level <%= request.getAttribute("level") %> - Test <%= request.getAttribute("testNo") %></h2>
        <form action="SubmitQuizServlet" method="post">
            <% 
                List<Question> questions = (List<Question>) request.getAttribute("questions");
                int questionNumber = 1; // Initialize counter for question numbers
                for (Question question : questions) {
            %>
                <div class="question-container">
                    <h3><span class="question-number">Question <%= questionNumber %>:</span> <%= question.getQuestionText() %></h3>
                    <div class="options-container">
                        <input type="radio" name="question_<%= question.getId() %>" value="<%= question.getOption1() %>" /> <%= question.getOption1() %><br />
                        <input type="radio" name="question_<%= question.getId() %>" value="<%= question.getOption2() %>" /> <%= question.getOption2() %><br />
                        <input type="radio" name="question_<%= question.getId() %>" value="<%= question.getOption3() %>" /> <%= question.getOption3() %><br />
                        <input type="radio" name="question_<%= question.getId() %>" value="<%= question.getOption4() %>" /> <%= question.getOption4() %><br />
                    </div>
                </div>
                <% 
                    questionNumber++; // Increment the question number after each question
                } 
            %>
        
            <input type="hidden" name="category" value="<%= request.getAttribute("category") %>" />
            <input type="hidden" name="level" value="<%= request.getAttribute("level") %>" />
            <input type="hidden" name="testNo" value="<%= request.getAttribute("testNo") %>" />
        
            <button class="submit-button" type="submit">Submit Quiz</button>
        </form>
    </div>
</body>
</html>
