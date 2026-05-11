<%--
  Created by IntelliJ IDEA.
  User: SHRUTI
  Date: 07-05-2026
  Time: 19:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<html>
<head>
    <title>sorry something went wrong </title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">
</head>
<body>


       <div class="container text-center">
         <img src="images/warning.png" class="image-fluid" >
         <h3>Sorry..something went wrong</h3>
           <% exception%>
         <a  href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home</a>
       </div>
</body>
</html>
