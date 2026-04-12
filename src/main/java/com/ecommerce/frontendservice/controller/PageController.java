package com.ecommerce.frontendservice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class PageController {

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @GetMapping("/home")
    public String homePage() {
        return "home";
    }
    
    @GetMapping("/products")
    public String productsPage() {
        return "products";
    }
    
    @GetMapping("/cart")
    public String cartPage() {
        return "cart";
    }
    
    @GetMapping("/orders")
    public String orderPage() {
        return "orders";
    }
    
    @GetMapping("/products/{id}")
    public String productDetails(@PathVariable Long id, Model model) {
        model.addAttribute("productId", id);
        return "/product-details";
    }
    
    @GetMapping("/oauth2/success")
    public String oauthSuccessPage() {
        return "oauth2/success";
    }
}
