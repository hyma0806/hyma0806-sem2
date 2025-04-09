<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, event_management.Event, event_management.EventDAO, event_management.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch search query parameters
    String searchName = request.getParameter("searchName");
    String searchCategory = request.getParameter("searchCategory");

    List<Event> events;
    if (searchName != null || searchCategory != null) {
        events = EventDAO.searchEvents(searchName, searchCategory);
    } else {
        events = EventDAO.getAllEvents();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Event Management</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 0; padding: 0; }
        .header { background: #007bff; color: white; padding: 15px; display: flex; justify-content: space-between; align-items: center; }
        .header h2 { margin: 0; }
        .header .buttons { display: flex; gap: 10px; }
        .header button { background: white; color: #007bff; border: none; padding: 8px 15px; cursor: pointer; border-radius: 5px; font-weight: bold; }
        .header button:hover { background: #0056b3; color: white; }
        
        .container { max-width: 900px; margin: auto; padding: 20px; background: white; box-shadow: 0px 0px 10px gray; border-radius: 10px; margin-top: 20px; }
        
        /* Search Bar */
        .search-bar { display: flex; gap: 10px; margin-bottom: 20px; }
        .search-bar input, .search-bar select, .search-bar button { padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .search-bar button { background: #28a745; color: white; border: none; cursor: pointer; }
        .search-bar button:hover { background: #218838; }
        
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background: #007bff; color: white; }
        .action-btn { background: #28a745; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 3px; }
        .action-btn:hover { background: #218838; }
    </style>
</head>
<body>

    <!-- Header Section -->
    <div class="header">
        <h2>Event Management Dashboard</h2>
        <div class="buttons">
            <a href="addEvent.jsp"><button>Add Event</button></a>
            <a href="LogoutServlet"><button>Logout</button></a>
        </div>
    </div>

    <!-- Search Bar -->
    <div class="container">
        <form method="GET" action="dashboard.jsp" class="search-bar">
            <input type="text" name="searchName" placeholder="Search by event name" value="<%= searchName != null ? searchName : "" %>">
            <select name="searchCategory">
                <option value="">All Categories</option>
                <option value="Conference" <%= "Conference".equals(searchCategory) ? "selected" : "" %>>Conference</option>
                <option value="Wedding" <%= "Wedding".equals(searchCategory) ? "selected" : "" %>>Wedding</option>
                <option value="Workshop" <%= "Workshop".equals(searchCategory) ? "selected" : "" %>>Workshop</option>
                <option value="Party" <%= "Party".equals(searchCategory) ? "selected" : "" %>>Party</option>
            </select>
            <button type="submit">Search</button>
        </form>

        <!-- Event List -->
        <h3>Available Events</h3>
        <% if (events.isEmpty()) { %>
            <p>No events found.</p>
        <% } else { %>
            <table>
                <tr>
                    <th>Name</th>
                    <th>Date</th>
                    <th>Location</th>
                    <th>Type</th>
                    <th>Actions</th>
                </tr>
                <% for (Event event : events) { %>
                    <tr>
                        <td><%= event.getName() %></td>
                        <td><%= event.getDate() %></td>
                        <td><%= event.getLocation() %></td>
                        <td><%= event.getType() %></td>
                        <td>
                            <a href="event_details.jsp?event_id=<%= event.getId() %>">
                                <button class="action-btn">View</button>
                            </a>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } %>
    </div>

</body>
</html>
