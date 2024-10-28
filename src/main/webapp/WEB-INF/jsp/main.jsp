<%--
  Created by IntelliJ IDEA.
  User: 丹青
  Date: 2019/12/13
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>教学管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layuimini.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style id="layuimini-bg-color">
    </style>
</head>
<body class="layui-layout-body layuimini-all">
<div class="layui-layout layui-layout-admin">

    <div class="layui-header header">
        <div class="layui-logo">
            <img src="${pageContext.request.contextPath }/images/logo.png">
            <h1>教学管理系统</h1>
        </div>
        <a>
            <div class="layuimini-tool"><i title="展开" class="fa fa-outdent" data-side-fold="1"></i></div>
        </a>

        <ul class="layui-nav layui-layout-left layui-header-menu layui-header-pc-menu mobile layui-hide-xs">
        </ul>
        <ul class="layui-nav layui-layout-left layui-header-menu mobile layui-hide-sm">
            <li class="layui-nav-item">
                <a href="javascript:;"><i class="fa fa-list-ul"></i> 选择模块</a>
                <dl class="layui-nav-child layui-header-mini-menu">
                </dl>
            </li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;" data-refresh="刷新"><i class="fa fa-refresh"></i></a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;" data-clear="清理" class="layuimini-clear" data-href="../api/clear.json"><i class="fa fa-trash-o"></i></a>
            </li>
            <li class="layui-nav-item layuimini-setting">
                <a href="javascrip:;"><img src="${pageContext.request.contextPath}/images/timg.png" class="layui-nav-img">${currentUser.username}</a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="javascript:;" data-iframe-tab="${pageContext.request.contextPath}/user/userInfo.action" data-title="基本资料" >基本资料</a>
                    </dd>
                    <dd>
                        <a href="javascript:;" data-iframe-tab="${pageContext.request.contextPath}/user/editpsw.action" data-title="修改密码" >修改密码</a>
                    </dd>
                    <dd>
                        <a href="javascript:;" class="login-out">退出登录</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item layuimini-select-bgcolor mobile layui-hide-xs">
                <a href="javascript:;" data-bgcolor="配色方案"><i class="fa fa-ellipsis-v"></i></a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll layui-left-menu">
        </div>
    </div>

    <div class="layui-body">
        <div class="layui-tab" lay-filter="layuiminiTab" id="top_tabs_box">
            <ul class="layui-tab-title" id="top_tabs">
                <li class="layui-this" id="layuiminiHomeTabId" >
                    <i class="fa fa-home"></i> <span>首页</span>
                </li>
            </ul>
            <ul class="layui-nav closeBox">
                <li class="layui-nav-item">
                    <a href="javascript:;"> <i class="fa fa-dot-circle-o"></i> 页面操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" data-page-close="other"><i class="fa fa-window-close"></i> 关闭其他</a></dd>
                        <dd><a href="javascript:;" data-page-close="all"><i class="fa fa-window-close-o"></i> 关闭全部</a></dd>
                    </dl>
                </li>
            </ul>
            <div class="layui-tab-content clildFrame">
                <div id="layuiminiHomeTabIframe" class="layui-tab-item layui-show">
                   <iframe width="100%" height="100%" frameborder="0" src="${pageContext.request.contextPath }/user/welcome.action"></iframe>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="${pageContext.request.contextPath}/lib/layui-v2.5.4/layui.js?v=1.0.4" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['element', 'layer', 'layuimini'], function () {
        var $ = layui.jquery,
            element = layui.element,
            layer = layui.layer;
       layuimini.init('${pageContext.request.contextPath}/api/init.json');

        $('.login-out').on("click", function () {
            layer.msg('退出登录成功', function () {
                window.location = '${pageContext.request.contextPath}/user/logout.action';
            });
        });
    });
</script>
</body>
</html>
