<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Car Rental Management System</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            font-family: Arial, Helvetica, sans-serif;

            /* Background Image */
            background: url("images/car_bg.jpg") no-repeat center center fixed;
            background-size: cover;
        }

        /* Overlay for readability */
        .overlay {
            background: rgba(0, 0, 0, 0.6);
            height: 100%;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            text-align: center;
            color: white;
            padding: 40px;
            border-radius: 10px;
        }

        h1 {
            font-size: 40px;
            margin-bottom: 10px;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 25px;
            margin: 10px;
            font-size: 16px;
            text-decoration: none;
            color: white;
            background-color: #e74c3c;
            border-radius: 5px;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>

<body>

<div class="overlay">
    <div class="container">
        <h1>Car Rental Management System</h1>
        <p>Book Cars Easily | Manage Rentals | Secure Payments</p>

        <a href="login.jsp" class="btn">Login</a>
        <a href="register.jsp" class="btn">Register</a>
        <a href="admin.jsp" class="btn">admin</a>
    </div>
</div>

</body>
</html>
