<%@ page contentType = "text/html; charset=UTF-8"  %>
<%@ page import = "com.bean.data.Login" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<jsp:useBean id = "loginBean" scope = "session"  class = "com.bean.data.Login" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>Avaware --查看购物车</title>
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
            background-image: url(assets/img/cart.jpg);
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
    <div class="container">
        <%
            if(loginBean == null){
                response.sendRedirect("login.jsp");
            }
            else{
                boolean b = loginBean.getLogname()==null||loginBean.getLogname().length()==0;
                if(b)
                    response.sendRedirect("login.jsp");
            }

            Connection con;
            Statement sql;
            ResultSet rs;
            try{
                String url = "jdbc:mysql://127.0.0.1:3306/avaware?" + "user=root&password=&characterEncoding=utf-8";
                con = DriverManager.getConnection(url);
                sql = con.createStatement();

                LinkedList cart = loginBean.getCart();
                if(cart==null) out.print("<h2>购物车没有物品</h2>");
                else{
                    Iterator<String> iterator = cart.iterator();
                    StringBuffer buyGoods = new StringBuffer();
                    StringBuffer pdlist = new StringBuffer();
                    int n = 1;
                    float priceSum = 0;
                    out.print("<h3>"+loginBean.getLogname()+"的购物车：</h3><table class = 'table'>");
                    out.print("<thead><tr>");
                    //out.print("<th></th>"); //checkbox功能！
                    out.print("<th>名称</th><th>价格</th><th>操作</th></thead><tbody>");
                    while(iterator.hasNext()){
                        String pid = iterator.next();
                        String showGoods = "";
                        String query = "SELECT pname, pic, price FROM product where ";
                        query += "pid ='"+pid+"'";
                        rs = sql.executeQuery(query);
                        //获取查询结果
                        while(rs.next()){
                            String pname = rs.getString(1);
                            String pic = rs.getString(2);
                            Float price = rs.getFloat(3);
                            priceSum += price;
                            buyGoods.append(n+":"+pname);
                            pdlist.append(pid+",");
                            String del = "<form action = 'deleteServlet' method = 'post'>"+
                                "<input type = 'hidden' name = 'delete' value = "+pid+">"+
                                "<button type = 'submit' class='btn-tran' title='删除'><i class='fa fa-minus-circle' style='color:#e02738;font-size:12pt'></i></button></form>";
                            //out.print("<tr><td><img alt='200x200' style='width:100%' src='data/img/"+pic+".jpg' /></td>");
                            //out.print("<tr><td><input type='checkbox' name='selected' /></td>"); //checkbox功能！
                            out.print("<td>"+pname+"</td>");
                            out.print("<td>¥"+price.toString()+"</td>");
                            out.print("<td>"+del+"</td></tr>");
                            n++;
                        }
                    }
                    out.print("</tbody></table>");
                    String orderForm = "<form action = 'buyServlet' method = 'post'>" +
                        "<input type = 'hidden' name = 'buy' value = '"+buyGoods.toString()+"'>"+
                        "<input type = 'hidden' name = 'price' value ="+priceSum+">"+"<input type='hidden' name='pdlist' value='"+pdlist.toString()+"'>"+
                        "<div class='text-right'><input type = 'submit' value = '结算' class='btn btn-default'></div></form>";
                    out.print(orderForm);
                }
            }
            catch(SQLException e){
                out.print(e);
            }
        %>
        <!--<jsp:getProperty name="loginBean" property="backNews" />-->
    </div>

</body>
</html>