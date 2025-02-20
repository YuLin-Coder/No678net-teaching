<%--
  Created by IntelliJ IDEA.
  User: 丹青
  Date: 2019/12/21
  Time: 19:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>学生</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body class="childrenBody">
<form class="layui-form">
    <blockquote class="layui-elem-quote quoteBox">
        <form class="layui-form">
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input type="text" class="layui-input searchVal" placeholder="请输入搜索的内容" />
                </div>
                <a class="layui-btn search_btn" data-type="reload">搜索</a>
            </div>

            <div class="layui-inline" style="margin-left:30px">
                <a class="layui-btn layui-btn-primary search_btn" id="all">可选课程</a>
            </div>
            <div class="layui-inline">
                <a class="layui-btn layui-btn-primary search_btn" id="my">已选课程</a>
            </div>
        </form>
    </blockquote>
    <div style="display: none" id="info-btn">${currentUser.username} </div>

    <table id="courseList" lay-filter="courseList" ></table>
    <!--操作-->
    <script type="text/html" id="courseListBar">
        <a class="layui-btn layui-btn-xs" lay-event="choice">选课</a>
    </script>
    <!--操作-->
    <script type="text/html" id="courseListBar2">
        <a class="layui-btn layui-btn-xs" lay-event="cancelChoice">取消</a>
    </script>
</form>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.use(['layer','table'],function(){
        var layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery,
            table = layui.table;

        var colsArray = [[
            {field: "courseId", title: "课程编号", sort:true, width:100, align:"left"},
            {field: "name", title: "课程名",minWidth:120, align:"left"},
            {field: "username", title: "任课教师",minWidth:120, align:"left"},
            {field: "startDate", title: "开始时间", minWidth:100, align:"center"},
            {field: "endDate", title: "结束时间", minWidth:100, align:"center"},
            {field: "classHour", title: "课时", minWidth:100, align:"center"},
            {field: "testModel", title: "考核方式", minWidth:100, align:"center"},
            {field: "studentNum", title: "最大人数", minWidth:100, align:"center"},
            {field: "choiceNum", title: "已选（人）", minWidth:100, align:"center"},
            {title: "操作", width:90, templet:"#courseListBar",fixed:"right",align:"center"}
        ]];


        //courseList列表
        var tableIns = null;
        loadChoiceList(1);
        function loadChoiceList(isAll) {

            if (isAll == 1) {
                colsArray[0][9] = {title: "操作", width:90, templet:"#courseListBar",fixed:"right",align:"center"};
            } else {
                colsArray[0][9] = {title: "操作", width:90, templet:"#courseListBar2",fixed:"right",align:"center"};
            }
            tableIns = table.render({
                elem: "#courseList",
                method: "POST",
                url : "${pageContext.request.contextPath}/teacherCourse/choiceList.action",
                request: {
                    /*pageName: "curr" //页码的参数名称
                    ,limitName: "nums" //每页数据量的参数名*/
                    searchKey : null
                },
                where: {
                    isAll: isAll,
                    searchKey: $(".searchVal").val()  //搜索的关键字
                },
                cellMinWidth : 95,
                page : true,
                height : "full-125",
                limits : [10,20,50,100],
                limit : 10,
                loading : true,
                id : "courseListTable",
                cols : colsArray
            });
        }

        //搜索
        $(".search_btn").on("click",function(){
            if ($(this).attr("id") == "my") {
                loadChoiceList(0);
            } else {//搜索和all
                loadChoiceList(1);
            }
        });

        //列表操作
        table.on("tool(courseList)", function(obj){
            var data = obj.data, layEvent = obj.event;
            var url;
            if (layEvent == "choice") {
                url = "${pageContext.request.contextPath}/studentCourse/choiceCourse.action";
            } else {
                url = "${pageContext.request.contextPath}/studentCourse/delete.action";
            }
            $.ajax({
                type: "POST",
                data: {
                    courseId: data.courseId,
                    teacherId:data.teacherId
                },
                url: url,
                success:function(res) {
                    if (res.code == 1) {
                        layer.msg(res.message)
                        tableIns.reload();
                        //layer.close(index);
                        layer.msg(res.message)
                    }else {
                        layer.msg(res.message, {icon: 5,time:1000});
                    }
                }
            });
        });

    });
</script>
</body>
</html>