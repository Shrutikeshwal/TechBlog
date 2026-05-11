package com.example.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PageController {

    @GetMapping("/")
    public String home() {
        return "index";
    }
    @GetMapping("/profile")
    public String profilePage() {
        return "profile";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }
    @GetMapping("/errorpage")
    public String errorPage() {
        return "error_page";
    }
    @GetMapping("/login")
    public String loginPage(){
        return "login_page";
    }
}
