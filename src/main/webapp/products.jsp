<%@ page import="java.net.*, java.io.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<html>
<head>
    <title>Products</title>
</head>
<body>

<div style="width:600px;margin:auto;border:1px solid black;padding:20px;">

<h2>Products</h2>

<a href="cart.jsp">Cart</a> |
<a href="logout.jsp">Logout</a>

<br><br>

<%
String token = (String) session.getAttribute("token");

try {
    URL url = new URL("http://localhost:8082/products");
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

    conn.setRequestMethod("GET");

    if(token != null){
        conn.setRequestProperty("Authorization", "Bearer " + token);
    }

    BufferedReader in = new BufferedReader(
        new InputStreamReader(conn.getInputStream())
    );

    StringBuilder responseStr = new StringBuilder();
    String line;

    while ((line = in.readLine()) != null) {
        responseStr.append(line);
    }

    JSONArray products = new JSONArray(responseStr.toString());

    for(int i=0; i<products.length(); i++){
        JSONObject p = products.getJSONObject(i);
%>

<div style="border:1px solid black;margin:10px;padding:10px;">
    <b><%= p.get("name") %></b><br>
    Price: <%= p.get("price") %>

    <form action="cart.jsp" method="post">
        <input type="hidden" name="id" value="<%= p.get("id") %>"/>
        <input type="hidden" name="name" value="<%= p.get("name") %>"/>
        <input type="hidden" name="price" value="<%= p.get("price") %>"/>
        <button>Add to Cart</button>
    </form>
</div>

<%
    }

} catch(Exception e){
%>
    <p style="color:red;">Error loading products</p>
<%
}
%>

</div>

</body>
</html>