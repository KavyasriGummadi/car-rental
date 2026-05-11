<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Student session check
    if (session.getAttribute("student_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f4f7;
            margin: 0;
            padding: 0;
        }

        .header {
            background: #2980b9;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 22px;
        }

        .header a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-size: 16px;
        }

        .header a:hover {
            text-decoration: underline;
        }

        .container {
            width: 95%;
            margin: 20px auto;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .card {
            background: white;
            border-radius: 10px;
            width: 250px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            overflow: hidden;
            text-align: center;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .card h3 {
            margin: 10px 0;
            color: #2c3e50;
        }

        .card p {
            margin: 5px 0;
            color: #34495e;
        }

        .buy-btn {
            display: inline-block;
            margin: 10px 0 15px 0;
            padding: 10px 15px;
            background: #27ae60;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }

        .buy-btn:hover {
            background: #1e8449;
        }
    </style>
</head>
<body>

<div class="header">
    Welcome, <%= session.getAttribute("student_name") %>!
    <a href="logout.jsp">Logout</a>
</div>

<div class="container">
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db", "root", "password");

        // Select only available vehicles
        ps = con.prepareStatement("SELECT * FROM vehicles WHERE status='Available'");
        rs = ps.executeQuery();

        while (rs.next()) {
            int vid = rs.getInt("id");
            String vname = rs.getString("vehicle_name");
            String vnumber = rs.getString("vehicle_number");
            String vtype = rs.getString("vehicle_type");
            double price = rs.getDouble("rental_price_per_day");
%>

    <div class="card">
        <img src="ImageServlet?id=<%= vid %>" alt="Vehicle Image">
        <h3><%= vname %></h3>
        <p>Type: <%= vtype %></p>
        <p>Number: <%= vnumber %></p>
        <p>Price/Day: ₹ <%= price %></p>
        <a class="buy-btn" href="payment.jsp?vehicle_id=<%= vid %>">Buy Now</a>
    </div>

<%
        }
    } catch(Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if(rs != null) rs.close(); if(ps != null) ps.close(); if(con != null) con.close(); } catch(Exception ex) {}
    }
%>
</div>

</body>
</html>
