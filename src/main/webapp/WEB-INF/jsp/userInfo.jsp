<%--
  Created by IntelliJ IDEA.
  User: 丹青
  Date: 2019/12/14
  Time: 23:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>个人资料</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.4/css/layui.css" media="all" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/html/public.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form layui-row" lay-filter="dataFrm">
    <div class="layui-col-md3 layui-col-xs12 user_right">
        <div class="layui-upload-list">
            <img class="layui-upload-img layui-circle userFaceBtn userAvatar" id="userFace" src="${pageContext.request.contextPath}/images/timg.png">
        </div>
        <button type="button" class="layui-btn layui-btn-primary userFaceBtn"><i class="layui-icon">&#xe67c;</i> ${currentUser.username}</button>
        <p>由于是纯静态页面，所以只能显示一张随机的图片</p>
    </div>
    <div class="layui-col-md6 layui-col-xs12">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text"  name="username" value="" disabled class="layui-input layui-disabled">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用户组</label>
            <div class="layui-input-block">
                <input type="text" value="超级管理员" disabled class="layui-input layui-disabled">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">教工号/学号</label>
            <div class="layui-input-block">
                <input type="text" name="number" value="" placeholder="请输入教工号/学号" lay-verify="required" class="layui-input realName">
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block userSex">
                <input type="radio" name="sex" value="男" title="男" checked="">
                <input type="radio" name="sex" value="女" title="女">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号码</label>
            <div class="layui-input-block">
                <input type="tel" name="phone" value="" placeholder="请输入手机号码"  class="layui-input userPhone">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出生年月</label>
            <div class="layui-input-block">
                <input type="text" name="birthday" value="" placeholder="请输入出生年月" lay-verify="userBirthday" readonly class="layui-input userBirthday">
            </div>
        </div>
        <div class="layui-form-item userAddress">
            <label class="layui-form-label">家庭住址</label>
            <div class="layui-input-inline">
                <select name="province" lay-filter="province" class="province">
                    <option value="">请选择市</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="city" lay-filter="city" class="city">
                    <option value="">请选择市</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="area" lay-filter="area" disabled>
                    <option value="">请选择县/区</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">掌握技术</label>
            <div class="layui-input-block userHobby">
                <input type="checkbox" name="like[javascript]" title="Javascript">
                <input type="checkbox" name="like[C#]" title="C#">
                <input type="checkbox" name="like[php]" title="PHP">
                <input type="checkbox" name="like[html]" title="HTML(5)">
                <input type="checkbox" name="like[css]" title="CSS(3)">
                <input type="checkbox" name="like[.net]" title=".net">
                <input type="checkbox" name="like[ASP]" title="ASP">
                <input type="checkbox" name="like[Angular]" title="Angular">
                <input type="checkbox" name="like[VUE]" title="VUE">
                <input type="checkbox" name="like[XML]" title="XML">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-block">
                <input type="text" name="email" value="" placeholder="请输入邮箱" lay-verify="email" class="layui-input userEmail">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">自我评价</label>
            <div class="layui-input-block">
                <textarea name="description" placeholder="请输入内容" class="layui-textarea myself"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="changeUser">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui-v2.5.4/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/userInfo.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/address.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/cacheUserInfo.js"></script>

<script>
    layui.use(['jquery', 'layer', 'form', 'table'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        var dtree = layui.dtree;

        window.onload=selectUser(${currentUser.id});
        function selectUser(id) {
            $.ajax({
                url:"${pageContext.request.contextPath}/user/selectUser.action",
                type:"POST",
                data:{
                    id:id
                },
                success:function (res) {
                    var data = res.res;
                    form.val("dataFrm", data);
                }
            });
        }




    });


</script>
</body>
</html>
