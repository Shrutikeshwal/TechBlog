<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.sql.*"%>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>
<!DOCTYPE html>

<html>
<head>
    <title>Index Page</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body>

    <h1>Index Page Working</h1>
    <%
        Connection con = ConnectionProvider.getConnection();

        if (con != null) {
            out.println("Connection Successful");
            out.println(con);
        } else {
            out.println("Connection Failed");
        }
    %>

<!--  jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>


<script src = "js/myjs.js" type="text/javascript"></script>

</body>
</html>
