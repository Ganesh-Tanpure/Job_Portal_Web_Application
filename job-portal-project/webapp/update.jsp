<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("index.html");
        return;
    }

    String name = "", phone = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database_name", "root", "password_of_database");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            phone = rs.getString("phone");
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
    <title>Update Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f3;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            background-color: white;
            padding: 30px;
            margin: auto;
            width: 400px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        .back-link {
            text-align: center;
            margin-top: 15px;
        }

        .back-link a {
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>

<h2>Update Your Profile</h2>

<form action="UpdateProfileServlet" method="post">
    <label>Name:</label>
    <input type="text" name="name" value="<%= name %>" required>

    <label>Email:</label>
    <input type="email" name="email" value="<%= email %>" readonly>

    <label>Mobile:</label>
    <input type="text" name="phone" value="<%= phone %>" required>

    <input type="submit" value="Update Profile">
</form>

<div class="back-link">
    <a href="profile.jsp">&larr; Back to Profile</a>
</div>

</body>
</html>
