package Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3305/quizdb";
    private static final String USER = "root";
    private static final String PASSWORD = "root"; 
    private static Connection connection;

    // Get a database connection
    public static Connection getConnection() throws SQLException {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ MySQL JDBC Driver Loaded Successfully!");

            // Establish Connection if it's null or closed
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("✅ Database Connection Established Successfully!");
            }
        } catch (ClassNotFoundException e) {
            System.err.println("❌ ERROR: MySQL JDBC Driver Not Found!");
            e.printStackTrace();
            throw new SQLException("Database Driver not found.");
        } catch (SQLException e) {
            System.err.println("❌ ERROR: Unable to Connect to Database!");
            e.printStackTrace();
            throw e;
        }
        return connection;
    }

    // Close the database connection
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("✅ Database Connection Closed Successfully!");
            }
        } catch (SQLException e) {
            System.err.println("❌ ERROR: Unable to Close Database Connection!");
            e.printStackTrace();
        }
    }

    // Test Database Connection (Run this as main method)
    public static void main(String[] args) {
        try {
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                System.out.println("🎉 Connection to Database is Working Fine!");
            }
            DBConnection.closeConnection();
        } catch (SQLException e) {
            System.err.println("❌ Database Connection Failed!");
            e.printStackTrace();
        }
    }
}
