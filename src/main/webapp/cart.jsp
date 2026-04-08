<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="main">
    <div class="card" style="width:800px">

        <h2>Your Cart</h2>

        <div id="cartItems"></div>

        <h3 id="total"></h3>

        <button onclick="goToProducts()">Back to Products</button>

    </div>
</div>

<script src="/js/api.js"></script>

<script>
const email = localStorage.getItem("email");

if (!email) {
    window.location.href = "/login";
}

async function removeItem(itemId) {
    await apiRequest("/orders/cart/item/" + itemId, "DELETE");
    loadCart(); // refresh cart
}

async function loadCart() {

    const data = await apiRequest("/orders/cart/" + email);
    console.log("CART DATA:", data);

    const container = document.getElementById("cartItems");
    const total = document.getElementById("total");

    container.innerHTML = "";

    if (!data || !data.items || data.items.length === 0) {
        container.innerHTML = "<p>Your cart is empty</p>";
        total.innerText = "";
        return;
    }

    data.items.forEach(item => {

        const price = Number(item.price);
        const quantity = item.quantity;
        const productId = item.productId;
        const itemTotal = price * quantity;

        const card = document.createElement("div");
        card.className = "product-card";

        const h3 = document.createElement("h3");
        h3.innerText = "Product ID: " + productId;

        const q = document.createElement("p");
        q.innerText = "Quantity: " + quantity;

        const p = document.createElement("p");
        p.innerText = "Price: $" + price;

        const t = document.createElement("p");
        t.innerText = "Total: $" + itemTotal;

        const removeBtn = document.createElement("button");
        removeBtn.innerText = "Remove";
        removeBtn.onclick = () => removeItem(item.id);

        card.appendChild(h3);
        card.appendChild(q);
        card.appendChild(p);
        card.appendChild(t);
        card.appendChild(removeBtn);

        container.appendChild(card);
    });

    total.innerText = "Total: $" + data.totalAmount;
}

function goToProducts() {
    window.location.href = "/products";
}

loadCart();
</script>

</body>
</html>