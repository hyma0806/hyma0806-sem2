package event_management;
public class RSVP {
    private int id;
    private int userId;
    private int eventId;
    private String status;

    public RSVP(int id, int userId, int eventId, String status) {
        this.id = id;
        this.userId = userId;
        this.eventId = eventId;
        this.status = status;
    }

    public int getId() { return id; }
    public int getUserId() { return userId; }
    public int getEventId() { return eventId; }
    public String getStatus() { return status; }
}
