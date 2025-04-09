package event_management;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RSVPDAO {
    public static boolean addRSVP(int userId, int eventId, String status) {
        try (Connection con = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO rsvp (user_id, event_id, status) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE status = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            ps.setString(3, status);
            ps.setString(4, status);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<RSVP> getRSVPsByEvent(int eventId) {
        List<RSVP> rsvpList = new ArrayList<>();
        try (Connection con = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM rsvp WHERE event_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rsvpList.add(new RSVP(rs.getInt("rsvp_id"), rs.getInt("user_id"), rs.getInt("event_id"), rs.getString("status")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rsvpList;
    }
}
