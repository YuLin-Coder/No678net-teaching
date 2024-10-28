<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>老师列表</title>
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
            <legend>学生评教</legend>
        </fieldset>
<%--        <form class="layui-form" method="post" id="searchForm">--%>

<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">用户名:</label>--%>
<%--                    <div class="layui-input-inline" style="padding: 5px">--%>
<%--                        <input type="text" name="username" id="username" autocomplete="off"--%>
<%--                               class="layui-input layui-input-inline"--%>
<%--                               placeholder="请输入用户名称" style="height: 30px;border-radius: 10px">--%>
<%--                    </div>--%>
<%--                </div>--%>
                <%--
                                <div class="layui-inline">
                                    <label class="layui-form-label">用户地址:</label>
                                    <div class="layui-input-inline" style="padding: 5px">
                                        <input type="text" name="address" id="address" autocomplete="off"
                                               class="layui-input layui-input-inline"
                                               placeholder="请输入用户地址" style="height: 30px;border-radius: 10px">
                                    </div>
                                </div>
                            </div>

                            <div class="layui-inline">
                                <label class="layui-form-label">性别:</label>
                                <div class="layui-input-inline">
                                    <input type="radio" name="sex" value="1" title="女">
                                    <input type="radio" name="sex" value="0" title="男">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">状态:</label>
                                <div class="layui-input-inline">
                                    <input type="radio" name="status" value="1" title="可用">
                                    <input type="radio" name="status" value="0" title="停用">
                                </div>--%>
<%--                <button type="button"--%>
<%--                        class="layui-btn layui-btn-normal layui-icon layui-icon-search layui-btn-radius layui-btn-sm"--%>
<%--                        id="doSearch" style="margin-top: 4px">查询--%>
<%--                </button>--%>
<%--                <button type="reset"--%>
<%--                        class="layui-btn layui-btn-warm layui-icon layui-icon-refresh layui-btn-radius layui-btn-sm"--%>
<%--                        style="margin-top: 4px">重置--%>
<%--                </button>--%>
<%--            </div>--%>

        </form>



        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

    </div>
    <div id="UserBar" style="display: none;">
        <a class="layui-btn layui-btn-xs layui-btn-radius" lay-event="edit">学生评教</a>
    </div>


    <!-- 修改的弹出层-->
    <div style="display: none;padding: 20px" id="UpdateDiv">
        <form class="layui-form" lay-filter="dataFrm1" id="dataFrm1">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">课程:</label>
                    <div class="layui-input-inline">
                        <input type="hidden" name="courseId">
                        <input type="text" name="name" readonly="readonly" placeholder="请输入密码"
                               autocomplete="off" lay-verify="required" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">老师介绍:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="username" readonly="readonly" placeholder="介绍一下"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">教学评价:</label>
                    <div class="layui-input-inline">
                        <input type="radio" name="evaluate" value="差" title="差">
                        <input type="radio" name="evaluate" value="一般" title="一般">
                        <input type="radio" name="evaluate" value="好" title="好">
                        <input type="radio" name="evaluate" value="很好" title="很好">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">


            </div>
            <div class="layui-form-item">
                <div class="layui-input-block" style="text-align: center;padding-right: 120px">
                    <button type="button"
                            class="layui-btn layui-btn-normal layui-btn-md layui-icon layui-icon-release layui-btn-radius"
                            lay-filter="doSubmit" lay-submit="">提交
                    </button>
                    <button type="reset"
                            class="layui-btn layui-btn-warm layui-btn-md layui-icon layui-icon-refresh layui-btn-radius">
                        重置
                    </button>
                </div>
            </div>
        </form>
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
            elem: '#birthdate' //指定元素
        })
        tableIns = table.render({
            elem: '#currentTableId',
            url: "${pageContext.request.contextPath}/studentCourse/studentScoreList.action",
            method: "POST",
            where: {
                username: null
            },
            toolbar: "#ad-btn",
            height: 'full-150',
            request: {
                //pageName: 'pageNum' //页码的参数名称，默认：page
                //,limitName: 'pageSize' //每页数据量的参数名，默认：limit
            },
            limits: [10, 15, 20, 25, 50, 100, 1000],
            limit: 15,
            page: true,
            cols : [[
                {field: 'courseId', title: '课程id',minWidth:60, align:'center'},
                {field: 'name', title: '课程名',minWidth:160, align:'center'},
                {field: 'username', title: '任课教师',minWidth:120, align:'center'},
                {field: 'testModel', title: '考核方式', minWidth:100, align:'center'},
                {field: 'evaluate', title: '教学评价', minWidth:100, align:'center'},
                {field: 'evTime', title: '评价日期', minWidth:150, align:'center'},
                {title: "操作", width:100, templet:"#UserBar",fixed:"right",align:"center"}
            ]]
        });

        // 监听搜索操作
        $("#doSearch").click(function () {
            search();
        });


        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });
        //监听每一行的评价
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                //layer.alert('编辑行：<br>' + JSON.stringify(data))
                openUpdateCustomer(data);//把layui框架拿到的数据(data)放到编辑框里，传入data数据
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除【' + data.username + '】这个老师吗？', function (index) {
                    //向服务端发送删除指令
                    $.post("${pageContext.request.contextPath}/teacher/deleteTeacher.action", {id: data.id}, function (res) {
                        layer.msg(res.message);
                        //刷新数据表格
                        tableIns.reload();
                    })
                });
            }
        });


        var url;
        var mainIndex;


        <%--//打开添加页面--%>
        <%--function openAddTeacher() {--%>
        <%--    mainIndex = layer.open({--%>
        <%--        type: 1,--%>
        <%--        title: '添加老师',--%>
        <%--        content: $("#saveDiv"),--%>
        <%--        area: ['700px', '260px'],--%>
        <%--        success: function (index) {--%>
        <%--            //清空表单数据--%>
        <%--            $("#dataFrm")[0].reset();--%>
        <%--            url = "${pageContext.request.contextPath}/teacher/addTeacher.action";--%>
        <%--        }--%>
        <%--    });--%>
        <%--}--%>

        //打开修改页面
        function openUpdateCustomer(data) {
            mainIndex = layer.open({
                type: 1,
                title: '学生评教',
                content: $("#UpdateDiv"),
                area: ['700px', '260px'],
                success: function (index) {
                    form.val("dataFrm1", data);//把数据放到编辑框
                    url = "${pageContext.request.contextPath}/studentCourse/editStudentCourse.action";
                }
            });
        }


        //模糊查询
        function search() {

            var username = $("#username").val();
            //var userVo = $("#searchForm").serialize();
            tableIns.reload({
                where: {
                    username: username,
                }
            });
        }

        //保存（添加）
        form.on("submit(doSubmitAdd)", function (obj) {
            //序列化表单数据
            var params = $("#dataFrm").serialize();
            //alert(params);
            $.post(url, params, function (obj) {
                layer.msg(obj.message);
                //关闭弹出层
                layer.close(mainIndex)
                //刷新数据 表格
                tableIns.reload();
            })
        });
        //保存（修改）
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#dataFrm1").serialize();
            // alert(params);
            $.post(url, params, function (obj) {
                layer.msg(obj.message);
                //关闭弹出层
                layer.close(mainIndex)
                //刷新数据 表格
                tableIns.reload();
            })
        });

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

            layer.confirm('真的要删除这些客户么？', function (index) {
                layer.msg('处理中', {icon: 16});
                //向服务端发送删除指令
                $.post("${pageContext.request.contextPath}/teacher/deleteBatchTeacher.action", params, function (res) {

                    layer.msg(res.message);
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



