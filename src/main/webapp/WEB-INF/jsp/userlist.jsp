<%--
  Created by IntelliJ IDEA.
  User: 丹青
  Date: 2019/12/10
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
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
                        <input type="text" name="username" id="username" autocomplete="off"
                               class="layui-input layui-input-inline"
                               placeholder="请输入用户名称" style="height: 30px;border-radius: 10px">
                    </div>
                </div>
                <%-- <div class="layui-inline">
                     <label class="layui-form-label">教工号/学号:</label>
                     <div class="layui-input-inline" style="padding: 5px">
                         <input type="text" name="number" id="number" autocomplete="off"
                                class="layui-input layui-input-inline"
                                placeholder="请输入教工号/学号" style="height: 30px;border-radius: 10px">
                     </div>
                 </div>--%>

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
                <label class="layui-form-label">角色:</label>
                <div class="layui-input-inline">
                    <input type="radio" name="role" value="1" title="学生">
                    <input type="radio" name="role" value="0" title="老师">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">状态:</label>
                <div class="layui-input-inline">
                    <input type="radio" name="status" value="1" title="可用">
                    <input type="radio" name="status" value="0" title="停用">
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
            <button type="button" class="layui-btn layui-btn-sm data-add-btn layui-btn-radius" lay-event="add">新增
            </button>
            <button type="button" class="layui-btn layui-btn-danger data-delete-btn layui-btn-sm layui-btn-radius"
                    lay-event="deleteBatch">批量删除
            </button>

        </div>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

    </div>
    <div id="UserBar" style="display: none;">
        <a class="layui-btn layui-btn-xs layui-btn layui-btn-normal layui-btn-radius" lay-event="add">生成信息</a>
        <a class="layui-btn layui-btn-xs layui-btn-radius" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs layui-btn-radius" lay-event="delete">删除</a>
    </div>

    <!-- 添加和修改的弹出层-->
    <div style="display: none;padding: 20px" id="saveOrUpdateDiv">
        <form class="layui-form" lay-filter="dataFrm" id="dataFrm">
            <div class="layui-form-item">
                <input type="hidden" name="id" placeholder="用户id：用来方便通过id修改，在页面中并不现实这个" autocomplete="off" class="layui-input">
                <div class="layui-inline">
                    <label class="layui-form-label">用户姓名:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="username" lay-verify="required" placeholder="请输入用户姓名"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">用户密码:</label>
                    <div class="layui-input-inline">
                        <input type="password" name="password" placeholder="请输入密码"
                               autocomplete="off" lay-verify="required" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">教工号/学号:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="number" lay-verify="required" placeholder="请输入教工号/学号"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">出生年月</label>
                    <div class="layui-input-block">
                        <input type="text" id="birthdate" name="birthday" value="" placeholder="请输入出生年月" lay-verify="userBirthday" readonly class="layui-input userBirthday">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">用户邮箱:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="email" <%--lay-verify="email" --%>placeholder="请输入用户邮箱"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">用户职位:</label>
                    <div class="layui-input-inline">
                        <input type="radio" name="role" value="1" checked="checked" lay-verify="otherReq" title="学生">
                        <input type="radio" name="role" value="0" lay-verify="otherReq" title="老师">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">用户性别:</label>
                    <div class="layui-input-inline">
                        <input type="radio" name="sex" checked="checked" value="1" title="女">
                        <input type="radio" name="sex" value="0" title="男">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">是否可用:</label>
                    <div class="layui-input-inline">
                        <input type="radio" name="status" checked="checked" value="1" title="可用">
                        <input type="radio" name="status" value="0" title="停用">
                    </div>
                </div>
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
    layui.use(['laydate','jquery', 'layer', 'form', 'table'], function () {
        var laydate = layui.laydate;
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        var dtree = layui.dtree;
        laydate.render({
            elem: '#birthdate' //指定元素
        })
        tableIns = table.render({
            elem: '#currentTableId',
            url: "${pageContext.request.contextPath}/user/getUserlist.action",
            method: "POST",
            where: {
                username: null,
                sex: null,
                status: null,
                role: null,
                address: null
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
            cols: [[
                {type: "checkbox", width: 50, fixed: "left", align: "center"},
                {field: 'id', width: 60, title: 'ID', sort: true, align: "center"},
                {field: 'username', width: 80, title: '用户名', align: "center"},
                {field: 'number', width: 120, title: '教工号/学号', sort: true, align: "center"},

                {
                    field: 'sex', width: 65, title: '性别', sort: true, align: "center", templet: function (a) {
                        return a.sex == '0' ? '<font color=blue>男</font>' : '<font color=red>女</font>';
                    }
                },

                {field: 'email', width: 280, title: '邮箱', align: "center"},

                {
                    field: 'role', width: 65, title: '角色', sort: true, align: "center", templet: function (d) {
                            return d.role == 1 ? '<font color=#deb887>学生</font>' : '<font color=#9acd32>老师</font>';
                    }
                },

                {field: 'birthday', width: 120, title: '生日', align: "center"},

                {
                    field: 'status', width: 65, title: '状态', sort: true, align: "center", templet: function (d) {
                        return d.status == '1' ? '<font color=green>可用</font>' : '<font color=red>停用</font>';
                    }
                },
                {title: '操作', minWidth: 220, templet: '#UserBar', fixed: "right", align: "center"}
            ]]
        });

        // 监听搜索操作
        $("#doSearch").click(function () {
            search();
        });

          // 监听添加操作，后面的可以用
         /*   $(".data-add-btn").on("click", function () {

               openAddUser();
               return true;
           });*/

        //监听头部工具栏事件
        table.on("toolbar(currentTableFilter)", function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddUser();
                    break;
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });
        //监听每一行的编辑和删除和生成老师/学生的表
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                //layer.alert('编辑行：<br>' + JSON.stringify(data))
                openUpdateCustomer(data);//把layui框架拿到的数据(data)放到编辑框里，传入data数据
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除【' + data.username + '】这个客户么？', function (index) {
                    //向服务端发送删除指令
                    $.post("${pageContext.request.contextPath}/user/deleteUser.action", {id: data.id}, function (res) {
                        layer.msg(res.message);
                        //刷新数据表格
                        tableIns.reload();
                    })
                });
            }else if(obj.event === 'add'){
                if(data.role==0){//生成老师的信息到老师表中
                    layer.confirm('确定要生成'+data.username+'老师信息吗？', function (index) {
                        //向服务端发送新增指令
                        $.post("${pageContext.request.contextPath}/teacher/addTeacher.action", {id:data.number,username:data.username,password:data.password,introduce:data.description}, function (res) {
                            if(res.message!=undefined){
                                layer.msg(res.message);
                            }else{
                                layer.msg("【"+data.username+"】老师信息已存在");
                            }
                        })
                    });
                }else{//生成学生的信息到学生表中
                    layer.confirm('确定要生成'+data.username+'学生信息吗？', function (index) {
                        //向服务端发送新增指令
                        $.post("${pageContext.request.contextPath}/student/addStudent.action", {id:data.number,username:data.username,password:data.password}, function (res) {
                            if(res.message!=undefined){
                                layer.msg(res.message);
                            }else {
                                layer.msg("【"+data.username+"】学生信息已存在");
                            }
                        })
                    });
                }
            }
        });


        var url;
        var mainIndex;


        //打开添加页面
        function openAddUser() {
            mainIndex = layer.open({
                type: 1,
                title: '添加用户',
                content: $("#saveOrUpdateDiv"),
                area: ['700px', '380px'],
                success: function (index) {
                    //清空表单数据
                    $("#dataFrm")[0].reset();
                    url = "${pageContext.request.contextPath}/user/addUser.action";
                }
            });
        }

        //打开修改页面
        function openUpdateCustomer(data) {
            mainIndex = layer.open({
                type: 1,
                title: '修改客户',
                content: $("#saveOrUpdateDiv"),
                area: ['700px', '380px'],
                success: function (index) {
                    form.val("dataFrm", data);//把数据放到编辑框
                    url = "${pageContext.request.contextPath}/user/editUser.action";
                }
            });
        }


        //模糊查询
        function search() {

            var username = $("#username").val();
            var address = $("#address").val();
            /*不加if判断之前遇到的问题：
          * 模糊查询一次，点击重置按钮之后，单选框的值虽然是重置的，但是发请求的时候，依然会带上重置之前的值。
          * 原因：未知。
          * */
            var sex = $('#searchForm input[name="sex"]:checked').val();

            if (sex == undefined) {
                sex = null;
            }
            var status = $('#searchForm input[name="status"]:checked').val();
            if (status == undefined) {
                status = null;
            }
            var role = $('#searchForm input[name="role"]:checked').val();
            if (role == undefined) {
                role = null;
            }
            //var userVo = $("#searchForm").serialize();
            tableIns.reload({
                where: {
                    username: username,
                    sex: sex,
                    status: status,
                    role: role,
                    address: address
                }
            });
        }

        //保存（添加和修改公用）
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#dataFrm").serialize();
           // alert(params);
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
                $.post("${pageContext.request.contextPath}/user/deleteBatchUser.action", params, function (res) {

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