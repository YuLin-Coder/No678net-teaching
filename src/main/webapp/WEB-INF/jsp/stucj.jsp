
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body class="childrenBody">
<!--startprint-->
<form class="layui-form">
    <blockquote class="layui-elem-quote quoteBox">
        <form class="layui-form">
            <div class="layui-inline">
                <a id="all" class="search_btn layui-btn layui-btn-primary">全部</a>
            </div>
        </form>
    </blockquote>
    <div id="toolbar" style="display: none"><h3>全部学生的课程成绩</h3></div>
    <table id="courseList" lay-filter="courseList" ></table>

</form>
<!--endprint-->
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.use(['form','layer','table','laytpl','upload'],function(){
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery,
            table = layui.table;

        //courseList列表
        var tableIns = null;
        loadCourse();
        function loadCourse() {
            tableIns = table.render({
                elem: "#courseList",
                toolbar: "#toolbar",
                url : "${pageContext.request.contextPath}/studentCourse/allStudentScoreList.action",
                request: {
                    /*pageName: 'curr' //页码的参数名称
                    ,limitName: 'nums' //每页数据量的参数名*/
                },
                where: {
                    searchKey: $(".searchVal").val()  //搜索的关键字
                },
                cellMinWidth : 95,
                page : true,
                height : "full-125",
                limits : [10,20,50,100],
                limit : 10,
                loading : true,
                id : "courseListTable",
                cols : [[
                    {field: 'username', title: '学生姓名',minWidth:120, align:'left'},
                    {field: 'name', title: '课程名',minWidth:160, align:'left'},
                    {field: 'testModel', title: '考核方式', minWidth:100, align:'center'},
                    {field: 'score', title: '成绩', minWidth:100, align:'center'},
                    {field: 'result', title: '老师评价', minWidth:100, align:'center'}
                ]]
            });
        }

        //搜索
        $(".search_btn").on("click",function(){
            var id = $(this).attr("id");
            var result;
            if (id == "all") {
                result = 2;
            } else if (id == "pass") {
                result = 1;
            } else {
                result = 0;
            }
            tableIns.reload({
                page: {curr: 1},
                where: { result: result }
            });
        });
    });
    function doPrint() {
        bdhtml = window.document.body.innerHTML;
        sprnstr = "<!--startprint-->";
        eprnstr = "<!--endprint-->";
        prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr)+17);
        prnhtml = prnhtml.substring(0,prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        window.print();
    }
</script>
</body>
</html>
