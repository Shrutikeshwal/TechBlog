<%@ page import="com.tech.blog.entities.User" %>
<%@ page import="com.tech.blog.dao.PostDao" %>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>
<%@ page import="com.tech.blog.entities.Categories" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Thread.sleep(1000);
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login_page.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile Page</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- jQuery (IMPORTANT FIX) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        .primary-background {
            background: #2962ff;
        }

        #post-container {
            display: none;
        }
        body{
            background-image: url("/images/img.png");
            background-size: cover ;
            background-attachment: fixed;
        }
    </style>

</head>

<body style="background:#f5f5f5;">

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
                    <a class="nav-link active" href="#">LearnCode with Shruti</a>
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

<!-- MAIN BODY -->
<main>
    <div class="container mt-3">
        <div class="row">

            <!-- LEFT CATEGORY -->
            <div class="col-md-4">

                <div class="list-group">

                    <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active">
                        All Post
                    </a>

                    <%
                        PostDao d = new PostDao(ConnectionProvider.getConnection());
                        ArrayList<Categories> list1 = d.getAllCategoriess();

                        for (Categories cc : list1) {
                    %>

                    <a href="#" onclick="getPosts(<%= cc.getCid() %>,this)" class="c-link list-group-item list-group-item-action">
                        <%= cc.getName() %>
                    </a>

                    <%
                        }
                    %>

                </div>

            </div>

            <!-- RIGHT POSTS -->
            <div class="col-md-8">

                <!-- LOADER -->
                <div class="container text-center" id="loader">
                    <i class="fa-solid fa-rotate fa-spin fa-4x"></i>
                    <h3 class="mt-2">Loading...</h3>
                </div>

                <!-- POSTS -->
                <div class="container-fluid" id="post-container"></div>

            </div>

        </div>
    </div>
</main>

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

<!-- BOOTSTRAP -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- AJAX: ADD POST -->
<script>
    $(document).ready(function () {

        $("#add-post-form").on("submit", function (event) {
            event.preventDefault();

            let form = new FormData(this);

            $.ajax({
                url: "AddPostServlet",
                type: "POST",
                data: form,
                success: function (data) {
                    if (data.trim() === "done") {
                        swal("Success!", "Post Added Successfully!", "success");
                    } else {
                        swal("Error!", "Something went wrong!", "error");
                    }
                },
                error: function () {
                    swal("Error!", "Server Error!", "error");
                },
                processData: false,
                contentType: false
            });
        });

    });
</script>

<!-- LOAD POSTS -->
<script>
    function getPosts(catId ,temp){

        $("#loader").show();
        $("#post-container").hide();

        $(".c-link").removeClass('active')
        $.ajax({
            url: "load_post.jsp",
            data : {cid:catId},
            success: function (data) {
                $("#loader").hide();
                $("#post-container").show();
                $("#post-container").show().html(data);
                $(temp).addClass('active')
            }
        });
    }
    $(document).ready(function () {

        let allPostRef = $('.c-link')[0]
        getPosts(0,allPostRef)

    });
</script>

</body>
</html>
