<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "com.bean.data.Login" %>
<jsp:useBean id = "loginBean" scope = "session"  class = "com.bean.data.Login"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>Avaware --会员登录</title>
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
            background-image: url(assets/img/login.jpg);
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
        #btn-login {
            background:#1c49a8;
            color:#ffffff;
        }
    </style>
</head>
<body>
    <%@ include file = "nav.txt" %>
    <div class="container" >
        <div class="lgpanel">
            <div class="row clearfix">
                <div class="col-md-10 column">
                <p><span style = "font-family:Italic Bold; font-weight:bold">Avaware </span>会员登录</p>
                    <form class="form-horizontal" role="form" action="loginServlet" method="post">
                        <div class="form-group">
                            <label for="username" class="col-sm-3 control-label">账号</label>
                            <div class="col-sm-8">
                            <input type="text" class="form-control" id="username" name="username"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword" class="col-sm-3 control-label">密码</label>
                            <div class="col-sm-8">
                               <input type="password" class="form-control" id="password" name="password"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <div class="checkbox">
                                    <label><a href="register.jsp">还没有账号？注册</a></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <div class="checkbox">
                                    <label><input type="checkbox" name="remembers"/>记住我</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <input type=submit name="login" id="btn-login" value="登录" onclick="check()" class="btn btn-default" />
                            </div>
                        </div>

                    </form>
                </div> <!--col-md-10 column-->
            </div> <!--row clearfix-->
        </div> <!--lgpanel-->
    </div> <!--container-->
    <script type="text/javascript">
        function check(){
            if(document.getElementById("username").value=="") {
                alert("没有输入用户名！");
                $("#btn-login").attr("disabled", false);
                return false;
            }
            else if(document.getElementById("password").value=="") {
                alert("没有输入密码！");
                $("#btn-login").attr("disabled", false);
                return false;
            }
            else {
                //alert("登录成功！");
                return true;
            }

        }
    </script>


</body></html>