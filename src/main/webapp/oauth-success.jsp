<script>
const params = new URLSearchParams(window.location.search);
const token = params.get("token");

if (token) {
    localStorage.setItem("token", token);
    window.location.href = "/home";
} else {
    alert("Login failed");
    window.location.href = "/login";
}
</script>