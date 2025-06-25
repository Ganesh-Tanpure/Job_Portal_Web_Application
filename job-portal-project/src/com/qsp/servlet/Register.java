package com.qsp.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/registerform")
public class Register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/your_database_name", "root", "password_of_database");

            PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Email already exists
                out.println("<html><head><title>Register Error</title>");
                out.println("<style> body {font-family:Arial; text-align:center; margin-top:50px;}");
                out.println(".msg { color:red; font-size:18px; font-weight:bold; }</style></head><body>");
                out.println("<div class='msg'>Email already registered!</div>");
                out.println("<br><a href='register.html'>Try Again</a>");
                out.println("</body></html>");
            } else {
                PreparedStatement ps = con.prepareStatement("INSERT INTO users (name, email, password, phone) VALUES (?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, phone);

                int result = ps.executeUpdate();

                if (result > 0) {
                    out.println("<html><head><title>Success</title>");
                    out.println("<meta http-equiv='refresh' content='2;URL=index.html'/>");
                    out.println("<style> body {font-family:Arial; text-align:center; margin-top:50px;}");
                    out.println(".msg { color:green; font-size:18px; font-weight:bold; }</style></head><body>");
                    out.println("<div class='msg'>Registration Successful! Redirecting to login...</div>");
                    out.println("</body></html>");
                } else {
                    out.println("<html><head><title>Error</title>");
                    out.println("<style> body {font-family:Arial; text-align:center; margin-top:50px;}");
                    out.println(".msg { color:red; font-size:18px; font-weight:bold; }</style></head><body>");
                    out.println("<div class='msg'>Registration failed. Please try again.</div>");
                    out.println("<br><a href='register.html'>Try Again</a>");
                    out.println("</body></html>");
                }
            }

            con.close();

        } catch (Exception e) {
            out.println("<html><head><title>Exception</title>");
            out.println("<style> body {font-family:Arial; text-align:center; margin-top:50px;}");
            out.println(".msg { color:red; font-size:18px; font-weight:bold; }</style></head><body>");
            out.println("<div class='msg'>Error: " + e.getMessage() + "</div>");
            out.println("<br><a href='register.html'>Try Again</a>");
            out.println("</body></html>");
        }
    }
}
