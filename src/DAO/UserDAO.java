package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Model.Result;
import Model.User;
import Connection.DBConnection; // Assume this class is for database connection handling

public class UserDAO {

    // Authenticate the user based on username and password
    public static User authenticate(String username, String password) {
        User user = null;
        String query = "SELECT * FROM User WHERE username = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Create a User object with the data from the ResultSet
                user = new User(
                    rs.getInt("userID"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("role")
                );
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user; // Return the User object if authenticated, or null if not
    }

    // Method to insert a new user into the database (for registration)
    public static boolean registerUser(User user) {
        String query = "INSERT INTO User (username, password, email, role) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getRole());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
 // Update username and/or password by user ID
    public static boolean updateUsernameAndPassword(int userId, String newUsername, String newPassword) {
        String query;
        boolean changePassword = (newPassword != null && !newPassword.trim().isEmpty());

        if (changePassword) {
            query = "UPDATE User SET username = ?, password = ? WHERE userID = ?";
        } else {
            query = "UPDATE User SET username = ? WHERE userID = ?";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, newUsername);

            if (changePassword) {
                ps.setString(2, newPassword);
                ps.setInt(3, userId);
            } else {
                ps.setInt(2, userId);
            }

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve user ID based on username
    public static int getUserIdByUsername(String username) {
        String query = "SELECT userID FROM User WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("userID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if not found
    }
    
    public static List<Result> getUserResults(int userId) throws SQLException {
        List<Result> results = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT r.score, r.passed, p.start_time, p.end_time, q.title AS quiz_title " +
                         "FROM Result r " +
                         "JOIN Participant p ON r.participant_ID = p.participant_ID " +
                         "JOIN Quiz q ON p.quiz_ID = q.quiz_ID"+
                         "WHERE p.user_ID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            
            
           

            while (rs.next()) {
                Result result = new Result();
                result.setQuizTitle(rs.getString("quiz_title"));
                result.setScore(rs.getInt("score"));
                result.setPassed(rs.getBoolean("passed"));
                result.setCreatedAt(rs.getTimestamp("created_at"));
                results.add(result);
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
        System.out.println("Results fetched for user ID " + userId + ": " + results.size() + " results.");
        return results;
    }


    

}




    




