package event_management;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/EventServlet")
public class EventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Ensure user is logged in and has admin role
        if (!isAdmin(user)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("dashboard.jsp?error=Invalid action");
            return;
        }

        switch (action) {
            case "add":
                handleAddEvent(request, response, user);
                break;
            case "update":
                handleUpdateEvent(request, response);
                break;
            default:
                response.sendRedirect("dashboard.jsp?error=Unknown action");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Ensure user is logged in and has admin role
        if (!isAdmin(user)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            handleDeleteEvent(request, response);
        } else {
            response.sendRedirect("dashboard.jsp?error=Unknown action");
        }
    }

    // ✅ Check if user is admin
    private boolean isAdmin(User user) {
        return user != null && "admin".equalsIgnoreCase(user.getRole());
    }

    // ✅ Handle adding a new event
    private void handleAddEvent(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String type = request.getParameter("type");

        boolean success = EventDAO.addEvent(name, date, location, description, type, user.getId());
        redirectWithMessage(response, success, "Event Added", "Event Not Added");
    }

    // ✅ Handle updating an existing event
    private void handleUpdateEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String type = request.getParameter("type");

        boolean success = EventDAO.updateEvent(id, name, date, location, description, type);
        redirectWithMessage(response, success, "Event Updated", "Event Not Updated");
    }

    // ✅ Handle deleting an event
    private void handleDeleteEvent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        boolean success = EventDAO.deleteEvent(id);
        redirectWithMessage(response, success, "Event Deleted", "Event Not Deleted");
    }

    // ✅ Utility method for redirection with success/error messages
    private void redirectWithMessage(HttpServletResponse response, boolean success, String successMessage, String errorMessage) throws IOException {
        if (success) {
            response.sendRedirect("dashboard.jsp?success=" + successMessage);
        } else {
            response.sendRedirect("dashboard.jsp?error=" + errorMessage);
        }
    }
}
