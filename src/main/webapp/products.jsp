<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="main">
    <div class="card" style="width:800px">

        <h2>Products</h2>
		<button onclick="goToCart()">View Cart</button>
        <div id="productList" class="products-grid"></div>

        <button onclick="logout()">Logout</button>

    </div>
</div>

<script src="/js/api.js"></script>

<script>
const token = localStorage.getItem("token");

if (!token) {
    window.location.href = "/login";
}

function goToCart() {
    window.location.href = "/cart";
}

// 🔥 ADD TO CART FUNCTION
async function addToCart(productId) {
    try {
        const email = localStorage.getItem("email");

        await apiRequest("/orders/cart/add", "POST", {
            productId: productId,
            quantity: 1,
            email: email
        });

        alert("Added to cart");

    } catch (err) {
        alert(err.message);
    }
}

// 🔥 LOAD PRODUCTS
async function loadProducts() {
    const data = await apiRequest("/api/products");

    const container = document.getElementById("productList");
    container.innerHTML = "";

    if (!data || !Array.isArray(data)) {
        container.innerHTML = "<p>Data not loaded correctly</p>";
        return;
    }

    data.forEach(p => {

        const card = document.createElement("div");
        card.className = "product-card";

        const name = document.createElement("h3");
        name.innerText = p.name;

        const desc = document.createElement("p");
        desc.className = "desc";
        desc.innerText = p.description;

        const price = document.createElement("div");
        price.className = "price";
        price.innerText = "$" + p.price;

        const btn = document.createElement("button");
        btn.className = "add-btn";
        btn.innerText = "Add to Cart";

        // 🔥 IMPORTANT LINE (this was missing before)
        btn.onclick = () => addToCart(p.id);

        card.appendChild(name);
        card.appendChild(desc);
        card.appendChild(price);
        card.appendChild(btn);

        container.appendChild(card);
    });
}

// 🔥 LOGOUT
function logout() {
    localStorage.removeItem("token");
    localStorage.removeItem("email");
    window.location.href = "/login";
}

loadProducts();
</script>

</body>
</html>