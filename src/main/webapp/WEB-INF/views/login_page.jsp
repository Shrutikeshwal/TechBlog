
<%@ page import="com.tech.blog.entities.Message" %><%--
  Created by IntelliJ IDEA.
  User: SHRUTI
  Date: 07-05-2026
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">

            <div class="card shadow">

                <!-- Card Header -->
                <div class="card-header text-center">
                    <h3>User Login</h3>
                </div>

              <%
                 Message m = (Message) session.getAttribute("msg");
                 if(m!=null){
                     %>
                <div class="alert <%= m.getCssClass() %>%>" role="alert">
                    <%= m.getContent() %>

                </div>
               <%
                     session.removeAttribute("msg");

                 }
              %>
                <!-- Login Form -->
                <form action="LoginServlet" method="post">

                    <!-- Card Body -->
                    <div class="card-body">

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   placeholder="Enter your email"
                                   required>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password"
                                   name="password"
                                   class="form-control"
                                   placeholder="Enter your password"
                                   required>
                        </div>

                    </div>

                    <!-- Card Footer -->
                    <div class="card-footer text-center">

                        <button type="submit"
                                class="btn btn-primary">
                            Login
                        </button>

                        <br><br>

                        <a href="register.jsp">
                            New user? Register here
                        </a>

                    </div>

                </form>
                <!-- Form End -->

            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>