<%@ page import="java.util.List, event_management.EventDAO, event_management.Event" %>
<%
    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getAllEvents();
    String role = (String) session.getAttribute("role");
%>

<h2>Event Management</h2>

<% if ("admin".equals(role)) { %>
<form action="EventServlet" method="post">
    <input type="hidden" name="action" value="add">
    <input type="text" name="name" placeholder="Event Name" required>
    <input type="date" name="date" required>
    <input type="text" name="location" placeholder="Location" required>
    <textarea name="description" placeholder="Description" required></textarea>
    <select name="type">
        <option value="Conference">Conference</option>
        <option value="Wedding">Wedding</option>
        <option value="Workshop">Workshop</option>
        <option value="Party">Party</option>
    </select>
    <button type="submit">Add Event</button>
</form>
<% } %>

<ul>
<% for (Event event : events) { %>
    <li><%= event.getName() %> - <%= event.getDate() %> 
        <% if ("admin".equals(role)) { %>
            <a href="EventServlet?action=delete&id=<%= event.getId() %>">Delete</a>
        <% } %>
    </li>
<% } %>
</ul>
