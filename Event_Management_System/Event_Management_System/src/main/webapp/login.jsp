<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="event_management.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect("dashboard.jsp");
        return;  // Ensure the rest of the page does not load
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Event Management</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; text-align: center; }
        .container { max-width: 400px; margin: 100px auto; padding: 20px; background: white; box-shadow: 0px 0px 10px gray; border-radius: 10px; }
        input, button { width: 90%; padding: 10px; margin: 10px 0; border-radius: 5px; border: 1px solid #ccc; }
        button { background: #007bff; color: white; border: none; }
        button:hover { background: #0056b3; }
        a { text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">Invalid credentials, try again.</p>
        <% } %>
        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <p>New user? <a href="register.jsp">Register here</a></p>
    </div>
</body>
</html>
