<%--
  Created by IntelliJ IDEA.
  User: 丹青
  Date: 2019/12/22
  Time: 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>学生成绩页面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body class="childrenBody">
<form class="layui-form">
    <blockquote class="layui-elem-quote quoteBox">
        <form class="layui-form">
            <div class="layui-inline" style="margin-left:40px">
                <div class="layui-input-inline" >
                    <select id="searchType" class="searchType">
                        <option value="">全部</option>
                        <#list courseList as C >
                        <option value="${C.id}">${C.courseName}</option>
                        </#list>
                    </select>
                </div>
                <a class="layui-btn search_btn" data-type="reload">确定</a>
            </div>

            <div class="layui-inline" style="margin-left:40px">
                <a id="update_list_btn" class="layui-btn ">批量提交成绩</a>
            </div>

           <%-- <div class="layui-inline" style="margin-left:40px">
                <a id="upload_btn" class="layui-btn ">导出</a>
            </div>--%>

        </form>
    </blockquote>
    <div id="toolbar" style="display: none"><h2>${currentUser.username}老师的学生信息</h2></div>
    <table id="studentList" lay-filter="studentList"></table>
    <!--操作-->
    <script type="text/html" id="studentListBar">
        <a class="layui-btn layui-btn-xs" lay-event="edit">提交成绩</a>
    </script>
</form>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.use(['form','layer','table','laytpl','upload'],function(){
        var form = layui.form,
            laytpl = layui.laytpl,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery,
            table = layui.table;

        //学生列表
        var tableIns = table.render({
            elem: "#studentList",
            method:"POST",
            url : "${pageContext.request.contextPath}/studentCourse/stulist.action",
            request: {
               /* pageName: 'curr'
                ,limitName: 'nums'*/
            },
           /* where: {
                courseId: $("#searchType").val()
            },*/
            cellMinWidth : 95,
            page : true,
            toolbar: "#toolbar",
            height : "full-125",
            limits : [10,15,20,25],
            limit : 10,
            loading : true,
            id : "studentListTable",
            cols : [[
                {type: "checkbox", fixed:"left", width:50},
                {field: "studentId", title: "学号", sort:true, minWidth:150, align:"center"},
                {field: "username", title: "姓名",minWidth:100, align:"center"},
                {field: "grdate", title: "班级", minWidth:150, align:"center"},
                {field: "name", title: "课程名", minWidth:150, align:"center"},
                {field: "score", title: "成绩", edit: "text", minWidth:60, align:"center"},
                {field: "result", title: "学习评价（差、一般、好、很好）", edit: "text", minWidth:250, align:"center"},
                {title: "操作", width:100, templet:"#studentListBar",fixed:"right",align:"center"}
            ]]
        });

        //搜索
        $(".search_btn").on("click",function(){
            tableIns.reload({
                where: { cId: $("#searchType").val() }
            });
        });

        //列表操作
        table.on("tool(studentList)", function(obj){
            var data = obj.data;

            $.ajax({
                type: "POST",
                data: {
                    studentId: data.studentId,
                    courseId: data.courseId,
                    score: data.score,
                    result: data.result
                },
                url: "${pageContext.request.contextPath}/studentCourse/updateScore.action",
                success:function(res) {
                    if (res.code == 1) {
                        tableIns.reload();
                        layer.msg(res.message, {icon: 1,time:1000});
                    }else {
                        layer.msg(res.message, {icon: 5,time:1000});
                    }
                }
            });
        });

        //批量评分
        $("#update_list_btn").click(function(){
            var checkStatus = table.checkStatus('studentListTable'),
                data = checkStatus.data,
                scoreList = new Array();
            if(data.length > 0) {
                for (var i in data) {
                    var score = new Object();
                    score.id = data[i].id;
                    score.score = data[i].score;
                    score.result = data[i].result;
                    scoreList[i] = score;
                }
                console.log(scoreList);
                layer.confirm("确定提交？", {icon: 3, title: "提示信息"}, function (index) {
                    $.ajax({
                        type: "post",
                        data: {
                            scoreListStr : JSON.stringify(scoreList)
                        },
                        url: "${pageContext.request.contextPath}/studentCourse/updateList.html",
                        timeout:2000,
                        success:function(res) {
                            if (res == true) {
                                tableIns.reload({
                                    page: { curr: 1 },
                                    where: { cId: $("#searchType").val() }
                                });
                            } else {
                                layer.msg(res, {icon: 5,time:1000});
                            }
                            layer.close(index);
                        },
                        error:function() {
                            layer.msg("操作失败！", {icon: 5,time:1000});
                            layer.close(index);
                        }
                    });
                });
            }else{
                layer.msg("请选择要选择提交的行");
            }
        });


    });

</script>

</body>
</html>
