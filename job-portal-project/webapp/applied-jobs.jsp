<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Applications</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f8;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
            color: #333;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .back-link {
            text-align: center;
            margin: 20px;
        }

        .back-link a {
            text-decoration: none;
            color: #007BFF;
            font-weight: bold;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<header>
    <h1>My Job Applications</h1>
</header>

<h2>Jobs You've Applied For</h2>

<table>
    <tr>
        <th>Job Title</th>
        <th>Company</th>
        <th>Applied Date</th>
    </tr>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database_name", "root", "password_of_database");

        PreparedStatement ps = con.prepareStatement(
            "SELECT j.title, j.company, a.applied_date FROM applications a JOIN jobs j ON a.job_id = j.id WHERE a.user_email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("company") %></td>
        <td><%= rs.getDate("applied_date") %></td>
    </tr>
<%
        }
        con.close();
    } catch (Exception e) {
%>
    <tr>
        <td colspan="3" style="color:red;"><%= e.getMessage() %></td>
    </tr>
<%
    }
%>
</table>

<div class="back-link">
    <a href="dashboard.jsp">&larr; Back to Dashboard</a>
</div>

</body>
</html>
