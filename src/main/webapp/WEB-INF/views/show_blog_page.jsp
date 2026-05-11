<%@ page import="com.tech.blog.entities.User" %>
<%@ page import="com.tech.blog.dao.PostDao" %>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>
<%@ page import="com.tech.blog.entities.Post" %>
<%@ page import="com.tech.blog.entities.Categories" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tech.blog.dao.UserDao" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="com.tech.blog.dao.LikeDao" %><%--
  Created by IntelliJ IDEA.
  User: SHRUTI
  Date: 10-05-2026
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@page errorPage="error_page.jsp"%>
<%
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login_page.jsp");
        return;
    }
%>
<%

    int postId = Integer.parseInt(request.getParameter("post_id"));

    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);


%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><%=p.getpTitle()%> || Techblog by shruti </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        /*.banner-background{*/
        /*    clip-path: polygon(30% 0% 70% 0% 100% 0,100% 91% ,63% 100%,22%);*/
        /*}*/
        .post-title{
            font-weight: 100;
            font-size: 30px;
        }
        .post-content{
            font-weight: 100;
            font-size: 25px;
        }
        .post-date{
            font-style: italic;
            font-weight: bold;
        }
        .post-userinfo{
           font-size: 20px;
        }
        .row-user{
            border : 1px solid #e2e2e2;
            padding-top: 15px;

        }
        body{
            background-image: url("/images/img.png");
            background-size: cover ;
            background-attachment: fixed;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark primary-background">

    <div class="container-fluid">

        <a class="navbar-brand" href="#">Tech Blog</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">

            <ul class="navbar-nav me-auto">

                <li class="nav-item">
                    <a class="nav-link active" href="profile.jsp">LearnCode with Shruti</a>
                </li>

                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                        Categories
                    </a>

                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Programming Language</a></li>
                        <li><a class="dropdown-item" href="#">Projects</a></li>
                        <li><a class="dropdown-item" href="#">Data Structure</a></li>
                    </ul>

                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal">
                        Do Post
                    </a>
                </li>

            </ul>

            <ul class="navbar-nav ms-auto">

                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#profile-modal">
                        <%= user.getName() %>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet">Logout</a>
                </li>

            </ul>

        </div>
    </div>
</nav>
<!--end od navbar-->

<!--main content of body-->

<div class="container">
    <div class="row my-4">
        <div class="col-md-8 offset-md-2">
            <div class="card">
                <div class="card-header">
                    <h4 class="post-title"><%= p.getpTitle()%></h4>
                </div>
                <div class="card-body">
                    <img class="card-img-top my-2" src="blog_pics/<%= p.getpPic()%>" alt="Card Image cap">

                    <div class="row my-3 row-user">
                        <div class="col-md-8">
                            <% UserDao ud = new UserDao(ConnectionProvider.getConnection());%>
                            <p class="post-userinfo"> <a href="#" ><%=ud.getUserByUserId(p.getUserId()).getName() %></a> Has posted: </p>
                        </div>
                        <div class="col-md-4">

                            <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                        </div>
                    </div>
                    <p class="post-content"><%=p.getpContent()%></p>
                    <br>
                    <br>
                    <div class="post-code">
                         <pre><%= p.getpCode()%></pre>
                    </div>
                </div>
                <div class="card-footer primary-background text-center">

                   <%
                       LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                       %>
                   %>
                    <a href="#" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span> </a>

                    <a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span> </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- PROFILE MODAL -->
<div class="modal fade" id="profile-modal" tabindex="-1">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header primary-background text-white">
                <h5 class="modal-title">Tech Blog</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body text-center">

                <img src="pics/<%= user.getProfile() %>"
                     class="img-fluid"
                     style="border-radius:50%; max-width:150px;">

                <h5 class="mt-3"><%= user.getName() %></h5>

                <table class="table">

                    <tr><th>ID</th><td><%= user.getId() %></td></tr>
                    <tr><th>Email</th><td><%= user.getEmail() %></td></tr>
                    <tr><th>Gender</th><td><%= user.getGender() %></td></tr>
                    <tr><th>About</th><td><%= user.getAbout() %></td></tr>
                    <tr><th>Registered</th><td><%= user.getDateTime() %></td></tr>

                </table>

            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<!-- ADD POST MODAL -->
<div class="modal fade" id="add-post-modal" tabindex="-1">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Provide Post Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form id="add-post-form" action="AddPostServlet" method="post" enctype="multipart/form-data">

                <div class="modal-body">

                    <select class="form-control mb-3" name="cid">

                        <option disabled selected>-- Select Category --</option>

                        <%
                            ArrayList<Categories> list = d.getAllCategoriess();
                            for (Categories c : list) {
                        %>

                        <option value="<%= c.getCid() %>"><%= c.getName() %></option>

                        <%
                            }
                        %>

                    </select>

                    <input type="text" name="pTitle" class="form-control mb-3" placeholder="Post Title">

                    <textarea name="pContent" class="form-control mb-3" style="height:150px;" placeholder="Content"></textarea>

                    <textarea name="pCode" class="form-control mb-3" style="height:150px;" placeholder="Code"></textarea>

                    <input type="file" name="pPic" class="form-control">

                </div>

                <div class="modal-footer">

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                    <button type="submit" class="btn btn-primary">Post</button>

                </div>

            </form>

        </div>
    </div>
</div>
<h1>going to show single blog page</h1>
<h1>Post id : <%=postId%></h1>
</body>
</html>
