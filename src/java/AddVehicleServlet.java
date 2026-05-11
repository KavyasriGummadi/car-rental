import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/AddVehicleServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB
public class AddVehicleServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {

        String vname = request.getParameter("vname");
        String vnumber = request.getParameter("vnumber");
        String vtype = request.getParameter("vtype");
        String status = request.getParameter("status");
        double price = Double.parseDouble(request.getParameter("price"));

        Part filePart = request.getPart("image");
        InputStream imageStream = filePart.getInputStream();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/car_rental_db",
                "root",
                "password"
            );

            String sql = "INSERT INTO vehicles(vehicle_name, vehicle_number, vehicle_type, rental_price_per_day, status, image) VALUES (?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, vname);
            ps.setString(2, vnumber);
            ps.setString(3, vtype);
            ps.setDouble(4, price);
            ps.setString(5, status);
            ps.setBlob(6, imageStream);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect("add_vehicle.jsp?msg=Vehicle Added Successfully");

        } catch (Exception e) {
            response.sendRedirect("add_vehicle.jsp?msg=Error Occurred");
        }
    }
}
