# Car Rental Management System

A Java web application developed using JSP, Servlets, JDBC, HTML, CSS, Bootstrap, and MySQL.  
This project helps manage vehicle rentals with admin operations, user flows, vehicle records, payments, and image handling.

## Features
- Admin login and dashboard
- User registration and login
- Student/user dashboard
- Add vehicle details
- Remove vehicle records
- Vehicle rental/payment module
- Upload vehicle image
- Display vehicle images from database
- MySQL database integration

## Technologies Used
- Java
- JSP and Servlets
- JDBC
- MySQL
- HTML
- CSS
- Bootstrap
- NetBeans / GlassFish or Tomcat

## Project Structure
- `src/java/` - Java servlet source files
- `web/` - JSP pages and frontend files
- `web/WEB-INF/` - Deployment configuration files
- `build/` - Generated build output
- `nbproject/` - NetBeans project configuration

## Important Modules
- `AddVehicleServlet` - Adds vehicle information and uploads image to database
- `ImageServlet` - Fetches vehicle image from database and displays it in browser
- `add_vehicle.jsp` - Vehicle entry form
- `admin_dashboard.jsp` - Admin dashboard
- `student_dashboard.jsp` - User dashboard
- `payment.jsp` - Payment-related page

## Database
This project uses MySQL database.

Example database configuration from the code:
- Database: `car_rental_db`
- Username: `root`
- Password: `password`

Update the database username, password, and JDBC configuration based on your local setup.

## Vehicle Image Handling
The project supports vehicle image upload using `@MultipartConfig` in `AddVehicleServlet`.  
Uploaded images are stored in the MySQL database as BLOB data and displayed through `ImageServlet`.

## How to Run
1. Clone or download the project.
2. Open the project in NetBeans or another Java IDE.
3. Create the MySQL database `car_rental_db`.
4. Create the required tables such as `vehicles`.
5. Update database credentials in servlet files.
6. Add MySQL JDBC driver to the project libraries.
7. Deploy the project on Apache Tomcat or GlassFish.
8. Run the application in the browser.

## Notes
- Some database credentials are hardcoded in the source code.
- Build files and IDE-specific files are included in the repository.
- Input validation and security improvements can be added for production use.

## Author
Kavyasri Gummadi
