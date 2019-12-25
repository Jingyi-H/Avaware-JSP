<%@ page contentType = "text/html; charset=UTF-8"  %>
<%@ page import = "com.bean.data.Login" %>
<%@ page import = "java.sql.*" %>
<jsp:useBean id = "loginBean" class = "com.bean.data.Login" scope = "session" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>我的账户</title>
    <!--<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">-->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/css/.css" type="text/css" rel="stylesheet">
    <!--Bootstrap_js直接使用会出现问题，但cdn加速连接到的可以成功-->
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        html{
            height:100%;
        }
        body {
            background-image: url(assets/img/theme.jpg);
            background-repeat:no-repeat;
            background-size:100%;
            height:100%;
        }
        .container{
            width:70%;
            background:rgb(255,255,255,0.8);
            height:100%;
            padding:8rem 20rem;
        }
    </style>
</head>
<body style="background-color:#ECEFF1">
    <%@ include file = "nav.txt" %>
    <%
            if(loginBean == null){
                response.sendRedirect("login.jsp");
            }
            else{
                boolean b = loginBean.getLogname()==null||loginBean.getLogname().length()==0;
                if(b)
                    response.sendRedirect("login.jsp");
            }
    %>
    <div class="container">
        <p><jsp:getProperty name="loginBean" property="logname" />的订单</p>
        <div class="col-md-12 column">
            <table class="table">
                <thead>
                    <tr>
                        <th>订单编号</th>
                        <th>产品</th>
                        <th>价格</th>
                        <th>状态</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
    <%
        Connection conn;
        Statement sql;
        ResultSet rs;
        try{
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch (Exception e) {}
        try{
            String url = "jdbc:mysql://127.0.0.1/avaware";
            String user = "root";
            String password = "";
            conn = DriverManager.getConnection(url,user,password);
            sql = conn.createStatement();
            String query = "SELECT orderID, mess, sum, status FROM orderform WHERE username = '"
                    +loginBean.getLogname()+"'";
            rs = sql.executeQuery(query);
            while(rs.next()){
                out.print("<tr>");
                out.print("<td>"+rs.getString(1)+"</td>");
                out.print("<td>"+rs.getString(2)+"</td>");
                out.print("<td>¥"+rs.getString(3)+"</td>");
                out.print("<td>"+rs.getString(4)+"</td>");
                out.print("<td><a href='#'>查看详情</a></td>");
                out.print("</tr>");
            }

            out.print("</table>");
            out.print("<div style='color:#797670;text-align:center'>已无更多记录</div>");
            conn.close();
        }
        catch (SQLException e){
            out.print(e);
        }
    %>
</body>
</html>