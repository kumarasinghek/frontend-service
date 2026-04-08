<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="main">

    <div class="card">

        <div class="logo">
            <img src="/images/logo.png">
        </div>

        <div class="small-text">Create your account</div>

        <h2>Sign up</h2>

        <form id="registerForm">

            <div class="input-group">
                <label>Email</label>
                <input type="email" name="email" required>
            </div>

            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <div id="errorMsg" style="color:#ff5a3c;font-size:12px;"></div>

            <button class="btn">SIGN UP</button>

        </form>

        <div class="signup">
            Already have an account? <a href="/login">Sign in</a>
        </div>

    </div>

</div>

<script src="/js/api.js"></script>

<script>
document.getElementById("registerForm").addEventListener("submit", async function(e) {
    e.preventDefault();

    const email = document.querySelector('input[name="email"]').value;
    const password = document.querySelector('input[name="password"]').value;

    const errorMsg = document.getElementById("errorMsg");
    errorMsg.innerText = "";

    try {
        await apiRequest("/api/auth/register", "POST", {
            email: email,
            password: password
        });

        alert("Registration successful");

        window.location.href = "/login";

    } catch (err) {
        errorMsg.innerText = err.message;
    }
});
</script>

</body>
</html>