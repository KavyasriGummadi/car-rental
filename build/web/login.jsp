<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Message to display errors
    String msg = "";

    // Process login only on POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            // Update your MySQL password if required
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/car_rental_db",
                "root",
                "password"
            );

            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                // Login success → create session
                session.setAttribute("student_id", rs.getInt("id"));
                session.setAttribute("student_name", rs.getString("name"));
                session.setAttribute("student_email", rs.getString("email"));

                // Redirect BEFORE sending any HTML output
                response.sendRedirect(request.getContextPath() + "/student_dashboard.jsp");
                return; // Important: stop further JSP execution
            } else {
                msg = "Invalid Email or Password!";
            }

        } catch (Exception e) {
            msg = "Something went wrong: " + e.getMessage();
        } finally {
            try { if(rs != null) rs.close(); if(ps != null) ps.close(); if(con != null) con.close(); } catch(Exception ex) {}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #2980b9, #6dd5fa);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            background: white;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            width: 400px;
        }

        .login-box h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .login-box input[type="email"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 15px;
        }

        .login-box button {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            border: none;
            border-radius: 6px;
            background-color: #27ae60;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-box button:hover {
            background-color: #1e8449;
        }

        .msg {
            text-align: center;
            color: red;
            margin-top: 10px;
        }

        .login-box a {
            display: block;
            text-align: center;
            margin-top: 15px;
            text-decoration: none;
            color: #2980b9;
        }

        .login-box a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Student Login</h2>

    <form method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>

        <button type="submit">Login</button>
    </form>

    <div class="msg"><%= msg %></div>

    <a href="register.jsp">New User? Register Here</a>
</div>

</body>
</html>
