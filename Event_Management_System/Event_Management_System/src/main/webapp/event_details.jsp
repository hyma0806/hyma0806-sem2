<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="event_management.Event, event_management.EventDAO, event_management.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
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
    <title>Event Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff9a9e, #fad0c4);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background: white;
            box-shadow: 0px 0px 10px gray;
            border-radius: 10px;
        }
        h2 { text-align: center; color: #333; }
        p { font-size: 18px; }
        .rsvp-form {
            margin-top: 20px;
        }
        select, button {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 16px;
            width: 100%;
        }
        button {
            background: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            margin-top: 10px;
        }
        .back-btn {
            background: #007bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><%= event.getName() %></h2>
        <p><strong>Date:</strong> <%= event.getDate() %></p>
        <p><strong>Location:</strong> <%= event.getLocation() %></p>
        <p><strong>Description:</strong> <%= event.getDescription() %></p>
        <p><strong>Type:</strong> <%= event.getType() %></p>

        <!-- RSVP Form -->
        <form action="RSVPServlet" method="post" class="rsvp-form">
            <input type="hidden" name="event_id" value="<%= event.getId() %>">
            <label for="rsvp_status"><strong>RSVP Status:</strong></label>
            <select name="status" id="rsvp_status">
                <option value="Going">Going</option>
                <option value="Not Going">Not Going</option>
            </select>
            <button type="submit">Submit RSVP</button>
        </form>
        
        <a href="dashboard.jsp"><button type="button" class="back-btn">Back to Dashboard</button></a>
    </div>
</body>
</html>
