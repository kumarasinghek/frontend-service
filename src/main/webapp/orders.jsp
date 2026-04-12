<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="main">
    <div class="card" style="width:800px">

		<button class="back-btn" onclick="goToProducts()">Back</button>

        <h2>My Orders</h2>
        
        <div id="ordersList" class="orders-container"></div>

    </div>
</div>

<script src="/js/api.js"></script>

<script>
const token = localStorage.getItem("token");

if (!token) {
    window.location.href = "/login";
}

async function loadOrders() {

    const data = await apiRequest("/api/orders/user");

    const container = document.getElementById("ordersList");
    container.innerHTML = "";

    if (!data || data.length === 0) {
        container.innerHTML = "<p>No orders yet</p>";
        return;
    }

    data.forEach(order => {

        const card = document.createElement("div");
        card.className = "product-card";

        const title = document.createElement("h3");
        title.innerText = "Order #" + order.id;

        const status = document.createElement("span");
        status.innerText = order.status;
        status.className = "status " + order.status.toLowerCase();

        const total = document.createElement("p");
        total.innerText = "Total: Rs. " + order.totalAmount;

        const date = document.createElement("p");
        date.innerText = "Date: " + new Date(order.createdAt).toLocaleString();

        card.appendChild(title);
        card.appendChild(status);
        card.appendChild(total);
        card.appendChild(date);

        if (order.items && order.items.length > 0) {

            const itemsDiv = document.createElement("div");
            itemsDiv.style.marginTop = "10px";

            order.items.forEach(item => {
                const itemText = document.createElement("p");
                itemText.style.fontSize = "13px";
                itemText.style.color = "#555";
                itemText.innerText = "Product " + item.productId + 
                                     " x " + item.quantity;
                itemsDiv.appendChild(itemText);
            });

            card.appendChild(itemsDiv);
        }

        container.appendChild(card);
    });
}

function goToProducts() {
    window.location.href = "/products";
}

loadOrders();
</script>

</body>
</html>