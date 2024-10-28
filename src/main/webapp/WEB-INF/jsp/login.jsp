<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>教学管理系统-登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/lib/layui-v2.5.4/css/layui.css" media="all">
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        html, body {
            width: 100%;
            height: 100%;
            overflow: hidden
        }

        body {
            background: #009688;
        }

        body:after {
            content: '';
            background-repeat: no-repeat;
            background-size: cover;
            -webkit-filter: blur(3px);
            -moz-filter: blur(3px);
            -o-filter: blur(3px);
            -ms-filter: blur(3px);
            filter: blur(3px);
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: -1;
        }

        .layui-container {
            width: 100%;
            height: 100%;
            overflow: hidden
        }

        .admin-login-background {
            width: 360px;
            height: 300px;
            position: absolute;
            left: 50%;
            top: 40%;
            margin-left: -180px;
            margin-top: -100px;
        }

        .logo-title {
            text-align: center;
            letter-spacing: 2px;
            padding: 14px 0;
        }

        .logo-title h1 {
            color: #009688;
            font-size: 25px;
            font-weight: bold;
        }

        .login-form {
            background-color: #fff;
            border: 1px solid #fff;
            border-radius: 3px;
            padding: 14px 20px;
            box-shadow: 0 0 8px #eeeeee;
        }

        .login-form .layui-form-item {
            position: relative;
        }

        .login-form .layui-form-item label {
            position: absolute;
            left: 1px;
            top: 1px;
            width: 38px;
            line-height: 36px;
            text-align: center;
            color: #d2d2d2;
        }

        .login-form .layui-form-item input {
            padding-left: 36px;
        }

        .captcha {
            width: 60%;
            display: inline-block;
        }

        .captcha-img {
            display: inline-block;
            width: 34%;
            float: right;
        }

        .captcha-img img {
            height: 34px;
            border: 1px solid #e6e6e6;
            height: 36px;
            width: 100%;
        }
    </style>
</head>
<body>
<%--正式使用删掉--%>
<div class="layui-row" style="position: fixed">
    <div class="layui-col-md4 layui-col-md-offset4">
        <div>
            <blockquote class="layui-elem-quote">管理员：<span style="color: red">1705145</span></blockquote>
            <blockquote class="layui-elem-quote">老师：<span style="color: red">170507103</span></blockquote>
            <blockquote class="layui-elem-quote">学生：<span style="color: red">170507106</span></blockquote>
            <blockquote class="layui-elem-quote">密码：<span style="color: red">均为123</span></blockquote>
        </div>
    </div>
</div>

<div class="layui-container">

    <div class="admin-login-background">
        <div class="layui-form login-form">
            <form class="layui-form" method="post">
                <div class="layui-form-item logo-title">
                    <h1>教学管理系统</h1>
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-username"></label>
                    <input type="text" name="number" id="number" placeholder="请输入教工号或学号" autocomplete="off"
                           class="layui-input" value="1705145">
                </div>
                <div class="layui-form-item">
                <label class="layui-icon layui-icon-password"></label>
                <input type="password" name="fpassword" id="fpassword" placeholder="密码" autocomplete="off"
                       class="layui-input" value="123">
                </div>


                <%--<div class="layui-form-item">
                    <label class="layui-icon layui-icon-user"></label>
                        <select name="frole" id="frole" lay-filter="aihao" autocomplete="off"
                                class="layui-select">
                            <option value="0"> 老师</option>
                            <option value="1" selected="selected"> 学生</option>
                        </select>
                </div>--%>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-vercode"></label>
                    <input type="text" name="fcaptcha" id="fcaptcha" lay-verify="required|captcha" placeholder="图形验证码"
                           autocomplete="off" class="layui-input verification captcha" value="xszg">
                    <div class="captcha-img">
                        <img id="captchaPic" src="${pageContext.request.contextPath }/images/captcha.jpg">
                    </div>
                </div>
                <div class="layui-form-item">
                    <input type="checkbox" name="rememberMe" value="true" lay-skin="primary" title="记住密码">
                </div>
                <div class="layui-form-item">
                    <a class="layui-btn layui-btn-fluid" id="submitBtn" onclick="dologin()">登 入</a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath }/lib/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath }/lib/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath }/lib/jq-module/jquery.particleground.min.js" charset="utf-8"></script>
<script>

    layui.use('form', function(){
        var form = layui.form;
        var $ = layui.jquery
        /*//监听提交
        form.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            return false;
        });*/
    });

    // 粒子线条背景
    $(document).ready(function () {
        $('.layui-container').particleground({
            dotColor: '#5cbdaa',
            lineColor: '#5cbdaa'
        });
    });

    function dologin() {
        var number = $("#number");
        var fpassword = $("#fpassword");
        var fcaptcha = $("#fcaptcha");
        // 表单检验
        layui.use('layer', function () {
            //$.trim()，把字符串两边的空格去掉
            if (number.val() == "") {
                //alert("用户账号不能为空，请重新输入！！！");
                layer.msg("用户账号不能为空，请重新输入！！！", {time: 1000, icon: 5, shift: 6}, function () {
                    number.val("");
                    number.focus();//获取焦点

                });
                return false;
            }
            if (fpassword.val() == "") {
                //alert("用户账号不能为空，请重新输入！！！");
                layer.msg("用户密码不能为空，请重新输入！！！", {time: 1000, icon: 5, shift: 6}, function () {
                    fpassword.val("");
                    fpassword.focus();//获取焦点

                });
                return false;
            }
            if (fcaptcha.val() != "xszg") {
                layer.msg("验证码不正确，请重新输入！！！", {time: 1000, icon: 5, shift: 6}, function () {
                    fcaptcha.val("");
                    fcaptcha.focus();//获取焦点

                });
                return false;
            }

                $.ajax({//json数据
                    url: "${pageContext.request.contextPath }/user/logindo.action",
                    type: "POST",
                    data: {
                        number: number.val(),
                        password: fpassword.val(),
                    },
                    beforeSend: function () {
                        loadingIndex = layer.msg('处理中', {icon: 16});
                    },
                    success: function (result) {
                       // layer.close(loadingIndex);
                        if (result.res == "1") {
                            // alert("ok");
                            var role = result.role;
                            if(role==2){
                                window.location.href = "${pageContext.request.contextPath }/user/main.action";
                            }else if(role==0){
                                window.location.href = "${pageContext.request.contextPath }/user/main0.action";
                            }else if(role==1){
                                window.location.href = "${pageContext.request.contextPath }/user/main1.action";
                            }

                        } else {
                            layer.msg(result.message, {time: 1000, icon: 5, shift: 6});
                            /*alert("not ok");*/
                        }
                    }
                });
            });
    }

</script>
</body>
</html>