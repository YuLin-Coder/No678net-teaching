
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>学生成绩管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body class="childrenBody">
<form class="layui-form">
    <blockquote class="layui-elem-quote quoteBox">
        <form class="layui-form">
            <div class="layui-inline">
                <div class="layui-input-inline" style="width:100px">
                    <select id="searchType" class="searchType">
                        <option value="0">已开课程</option>
                        <%--<option value="1">基本课程</option>--%>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input searchVal" placeholder="输入老师名或课程名检索"/>
                </div>
                <a class="layui-btn search_btn" data-type="reload">搜索</a>
            </div>

            <div class="layui-inline" style="margin-left:20px">
                <a class="layui-btn layui-btn-normal addNews_btn">新开课程</a>
            </div>
            <div class="layui-inline">
                <a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
            </div>

            <div class="layui-inline">
                <a id="upload_btn" class="layui-btn layui-btn-primary"><i class="layui-icon">&#xe67c;</i>导入基本课程</a>
            </div>
        </form>
    </blockquote>
    <div id="ad-btn" style="display: none"><h2>老师课程分配</h2></div>

    <table id="courseList" lay-filter="courseList"></table>
    <!--操作-->
    <script type="text/html" id="courseListBar">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
    </script>
</form>

<!-- 添加的弹出层-->
<div style="display: none;padding: 20px" id="saveDiv">
    <form class="layui-form" lay-filter="dataFrm" id="dataFrm">
        <div class="layui-form-item">
            <div class="layui-inline" id="baseCourseDiv">
                <label class="layui-form-label">课程:</label>
                <div class="layui-input-inline">
                    <select id="baseCourseSelect" lay-search>

                    </select>
                </div>
            </div>
            <div class="layui-inline" id="teacherDiv">
                <label class="layui-form-label">任课教师:</label>
                <div class="layui-input-inline">
                    <select id="teacherSelect" lay-search>
                        <option name="username"></option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">开始时间:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请选择开始时间"
                           name="startDate" id="startDate" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">结束时间:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请选择结束时间" name="enDate"
                           id="endDate" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">课时:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请输入课时"
                           id="classHour" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">考核方式:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请输入考核方式"
                           name="testModel" id="testModel" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">班级人数：</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请输入人数"
                           name="studentNum" id="studentNum" class="layui-input">
                </div>
            </div>
            <div class="layui-input-block" style="text-align: center;padding-right: 120px">
                <button type="button"
                        class="layui-btn layui-btn-normal layui-btn-md layui-icon layui-icon-release layui-btn-radius"
                        lay-filter="addCourse" lay-submit="">提交
                </button>
                <button type="reset"
                        class="layui-btn layui-btn-warm layui-btn-md layui-icon layui-icon-refresh layui-btn-radius">
                    重置
                </button>
            </div>
        </div>
    </form>
</div>

<!--编辑的弹出层-->
<div style="display: none;padding: 20px" id="editDiv">
    <form class="layui-form" lay-filter="editdataFrm" id="editdataFrm">
        <div class="layui-form-item">
            <div class="layui-inline" id="editbaseCourseDiv">
                <label class="layui-form-label">课程:</label>
                <div class="layui-input-inline">
                    <input type="hidden" name="teacherId" id="teacherId">
                    <input type="hidden" name="courseId" id="courseId">
                    <input type="text" value=""
                           name="name" id="name" class="layui-input">
                </div>
            </div>
            <div class="layui-inline" id="editteacherDiv">
                <label class="layui-form-label">任课教师:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" readonly="readonly"
                           name="username" id="username" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">开始时间:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请选择开始时间"
                           name="startDate" id="editstartDate" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">结束时间:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请选择结束时间" name="endDate"
                           id="editendDate" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">课时:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请输入课时"
                           name="classHour" id="editclassHour" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">考核方式:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请输入考核方式"
                           name="testModel" id="edittestModel" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">班级人数：</label>
                <div class="layui-input-inline">
                    <input type="text" value="" placeholder="请输入人数"
                           name="studentNum" id="editstudentNum" class="layui-input">
                </div>
            </div>
            <div class="layui-input-block" style="text-align: center;padding-right: 120px">
                <button type="button"
                        class="layui-btn layui-btn-normal layui-btn-md layui-icon layui-icon-release layui-btn-radius"
                        lay-filter="editCourse" lay-submit="">提交
                </button>
                <button type="reset"
                        class="layui-btn layui-btn-warm layui-btn-md layui-icon layui-icon-refresh layui-btn-radius">
                    重置
                </button>
            </div>
        </div>
    </form>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.use(['form', 'layer', 'table', 'laytpl', 'upload'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery,
            upload = layui.upload,
            table = layui.table;
        var opTable = 0;//记录目前是哪个数据table显示

        //courseList列表 模糊查询
        var tableIns = null;
        loadCourse();

        function loadCourse() {
            tableIns = table.render({
                elem: '#courseList',
                url: '${pageContext.request.contextPath}/teacherCourse/loadTeacherCourse.action',
                request: {
                    /* pageName: 'curr' //页码的参数名称
                     ,limitName: 'nums' //每页数据量的参数名*/
                    searchKey: null
                },
                where: {
                    searchKey: $(".searchVal").val()  //搜索的关键字
                },
                cellMinWidth: 95,
                page: true,
                toolbar: "#ad-btn",
                height: "full-125",
                limits: [10, 15, 20, 25,1000],
                limit: 10,
                loading: true,
                id: "courseListTable",
                cols: [[
                    {type: "checkbox", fixed: "left", width: 50},
                    {field: 'courseId', title: '课程编号', sort: true, minWidth: 80, align: "left"},
                    {field: 'name', title: '课程名', minWidth: 120, align: 'left'},
                    {field: 'username', title: '任课教师', minWidth: 120, align: 'left'},
                    {field: 'startDate', title: '开始时间', minWidth: 100, align: 'center'},
                    {field: 'endDate', title: '结束时间', minWidth: 100, align: 'center'},
                    {field: 'classHour', title: '课时', minWidth: 100, align: 'center'},
                    {field: 'testModel', title: '考核方式', minWidth: 100, align: 'center'},
                    {field: 'studentNum', title: '最大人数', minWidth: 100, align: 'center'},
                    {field: "choiceNum", title: "已选（人）", minWidth: 100, align: "center"},
                    {title: '操作', width: 160, templet: '#courseListBar', fixed: "right", align: "center"}
                ]]
            });
        }

        //搜索
        $(".search_btn").on("click", function () {
            //对course的搜索
            if ($("#searchType").val() == 0) {
                opTable = 0;
                if (tableIns == null) {
                    loadCourse();
                } else {
                    tableIns.reload({
                        page: {
                            curr: 1 //重新从第 1 页开始
                        },
                        where: {
                            searchKey: $(".searchVal").val()  //搜索的关键字
                        }
                    });
                }
            } /*else {//对基本课程的搜索
                opTable = 1;
                if (baseCourseTableIns == null) {
                    loadBaseCourseList();
                } else {
                    baseCourseTableIns.reload({
                        page: {
                            curr: 1
                        },
                        where: {
                            searchKey: $(".searchVal").val()
                        }
                    });
                }
            }*/
        });


        var addEdit;

        //添加开设课程
        function addCourse(edit) {

            addEdit = layui.layer.open({
                title: "新增开设课程",
                type: 1,
                area: ['720px', '360px'],
                content: $("#saveDiv"),//../course/addPage.html
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', addEdit);

                    /* if(edit){
                         //body.find("#id").val(edit.id);
                         //alert(edit.startDate);
                      /* var select = body.find("#teacherSelect");
                         select.html("<option id='defaultTeacher' value='"+edit.username+"' >"+edit.username+"</option>");
                         select = body.find("#baseCourseSelect");
                         select.html("<option id='defaultCourse' value='"+edit.baseCourseId+"' >"+edit.name+"</option>");

                         body.find("#startDate").val(edit.startDate);

                         body.find("#endDate").val(edit.endDate);
                         body.find("#classHour").val(edit.classHour);
                         body.find("#testModel").val(edit.testModel);
                         body.find("#studentNum").val(edit.studentNum);
                         body.find('#reset').attr("disabled","disabled").addClass("layui-disabled");
                         layui.form.render();
                     }*/

                }
            });
            // layui.layer(addEdit);//充满整个屏幕layui.layer.full(index);
            //window.sessionStorage.setItem("index",addEdit);
            //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
            // $(window).on("resize",function(){
            //    layui.layer.full(window.sessionStorage.getItem("addEdtit"));
            // });
        }

        //修改开设的课程
        var editAdd

        function editCourse(edit) {
            editAdd = layui.layer.open({
                title: "编辑开设课程",
                type: 1,
                area: ['720px', '360px'],
                content: $("#editDiv"),//../course/addPage.html
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', editAdd);

                    //body.find("#id").val(edit.id);
                    form.val("editdataFrm", edit);
                }
            });
        }


        //添加
        $(".addNews_btn").click(function () {
            addCourse();
        });
        /*  $("#addBaseCourse").click(function(){
              addBaseCourse();
          });
  */

        //批量导入
        var uploadInst = upload.render({
            elem: '#upload_btn' //绑定元素
            , url: '../basecourse/import.html' //上传接口
            , accept: 'file'
            , exts: 'xls|xlsx'
            , before: function (obj) {
                layer.load(); //上传loading
            }
            , done: function (res) {
                layer.closeAll('loading'); //关闭loading
                if (opTable == 1) {
                    baseCourseTableIns.reload();
                }
            }
            , error: function () {
                layer.closeAll('loading'); //关闭loading
            }
        });
        //批量删除
        $(".delAll_btn").click(function () {
            var checkStatus;
            var url;
            //if (opTable == 0) {
                checkStatus = table.checkStatus('courseListTable');
                url = '${pageContext.request.contextPath}/teacherCourse/deleteList.action';
           // }

            var data = checkStatus.data, teacherIds = "",courseIds="";
            if (data.length > 0) {
                for (var i in data) {
                    teacherIds += data[i].teacherId + "-";
                }
                var teacherId = teacherIds.substr(0,teacherIds.length-1);
                for (var i in data) {
                    courseIds += data[i].courseId + "-";
                }
                var courseId = courseIds.substr(0,courseIds.length-1);
                alert(teacherId);
                layer.confirm('确定删除选中的课程？', {icon: 3, title: '提示信息'}, function (index) {
                    $.ajax({
                        type: 'post',
                        data: {
                            teacherId:teacherId,
                            courseId:courseId
                        },
                        url: url,
                        timeout: 2000,
                        success: function (res) {
                            if (res.code == 1) {
                                layer.msg(res.message, {icon: 1, time: 1000});
                                if (opTable == 0) {
                                    tableIns.reload({
                                        page: {
                                            curr: 1 //重新从第 1 页开始
                                        }
                                    });
                                } /*else {
                                    baseCourseTableIns.reload({page: {
                                            curr: 1 //重新从第 1 页开始
                                        }});
                                }*/
                            } else {
                                layer.msg(res, {icon: 5, time: 1000});
                            }
                            layer.close(index);
                        },
                        error: function () {
                            layer.msg("操作失败！", {icon: 5, time: 1000});
                            layer.close(index);
                        }
                    });
                });
            } else {
                layer.msg("请选择需要删除的行");
            }
        });

        //列表操作
        table.on('tool(courseList)', function (obj) {
            var layEvent = obj.event,
                data = obj.data;
            if (layEvent === 'edit') { //编辑
                if (opTable == 0) {
                    editCourse(data);
                } /*else {
                    addBaseCourse(data);
                }*/
            } else if (layEvent === 'del') { //删除
                var url;
                if (opTable == 0) {
                    url = '${pageContext.request.contextPath}/teacherCourse/delete.action';
                }
                layer.confirm('确定删除？', {icon: 3, title: '提示信息'}, function (index) {
                    $.ajax({
                        type: 'post',
                        data: {
                            teacherId: data.teacherId,
                            courseId: data.courseId
                        },
                        url: url,
                        success: function (res) {
                            if (res.code == 1) {
                                layer.msg(res.message);
                                tableIns.reload();

                                layer.close(index);
                            } else {
                                layer.msg("删除失败", {icon: 5, time: 1000});
                                layer.close(index);
                            }
                        }
                    });
                });
            }
        });

        //点击用于添加的保存按钮
        form.on("submit(addCourse)", function (data) {
            //弹出loading
            var index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
            //var id = $("#id").val();
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/teacherCourse/addCourseInfo.action',
                data: {
                    //id : id,
                    teacherId: $("#teacherSelect").val(),
                    courseId: $("#baseCourseSelect").val(),
                    startDate: $("#startDate").val(),
                    endDate: $("#endDate").val(),
                    classHour: $("#classHour").val(),
                    testModel: $("#testModel").val(),
                    studentNum: $("#studentNum").val()
                },
                timeout: 2000,
                success: function (msg) {
                    //top.layer.close(index);
                    if (msg.code == 1) {
                        top.layer.msg(msg.message);
                        //parent.location.reload();//成功则刷新父页面
                    } else {
                        top.layer.msg("该老师的该课程已经存在", {icon: 5, time: 1000});
                    }
                    layui.layer.close(addEdit);
                    tableIns.reload({
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                    });
                    $("#dataFrm")[0].reset();
                },
                error:function (msg) {
                    layer.msg("添加失败");
                    layui.layer.close(addEdit);
                }
            });
            return false;
        });

        //点击用于修改的保存按钮后
        form.on("submit(editCourse)", function (data) {
            //弹出loading
            var index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
            var id = $("#id").val();
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/teacherCourse/editCourseInfo.action',
                data: {
                    //id : id,
                    teacherId: $("#teacherId").val(),
                    courseId: $("#courseId").val(),
                    startDate: $("#editstartDate").val(),
                    endDate: $("#editendDate").val(),
                    classHour: $("#editclassHour").val(),
                    testModel: $("#edittestModel").val(),
                    studentNum: $("#editstudentNum").val()
                },
                timeout: 2000,
                success: function (msg) {
                    //top.layer.close(index);

                    if (msg.code == 1) {
                            //修改成功则刷新父页面
                            //layer.closeAll("iframe");
                            //关闭弹出层
                            //parent.location.reload();
                            top.layer.msg(msg.message);
                        tableIns.reload();
                        } else {
                            top.layer.msg("修改失败");
                            //parent.location.reload();
                        }
                    layui.layer.close(editAdd);
                    $("#editdataFrm")[0].reset();
                }
            });
            return false;
        });

    });


    layui.use(['form', 'layer', 'laydate'], function () {
        var form = layui.form,
            laydate = layui.laydate,
            //layer = parent.layer === undefined ? layui.layer : top.layer,
            layer = layui.layer;
        $ = layui.jquery;

        laydate.render({elem: '#startDate'});
        laydate.render({elem: '#endDate'});
        laydate.render({elem: '#editstartDate'});
        laydate.render({elem: '#editendDate'});

        var inputObj = $("#teacherDiv").find("input");
        inputObj.bind("keyup", function (event) {
            if (event.keyCode == "13") {
                loadTeacher();
            }
        });

        /**
         * 老师搜索,添加到增加和修改框里
         */
        function loadTeacher() {
            var searchKey = inputObj.val();
            $.ajax({
                type: 'get',
                url: '${pageContext.request.contextPath}/teacher/getTeacherList.action',
                data: {username: searchKey},
                timeout: 1500,
                success: function (msg) {
                    var select = $('#teacherSelect');
                    var options = "";//select.html();
                    var data = msg.data;
                    for (var i in data) {
                        options += "<option value='" + data[i].id + "'>" + data[i].username + "</option>";
                    }
                    select.html(options);
                    form.render('select');
                    //渲染后要重新绑定
                    inputObj = $("#teacherDiv").find("input");
                    inputObj.click();
                    inputObj.bind("keyup", function (event) {
                        if (event.keyCode == "13") {
                            loadTeacher();
                        }
                    });
                    //课程的搜索绑定
                    inputObj2 = $("#baseCourseDiv").find("input");
                    inputObj2.bind("keyup", function (event) {
                        if (event.keyCode == "13") {
                            loadCourse();
                        }
                    });
                }
            });
        }

        var inputObj2 = $("#baseCourseDiv").find("input");
        inputObj2.bind("keyup", function (event) {
            if (event.keyCode == "13") {
                loadCourse();
            }
        });

        /**
         * 课程搜索,添加到增加和修改框里
         */
        function loadCourse() {
            var searchKey = inputObj2.val();
            $.ajax({
                type: 'get',
                url: '${pageContext.request.contextPath}/course/getCourseList.action',
                data: {name: searchKey},
                timeout: 1500,
                success: function (msg) {
                    var select = $('#baseCourseSelect');
                    var options = "";
                    var data = msg.data;
                    for (var i in data) {
                        options += "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
                    }
                    select.html(options);
                    form.render('select');
                    //渲染后要重新绑定
                    inputObj = $("#teacherDiv").find("input");
                    inputObj.bind("keyup", function (event) {
                        if (event.keyCode == "13") {
                            loadTeacher();
                        }
                    });
                    //课程的搜索绑定
                    inputObj2 = $("#baseCourseDiv").find("input");
                    inputObj2.click();
                    inputObj2.bind("keyup", function (event) {
                        if (event.keyCode == "13") {
                            loadCourse();
                        }
                    });
                }
            });
        }

        $(document).ready(function () {
            if (inputObj.val() == null || inputObj.val() == "") {
                loadTeacher();
                loadCourse();
            }
        });


    });
</script>
</body>
</html>