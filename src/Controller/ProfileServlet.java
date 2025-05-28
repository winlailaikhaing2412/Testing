package Controller;

import DAO.UserDAO;
import Model.Result;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
    	String username = (String) session.getAttribute("username");
        Integer userId = (Integer) session.getAttribute("userId");
        if (username == null || userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        //int userId = UserDAO.getUserIdByUsername(username);
        request.setAttribute("userId", userId);
        request.setAttribute("username", username);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentUsername = (String) request.getSession().getAttribute("username");
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (currentUsername == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        //int userId = UserDAO.getUserIdByUsername(currentUsername);
        String newUsername = request.getParameter("username");
        String newPassword = request.getParameter("password");
        
        //show result that user have tested
        try {
            List<Result> userResults = UserDAO.getUserResults(userId); // Fetch quiz results
            request.setAttribute("userResults", userResults);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load quiz results.");
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);

        
        //update username and password
        boolean isUpdated = UserDAO.updateUsernameAndPassword(userId, newUsername, newPassword);

        if (isUpdated) {
            request.getSession().setAttribute("username", newUsername); // Update session username
            request.setAttribute("successMessage", "Profile updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile.");
        }

        request.setAttribute("userId", userId);
        request.setAttribute("username", newUsername);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
