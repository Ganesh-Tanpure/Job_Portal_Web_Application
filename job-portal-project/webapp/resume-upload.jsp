<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Resume</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .upload-container {
            background: white;
            padding: 40px 50px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        input[type="file"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 20px;
            width: 100%;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #3498db;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

<div class="upload-container">
    <h2>Upload Resume</h2>
    <form action="ResumeUploadServlet" method="post" enctype="multipart/form-data">
        <input type="file" name="resume" required /><br>
        <input type="submit" value="Upload" />
    </form>
</div>

</body>
</html>
