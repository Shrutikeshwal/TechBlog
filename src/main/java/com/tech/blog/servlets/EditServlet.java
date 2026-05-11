package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        // fetch all data
        String userEmail = request.getParameter("user_email");
        String userName = request.getParameter("user_name");
        String userPassword = request.getParameter("user_password");
        String userAbout = request.getParameter("user_about");
        Part part = request.getPart("image");

        // get current user from session
        HttpSession s = request.getSession();
        User user = (User) s.getAttribute("currentUser");

        // set new data
        user.setEmail(userEmail);
        user.setName(userName);
        user.setPassword(userPassword);
        user.setAbout(userAbout);

        String fileName = part.getSubmittedFileName();
        user.setProfile(fileName);

        // here database update code will be added
        // currently only session update

        s.setAttribute("currentUser", user);

        response.sendRedirect("profile");
        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
       boolean ans = userDao.updateUser(user);
       if(ans){
           out.println("updated to db");
       }else{
           out.println("not updated..");
       }
    }
}