<%@ page import="java.util.*,Model.Result" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Model.Result> userResults = (List<Model.Result>) request.getAttribute("userResults");
    String username = (String) session.getAttribute("username");
    Integer userId = (Integer) session.getAttribute("userId");
    session.setMaxInactiveInterval(24 * 60 * 60);
    
    if (username == null || userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
    .navbar {
		position: sticky;
		top: 0;
		z-index: 1000;
		background-color: #343a40;
		}
    body {
        background-color: #f8f9fa;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        padding: 0px;
    }
    h4 {
        margin-top: 40px;
        margin-bottom: 20px;
        color: #343a40;
    }
    .table {
        background-color: #ffffff;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        border-radius: 8px;
        overflow: hidden;
    }
    .table th, .table td {
        vertical-align: middle;
        text-align: center;
    }
    .alert {
        margin-top: 20px;
    }
    form {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        margin-top: 30px;
    }
    label {
        font-weight: 600;
    }

    .btn-primary {
        background-color: #0069d9;
        border: none;
    }
    .btn-primary:hover {
        background-color: #0056b3;
    }
    p {
        font-size: 1.1rem;
        color: #555;
    }
    .back-button {
		    display: inline-block;
		    background-color: #6c757d; /* Bootstrap secondary color */
		    color: white;
		    padding: 8px 15px;
		    text-decoration: none;
		    border-radius: 4px;
		    font-weight: bold;
		    font-size: 14px;
		    transition: background-color 0.3s;
		}
		.back-button:hover {
		    background-color: #5a6268;
		}
		.uniform-size {
		    padding: 8px 15px;
		    font-size: 14px;
		    font-weight: bold;
		    height: 40px;
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
                <li class="nav-item"><a class="nav-link" href="quizzes.jsp">Quizzes</a></li>
                <li class="nav-item active"><a class="nav-link" href="ProfileServlet"><%= username %></a></li>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </nav>

        <% if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } %>

        <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>
        
        <%-- Display user results if available --%>
	    <% if (userResults != null && !userResults.isEmpty()) { %>
	        <h4 class="mt-5">Your Quiz History</h4>
	        <table class="table table-striped">
	            <thead class="thead-dark">
	                <tr>
	                    <th>Quiz Title</th>
	                    <th>Score (%)</th>
	                    <th>Result</th>
	                    <th>Date Taken</th>
	                </tr>
	            </thead>
	            <tbody>
	                <% int resultCount = 0; %>
	                <% for (Model.Result result : userResults) { %>
	                    <tr class="result-row <%= resultCount >= 5 ? "d-none" : "" %>">
	                        <td><%= result.getQuizTitle() %></td>
	                        <td><%= result.getScore() %>%</td>
	                        <td>
	                            <% if (result.isPassed()) { %>
	                                <span class="badge badge-success">Passed</span>
	                            <% } else { %>
	                                <span class="badge badge-danger">Failed</span>
	                            <% } %>
	                        </td>
	                        <td><%= result.getCreatedAt() %></td>
	                    </tr>
	                    <% resultCount++; %>
	                <% } %>
	            </tbody>
	        </table>

        <% if (userResults.size() > 5) { %>
			<div class="d-flex justify-content-center flex-wrap mt-4 gap-2">
			    <button id="showAllBtn" class="btn btn-outline-secondary mx-2 uniform-size" onclick="showAllResults()">Show All</button>
			    <button id="showLessBtn" class="btn btn-outline-secondary d-none mx-2 uniform-size" onclick="showLessResults()">Show Less</button>
			    <button type="button" class="btn btn-outline-primary mx-2 uniform-size" data-toggle="modal" data-target="#updateProfileModal">Update Profile</button>
			    <a class="back-button mx-2" href="index.jsp">Back</a>
			</div>
        <% } 
        	else {%>
	        <div class="d-flex justify-content-center flex-wrap mt-4 gap-2">
				    <button type="button" class="btn btn-outline-primary mx-2 uniform-size" data-toggle="modal" data-target="#updateProfileModal">Update Profile</button>
				    <a class="back-button mx-2" href="index.jsp">Back</a>
			</div>
    	<%	}
        } else { %>
        <p class="mt-5">You have not taken any quizzes yet.</p>
        <div class="d-flex justify-content-center flex-wrap mt-4 gap-2">
				    <button type="button" class="btn btn-outline-primary mx-2 uniform-size" data-toggle="modal" data-target="#updateProfileModal">Update Profile</button>
				    <a class="back-button mx-2" href="index.jsp">Back</a>
		</div>
    <% } %>
 <!-- Update Profile Modal -->
<div class="modal fade" id="updateProfileModal" tabindex="-1" role="dialog" aria-labelledby="updateProfileModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="updateProfileModalLabel">Update Profile</h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <form action="ProfileServlet" method="POST">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="username">New Username</label>
                        <input type="text" class="form-control" id="username" name="username" value="<%= username %>" required>
                    </div>
                    <div class="form-group">
                        <label for="password">New Password (optional)</label>
                        <input type="password" class="form-control" id="password" name="password">
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function showAllResults() {
        document.querySelectorAll('.result-row.d-none').forEach(function(row) {
            row.classList.remove('d-none');
        });
        document.getElementById('showAllBtn').classList.add('d-none');
        document.getElementById('showLessBtn').classList.remove('d-none');
    }

    function showLessResults() {
        let resultCount = 0;
        document.querySelectorAll('.result-row').forEach(function(row) {
            if (resultCount >= 5) {
                row.classList.add('d-none');
            }
            resultCount++;
        });
        document.getElementById('showLessBtn').classList.add('d-none');
        document.getElementById('showAllBtn').classList.remove('d-none');
    }
</script>     
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
