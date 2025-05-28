<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function toggleAdminPasscode() {
            const role = document.getElementById("role").value;
            const passcodeGroup = document.getElementById("admin-passcode-group");
            passcodeGroup.style.display = role === "admin" ? "block" : "none";
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center mt-5">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header text-center">
                        <h3>Register</h3>
                    </div>
                    <div class="card-body">
                        <%
                            // Display error or success message
                            String errorMessage = (String) request.getAttribute("errorMessage");
                            String successMessage = (String) request.getAttribute("successMessage");

                            if (errorMessage != null) {
                        %>
                            <div class="alert alert-danger text-center">
                                <%= errorMessage %>
                            </div>
                        <%
                            } else if (successMessage != null) {
                        %>
                            <div class="alert alert-success text-center">
                                <%= successMessage %>
                            </div>
                        <%
                            }
                        %>

                        <form action="RegisterServlet" method="post">
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" id="username" name="username" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="role">Role</label>
                                <select id="role" name="role" class="form-control" onchange="toggleAdminPasscode()" required>
                                    <option value="participant">Participant</option>
                                    <option value="admin">Admin</option>
                                </select>
                            </div>
                            <div class="form-group" id="admin-passcode-group" style="display: none;">
                                <label for="adminPasscode">Admin Passcode</label>
                                <input type="password" id="adminPasscode" name="adminPasscode" class="form-control">
                            </div>
                            <button type="submit" class="btn btn-success btn-block">Register</button>
                        </form>

                        <div class="mt-3 text-center">
                            <a href="login.jsp">Already have an account? Login here</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
