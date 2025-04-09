<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="event_management.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Event</title>
</head>
<body>
    <h2>Add New Event</h2>
    <form action="EventServlet" method="post">
        <input type="text" name="name" placeholder="Event Name" required>
        <input type="date" name="date" required>
        <input type="text" name="location" placeholder="Location" required>
        <input type="text" name="description" placeholder="Description" required>
        <input type="text" name="type" placeholder="Type" required>
        <button type="submit">Add Event</button>
    </form>
</body>
</html>
