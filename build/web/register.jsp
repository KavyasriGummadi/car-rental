<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String msg = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.jdbc.Driver"); // MySQL Driver
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/car_rental_db",
                    "root",
                    "password"
            );

            String sql = "INSERT INTO users(name,email,password,phone) VALUES(?,?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);

            int i = ps.executeUpdate();
            if (i > 0) {
                msg = "Registration Successful!";
            } else {
                msg = "Registration Failed!";
            }

        } catch (Exception e) {
            msg = "Email already exists!";
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ex) {}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <style>
        body {
            font-family: Arial;
            background: #f2f2f2;
        }
        .box {
            width: 350px;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px gray;
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
            background: #e74c3c;
            color: white;
            border: none;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background: #c0392b;
        }
        .msg {
            text-align: center;
            color: green;
        }
        a {
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>

<body>

<div class="box">
    <h2>User Registration</h2>

    <form method="post">
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="text" name="phone" placeholder="Mobile Number" required>

        <button type="submit">Register</button>
    </form>

    <div class="msg"><%= msg %></div>

    <a href="login.jsp">Already have an account? Login</a>
</div>

</body>
</html>
