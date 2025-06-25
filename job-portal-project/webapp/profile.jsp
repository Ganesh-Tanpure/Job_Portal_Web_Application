<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page import="java.io.File" %>

<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("index.html");
        return;
    }

    //String name = "", phone = "";
    String name = "", phone = "", resumeFile = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database_name", "root", "password_of_database");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            phone = rs.getString("phone");
            resumeFile = rs.getString("resume_path");
        }

        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <style>
        /* Reset some basic styles */
body {
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', sans-serif;
    background-color: #eef2f3;
}

/* Heading */
h2 {
    text-align: center;
    margin-top: 30px;
    color: #2c3e50;
}

/* Form styling */
form {
    background-color: #ffffff;
    width: 400px;
    margin: 30px auto;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

label {
    display: block;
    margin-top: 15px;
    margin-bottom: 5px;
    font-weight: bold;
    color: #333;
}

input[type="text"],
input[type="email"] {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 15px;
    margin-bottom: 10px;
    box-sizing: border-box;
}

input[type="submit"] {
    width: 100%;
    background-color: #007bff;
    color: white;
    font-weight: bold;
    padding: 12px;
    border: none;
    border-radius: 6px;
    margin-top: 20px;
    cursor: pointer;
    font-size: 16px;
}

input[type="submit"]:hover {
    background-color: #0056b3;
}

/* Resume section */
.resume-section {
    width: 400px;
    margin: 10px auto 30px auto;
    background-color: #fff;
    padding: 20px 30px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    text-align: center;
    font-size: 15px;
}

.resume-section p {
    margin: 10px 0;
    color: #2c3e50;
}

.resume-section a {
    display: inline-block;
    margin: 8px 10px;
    color: #007bff;
    text-decoration: none;
    font-weight: bold;
}

.resume-section a:hover {
    text-decoration: underline;
}

/* Back link area */
.back-link {
    text-align: center;
    margin-top: 20px;
    font-size: 15px;
}

.back-link a {
    margin: 0 10px;
    color: #007bff;
    text-decoration: none;
    font-weight: bold;
}

.back-link a:hover {
    text-decoration: underline;
}

    </style>
</head>
<body>

<h2>Your Profile</h2>

<form action="UpdateProfileServlet" method="post">
    <label>Name:</label>
    <input type="text" name="name" value="<%= name %>" required>

    <label>Email:</label>
    <input type="email" name="email" value="<%= email %>" readonly>

    <label>Mobile:</label>
    <input type="text" name="phone" value="<%= phone %>" required>

    <input type="submit" value="Update Profile">
</form>

<div class="resume-section">

<%
    if (resumeFile != null && !resumeFile.trim().isEmpty()) {
%>
    <p><strong>Resume Uploaded:</strong> <%= resumeFile %></p>

    <a href="ViewResumeServlet?file=<%= resumeFile %>" target="_blank">View Resume</a>  
<%
    } else {
%>
    <p style="color:red;">No resume uploaded.</p>
<%
    }
%>


</div>


<div class="back-link">
<a href="update.jsp"> Edit profile</a>
    <a href="dashboard.jsp">&larr; Back to Dashboard</a>
</div>

</body>
</html>
