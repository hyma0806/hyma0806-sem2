package event_management;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/event_management?useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    /**
     * Establishes and returns a database connection.
     *
     * @return Connection object if successful, null otherwise.
     */
    public static Connection getConnection() {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("Error: MySQL JDBC Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error: Database connection failed!");
            e.printStackTrace();
        }
        return null;
    }
}
