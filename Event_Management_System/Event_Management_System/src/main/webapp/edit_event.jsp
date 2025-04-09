<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="event_management.Event, event_management.EventDAO, event_management.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    Event event = null;
    try {
        int eventId = Integer.parseInt(request.getParameter("event_id"));
        event = EventDAO.getEventById(eventId);
    } catch (Exception e) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    if (event == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Event</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 500px;
            margin: auto;
            padding: 20px;
            background: white;
            box-shadow: 0px 0px 10px gray;
            border-radius: 10px;
        }
        h2 { text-align: center; color: #333; }
        label { font-weight: bold; display: block; margin-top: 10px; }
        input, textarea, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            width: 100%;
            background: #28a745;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 15px;
        }
        .cancel-btn {
            background: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Event</h2>
        <form action="EventServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= event.getId() %>">

            <label>Name:</label>
            <input type="text" name="name" value="<%= event.getName() %>" required>

            <label>Date & Time:</label>
            <input type="datetime-local" name="date" value="<%= event.getDate() %>" required>

            <label>Location:</label>
            <input type="text" name="location" value="<%= event.getLocation() %>" required>

            <label>Description:</label>
            <textarea name="description" required><%= event.getDescription() %></textarea>

            <label>Type:</label>
            <select name="type" required>
                <option value="Conference" <%= event.getType().equals("Conference") ? "selected" : "" %>>Conference</option>
                <option value="Wedding" <%= event.getType().equals("Wedding") ? "selected" : "" %>>Wedding</option>
                <option value="Workshop" <%= event.getType().equals("Workshop") ? "selected" : "" %>>Workshop</option>
                <option value="Party" <%= event.getType().equals("Party") ? "selected" : "" %>>Party</option>
            </select>

            <button type="submit">Update Event</button>
            <a href="dashboard.jsp"><button type="button" class="cancel-btn">Cancel</button></a>
        </form>
    </div>
</body>
</html>
