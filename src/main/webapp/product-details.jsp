<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="main">
    <div class="card" style="width:800px">

        <button class="back-btn" onclick="goBack()">Back</button>

		<div id="productDetails"></div>	

    </div>
</div>

<script src="/js/api.js"></script>

<script>

const token = localStorage.getItem("token");

if (!token) {
    window.location.href = "/login";
}

// ✅ GET ID FROM URL
const productId = '<%= request.getAttribute("productId") %>';

if (!productId) {
    alert("Invalid product ID");
    window.location.href = "/products";
}

async function loadProduct() {
    try {
        const response = await fetch(`/api/products/${productId}`, {
            headers: {
                "Authorization": "Bearer " + token
            }
        });

        if (!response.ok) {
            throw new Error("Failed");
        }

        const product = await response.json();

        const container = document.getElementById("productDetails");
        container.className = "product-details-container";

        const img = document.createElement("img");
        img.src = product.imageUrl || "https://via.placeholder.com/300";
        img.className = "product-details-image";

        const name = document.createElement("div");
        name.className = "product-details-name";
        name.innerText = product.name;

        const desc = document.createElement("div");
        desc.className = "product-details-desc";
        desc.innerText = product.description;

        const price = document.createElement("div");
        price.className = "product-details-price";
        price.innerText = "Rs. " + product.price;

        const btn = document.createElement("button");
        btn.className = "add-btn";
        btn.innerText = "Add to Cart";

        btn.onclick = () => addToCart(product.id);

        container.appendChild(img);
        container.appendChild(name);
        container.appendChild(desc);
        container.appendChild(price);
        container.appendChild(btn);

    } catch (err) {
        alert("Error loading product");
    }
}

function goBack() {
    window.location.href = "/products";
}

// reuse existing function
async function addToCart(productId) {
    const email = localStorage.getItem("email");

    await apiRequest("/api/orders/cart/add", "POST", {
        productId,
        quantity: 1,
        email
    });

    alert("Added to cart");
}

loadProduct();

console.log("RAW PRODUCT ID:", productId);
console.log("TYPE:", typeof productId);
console.log("LENGTH:", productId.length);
console.log("API URL:", `/api/products/${productId}`);

</script>

</body>
</html>