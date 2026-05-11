package com.tech.blog.servlets;

import com.tech.blog.entities.Message;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import javax.print.attribute.standard.MediaSize;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession s = request.getSession();

        s.removeAttribute("currentUser");
        Message m = new Message("Logout succesfully","success","alert-success");

        s.setAttribute("msg",m);
        s.invalidate();

        response.sendRedirect("login_page.jsp");
    }
}