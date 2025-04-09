package event_management;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    // ✅ Add New Event
    public static boolean addEvent(String name, String date, String location, String description, String type, int createdBy) {
        String query = "INSERT INTO events (name, date, location, description, type, created_by) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, name);
            ps.setString(2, date);
            ps.setString(3, location);
            ps.setString(4, description);
            ps.setString(5, type);
            ps.setInt(6, createdBy);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Get All Events
    public static List<Event> getAllEvents() {
        List<Event> eventList = new ArrayList<>();
        String query = "SELECT * FROM events";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                eventList.add(mapEvent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return eventList;
    }

    // ✅ Get Event By ID
    public static Event getEventById(int eventId) {
        String query = "SELECT * FROM events WHERE id = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapEvent(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Update Event (Admin only)
    public static boolean updateEvent(int id, String name, String date, String location, String description, String type) {
        String query = "UPDATE events SET name=?, date=?, location=?, description=?, type=? WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, name);
            ps.setString(2, date);
            ps.setString(3, location);
            ps.setString(4, description);
            ps.setString(5, type);
            ps.setInt(6, id);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Delete Event (Admin only)
    public static boolean deleteEvent(int id) {
        String query = "DELETE FROM events WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Search Events by Name or Category
    public static List<Event> searchEvents(String name, String category) {
        List<Event> eventList = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM events WHERE 1=1");

        if (name != null && !name.isEmpty()) {
            queryBuilder.append(" AND name LIKE ?");
        }
        if (category != null && !category.isEmpty()) {
            queryBuilder.append(" AND type = ?");
        }

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(queryBuilder.toString())) {

            int index = 1;
            if (name != null && !name.isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (category != null && !category.isEmpty()) {
                ps.setString(index++, category);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    eventList.add(mapEvent(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return eventList;
    }

    // ✅ Helper Method to Map ResultSet to Event Object
    private static Event mapEvent(ResultSet rs) throws SQLException {
        return new Event(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("date"),
                rs.getString("location"),
                rs.getString("description"),
                rs.getString("type"),
                rs.getInt("created_by")
        );
    }
}
