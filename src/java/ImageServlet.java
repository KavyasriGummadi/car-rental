import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ImageServlet")
public class ImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) return;

        int id = Integer.parseInt(idStr);

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

            ps = con.prepareStatement("SELECT image FROM vehicles WHERE id=?");
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                Blob blob = rs.getBlob("image");
                if (blob != null) {
                    response.setContentType("image/jpeg");
                    OutputStream out = response.getOutputStream();
                    out.write(blob.getBytes(1, (int) blob.length()));
                    out.flush();
                    out.close();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ex) {}
        }
    }
}
