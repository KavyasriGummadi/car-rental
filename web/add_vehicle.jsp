<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Vehicle</title>
    <style>
        /* Background */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #2980b9, #6dd5fa);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Form Container */
        .form-container {
            background: white;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            width: 400px;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
        }

        /* Input fields */
        input[type="text"],
        input[type="number"],
        select,
        input[type="file"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 15px;
        }

        /* Submit Button */
        input[type="submit"] {
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

        input[type="submit"]:hover {
            background-color: #1e8449;
        }

        /* Labels */
        label {
            font-weight: bold;
            color: #34495e;
        }

        /* Responsive */
        @media(max-width: 500px) {
            .form-container {
                width: 90%;
                padding: 30px 20px;
            }
        }
    </style>
</head>

<body>
    <div class="form-container">
        <h2>Add Vehicle</h2>

        <form action="AddVehicleServlet" method="post" enctype="multipart/form-data">

            <label>Vehicle Name:</label>
            <input type="text" name="vname" placeholder="Enter Vehicle Name" required>

            <label>Vehicle Number:</label>
            <input type="text" name="vnumber" placeholder="Enter Vehicle Number" required>

            <label>Vehicle Type:</label>
            <select name="vtype" required>
                <option value="">-- Select Vehicle Type --</option>
                <option>Car</option>
                <option>SUV</option>
                <option>Bike</option>
                <option>Van</option>
            </select>

            <label>Rental Price / Day:</label>
            <input type="number" step="0.01" name="price" placeholder="Enter Price per Day" required>

            <label>Status:</label>
            <select name="status" required>
                <option value="">-- Select Status --</option>
                <option>Available</option>
                <option>Booked</option>
            </select>

            <label>Vehicle Image:</label>
            <input type="file" name="image" accept="image/*" required>

            <input type="submit" value="Add Vehicle">
        </form>
    </div>
</body>
</html>
