<%@ page contentType = "text/html; charset=UTF-8"  %>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.sun.rowset.*" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>Avaware --产品目录</title>
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
        .btn-tran {
            background: transparent;
            border: none !important;
            font-size:0;
        }
        .container{
            width:70%;
            background:rgb(255,255,255,0.7);
            height:100%;
            padding:6rem 8rem;
        }
        .pagination li button {
            color: black;
            float: left;
            padding: 8px 16px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <%@ include file="nav.txt" %>
    <div class="container">
        <div class="row clearfix" style="padding: 2rem 0">
            <!--
            <ul class="nav nav-pills navbar-left list" style="height:25px" >
              <li class="active"><a href="#" >Window OS</a></li>
              <li><a href="#">iOS</a></li>
              <li><a href="#">Android apk</a></li>
              <li><a href="#"></a></li>
            </ul>
            -->
            <form class="navbar-form navbar-left" role="order">
                <div class="form-group">
                    <form action="" class="navbar-left"><button type="submit" class="btn btn-default"><input type="hidden" value="ASC" name="order">价格升序</button></form>
                    <form action="" class="navbar-left"><button type="submit" class="btn btn-default"><input type="hidden" value="DESC" name="order">价格降序</button></form>
                </div>
            </form>
            <form class="navbar-form navbar-right" role="search">
                <div class="form-group">
                    <input type="text" name="queryCond" class="form-control" placeholder="按产品名称查找" value=""/>
                </div>
                <button type="submit" class="btn btn-default">搜索</button>
            </form>
        </div>
        <div class="row clearfix ">
            <div class="col-md-16 column">
            <%
                Connection con;
                Statement sql;
                ResultSet rs;
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                }
                catch (Exception e) {}
                try{
                    String url = "jdbc:mysql://127.0.0.1:3306/avaware?" + "user=root&password=&characterEncoding=utf-8";
                    con = DriverManager.getConnection(url);
                    sql = con.createStatement();
                    String cond = request.getParameter("queryCond");
                    String order = request.getParameter("order");
                    if(cond==null||cond=="")
                        cond="";
                    else
                        cond=" WHERE pname like '%"+cond+"%'";
                    if(order==null||order=="")
                        order="";
                    else{
                        order=" ORDER BY price "+order;
                    }
                    String query = "SELECT pid, pname, pic, price, mess FROM product"+cond+order;
                    rs = sql.executeQuery(query);
                    CachedRowSetImpl rowset = new CachedRowSetImpl();
                    rowset.populate(rs);
                    //dataBean.setRowSet(rowset);
                    con.close();
                    int count = 0;
                    out.print("<div class='row'>");
                    while(rowset.next()){
                        String pid = rowset.getString(1);
                        String pname = rowset.getString(2);
                        String pic = rowset.getString(3);
                        if(pic=="") pic="none";
                        Float price = rowset.getFloat(4);
                        String mess = rowset.getString(5);
                        out.println("<div class='col-md-3'><div class='thumbnail'>");
                        out.println("<a href='#details'>");
                        out.println("<img alt='200x200' style='height:100%;width:100%;' src='data/img/"+pic+".jpg' />");
                        out.println("</a>");
                        out.println("<div class='caption'>");
                        out.println("<h4>"+pname+"</h4>");
                        out.println("<p>"+mess+"</p>");
                        out.println("<div class='text-left'><p style='color:#fca311;font-size:12pt'>¥"+price.toString()+"</p></div>");
                        out.println("<form id ='"+pid+"' name='"+pid+"' action='AddToCartServlet' method='post'>");
                        out.println("<input type='hidden' name='pd' value='"+pid+"'>");
                        out.print("<div class='text-right'>");
                        out.print("<button type='submit' name='add' class='btn-tran' title='加入购物车'>");
                        out.println("<i class='fa fa-cart-plus' style='font-size:16pt;color:#1c49a8'></i></button></div>");
                        out.println("</form></div></div></div>");
                        count++;
                        if(count%4==0) out.print("</div><div class='row'>");
                    }

                    out.print("</div>");
                    out.print("<div style='color:#797670;text-align:center'>已无更多记录</div>");
                }
                catch (SQLException e){
                    out.print(e);
                }
            %>

            </div>
        </div>
    </div>
<script type="text/javascript">
    function add(p){
        document.getElementById(p).submit();
    }
</script>
</body>
</html>