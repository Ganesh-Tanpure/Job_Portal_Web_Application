package com.qsp.servlet;

import java.io.IOException;

import jakarta.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
  protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
    
	  HttpSession s = req.getSession(false);
    
	  if(s != null) s.invalidate();
    res.sendRedirect("index.html");
  }
}

