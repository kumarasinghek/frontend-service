package com.ecommerce.frontendservice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

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
}
