<%@ page contentType = "text/html; charset=UTF-8"  %>
<%@ page import = "com.baidu.aip.ocr.AipOcr" %>
<%@ page import = "netscape.javascript.JSObject" %>
<%@ page import = "org.json.JSONObject" %>
<jsp:useBean id = "userBean" class = "com.bean.data.Register" scope = "request" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>Avaware -- 会员注册</title>
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
            /*background:#fff;*/
            background:rgb(255,255,255,0.8);
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
            background:#1da5f5;
            color:white;
        }
    </style>
    <script>
    var flag1,flag2,flag3,flag4=false;

    function blur_email(){
        var mailObj = document.getElementById("result_email");
        var mail = "@";
        str = document.getElementById("email");
        mailObj.style.color="red";
        for(var i=0;i<str.length;i++){
            if(str.charAt(i)==mail){
                flag1 = true;
                break;
            }
        }
        if(flag1==true)
            mailObj.innerHTML="<i class='fa fa-check-circle' style='color:green'></i>";
        else
            mailObj.innerHTML="<i class='fa fa-exclamation-circle'></iclass>邮箱格式错误！";
    }

    function blur_username()
    {
        // 找到id=result_name的div
        var nameObj = document.getElementById("result_name");
        // 判断用户名是否合法
        var str2 = check_user_name(document.reg.username.value);
        nameObj.style.color="red";
        if ("check" ==  str2)
        {
            flag2 = true;
            nameObj.innerHTML = "<i class='fa fa-check-circle' style='color:green'></i>";
        }
        else
        {
            nameObj.innerHTML = "<i class='fa fa-exclamation-circle'></iclass>"+str2;
        }

    }
    function check_user_name(str)
    {
        var str2 = "check";
        if ("" == str)
        {
            str2 = "用户名不能为空";
            return str2;
        }
        else if ((str.length < 5) || (str.length > 16))
        {
            str2 = "用户名必须为5 ~ 20位";
            return str2;
        }
        else if (check_other_char(str))
        {
            str2 = "不能含有特殊字符";
            return str2;
        }
        return str2;
    }
    function check_other_char(str)
    {
        var arr = ["&", "\\", "/", "*", ">", "<", "@", "!"," "];
        for (var i = 0; i < arr.length; i++)
        {
            for (var j = 0; j < str.length; j++)
            {
                if (arr[i] == str.charAt(j))
                {
                    return true;
                }
            }
        }
        return false;
    }
    function blur_pwd()
    {
        // 找到id=result_pwd的div
        var nameObj = document.getElementById("result_pwd");
        // 判断密码是否合法
        var str2 = check_pwd(document.reg.password.value);
        nameObj.style.color="red";
        if ("check" ==  str2)
        {
            flag3 = true;
            nameObj.innerHTML = "<i class='fa fa-check-circle' style='color:green'></i>";
        }
        else
        {
            nameObj.innerHTML = "<i class='fa fa-exclamation-circle'></iclass>"+str2;
        }

    }
    function check_pwd(str)
    {
        var str2 = "check";
        if ("" == str)
        {
            str2 = "密码不能为空";
            return str2;
        }
        else if ((str.length < 5) || (str.length > 16))
        {
            str2 = "密码必须为5 ~ 16位";
            return str2;
        }

        return str2;
    }
    function blur_pwcf(){
        var obj1 = document.getElementById("passwordConfirm");
        var obj2 = document.getElementById("password");
        check_repw(obj1, obj2);

    }
    function check_repw(obj1,obj2){
        var objvalue1=obj1.value;
        var objvalue2=obj2.value;
        pwObj = document.getElementById("result_pwcf");
        if(objvalue1==objvalue2){
            pwObj.innerHTML="<i class='fa fa-check-circle' style='color:green'></i>";
            flag4 = true;
        }else {
            pwObj.style.color="red";
            pwObj.innerHTML="<i class='fa fa-exclamation-circle'></iclass>两次输入的密码不一致!";
            //document.getElementById("result_pwcf").innerHTML="<font color='red'><i class='fa fa-exclamation-circle'></iclass>两次输入的密码不一致!</font>";
        }
    }
    // 根据验证结果确认是否提交
    function check_submit()
    {
        if (flag2==true && flag3==true && flag4==true)
        {
            return true;
        }
        alert("请将信息填写正确再提交！");
        return false;
    }

    </script>
</head>
<body>
<%@ include file = "nav.txt" %>
<div class="container" >
    <div class="row clearfix">
        <h3><span style = "font-family:Italic Bold; font-weight:bold">Avaware </span>注册</h3>
        <p style = "font-size: 14px"><a href = "login.jsp">已有账号？登录</a></p>
        <div class="col-md-14 column">
            <form class="form-horizontal" name="reg" role="form" action="registerServlet" method="post" onSubmit="return check_submit();" ENCTYPE="multipart/form-data">
                <div class="form-group">
                    <label for="email" class="col-sm-3 control-label"><span class="red">*</span>电子邮箱:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="email" name="email" onblur="blur_email()"/>
                    </div>
                    <div class="col-sm-2" id="result_email"></div>
                </div>
                <div class="form-group">
                    <label for="username" class="col-sm-3 control-label"><span class="red">*</span>用户名:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="username" name="username" placeholder="*用户名中不能出现空格，字符(. @* / )" onblur="blur_username()" />
                    </div>
                    <div class="col-sm-3" id="result_name"></div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-3 control-label"><span class="red">*</span>密码:</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="password" name="password" placeholder="*密码需要是5-12位" onblur="blur_pwd()" />
                    </div>
                    <div class="col-sm-2" id="result_pwd"></div>
                </div>
                <div class="form-group">
                    <label for="passwordConfirm" class="col-sm-3 control-label"><span class="red">*</span>确认密码:</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" id="passwordConfirm" name="again_password" onblur="blur_pwcf()"/>
                    </div>
                    <div class="col-sm-2" id="result_pwcf"></div>
                </div>
                <div class="form-group">
                    <label for="infoUpload" class="col-sm-3 control-label" for="chooseImg"><span class="red">*</span>上传身份证信息(文件大小不超过16M):</label>
                        <input type="file" accept="image/jpg,image/jpeg,image/png" name="file" id="chooseImg" class="hidden" onchange="selectImg(this)">
                    </label>
                    <div class="col-sm-8">
                        <input type="file" id="infoUpload" name="info"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <div class="checkbox">
                            <label><input type="checkbox" name="agree" id="checkbox" />我已阅读并同意<a href="#">Avaware服务协议</a>.</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type=submit name="signIn" id="btn-signIn" value="注册" class="btn btn-default" />
                    </div>
                </div>
            </form>
            <p style="color:red;font-size:12px"><jsp:getProperty name = "userBean" property = "backNews" /></p>
            <p style="font-size:12px"><jsp:getProperty name = "userBean" property = "logname" /></p>
        </div> <!--col-md-10 column-->

    </div> <!--row clearfix-->
</div> <!--container-->
<script type="text/javascript">
        function check(){
            if(document.getElementById("username").value=="") {
                alert("没有输入用户名！");
                return false;
            }
            else if(document.getElementById("password").value=="") {
                alert("没有输入密码！");
                return false;
            }
            else if(document.getElementById("passwordConfirm").value!=document.getElementById("password").value){
                alert("两次密码不同！请重新输入");
                return false;
            }
            else if(document.getElementById("checkbox").checked!=true) {
                alert("请勾选同意Avaware服务协议");
                return false;
            }
            else {
                return true;
            }
        }


</script>

</body></html>