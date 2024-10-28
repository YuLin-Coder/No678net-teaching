<%--
  Created by IntelliJ IDEA.
  User: 丹青
  Date: 2019/12/21
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>教师</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body class="childrenBody">
<form class="layui-form">
    <div id="info-btn" style="display: none"><h2>${currentUser.username}的课程信息</h2></div>
    <table id="courseList" lay-filter="courseList" ></table>
    <!--操作-->
    <script type="text/html" id="courseListBar">
        <a class="layui-btn layui-btn-xs" lay-event="edit">结束课程</a>
    </script>

</form>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.use(['layer','table'],function(){
        var $ = $ = layui.jquery;
        //courseList列表
        tableIns = layui.table.render({
            elem: "#courseList",
            url : "${pageContext.request.contextPath}/teacherCourse/getMyCourse.action",
            request: {
               /* pageName: "curr" //页码的参数名称
                ,limitName: "nums" //每页数据量的参数名*/
            },
            cellMinWidth : 95,
            page : true,
            toolbar: "#info-btn",
            height : "full-25",
            limits : [10,15,20,25],
            limit : 10,
            loading : true,
            id : "courseListTable",
            cols : [[
                {field: "courseId", title: "课程编号", sort:true, width:100, align:"left"},
                {field: "name", title: "课程名",minWidth:120, align:"left"},
                {field: "username", title: "任课教师",minWidth:120, align:"left"},
                {field: "startDate", title: "开始时间", sort:true, minWidth:100, align:"center"},
                {field: "endDate", title: "结束时间", minWidth:100, align:"center"},
                {field: "classHour", title: "课时", minWidth:100, align:"center"},
                {field: "testModel", title: "考核方式", minWidth:100, align:"center"},
                {field: "studentNum", title: "最大人数", minWidth:100, align:"center"},
                {field: "choiceNum", title: "已选（人）", minWidth:100, align:"center"},
                {field: "complete", title: "状态", minWidth:100, align:"center",templet: function (d){
                  return   d.complete==0? '<font color="red">进行中</font>':'<font color="blue">已结束</font>'
                    }},
                {title: "操作", width:100, templet:"#courseListBar",fixed:"right",align:"center"}
            ]]
        });


        //列表操作
        layui.table.on("tool(courseList)", function(obj){
            layer.confirm('请确保结束课程前已提交学生成绩！确定结束此课程？', {icon: 3, title: '提示信息'}, function (index) {
                var data = obj.data;
                $.ajax({
                    type: "get",
                    data: { courseId: data.courseId, teacherId: data.teacherId },
                    url: "${pageContext.request.contextPath}/teacherCourse/completeCourse.action",
                    success:function(res) {
                        if (res.code == 200) {
                            tableIns.reload();
                            layer.msg("课程已结束")
                            layer.close(index);
                        }else {
                            layer.msg("该课程已结束", {icon: 5,time:1000});
                        }
                    }
                });
            });
        });
    });
</script>
</body>
</html>