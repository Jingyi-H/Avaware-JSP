<%@ page contentType = "text/html; charset=UTF-8"  %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>Avaware --专注提供最便捷的下载服务</title>
    <!--Bootstrap备用cdn-->
    <!--<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">-->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/css/.css" type="text/css" rel="stylesheet">
    <!--Bootstrap_js直接使用会出现问题，但cdn加速连接到的可以成功-->
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        body {
            background-image: url(assets/img/index.jpg);
            background-repeat:no-repeat;
            background-size:100%;
        }
        p{
            font-family:"Microsoft YaHei";
            font-size:16pt;
            margin-top:20px;
            margin-bottom: 30px;
            margin-left:1rem;
        }
        .container{
            padding:12rem 10rem;
        }
    </style>
</head>
<body>
    <%@ include file = "nav.txt" %>
    <div class="container">
        <h1>Avaware</h1>
        <div class = "welcome">
            <h2>提供最便捷的软件下载服务</h2>
            <p>现在注册会员，付费软件最高可享受50%的优惠！</p>
            <a href = "register.jsp" class = "btn btn-default">立即注册</a>
        </div>
    </div>
</body></html>