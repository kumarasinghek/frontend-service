const BASE_URL = "http://localhost:8085";

async function apiRequest(endpoint, method = "GET", body = null) {
    const token = localStorage.getItem("token");

    const headers = {
        "Content-Type": "application/json"
    };

    if (token) {
        headers["Authorization"] = "Bearer " + token;
    }

    const response = await fetch(BASE_URL + endpoint, {
        method: method,
        headers: headers,
        body: body ? JSON.stringify(body) : null
    });

    if (response.status === 401) {
        localStorage.removeItem("token");
        window.location.href = "/login";
        return;
    }

    const text = await response.text();

    if (!response.ok) {
        throw new Error(text || "Request failed");
    }

    return text ? JSON.parse(text) : {};
}