<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - Job Portal</title>
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #eef2f3, #dfe6e9);
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 30px 0;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        header h1 {
            margin: 0;
            font-size: 2em;
        }

        header p {
            margin: 5px 0 0;
            font-size: 1.1em;
        }

        .logout-btn {
            display: inline-block;
            margin-top: 15px;
            color: white;
            text-decoration: none;
            background-color: #e74c3c;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
            transform: scale(1.05);
        }

        nav {
            background-color: #34495e;
            display: flex;
            justify-content: center;
            padding: 10px 0;
            gap: 20px;
            flex-wrap: wrap;
        }

        nav a {
            color: white;
            text-decoration: none;
            background-color: #2980b9;
            padding: 10px 18px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s;
        }

        nav a:hover {
            background-color: #1abc9c;
            transform: scale(1.05);
        }

        .content {
            padding: 50px 20px;
            max-width: 1100px;
            margin: auto;
        }

        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 25px;
            text-align: center;
            text-decoration: none;
            color: #2c3e50;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            width: 260px;
            min-height: 220px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        .card h3 {
            margin-top: 10px;
            color: #2980b9;
        }

        .card p {
            font-size: 14px;
            color: #555;
        }

        .card i {
            margin-bottom: 10px;
            transition: transform 0.3s ease;
        }

        .card:hover i {
            transform: scale(1.1);
        }

        .card img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        }

        .card-row {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
        }

        @media (max-width: 800px) {
            .card-row {
                flex-direction: column;
                align-items: center;
                gap: 20px;
            }
            .card {
                width: 90vw;
                min-width: 0;
            }
        }
    </style>
</head>
<body>

<header>
    <h1>Welcome to Your Dashboard</h1>
    <p>Hello, <%= username %> </p>
    <a href="LogoutServlet" class="logout-btn">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>
</header>

<div class="content">
    <div class="card-row">
        <a href="view-jobs.jsp" class="card">
            <i class="fas fa-briefcase fa-3x" style="color: #2980b9;"></i>
            <h3>View Jobs</h3>
            <p>Explore and apply to the latest job openings.</p>
        </a>
        <a href="applied-jobs.jsp" class="card">
            <i class="fas fa-tasks fa-3x" style="color: #2980b9;"></i>
            <h3>My Applications</h3>
            <p>Track your job applications and their status.</p>
        </a>
        <a href="profile.jsp" class="card">
            <i class="fas fa-user-circle fa-3x" style="color: #2980b9;"></i>
            <h3>Profile</h3>
            <p>View and edit your profile information.</p>
        </a>
        <a href="resume-upload.jsp" class="card">
            <i class="fas fa-file-upload fa-3x" style="color: #2980b9;"></i>
            <h3>Upload Resume</h3>
            <p>Upload or update your resume for employers.</p>
        </a>
    </div>
</div>

</body>
</html>
