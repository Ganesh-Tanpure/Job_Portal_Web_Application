package com.qsp.servlet;


import jakarta.servlet.*;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.html");
            return;
        }

        String email = (String) session.getAttribute("email");  // username = email
        String jobIdParam = request.getParameter("jobId");

        if (jobIdParam == null || jobIdParam.isEmpty()) {
            response.getWriter().println("Error: Job ID is missing.");
            return;
        }

        int jobId = Integer.parseInt(jobIdParam);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/your_database_name", "root", "password_of_database");

            // Check if already applied
            PreparedStatement check = con.prepareStatement(
                "SELECT * FROM applications WHERE user_email = ? AND job_id = ?");
            check.setString(1, email);
            check.setInt(2, jobId);
            ResultSet rs = check.executeQuery();

            if (!rs.next()) {
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO applications (user_email, job_id, applied_date) VALUES (?, ?, CURDATE())");
                ps.setString(1, email);
                ps.setInt(2, jobId);
                ps.executeUpdate();
            }

            con.close();
            response.sendRedirect("applied-jobs.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error applying for job: " + e.getMessage());
        }
    }
}
