package com.ecommerce.frontendservice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.client.RestTemplate;

@Controller
public class WebController {
    private String BASE_URL = "http://localhost:8085";
    private String token = "";

    @GetMapping("/")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, Model model) {
        RestTemplate restTemplate = new RestTemplate();
        Map<String, String> req = new HashMap<>();
        req.put("email", email);
        req.put("password", password);
        ResponseEntity<Map> response = restTemplate.postForEntity(BASE_URL + "/api/auth/login", req, Map.class);
        token = (String) response.getBody().get("token");
        return "redirect:/products";
    }

    @GetMapping("/products")
    public String products(Model model) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);
        HttpEntity<?> entity = new HttpEntity<>(headers);
        ResponseEntity<List> response = restTemplate.exchange(BASE_URL + "/products", HttpMethod.GET, entity, List.class);

        model.addAttribute("products", response.getBody());
        return "products";
    }

    @PostMapping("/order")
    public String createOrder(@RequestParam Long productId) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);

        Map<String, Object> item = new HashMap<>();
        item.put("productId", productId);
        item.put("quantity", 1);
        item.put("price", 5000);

        Map<String, Object> req = new HashMap<>();
        req.put("userId", 1);
        req.put("items", List.of(item));

        HttpEntity<?> entity = new HttpEntity<>(req, headers);
        restTemplate.postForEntity(BASE_URL + "/orders", entity, String.class);
        return "redirect:/payment";
    }

    @GetMapping("/payment")
    public String paymentPage() {
        return "payment";
    }
    
    @PostMapping("/payment")
    public String pay(Model model) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);

        Map<String, Object> req = new HashMap<>();
        req.put("orderId", 1);
        req.put("amount", 5000);

        HttpEntity<?> entity = new HttpEntity<>(req, headers);
        ResponseEntity<Map> response = restTemplate.postForEntity(BASE_URL + "/payments", entity, Map.class);
        model.addAttribute("result", response.getBody().get("status"));
        return "result";
    }
}