<%@ page contentType = "text/html; charset=UTF-8"  %>
<%@ page import = "java.sql.*" %>
<jsp:useBean id = "loginBean" scope = "session"  class = "com.bean.data.Login" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>我的仓库</title>
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
            background-image: url(assets/img/repository.jpg);
            background-repeat:no-repeat;
            background-size:100%;
            height:100%;
        }
        .container{
            width:70%;
            background:rgb(255,255,255,0.7);
            height:100%;
            padding:8rem 20rem;
        }
        .btn{
            background:#1c49a8;
            color:white;
        }

    </style>
</head>
<body>
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
        <h3><jsp:getProperty name="loginBean" property="logname" />的仓库</h3>
        <div class="col-md-12 column">
            <table class="table">
        <%
            Connection con;
            Statement sql;Statement detail;
            ResultSet rs;
            ResultSet rspd;
            try{
                Class.forName("com.mysql.jdbc.Driver");
            }
            catch (Exception e) {}
            try{
                String url = "jdbc:mysql://127.0.0.1:3306/avaware?" + "user=root&password=&characterEncoding=utf-8";
                con = DriverManager.getConnection(url);
                sql = con.createStatement();
                detail = con.createStatement();
                String query = "SELECT idlist FROM orderform WHERE username='"+loginBean.getLogname()+"' AND status='已支付'";
                rs = sql.executeQuery(query);
                while(rs.next()){
                    String list = rs.getString(1);
                    int index = 0;
                    while(list.indexOf(',',index)!=-1){
                        String pid = list.substring(index, list.indexOf(',',index));
                        index = list.indexOf(',',index)+1;
                        out.print("<tr>");
                        String prod = "SELECT pname, pic, path FROM product WHERE pid='"+pid+"'";
                        rspd = detail.executeQuery(prod);
                        if(rspd.next()){
                            String pname = rspd.getString(1);
                            String pic = rspd.getString(2);
                            String path = rspd.getString(3);
                            out.print("<td><img alt='200x200' style='width:75px;height:auto' src='data/img/"+pic+".jpg' /></td>");
                            out.print("<td style='vertical-align:middle'>"+pname+"</td><td></td>");
                            out.print("<td style='vertical-align:middle'><form action='downloadServlet' method='get'>");
                            out.print("<input type='hidden' name=pid value='"+pid+"'>");
                            //out.print("<input type='hidden' name='path' value='"+path+"'>");
                            out.print("<button type='submit' name='add' class='btn-tran' title='下载'>");
                            out.println("<i class='fa fa-download' style='font-size:16pt;color:#1c49a8'></i></button>");
                            out.print("</form></td>");
                        }
                        out.print("</tr>");
                    }
                }
                con.close();
            }
            catch(SQLException e){
                out.print(e);
            }

        %>
    </div>
</body>
</html>