<html>
<head>
    <title>Payment</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="container">
    <h2>Payment</h2>

    <form action="/payment/process" method="post">
        <input type="hidden" name="orderId" value="${orderId}" />

        <button type="submit">Pay Now</button>
    </form>
</div>

</body>
</html>