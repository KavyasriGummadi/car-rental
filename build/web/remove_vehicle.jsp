<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin.jsp");
        return;
    }

    String msg = request.getParameter("msg");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/car_rental_db",
            "root",
            "password"
        );

        // Delete vehicle
        String deleteId = request.getParameter("deleteId");
        if (deleteId != null) {
            ps = con.prepareStatement("DELETE FROM vehicles WHERE id=?");
            ps.setInt(1, Integer.parseInt(deleteId));
            ps.executeUpdate();
            response.sendRedirect("remove_vehicle.jsp?msg=Vehicle Deleted Successfully");
            return;
        }

        ps = con.prepareStatement("SELECT * FROM vehicles");
        rs = ps.executeQuery();

    } catch (Exception e) {
        msg = "Database Error!";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Remove Vehicle</title>
    <style>
        body { font-family: Arial; background: #f2f2f2; }
        .container { width: 95%; margin: 40px auto; background: white; padding: 20px; border-radius: 10px; box-shadow:0 0 10px gray; }
        h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #2c3e50; color: white; }
        .delete { background: #e74c3c; color: white; padding: 6px 12px; border-radius: 4px; text-decoration: none; }
        .delete:hover { background: #c0392b; }
        .msg { text-align: center; color: green; margin-top: 10px; }
        img { width: 120px; height: 80px; border-radius: 5px; }
    </style>
</head>
<body>

<div class="container">
    <h2>Remove Vehicle</h2>

    <% if (msg != null) { %>
        <div class="msg"><%= msg %></div>
    <% } %>

    <table>
        <tr>
            <th>ID</th>
            <th>Vehicle Name</th>
            <th>Vehicle Number</th>
            <th>Type</th>
            <th>Price / Day</th>
            <th>Status</th>
            <th>Image</th>
            <th>Action</th>
        </tr>

        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("vehicle_name") %></td>
            <td><%= rs.getString("vehicle_number") %></td>
            <td><%= rs.getString("vehicle_type") %></td>
            <td>₹ <%= rs.getDouble("rental_price_per_day") %></td>
            <td><%= rs.getString("status") %></td>
            <td>
                <img src="ImageServlet?id=<%= rs.getInt("id") %>" alt="Vehicle Image">
            </td>
            <td>
                <a class="delete" href="remove_vehicle.jsp?deleteId=<%= rs.getInt("id") %>" 
                   onclick="return confirm('Are you sure you want to delete this vehicle?');">
                   Delete
                </a>
            </td>
        </tr>
        <% } %>
    </table>

    <br>
    <a href="admin_dashboard.jsp">⬅ Back to Dashboard</a>
</div>

</body>
</html>

<%
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (Exception e) {}
%>
