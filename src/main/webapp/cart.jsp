<%@ page import="java.util.*" %>

<%
    List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");

    if(cart == null){
        cart = new ArrayList<>();
    }

    String id = request.getParameter("id");

    if(id != null){
        Map<String, String> item = new HashMap<>();
        item.put("id", id);
        item.put("name", request.getParameter("name"));
        item.put("price", request.getParameter("price"));

        cart.add(item);
    }

    String removeId = request.getParameter("removeId");

    if(removeId != null){
        cart.removeIf(item -> item.get("id").equals(removeId));
    }

    session.setAttribute("cart", cart);

    double total = 0;
    for(Map<String, String> item : cart){
        total += Double.parseDouble(item.get("price"));
    }
%>

<html>
<head>
    <title>Cart</title>

    <style>
        body {
            font-family: Arial;
            background: #f5f5f5;
            padding: 20px;
        }

        h2 {
            text-align: center;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .card {
            background: white;
            padding: 15px;
            width: 220px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        .price {
            color: green;
            font-weight: bold;
            margin: 10px 0;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .empty {
            text-align: center;
            font-size: 18px;
            color: gray;
        }

        button {
            background: red;
            color: white;
            border: none;
            padding: 6px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .checkout {
            display: block;
            margin: 30px auto;
            background: green;
            padding: 10px 20px;
        }
    </style>
</head>

<body>

<div class="top-bar">
    <a href="products.jsp">⬅ Back</a>
    <h3>Total: Rs. <%= total %></h3>
</div>

<h2>Your Cart</h2>

<div class="container">

<%
if(cart.isEmpty()){
%>
    <div class="empty">Your cart is empty 🛒</div>
<%
} else {

    for(Map<String, String> item : cart){
%>

    <div class="card">
        <h3><%= item.get("name") %></h3>
        <p class="price">Rs. <%= item.get("price") %></p>

        <form method="post">
            <input type="hidden" name="removeId" value="<%= item.get("id") %>"/>
            <button type="submit">Remove</button>
        </form>
    </div>

<%
    }
}
%>

</div>

<%
if(!cart.isEmpty()){
%>
<form action="orders.jsp" method="post">
    <button class="checkout">Checkout</button>
</form>
<%
}
%>

</body>
</html>