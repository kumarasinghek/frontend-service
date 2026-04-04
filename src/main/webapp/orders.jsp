<%@ page import="java.net.*, java.io.*, java.util.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<html>
<head>
    <title>Orders</title>
</head>
<body>

<div style="width:600px;margin:auto;border:1px solid black;padding:20px;">

<h2>Orders</h2>

<a href="products.jsp">Products</a> |
<a href="cart.jsp">Cart</a> |
<a href="logout.jsp">Logout</a>

<br><br>

<%
List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
String token = (String) session.getAttribute("token");

if(cart == null || cart.isEmpty()){
%>

<div style="border:1px solid black;margin:10px;padding:10px;">
    Cart is empty
</div>

<%
} else {

    try {

        URL url = new URL("http://localhost:8083/orders");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");

        if(token != null){
            conn.setRequestProperty("Authorization", "Bearer " + token);
        }

        conn.setDoOutput(true);

        JSONArray items = new JSONArray();

        for(Map<String, String> item : cart){
            JSONObject obj = new JSONObject();
            obj.put("productId", Integer.parseInt(item.get("id")));
            obj.put("quantity", 1);
            items.put(obj);
        }

        JSONObject order = new JSONObject();
        order.put("items", items);

        OutputStream os = conn.getOutputStream();
        os.write(order.toString().getBytes());
        os.flush();
        os.close();

        int status = conn.getResponseCode();

        if(status == 200 || status == 201){

            session.removeAttribute("cart");
%>

<div style="border:1px solid black;margin:10px;padding:10px;">
    <b>Status:</b> Order placed successfully!
</div>

<%
        } else {
%>

<div style="border:1px solid black;margin:10px;padding:10px;">
    <b>Error:</b> Order Failed (Status: <%= status %>)
</div>

<%
        }

    } catch(Exception e){
%>

<div style="border:1px solid black;margin:10px;padding:10px;">
    <b>Error:</b> <%= e.getMessage() %>
</div>

<%
    }
}
%>

</div>

</body>
</html>