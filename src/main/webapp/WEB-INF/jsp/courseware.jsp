
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员查看备课</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <%--<link rel="icon" href="favicon.ico">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body class="childrenBody">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>教案</legend>
</fieldset>
<!-- 数据表格开始 -->
<table class="layui-hide" id="carTable" lay-filter="carTable"></table>
<div id="carToolBar" style="display: none;">
    <%--    <button type="button" class="layui-btn layui-btn-sm layui-btn-radius" lay-event="add">增加</button>--%>
    <%--    <button type="button" class="layui-btn layui-btn-danger layui-btn-sm layui-btn-radius" lay-event="deleteBatch">--%>
    <%--        批量删除--%>
    <%--    </button>--%>
</div>
<div id="carBar" style="display: none;">
    <a class="layui-btn layui-btn-xs layui-btn-radius" lay-event="edit">评分</a>
    <a class="layui-btn layui-btn-xs layui-btn-radius" lay-event="viewImage">查看教案</a>
<%--    <a class="layui-btn layui-btn-danger layui-btn-xs layui-btn-radius" lay-event="del">删除</a>--%>
</div>

<!-- 添加和修改的弹出层-->
<div style="display: none;padding: 20px" id="saveOrUpdateDiv">
    <form class="layui-form layui-row layui-col-space10" method="post" enctype="multipart/form-data" lay-filter="dataFrm" id="dataFrm">
        <div class="layui-col-md12 layui-col-xs12">
            <div class="layui-row layui-col-space10">
                <div class="layui-col-md9 layui-col-xs7">

                    <div class="layui-form-item magt3">
                        <label class="layui-form-label">课件名称:</label>
                        <div class="layui-input-block" style="padding: 5px">
                            <input type="hidden" name="id">
                            <input type="text" name="name" readonly="readonly" autocomplete="off" class="layui-input"
                                   lay-verify="required"
                                   placeholder="请输入课件名称" style="height: 30px;border-radius: 10px">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">教案评价:</label>
                        <div class="layui-input-inline">
                            <input type="radio" name="score" value="差" title="差">
                            <input type="radio" name="score" value="一般" title="一般">
                            <input type="radio" name="score" value="好" title="好">
                            <input type="radio" name="score" value="很好" title="很好">
                        </div>
                    </div>
                </div>
            </div>

            <div class="layui-form-item magb0">
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
        </div>
    </form>
</div>

<%--查看大图弹出的层开始--%>
<div id="viewCarImageDiv" style="display: none;text-align: center">
    <a alt="教案" width="700px" height="450px" id="view_carimg" style="color: red">教案查看(点击下载)</a>
</div>

<script src="${pageContext.request.contextPath}/lib/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script type="text/javascript">

    var tableIns;
    layui.use(['jquery', 'layer', 'form', 'table', 'upload'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        var dtree = layui.dtree;
        var upload = layui.upload;
        //渲染数据表格
        tableIns = table.render({
            elem: '#carTable'   //渲染的目标对象
            , url: '${pageContext.request.contextPath}/courseware/getCoursewareForM.action' //数据接口
            , title: ''//数据导出来的标题
            , toolbar: "#carToolBar"   //表格的工具条
            , height: 'full-210'
            , cellMinWidth: 100 //设置列的最小默认宽度
            , page: true  //是否启用分页
            , cols: [[   //列表数据
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: '课件编号', align: 'center', width: '60'}
                , {field: 'subject', title: '教学科目', align: 'center', width: '150'}
                , {field: 'name', title: '课件名称', align: 'center', width: '100'}
                , {field: 'introduce', title: '介绍', align: 'center', width: '190'}
                , {field: 'number', title: '教师编号', align: 'center', width: '180'}
                , {field: 'teacherName', title: '教师姓名', align: 'center', width: '100'}
                , {field: 'time', title: '创建时间', align: 'center', width: '200'}
                , {field: 'score', title: '评价', align: 'center', width: '100'}
                , {field: 'evTime', title: '评价时间', align: 'center', width: '200'}
                , {field: 'operator', title: '评价人', align: 'center', width: '100'}
                ,{title: '操作', width: 160, templet: '#carBar', fixed: "right", align: "center"}
            ]],
            done: function (data, curr, count) {
                //不是第一页时，如果当前返回的数据为0那么就返回上一页
                if (data.data.length == 0 && curr != 1) {
                    tableIns.reload({
                        page: {
                            curr: curr - 1
                        }
                    })
                }
            }
        });

        //模糊查询
        $("#doSearch").click(function () {
            var params = $("#searchFrm").serialize();
//            alert(params);
            tableIns.reload({
                url: "${pageContext.request.contextPath}/courseware/getCourseware.action",
                data:params,
                page: {curr: 1}
            })
        });

        //监听头部工具栏事件
        table.on("toolbar(carTable)", function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddCar();
                    break;
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }
        });

        //监听行工具事件
        table.on('tool(carTable)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            if (layEvent === 'del') { //删除
                layer.confirm('真的删除【' + data.name + '】这个教案么？', function (index) {
                    //向服务端发送删除指令
                    $.post("${pageContext.request.contextPath}/courseware/delCourseware.action", {id: data.id}, function (res) {
                        layer.msg(res.msg);
                        //刷新数据表格
                        tableIns.reload();
                    })
                });
            } else if (layEvent === 'edit') { //编辑
                //编辑，打开修改界面
                openUpdateCar(data);
            }else if (layEvent === 'viewImage'){ //查看大图
                showCarImage(data);
            }
        });

        var url;
        var mainIndex;

        /*  //打开添加页面
          function openAddCar() {
              mainIndex = layer.open({
                  type: 1,
                  title: '添加车辆',
                  content: $("#saveOrUpdateDiv"),
                  area: ['700px', '480px'],
                  success: function (index) {
                      //清空表单数据
                      $("#dataFrm")[0].reset();
                      //设置默认图片
                      $("#showCarImg").attr("src", "${yeqifu}/file/downloadShowFile.action?path=images/defaultcarimage.jpg");
                    $("#carimg").val("images/defaultcarimage.jpg");
                    url = "${yeqifu}/car/addCar.action";
                    $("#carnumber").removeAttr("readonly","readonly");
                }
            });
        }*/

        //打开修改页面
        function openUpdateCar(data) {
            mainIndex = layer.open({
                type: 1,
                title: '教案评价',
                content: $("#saveOrUpdateDiv"),
                area: ['700px', '280px'],
                success: function (index) {
                    form.val("dataFrm", data);
                    url = "${pageContext.request.contextPath}/courseware/editCoursewareForM.action"
                }
            });
        }

        //保存
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#dataFrm").serialize();
            $.post(url, params, function (obj) {
                layer.msg(obj.msg);
                //关闭弹出层
                layer.close(mainIndex)
                //刷新数据 表格
                tableIns.reload();
            })
        });

        //批量删除
        function deleteBatch() {
            //得到选中的数据行
            var checkStatus = table.checkStatus('carTable');
            var data = checkStatus.data;
            var params = "";
            $.each(data, function (i, item) {
                if (i == 0) {
                    params += "ids=" + item.carnumber;
                } else {
                    params += "&ids=" + item.carnumber;
                }
            });
            layer.confirm('真的要删除这些教案么？', function (index) {
                //向服务端发送删除指令
                $.post("${yeqifu}/car/deleteBatchCar.action", params, function (res) {
                    layer.msg(res.msg);
                    //刷新数据表格
                    tableIns.reload();
                })
            });
        }

        //上传缩略图
        upload.render({
            elem: '#carimgDiv',
            url: '${yeqifu}/file/uploadFile.action',
            method: "post",  //此处是为了演示之用，实际使用中请将此删除，默认用post方式提交
            acceptMime: 'images/*',
            field: "mf",
            done: function (res, index, upload) {
                $('#showCarImg').attr('src', "${yeqifu}/file/downloadShowFile.action?path=" + res.data.src);
                $('#carimg').val(res.data.src);
                $('#carimgDiv').css("background", "#fff");
            }
        });

        //查看教案
        function showCarImage(data) {
            mainIndex = layer.open({
                type: 1,
                title: "教案名：【"+data.name+'】',
                content: $("#viewCarImageDiv"),
                area: ['250px', '100px'],
                success: function (index) {
                    $("#view_carimg").attr("href","${pageContext.request.contextPath}/courseware/download.action?filename="+data.address);
                }
            });
        }

    });

</script>
</body>
</html>

