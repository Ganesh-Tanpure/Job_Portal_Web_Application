package com.qsp.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/ResumeUploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5)
public class ResumeUploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = (String) request.getSession().getAttribute("email");
        if (email == null) {
            response.sendRedirect("index.html");
            return;
        }

        Part filePart = request.getPart("resume");
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String storedFileName = originalFileName;
        

        // Save under: /resumes/[email]_[resumeFileName]
        String resumeFolderPath = getServletContext().getRealPath("/resumes");
        File uploadDir = new File(resumeFolderPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Full path to write file
        String fullPath = resumeFolderPath + File.separator + storedFileName;
        filePart.write(fullPath); // ✅ now writes correctly to /resumes/

        // Store only the file name in DB (not full path)
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/your_database_name", "root", "password_of_database");

            PreparedStatement ps = con.prepareStatement("UPDATE users SET resume_path=? WHERE email=?");
            ps.setString(1, storedFileName);
            ps.setString(2, email);
            ps.executeUpdate();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("profile.jsp");
    }
}
