<%@ page contentType = "text/html; charset=UTF-8"  %>
<%@ page import = "com.bean.data.Login" %>
<%@ page import = "java.sql.*" %>
<jsp:useBean id = "loginBean" scope = "session"  class = "com.bean.data.Login" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>支付页面</title>
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
            background-image: url(assets/img/pay.jpg);
            background-repeat:no-repeat;
            background-size:100%;
            height:100%;
        }
        .container{
            width:70%;
            background:rgb(255,255,255,0.7);
            height:100%;
            padding:9rem 32rem;
        }
        .btn{
            background:#1c49a8;
            color:white;
        }

    </style>
</head>
<body>
    <%@ include file = "nav.txt" %>
    <div class="container">
        <h3>订单金额为：<%= request.getServletContext().getAttribute("sum") %></h3>
        <p>请使用支付宝扫码完成支付：</p>
        <img alt="QRcode" style="width:150px;height:auto" src="img/code.jpg" class="img-responsive center-block">
        <div class="row clearfix">
        <div class="col-md-12 column">
            <form action="payment.jsp" method="get">
                <div class="col-sm-8 text-right"><input type="text" name="payID" placeholder="请输入收款单号" value=""/></div>
                <div class="col-sm-3 text-left">
                    <%
                        String oid = request.getServletContext().getAttribute("oid").toString();
                        out.print("<input type='hidden' name='oid' value='"+oid+"'>");
                    %>
                    <button type="submit" class="btn btn-default" name="submit" value="yes">提交</button>
                </div>
            </form>
            <%
                String sub = request.getParameter("submit");
                if(sub==null){
                    sub="";
                }
                if(sub.equals("yes")){
                    Connection conn;
                    Statement sql;
                    ResultSet rs;
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                    }
                    catch (Exception e) {}
                    try{
                        String url = "jdbc:mysql://127.0.0.1:3306/avaware?" + "user=root&password=&characterEncoding=utf-8";
                        conn = DriverManager.getConnection(url);
                        sql = conn.createStatement();
                        String payID = request.getParameter("payID");
                        sql.executeUpdate("UPDATE orderform SET status='已支付', payID='"+payID+"' WHERE orderID='"+oid+"'");
                        //conn.close();
                        session.setAttribute("loginBean",loginBean);
                        response.sendRedirect("myAccount.jsp");
                    }
                    catch(SQLException e){
                        System.out.print(e);
                    }
                }
            %>
        </div>
        </div>
    </div>
</body>
</html>