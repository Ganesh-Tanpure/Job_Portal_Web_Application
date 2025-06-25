package com.qsp.servlet;

import java.io.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.sql.*;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
  
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    String name = req.getParameter("name");
    String email = req.getParameter("email");
    String phone = req.getParameter("phone");
    
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database_name","root","password_of_database");
      PreparedStatement ps = c.prepareStatement("UPDATE users SET name=?, phone=? WHERE email=?");
      ps.setString(1,name); 
      ps.setString(2,phone); 
      ps.setString(3,email);
      
      int r = ps.executeUpdate();
      c.close();
      
      res.sendRedirect("profile.jsp");
    } catch (Exception e) { throw new ServletException(e); }
  }

  protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
    res.sendRedirect("update.jsp");
  }
}
