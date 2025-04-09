package event_management;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/rsvp")
public class RSVPServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int eventId = Integer.parseInt(request.getParameter("event_id"));
        String status = request.getParameter("status");

        if (RSVPDAO.addRSVP(user.getId(), eventId, status)) {
            response.sendRedirect("event_details.jsp?event_id=" + eventId + "&success=1");
        } else {
            response.sendRedirect("event_details.jsp?event_id=" + eventId + "&error=1");
        }
    }
}
