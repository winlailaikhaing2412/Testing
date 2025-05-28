package Controller;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Connection.DBConnection;

@WebServlet("/AdminQuizServlet")
public class AdminQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	
        HttpSession session = request.getSession(false);
        session.setMaxInactiveInterval(24 * 60 * 60);
        
        if (session == null || session.getAttribute("userId") == null) {
            request.setAttribute("errorMessage", "Session expired or invalid user.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        
        // If session is valid, retrieve the user info
        String username = (String) session.getAttribute("username");
        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("Session Username: " + username);
        System.out.println("Session UserID: " + userId);
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String level = request.getParameter("level");
        int test_no;

        try {
            test_no = Integer.parseInt(request.getParameter("test_no"));
        } catch (NumberFormatException e) {
            response.sendRedirect("addQuiz.jsp?error=Invalid test number.");
            return;
        }

        Connection conn = null;
        PreparedStatement quizStmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                response.sendRedirect("addQuiz.jsp?error=Database connection failed.");
                return;
            }

            conn.setAutoCommit(false);

//            String checkTestNoSQL = "SELECT COUNT(*) FROM Quiz WHERE test_no = ?";
//            quizStmt = conn.prepareStatement(checkTestNoSQL);
//            quizStmt.setInt(1, test_no);
//            rs = quizStmt.executeQuery();
//
//            if (rs.next() && rs.getInt(1) > 0) {
//                response.sendRedirect("addQuiz.jsp?error=Test number already exists.");
//                return;
//            }

            
            String insertQuizSQL = "INSERT INTO Quiz (title, description, category, level, test_no, created_by) VALUES (?, ?, ?, ?, ?, ?)";
            quizStmt = conn.prepareStatement(insertQuizSQL, Statement.RETURN_GENERATED_KEYS);
            quizStmt.setString(1, title);
            quizStmt.setString(2, description);
            quizStmt.setString(3, category);
            quizStmt.setString(4, level);
            quizStmt.setInt(5, test_no);
            quizStmt.setInt(6, userId);
            quizStmt.executeUpdate();

            rs = quizStmt.getGeneratedKeys();
            int quiz_ID = 0;
            if (rs.next()) {
                quiz_ID = rs.getInt(1);
            }
            
            int additionalQuestions = 0;
            if (request.getParameter("additional_questions") != null) {
                additionalQuestions = Integer.parseInt(request.getParameter("additional_questions"));
            }

            int questionIndex = 1;
            while (request.getParameter("question" + questionIndex) != null) {
                String questionText = request.getParameter("question" + questionIndex);

                String insertQuestionSQL = "INSERT INTO Question (quiz_ID, question_text) VALUES (?, ?)";
                PreparedStatement questionStmt = conn.prepareStatement(insertQuestionSQL, Statement.RETURN_GENERATED_KEYS);
                questionStmt.setInt(1, quiz_ID);
                questionStmt.setString(2, questionText);
                questionStmt.executeUpdate();

                ResultSet qrs = questionStmt.getGeneratedKeys();
                int question_ID = 0;
                if (qrs.next()) {
                    question_ID = qrs.getInt(1);
                }

                String correctAnswerParam = request.getParameter("correct_answer" + questionIndex);
                int correctAnswer = 0;
                try {
                    correctAnswer = Integer.parseInt(correctAnswerParam);
                } catch (NumberFormatException e) {
                    response.sendRedirect("addQuiz.jsp?error=Invalid correct answer for question " + questionIndex);
                    return;
                }

                for (int i = 1; i <= 4; i++) {
                    String optionText = request.getParameter("option" + questionIndex + "_" + i);
                    if (optionText == null || optionText.trim().isEmpty()) {
                        response.sendRedirect("addQuiz.jsp?error=All options must be filled.");
                        return;
                    }

                    int isCorrect = (correctAnswer == i) ? 1 : 0;
                    String insertOptionSQL = "INSERT INTO Options (question_ID, option_text, is_correct) VALUES (?, ?, ?)";
                    PreparedStatement optionStmt = conn.prepareStatement(insertOptionSQL);
                    optionStmt.setInt(1, question_ID);
                    optionStmt.setString(2, optionText);
                    optionStmt.setInt(3, isCorrect);
                    optionStmt.executeUpdate();
                    optionStmt.close();
                }

                qrs.close();
                questionStmt.close();
                questionIndex++;
            }

            conn.commit();
            request.setAttribute("username", username);
            request.setAttribute("userId", userId);
            response.sendRedirect("addQuiz.jsp?success=Quiz added successfully!");

        } catch (SQLException e) {
        	    if (e.getErrorCode() == 1062) {
        	        // Error code 1062 = Duplicate entry
        	        //request.setAttribute("errorMessage", "A quiz with this test name already exists.");
        	    	response.sendRedirect("addQuiz.jsp?error=A quiz with this test number of this level and category already exists!");
        	    } else {
        	        // some other SQL error
        	        e.printStackTrace();
        	        request.setAttribute("errorMessage", "An unexpected database error occurred.");
        	        request.getRequestDispatcher("/addQuiz.jsp").forward(request, response);
        	    }
        	}

//            try {
//                if (conn != null) conn.rollback();
//            } catch (SQLException ex) {
//                ex.printStackTrace();
//            }
//            e.printStackTrace();
//            response.sendRedirect("addQuiz.jsp?error=Database error occurred.");
//
//        } 
        finally {
            try {
                if (rs != null) rs.close();
                if (quizStmt != null) quizStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}