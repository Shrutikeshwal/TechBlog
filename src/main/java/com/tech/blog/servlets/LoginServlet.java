package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.entities.Message;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        // login
        String userEmail = request.getParameter("email");
        String userPassword = request.getParameter("password");

        UserDao dao = new UserDao(ConnectionProvider.getConnection());

        User u = dao.getUserByEmailandpassword(userEmail, userPassword);

        if (u == null) {
            // login failed
            PrintWriter out = response.getWriter();
            Message msg = new Message("Invalid Details ! try with another ", "error", "alert-danger") ;





            HttpSession s = request.getSession();
            s.setAttribute("msg",msg);
            response.sendRedirect("login_page.jpg");

        } else {
            // login success
            HttpSession s = request.getSession();
            s.setAttribute("currentUser", u);

            // redirect to profile page
            response.sendRedirect("profile");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
