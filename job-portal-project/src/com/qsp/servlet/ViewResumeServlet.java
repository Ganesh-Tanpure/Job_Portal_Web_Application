package com.qsp.servlet;


import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ViewResumeServlet")
public class ViewResumeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fileName = request.getParameter("file"); // e.g., ganesh_resume.pdf
        if (fileName == null || fileName.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing file name");
            return;
        }

        String resumePath = getServletContext().getRealPath("/resumes/" + fileName);
        File file = new File(resumePath);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Resume not found");
            return;
        }

        String mimeType = getServletContext().getMimeType(resumePath);
        if (mimeType == null) {
            mimeType = "application/octet-stream"; // default binary
        }

        response.setContentType(mimeType);
        response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");

        // Send file content to client
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, bytesRead, 0);
            }
        }
    }
}

