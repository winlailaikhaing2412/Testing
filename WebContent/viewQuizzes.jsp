<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
session.setMaxInactiveInterval(24 * 60 * 60);
    String username = (String) session.getAttribute("username");
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Quizzes</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
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
        h2 {
            margin-bottom: 30px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <div class="container">
    	<header>
            <h1><a href="adminDashboard.jsp">Admin Dashboard</a></h1>
        </header>
    
    <div class="container mt-5">
        <h2 class="text-center">All Quizzes</h2>
        
        <% 
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3305/quizdb", "root", "root");
            String query = "SELECT quiz_ID, title, description, category, level, test_no, created_at FROM Quiz WHERE created_by = ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
        %>
        
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="thead-dark text-center">
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Level</th>
                        <th>Test Number</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                        <tr>
                            <td class="text-center"><%= rs.getInt("quiz_ID") %></td>
                            <td><%= rs.getString("title") %></td>
                            <td><%= rs.getString("description") %></td>
                            <td><%= rs.getString("category") %></td>
                            <td><%= rs.getString("level") %></td>
                            <td class="text-center"><%= rs.getInt("test_no") %></td>
                            <td><%= rs.getTimestamp("created_at") %></td>
                            <td class="text-center">
                                <a href="editQuiz.jsp?id=<%= rs.getInt("quiz_ID") %>" class="btn btn-sm btn-warning">Edit</a>
                                <a href="deleteQuiz.jsp?id=<%= rs.getInt("quiz_ID") %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <% 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        %>
    </div>
    
    </div>
</body>
</html>
