<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // -----------------------------
    // 1️⃣ Student session check
    // -----------------------------
    if (session.getAttribute("student_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String msg = "";
    int vehicle_id = 0;
    String vname = "";
    String vnumber = "";
    String vtype = "";
    double pricePerDay = 0.0;

    // -----------------------------
    // 2️⃣ Get vehicle_id from request
    // -----------------------------
    if (request.getParameter("vehicle_id") != null) {
        vehicle_id = Integer.parseInt(request.getParameter("vehicle_id"));

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db","root","password");

            ps = con.prepareStatement("SELECT * FROM vehicles WHERE id=?");
            ps.setInt(1, vehicle_id);
            rs = ps.executeQuery();

            if (rs.next()) {
                vname = rs.getString("vehicle_name");
                vnumber = rs.getString("vehicle_number");
                vtype = rs.getString("vehicle_type");
                pricePerDay = rs.getDouble("rental_price_per_day");
            } else {
                msg = "Vehicle not found!";
            }

        } catch(Exception e) {
            msg = "Error fetching vehicle: " + e.getMessage();
        } finally {
            try { if(rs != null) rs.close(); if(ps != null) ps.close(); if(con != null) con.close(); } catch(Exception ex) {}
        }
    }

    // -----------------------------
    // 3️⃣ Process payment form
    // -----------------------------
    if ("POST".equalsIgnoreCase(request.getMethod()) &&
        request.getParameter("days") != null &&
        request.getParameter("pin") != null) {

        int days = Integer.parseInt(request.getParameter("days"));
        String pin = request.getParameter("pin");
        double totalAmount = days * pricePerDay;

        // Safe cast for session attribute
        int student_id = Integer.parseInt(session.getAttribute("student_id").toString());

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_db","root","password");

            // 1️⃣ Insert booking info into bookings table
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO bookings (student_id, vehicle_id, days, total_amount, payment_pin) VALUES (?,?,?,?,?)"
            );
            ps.setInt(1, student_id);
            ps.setInt(2, vehicle_id);
            ps.setInt(3, days);
            ps.setDouble(4, totalAmount);
            ps.setString(5, pin);
            ps.executeUpdate();
            ps.close();

            // 2️⃣ Update vehicle status to Booked
            ps = con.prepareStatement("UPDATE vehicles SET status='Booked' WHERE id=?");
            ps.setInt(1, vehicle_id);
            ps.executeUpdate();
            ps.close();

            con.close();

            msg = "Payment successful! Total amount ₹ " + totalAmount;

        } catch(Exception e) {
            msg = "Payment failed: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Page</title>
    <style>
        body { font-family: Arial; background: #f0f4f7; margin: 0; padding: 0; }
        .container { width: 400px; margin: 50px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 8px 20px rgba(0,0,0,0.2); }
        h2 { text-align: center; color: #2c3e50; }
        label { font-weight: bold; margin-top: 10px; display: block; }
        input[type="number"], input[type="password"] { width: 100%; padding: 10px; margin: 8px 0; border-radius: 6px; border: 1px solid #ccc; }
        button { width: 100%; padding: 12px; margin-top: 15px; border: none; border-radius: 6px; background: #27ae60; color: white; font-size: 16px; cursor: pointer; }
        button:hover { background: #1e8449; }
        .msg { color: green; text-align: center; margin-top: 10px; }
        .details p { margin: 5px 0; }
    </style>
</head>
<body>

<div class="container">
    <h2>Payment for Vehicle</h2>

    <div class="details">
        <p><b>Vehicle Name:</b> <%= vname %></p>
        <p><b>Vehicle Number:</b> <%= vnumber %></p>
        <p><b>Vehicle Type:</b> <%= vtype %></p>
        <p><b>Price per Day:</b> ₹ <%= pricePerDay %></p>
    </div>

    <form method="post">
        <label>Number of Days:</label>
        <input type="number" name="days" min="1" required>

        <label>Payment PIN:</label>
        <input type="password" name="pin" placeholder="Enter 4-digit PIN" maxlength="4" required>

        <button type="submit">Pay Now</button>
    </form>

    <div class="msg"><%= msg %></div>
    <center>
    <a href="index.jsp">go home </a>
    </center>
</div>


</body>
</html>
