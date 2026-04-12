<!DOCTYPE html>
<html>
	<head>
	    <title>Login</title>
	    <link rel="stylesheet" href="/css/style.css">
	</head>
	<body>
		<div class="main">
		    <div class="card">
		        <div class="logo">
		            <img src="/images/logo.png">
		        </div>
		        <div class="small-text">Welcome back !!!</div>
		        <h2>Sign in</h2>
		        <form id="loginForm">
		            <div class="input-group">
		                <label>Email</label>
		                <input type="email" name="email" placeholder="test@gmail.com">
		            </div>
		            <div class="input-group">
		                <div class="row">
		                    <label>Password</label>
		                    <a href="#">Forgot Password?</a>
		                </div>
		                <input type="password" name="password" placeholder="********">
		                <div id="errorMsg" style="color:#ff5a3c;font-size:12px;margin-top:5px;"></div>
		            </div>
		            <button type="submit" class="btn" id="loginBtn">
		                <span id="btnText">SIGN IN</span>
		                <span id="spinner" class="spinner"></span>
		            </button>
		        </form>
		        <div class="divider">
		            <span>or login using</span>
		        </div>
		        <div class="socials">
		            <div class="social-btn" onclick="googleLogin()">
		    			<img src="/images/google.png">
					</div>
					<script>
					function googleLogin() {
					    window.location.href = "http://localhost:8081/oauth2/authorization/google";
					}
					</script>
		            <form action="/oauth2/authorization/facebook" method="get">
		                <button type="button" class="social-btn">
		                    <img src="/images/facebook.png">
		                </button>
		            </form>
		            <form action="/oauth2/authorization/github" method="get">
		                <button type="button" class="social-btn">
		                    <img src="/images/github.png">
		                </button>
		            </form>
		        </div>
		        <div class="signup">
		            Don’t have an account? <a href="/register">Sign up</a>
		        </div>
		    </div>
		</div>
		<script>
		document.addEventListener("DOMContentLoaded", function () {
		    const form = document.getElementById("loginForm");
		    const btnText = document.getElementById("btnText");
		    const spinner = document.getElementById("spinner");
		    const btn = document.getElementById("loginBtn");
		    const errorMsg = document.getElementById("errorMsg");

		    form.addEventListener("submit", async function(e) {
		        e.preventDefault();		
		        const email = document.querySelector('input[name="email"]').value;
		        const password = document.querySelector('input[name="password"]').value;
		        errorMsg.innerText = "";
		        btnText.innerText = "Loading...";
		        spinner.style.display = "inline-block";
		        btn.disabled = true;
		
		        try {
		            const response = await fetch("/api/auth/login", {
		                method: "POST",
		                headers: {
		                    "Content-Type": "application/json"
		                },
		                body: JSON.stringify({
		                    email: email,
		                    password: password
		                })
		            });
		            let data;
		            try {
		                data = await response.json();
		            } catch {
		                data = { message: "Invalid email or password" };
		            }
		            if (!response.ok) {
		                throw new Error(data.message || "Login failed");
		            }
		            localStorage.setItem("token", data.token);
		            localStorage.setItem("email", data.email);		
		            window.location.href = "/home";		
		        } catch (error) {
		            errorMsg.innerText = error.message;		
		            btnText.innerText = "SIGN IN";
		            spinner.style.display = "none";
		            btn.disabled = false;
		        }
		    });		
		});
		</script>
	</body>
</html>