<html>
<head>
    <title>Order Created</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="container">
    <h2>Order Created Successfully</h2>

    <p>Order ID: ${orderId}</p>
    <p>Total: ${total}</p>

    <form action="/payment" method="post">
        <input type="hidden" name="orderId" value="${orderId}" />
        <button type="submit">Proceed to Payment</button>
    </form>
</div>

</body>
</html>