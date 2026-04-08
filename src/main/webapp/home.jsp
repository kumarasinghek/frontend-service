<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>

<h2>Welcome ✅ Logged in</h2>

<button onclick="logout()">Logout</button>

<script src="/js/api.js"></script>

<script>
const token = localStorage.getItem("token");

if (!token) {
    window.location.href = "/login";
}

// TEST API CALL
apiRequest("/api/auth/test")  // you can change later
    .then(data => console.log("API RESPONSE:", data))
    .catch(err => console.error(err));

function logout() {
    localStorage.removeItem("token");
    window.location.href = "/login";
}
</script>

</body>
</html>