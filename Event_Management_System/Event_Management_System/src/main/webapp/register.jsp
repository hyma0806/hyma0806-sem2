<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Event Management</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; text-align: center; }
        .container { max-width: 400px; margin: 100px auto; padding: 20px; background: white; box-shadow: 0px 0px 10px gray; border-radius: 10px; }
        input, button { width: 90%; padding: 10px; margin: 10px 0; border-radius: 5px; border: 1px solid #ccc; }
        button { background: #28a745; color: white; border: none; }
        button:hover { background: #218838; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <form action="RegisterServlet" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Register</button>
        </form>
        <p>Already registered? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>
