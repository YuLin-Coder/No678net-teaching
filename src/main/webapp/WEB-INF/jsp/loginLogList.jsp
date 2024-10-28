
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登录日志</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <!-- 搜索条件开始 -->
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>查询条件</legend>
        </fieldset>
        <form class="layui-form" method="post" id="searchForm">

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">用户名:</label>
                    <div class="layui-input-inline" style="padding: 5px">
                        <input type="text" name="loginname" id="loginname" autocomplete="off"
                               class="layui-input layui-input-inline"
                               placeholder="请输入用户名称" style="height: 30px;border-radius: 10px">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">登录IP:</label>
                    <div class="layui-input-inline" style="padding: 5px">
                        <input type="text" name="loginip" id="loginip" autocomplete="off"
                               class="layui-input layui-input-inline"
                               placeholder="请输入用户IP" style="height: 30px;border-radius: 10px">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">开始时间:</label>
                    <div class="layui-input-inline" style="padding: 5px">
                        <input type="text" name="startTime" id="startTime" readonly="readonly"
                               class="layui-input layui-input-inline" placeholder="yyyy-MM-dd"
                               style="height: 30px;border-radius: 10px" lay-key="1">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">结束时间:</label>
                    <div class="layui-input-inline" style="padding: 5px">
                        <input type="text" name="endTime" id="endTime" readonly="readonly"
                               class="layui-input layui-input-inline" placeholder="yyyy-MM-dd"
                               style="height: 30px;border-radius: 10px" lay-key="2">
                    </div>
                </div>
                <button type="button"
                        class="layui-btn layui-btn-normal layui-icon layui-icon-search layui-btn-radius layui-btn-sm"
                        id="doSearch" style="margin-top: 4px">查询
                </button>
                <button type="reset"
                        class="layui-btn layui-btn-warm layui-icon layui-icon-refresh layui-btn-radius layui-btn-sm"
                        style="margin-top: 4px">重置
                </button>
            </div>

        </form>

        <div id="ad-btn" style="display: none;">
            <button type="button" class="layui-btn layui-btn-danger data-delete-btn layui-btn-sm layui-btn-radius"
                    lay-event="deleteBatch">批量删除
            </button>
        </div>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
    </div>

    <div id="UserBar" style="display: none;">
        <a class="layui-btn layui-btn-danger layui-btn-xs layui-btn-radius" lay-event="delete">删除</a>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script>

    var tableIns;
    layui.use(['laydate', 'jquery', 'layer', 'form', 'table'], function () {
        var laydate = layui.laydate;
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        laydate.render({
            elem: "#startTime",
            type:"datetime"
        })
        laydate.render({
            elem: "#endTime",
            type:"datetime"
        })
        tableIns = table.render({
            elem: '#currentTableId',
            url: "${pageContext.request.contextPath}/log/getLoginLog.action",
            method: "POST",
            where: {
                loginname: null
            },
            toolbar: "#ad-btn",
            height: 'full-150',
            request: {
                //pageName: 'pageNum' //页码的参数名称，默认：page
                //,limitName: 'pageSize' //每页数据量的参数名，默认：limit
            },
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            cols: [[
                {type: "checkbox", width: 80, fixed: "left", align: "center"},
                {field: 'id', width: 200, title: 'ID', sort: true, align: "center"},
                {field: 'loginname', width: 100, title: '用户名', align: "center"},
                {field: 'logindate', width: 300, title: '登录时间', align: "center"},
                {field: 'loginip', width: 280, title: 'IP', align: "center"},
                {title: '操作', minWidth: 120, templet: '#UserBar', fixed: "right", align: "center"}
            ]]
        });

        // 监听搜索操作
        $("#doSearch").click(function () {
            search();
        });

        //监听头部工具栏事件
        table.on("toolbar(currentTableFilter)", function (obj) {
            switch (obj.event) {
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });
        //监听每一行的编辑和删除
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'delete') {
                layer.confirm('真的删除【' + data.id + '】这条数据吗？', function (index) {
                    //向服务端发送删除指令
                    $.post("${pageContext.request.contextPath}/log/deleteLoginLog.action", {id: data.id}, function (res) {
                        layer.msg(res.message);
                        //刷新数据表格
                        tableIns.reload();
                    })
                });
            }
        });


        var url;
        var mainIndex;


        //模糊查询
        function search() {


            var loginname = $("#loginname").val();
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            var loginip = $("#loginip").val();
            //var userVo = $("#searchForm").serialize();
            tableIns.reload({
                where: {
                    loginname: loginname,
                    loginip: loginip,
                    startTime: startTime,
                    endTime: endTime
                }
            });
        }

        //批量删除
        function deleteBatch() {
            //得到选中的数据行
            var checkStatus = table.checkStatus('currentTableId')
                , data = checkStatus.data;

            // layer.alert(data.length);
            var params = "";
            $.each(data, function (i, item) {
                if (i == 0) {
                    params += "ids=" + item.id;
                } else {
                    params += "&ids=" + item.id;
                }
            });

            layer.confirm('真的要删除这些登录信息吗？', function (index) {
                layer.msg('处理中', {icon: 16});
                //向服务端发送删除指令
                $.post("${pageContext.request.contextPath}/log/deleteBatchLoginLog.action", params, function (res) {

                    layer.msg(res.msg);
                    //刷新数据表格
                    // tableIns.reload();
                    search();
                })
            });


        }
    });
</script>

</body>
</html>



