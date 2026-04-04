<%@ page import="java.net.*, java.io.*" %>
<%@ page import="org.json.JSONObject" %>

<html>
<head>
    <title>Login</title>
</head>
<body>

<div style="width:300px;margin:auto;margin-top:100px;border:1px solid black;padding:20px;">
    <h2>Login</h2>

    <form method="post">
        Email:<br>
        <input type="text" name="email"/><br><br>

        Password:<br>
        <input type="password" name="password"/><br><br>

        <button type="submit">Login</button>
    </form>

    <br>
    <a href="register.jsp">Register</a>
</div>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

if(email != null && password != null){

    try {
        URL url = new URL("http://localhost:8081/api/auth/login");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        String jsonInput = "{ \"email\": \"" + email + "\", \"password\": \"" + password + "\" }";

        OutputStream os = conn.getOutputStream();
        os.write(jsonInput.getBytes());
        os.flush();
        os.close();

        BufferedReader in = new BufferedReader(
            new InputStreamReader(conn.getInputStream())
        );

        StringBuilder responseStr = new StringBuilder();
        String line;

        while ((line = in.readLine()) != null) {
            responseStr.append(line);
        }

        JSONObject json = new JSONObject(responseStr.toString());

        String token = json.getString("token");

        session.setAttribute("token", token);

        response.sendRedirect("products.jsp");

    } catch(Exception e){
%>
        <p style="color:red;">Login Failed</p>
<%
    }
}
%>

</body>
</html>