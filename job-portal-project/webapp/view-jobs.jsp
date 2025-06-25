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
    <title>Available Jobs</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f3f6f9;
        }
        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #fff;
        }
        th, td {
            padding: 12px 20px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        .apply-btn {
            padding: 6px 14px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .applied-btn {
            padding: 6px 14px;
            background-color: gray;
            color: white;
            border-radius: 5px;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Available Jobs</h2>
<table>
    <tr>
        <th>Title</th>
        <th>Company</th>
        <th>Description</th>
        <th>Status</th>
    </tr>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database_name", "root", "password_of_database");

        // Get all jobs
        Statement stmt = con.createStatement();
        ResultSet jobs = stmt.executeQuery("SELECT * FROM jobs");

        while (jobs.next()) {
            int jobId = jobs.getInt("id");
            String title = jobs.getString("title");
            String company = jobs.getString("company");
            String description = jobs.getString("description");

            // Check if this job is already applied by current user
            PreparedStatement ps = con.prepareStatement(
                "SELECT id FROM applications WHERE user_email = ? AND job_id = ?");
            ps.setString(1, email);
            ps.setInt(2, jobId);
            ResultSet applied = ps.executeQuery();

            boolean isApplied = applied.next(); // true if record exists
%>
    <tr>
        <td><%= title %></td>
        <td><%= company %></td>
        <td><%= description %></td>
        <td>
            <% if (isApplied) { %>
                <span class="applied-btn">Applied</span>
            <% } else { %>
                <a class="apply-btn" href="ApplyJobServlet?jobId=<%= jobId %>">Apply</a>
            <% } %>
        </td>
    </tr>
<%
        }
        con.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
</table>

</body>
</html>
