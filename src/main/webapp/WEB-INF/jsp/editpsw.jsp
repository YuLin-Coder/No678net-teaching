
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/lib/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/public.css" media="all">
    <style>
        .layui-form-item .layui-input-company {width: auto;padding-right: 10px;line-height: 38px;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="layui-form layuimini-form">
            <div class="layui-form-item">
                <label class="layui-form-label required">旧的密码</label>
                <div class="layui-input-block">
                    <input type="password" name="old_password" lay-verify="required" lay-reqtext="旧的密码不能为空" placeholder="请输入旧的密码"  value="" class="layui-input">
                    <tip>填写自己账号的旧的密码。</tip>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">新的密码</label>
                <div class="layui-input-block">
                    <input type="password" name="new_password" lay-verify="required" lay-reqtext="新的密码不能为空" placeholder="请输入新的密码"   class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">新的密码</label>
                <div class="layui-input-block">
                    <input type="password" name="again_password" lay-verify="required" lay-reqtext="新的密码不能为空" placeholder="请输入新的密码"   class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="saveBtn">确认保存</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath }/lib/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form;
        var $ = layui.jquery;
        var  layer = layui.layer;
        var id = ${currentUser.id}

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            //判断两次输入的密码是否相同
            console.log(data);
            if (data.field.new_password != data.field.again_password){
                layer.alert("输入的两次密码不相同", function(index){
                    layer.close(index);
                });
                return false;
            }
            $.ajax({
                url:"${pageContext.request.contextPath}/user/editpswdo.action",
                type:"POST",
                data:{
                    id:id,
                    oldpsw:data.field.old_password,
                    newpsw:data.field.new_password,
                    againpsw:data.field.again_password
                } ,
                beforeSend: function () {
                    loadingIndex = layer.msg('处理中', {time:1000,icon: 16});
                },
                success:function (result) {
                    if(result.res==1){
                        layer.msg(result.message, {time: 1000, icon: 1, shift: 6});
                        window.parent.location.href = "${pageContext.request.contextPath }/user/main.action";
                    }else{
                        layer.msg(result.message, {time: 1000, icon: 5, shift: 6});
                    }
                }
            });

        });

    });
</script>
</body>
</html>