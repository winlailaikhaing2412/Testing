package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Connection.DBConnection;
import Model.Result;

public class ResultDAO {
	
	
	public static List<Result> getUserResults(int userId) throws SQLException {
	    List<Result> results = new ArrayList<>();
	    try (Connection conn = DBConnection.getConnection()) {
	        String sql = "SELECT r.quiz_id, q.title AS quiz_title, r.score, r.passed, r.start_time " +
	                     "FROM result r " +
	                     "JOIN quiz q ON r.quiz_id = q.id " +
	                     "WHERE r.user_id = ? " +
	                     "ORDER BY r.start_time DESC";  // <-- This line ensures newest first
	        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	            stmt.setInt(1, userId);
	            try (ResultSet rs = stmt.executeQuery()) {
	                while (rs.next()) {
	                    Result result = new Result();
	                    result.setQuizId(rs.getInt("quiz_id"));
	                    result.setQuizTitle(rs.getString("quiz_title"));
	                    result.setScore(rs.getInt("score"));
	                    result.setPassed(rs.getBoolean("passed"));
	                    result.setCreatedAt(rs.getTimestamp("start_time"));
	                    results.add(result);
	                }
	            }
	        }
	    }
	    return results;
	}

	
	// Method to retrieve results for a specific quiz from the database
    public static List<Result> getResultsByQuizId(Connection conn, int quizId) throws SQLException {
        String sql = "SELECT r.quiz_ID, r.participant_ID, r.score, r.passed, r.created_at, p.username, q.title, q.category, q.level, q.test_no " +
                     "FROM Result r " +
                     "JOIN Participant p ON r.participant_ID = p.participant_ID " +
                     "JOIN Quiz q ON r.quiz_ID = q.quiz_ID " +
                     "WHERE r.quiz_ID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Result> results = new ArrayList<>();
                while (rs.next()) {
                    // Map the ResultSet to a Result object
                    Result result = new Result();
                    result.setQuiz_ID(rs.getInt("quiz_ID"));
                    result.setParticipant_ID(rs.getInt("participant_ID"));
                    result.setScore(rs.getInt("score"));
                    result.setPassed(rs.getBoolean("passed"));
                    result.setCreatedAt(rs.getTimestamp("created_at"));
                    result.setUsername(rs.getString("username"));
                    result.setQuizTitle(rs.getString("title"));
                    result.setCategory(rs.getString("category"));
                    result.setLevel(rs.getString("level"));
                    result.setTest_no(rs.getInt("test_no"));

                    results.add(result);
                }
                return results;
            }
        }
    }

}
