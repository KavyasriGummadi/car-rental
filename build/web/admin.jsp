<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String msg = "";

    if (request.getMethod().equalsIgnoreCase("POST")) {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Default Admin Credentials
        if ("admin".equals(username) && "admin123".equals(password)) {

            session.setAttribute("admin", "admin");
            response.sendRedirect("admin_dashboard.jsp");

        } else {
            msg = "Invalid Admin Credentials!";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>

    <style>
        body {
            font-family: Arial;
            background: #2c3e50;
        }
        .box {
            width: 350px;
            margin: 120px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px black;
        }
        h2 {
            text-align: center;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #e67e22;
            color: white;
            border: none;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background: #d35400;
        }
        .msg {
            color: red;
            text-align: center;
        }
    </style>
</head>

<body>

<div class="box">
    <h2>Admin Login</h2>

    <form method="post">
        <input type="text" name="username" placeholder="Admin Username" required>
        <input type="password" name="password" placeholder="Admin Password" required>
        <button type="submit">Login</button>
    </form>

    <div class="msg"><%= msg %></div>
</div>

</body>
</html>
