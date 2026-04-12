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
        
        <!-- ✅ FIX 1: This is correct (keep this) -->
        <div class="products-container" id="productsContainer"></div>

        <button onclick="goToCart()">View Cart</button>

        <!-- ⚠️ (Not removed, but now unused) -->
        <div id="productList" class="products-grid"></div>

        <button onclick="goToOrders()">My Orders</button>
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

        await apiRequest("/api/orders/cart/add", "POST", {
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
	const response = await fetch("/api/products", {
	    headers: {
	        "Authorization": "Bearer " + token
	    }
	});
    
	if (!response.ok) {
	    throw new Error("Failed to fetch products");
	}

	const products = await response.json();

    const container = document.getElementById("productsContainer");
    container.innerHTML = "";

    for (const product of products) {

        // ✅ CREATE FIRST
        const card = document.createElement("div");
        card.className = "product-card";

        // ✅ THEN ADD CLICK
        card.style.cursor = "pointer";
        card.onclick = () => {
            window.location.href = "/products/" + product.id;
        };

        const img = document.createElement("img");
        img.src = product.imageUrl;
        img.className = "product-image";

        img.onerror = () => {
            img.src = "https://via.placeholder.com/300";
        };

        const name = document.createElement("div");
        name.className = "product-name";
        name.innerText = product.name;

        const desc = document.createElement("div");
        desc.className = "product-description";
        desc.innerText = product.description;

        const price = document.createElement("div");
        price.className = "product-price";
        price.innerText = "Rs. " + product.price;

        const btn = document.createElement("button");
        btn.className = "add-btn";
        btn.innerText = "Add to Cart";

        // ✅ IMPORTANT FIX (prevent navigation on button click)
        btn.onclick = (e) => {
            e.stopPropagation();
            addToCart(product.id);
        };

        card.appendChild(img);
        card.appendChild(name);
        card.appendChild(desc);
        card.appendChild(price);
        card.appendChild(btn);

        container.appendChild(card);
    }
}

// 🔥 LOGOUT
function logout() {
    localStorage.removeItem("token");
    localStorage.removeItem("email");
    window.location.href = "/login";
}

function goToOrders() {
    window.location.href = "/orders";
}

loadProducts();
</script>

</body>
</html>