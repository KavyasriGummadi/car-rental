<%
    // Admin session check
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: #ecf0f1;
        }

        .header {
            background: #2c3e50;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 22px;
        }

        .container {
            width: 400px;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px gray;
            text-align: center;
        }

        a {
            display: block;
            padding: 15px;
            margin: 15px 0;
            background: #3498db;
            color: white;
            text-decoration: none;
            font-size: 18px;
            border-radius: 5px;
            transition: 0.3s;
        }

        a:hover {
            background: #2980b9;
        }

        .logout {
            background: #e74c3c;
        }

        .logout:hover {
            background: #c0392b;
        }
    </style>
</head>

<body>

<div class="header">
    Admin Dashboard
</div>

<div class="container">
    <a href="add_vehicle.jsp">Add Vehicle</a>
    <a href="remove_vehicle.jsp">Remove Vehicle</a>
    <a href="index.jsp">Logout</a>
</div>

</body>
</html>
