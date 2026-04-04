<%@ page import="java.net.*, java.io.*" %>

<html>
<head>
    <title>Register</title>
</head>
<body>

<div style="width:300px;margin:auto;margin-top:100px;border:1px solid black;padding:20px;">
    <h2>Register</h2>

    <form method="post">
        Name:<br>
        <input type="text" name="name"/><br><br>

        Email:<br>
        <input type="text" name="email"/><br><br>

        Password:<br>
        <input type="password" name="password"/><br><br>

        <button type="submit">Register</button>
    </form>

    <br>
    <a href="login.jsp">Login</a>
</div>

<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

if(name != null){

    try {
        URL url = new URL("http://localhost:8081/api/auth/register");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        String jsonInput = "{ \"name\": \"" + name + "\", \"email\": \"" + email + "\", \"password\": \"" + password + "\" }";

        OutputStream os = conn.getOutputStream();
        os.write(jsonInput.getBytes());
        os.flush();
        os.close();

        response.sendRedirect("login.jsp");

    } catch(Exception e){
%>
        <p style="color:red;">Register Failed</p>
<%
    }
}
%>

</body>
</html>