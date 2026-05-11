<%@ page import="com.tech.blog.dao.PostDao" %>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>
<%@ page import="com.tech.blog.entities.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tech.blog.dao.LikeDao" %>
<%@ page import="jdk.vm.ci.code.VirtualObject" %>
<%@ page import="com.tech.blog.entities.User" %><%--
  Created by IntelliJ IDEA.
  User: SHRUTI
  Date: 10-05-2026
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%


    User uuu = (User)session.getAttribute("currentUser");

    PostDao d = new PostDao(ConnectionProvider.getConnection());


    int cid = Integer.parseInt(request.getParameter("cid"));
    List<Post> posts = null;
    if(cid ==0){

        posts = d.getAllPosts();
    }else{

        posts = d.getPostByCatId(cid);
    }

    if(posts.size()==0){
        out.println("<h3 class='display-3 text-center'>No post In this Category</h3>");
        return;
    }

    for(Post p : posts){
        %>

<div class="col-md-6 mt-2">
    <div class="card">
        <img src="..." class="card-img-top" srcset="blog_pics/<%= p.getpPic()%>" alt="Card image">
        <div class="card-body">
            <h3><%=p.getpTitle()%></h3>
            <p><%= p.getpContent()%></p>

        </div>
    </div>
    <div class="card-footer primary-background text-center">

        <%
            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());

        %>
      <a href="#" onclick="doLike(<%=p.getPid()%>,<%=uuu.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span> </a>
        <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read More..</a>
        <a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span> </a>
    </div>
</div>

       <%
    }
%>

</body>
</html>
