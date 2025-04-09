<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="event_management.EventDAO, event_management.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    int eventId = Integer.parseInt(request.getParameter("event_id"));
    EventDAO.deleteEvent(eventId);
    response.sendRedirect("dashboard.jsp?deleted=1");
%>
