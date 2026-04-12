<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="main">
    <div class="card" style="width:500px; text-align:center;">

        <h2>Welcome</h2>
        <p class="small-text">Choose where to go</p>

        <div style="margin-top:30px; display:flex; flex-direction:column; gap:15px;">

            <div class="home-actions">
			    <div class="home-card" onclick="goToProducts()">
			        <span>Browse Products</span>
			    </div>
			    <div class="home-card" onclick="goToCart()">
			        <span>Your Cart</span>
			    </div>
			    <div class="home-card" onclick="goToOrders()">
					<span>Your Orders</span>
			    </div>
			</div>
<button class="btn btn-secondary" onclick="logout()">Logout</button>

        </div>

    </div>
</div>

<script>
function goToProducts() {
    window.location.href = "/products";
}

function goToCart() {
    window.location.href = "/cart";
}

function goToOrders() {
    window.location.href = "/orders";
}

function logout() {
    localStorage.removeItem("token");
    localStorage.removeItem("email");
    window.location.href = "/login";
}

const email = localStorage.getItem("email");

if (email) {
    document.querySelector("h2").innerText = "Welcome, " + email;
}
</script>

</body>
</html>