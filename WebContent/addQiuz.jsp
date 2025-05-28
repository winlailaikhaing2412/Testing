<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	
    String username = (String) session.getAttribute("username");
	Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
    session.setMaxInactiveInterval(24 * 60 * 60);

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Quiz</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            color: #333;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        header {
        	position: sticky;
		    top: 0;
		    z-index: 1;
		    border-top-right-radius: 15px;
            background-color: #2c3e50;
            color: white;
            padding: 20px 0;
            text-align: center;
            border-radius: 10px;
        }
        header h1 a {
  			text-decoration: none;
			color: white;
			transition: background 0.3s;
			}
		header h1 a:hover {
  			text-decoration: none;
			color: white;
			transition: background 0.3s;
			}

        h3 {
            text-align: center;
            color: #2c3e50;
        }
        

        form {
            max-width: 1000px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 80px;
        }

        .radio-group {
            margin-top: 5px;
        }

        .radio-group input {
            margin-right: 5px;
        }

        .question-div {
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #eee;
            border-radius: 10px;
            background-color: #f9f9f9;
        }

        input[type="submit"] {
            margin-top: 20px;
            padding: 12px 20px;
            background-color: #3498db;
            border: none;
            color: white;
            font-size: 15px;
            border-radius: 6px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        button {
        margin-top: 20px;
            padding: 12px 20px;
            background-color: #3498db;
            border: none;
            color: white;
            font-size: 15px;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }

        .message {
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>

<% if (request.getParameter("success") != null) { %>
    <div class="message success"><%= request.getParameter("success") %></div>
<% } else if (request.getParameter("error") != null) { %>
    <div class="message error"><%= request.getParameter("error") %></div>
<% } 
	%>
	
	<% 
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) { 
%>
    <div style="color: red;"><%= errorMessage %></div>
<% 
    } 
%>
	
   <div class="container">
    <header>
           <h1><a href="adminDashboard.jsp">Admin Dashboard</a></h1>
    </header><br>
    
	<form action="AdminQuizServlet" method="post">
	<h3>Add New Quiz</h3>
	    <label>Title:</label>
	    <input type="text" name="title" required>
	
	    <label>Description:</label>
	    <textarea name="description" required></textarea>
	
	    <label>Category:</label>
	    <select name="category" required>
	        <option value="Vocabulary">Vocabulary</option>
	        <option value="Kanji">Kanji</option>
	        <option value="Grammar">Grammar</option>
	    </select>
	
	    <label>Level:</label>
	    <select name="level" required>
	        <option value="N1">JLPT N1</option>
	        <option value="N2">JLPT N2</option>
	        <option value="N3">JLPT N3</option>
	        <option value="N4">JLPT N4</option>
	        <option value="N5">JLPT N5</option>
	    </select>
	
	    <label>Test Number:</label>
	    <input type="number" id="test_no" name="test_no" required>
	
	    <div id="questions">
	        <% for (int i = 1; i <= 10; i++) { %>
	            <div class="question-div">
	                <label for="question<%=i%>">Question <%=i%>:</label>
	                <input type="text" name="question<%=i%>" id="question<%=i%>" required>
	
	                <label>Options:</label>
	                <input type="text" name="option<%=i%>_1" id="option<%=i%>_1" required placeholder="Option 1">
	                <input type="text" name="option<%=i%>_2" id="option<%=i%>_2" required placeholder="Option 2">
	                <input type="text" name="option<%=i%>_3" id="option<%=i%>_3" required placeholder="Option 3">
	                <input type="text" name="option<%=i%>_4" id="option<%=i%>_4" required placeholder="Option 4">
	
	                <label>Correct Answer:</label>
	                <div class="radio-group">
	                    <input type="radio" name="correct_answer<%=i%>" id="correct_answer<%=i%>_1" value="1" required> Option 1
	                    <input type="radio" name="correct_answer<%=i%>" id="correct_answer<%=i%>_2" value="2"> Option 2
	                    <input type="radio" name="correct_answer<%=i%>" id="correct_answer<%=i%>_3" value="3"> Option 3
	                    <input type="radio" name="correct_answer<%=i%>" id="correct_answer<%=i%>_4" value="4"> Option 4
	                </div>
	            </div>
	        <% } %>
	    </div>
	   
	    <input type="hidden" name="userId" value="<%= userId != null ? userId : "" %>" />
	    <input type="hidden" name="username" value="<%= username %>">
	    
	    <button type="button" onclick="addQuestion()">Add More Question</button>
	    <input type="submit" value="Submit Quiz"><br>
	</form>
	</div>
	
<script>
let questionCount = 10; // Initial count, since 10 questions are already rendered

function addQuestion() {
    questionCount++;

    const container = document.getElementById("questions");

    const div = document.createElement("div");
    div.className = "question-div";

    div.innerHTML =
        '<label for="question' + questionCount + '"><strong>Question ' + questionCount + ':</strong></label>' +
        '<input type="text" name="question' + questionCount + '" id="question' + questionCount + '" required>' +

        '<label><strong>Options:</strong></label>' +
        '<input type="text" name="option' + questionCount + '_1" id="option' + questionCount + '_1" required placeholder="Option 1">' +
        '<input type="text" name="option' + questionCount + '_2" id="option' + questionCount + '_2" required placeholder="Option 2">' +
        '<input type="text" name="option' + questionCount + '_3" id="option' + questionCount + '_3" required placeholder="Option 3">' +
        '<input type="text" name="option' + questionCount + '_4" id="option' + questionCount + '_4" required placeholder="Option 4">' +

        '<label><strong>Correct Answer:</strong></label>' +
        '<div class="radio-group">' +
            '<input type="radio" name="correct_answer' + questionCount + '" id="correct_answer' + questionCount + '_1" value="1" required> Option 1 ' +
            '<input type="radio" name="correct_answer' + questionCount + '" id="correct_answer' + questionCount + '_2" value="2"> Option 2 ' +
            '<input type="radio" name="correct_answer' + questionCount + '" id="correct_answer' + questionCount + '_3" value="3"> Option 3 ' +
            '<input type="radio" name="correct_answer' + questionCount + '" id="correct_answer' + questionCount + '_4" value="4"> Option 4 ' +
        '</div>';

    container.appendChild(div);
}
</script>
</body>
</html>
