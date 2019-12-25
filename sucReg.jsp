<%@ page contentType = "text/html; charset=UTF-8"  %>
<%@ page import = "com.baidu.aip.ocr.AipOcr" %>
<%@ page import = "netscape.javascript.JSObject" %>
<%@ page import = "org.json.JSONObject" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>注册成功</title>
    <!--<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">-->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <link href="assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/css/.css" type="text/css" rel="stylesheet">
    <!--Bootstrap_js直接使用会出现问题，但cdn加速连接到的可以成功-->
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type = "text/css">
        html{
            height:100%;
        }
        body{
            background-image: url(assets/img/theme.jpg);
            background-repeat:no-repeat;
            background-size:100%;
            height:100%;
        }
        .container{
            width:70%;
            background:rgb(255,255,255,0.85);
            height:100%;
            padding:8rem 20rem;
        }
        .form-group{
            margin-bottom:3rem;
        }
        .red{
            color:red;
        }
        #btn-signIn{
            background:#2e4052;
            color:white;
        }
    </style>
</head>
<body>
<%@ include file = "nav.txt" %>
<div class="container" >
    <div class="row clearfix">
        <div class="col-md-12 column">
            <p style = "font-size: 14px">
                <span>注册成功，</span>
                <span><a href="login.jsp">登录</a></span>
            </p>
            <table class="table">
                <tr><td>身份证姓名：</td>
                    <td>${name11 }</td>
                </tr>
                <tr><td>民族：</td>
                    <td>${nation1 }</td>
                </tr>
                <tr><td>住址：</td>
                    <td>${address1 }</td>
                </tr>
                <tr><td>公民身份证号码：</td>
                    <td>${IDNumber1 }</td>
                </tr>
            </table>
        </div> <!--col-md-12 column-->
    </div> <!--row clearfix-->
</div> <!--container-->
<script>
        window.onload=function(){
            alert("注册成功");
        }
</script>
</body>
</html>