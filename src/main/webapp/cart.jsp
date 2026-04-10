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
        <button onclick="checkout()">Checkout</button>

    </div>
</div>

<script src="/js/api.js"></script>

<script>
const email = localStorage.getItem("email");

if (!email) {
    window.location.href = "/login";
}

// REMOVE ITEM
async function removeItem(itemId) {
    await apiRequest("/orders/cart/item/" + itemId, "DELETE");
    loadCart();
}

// UPDATE QUANTITY
async function updateQty(itemId, qty) {
    if (qty <= 0) {
        await removeItem(itemId);
        return;
    }

    await apiRequest("/orders/cart/item/" + itemId, "PUT", {
        quantity: qty
    });

    loadCart();
}

async function checkout() {

    await apiRequest("/orders/cart/checkout/" + email, "PUT");

    alert("Order placed successfully!");

    window.location.href = "/products";
}

// GET PRODUCT
async function getProduct(productId) {
    try {
        const res = await apiRequest("/api/products/" + productId);
        console.log("PRODUCT:", res);
        return res;
    } catch (e) {
        console.log("Product fetch failed:", e);
        return null;
    }
}

// LOAD CART
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

    for (const item of data.items) {

        const price = Number(item.price);
        const quantity = item.quantity;
        const productId = item.productId;

        let productName = "Product ID: " + productId;

        const product = await getProduct(productId);
        if (product && product.name) {
            productName = product.name;
        }

        const itemTotal = price * quantity;

        const card = document.createElement("div");
        card.className = "product-card";

        const h3 = document.createElement("h3");
        h3.innerText = productName;

        const q = document.createElement("p");
        q.innerText = "Quantity: " + quantity;

        const p = document.createElement("p");
        p.innerText = "Price: Rs. " + price;

        const t = document.createElement("p");
        t.innerText = "Total: Rs. " + itemTotal;

        const removeBtn = document.createElement("button");
        removeBtn.innerText = "Remove";
        removeBtn.onclick = () => removeItem(item.id);

        const controls = document.createElement("div");

        const minus = document.createElement("button");
        minus.innerText = "-";
        minus.onclick = () => updateQty(item.id, item.quantity - 1);

        const qty = document.createElement("span");
        qty.innerText = " " + item.quantity + " ";

        const plus = document.createElement("button");
        plus.innerText = "+";
        plus.onclick = () => updateQty(item.id, item.quantity + 1);

        controls.appendChild(minus);
        controls.appendChild(qty);
        controls.appendChild(plus);

        card.appendChild(h3);
        card.appendChild(q);
        card.appendChild(p);
        card.appendChild(t);
        card.appendChild(removeBtn);
        card.appendChild(controls);

        container.appendChild(card);
    }

    total.innerText = "Total: Rs. " + data.totalAmount;
}

async function checkout() {

    const res = await apiRequest("/orders/cart/checkout/" + email, "PUT");

    if (res.status === "PAID") {
        alert("Payment successful 🎉");
    } else {
        alert("Payment failed ❌");
    }

    window.location.href = "/products";
}

// NAVIGATION
function goToProducts() {
    window.location.href = "/products";
}

loadCart();
</script>

</body>
</html>