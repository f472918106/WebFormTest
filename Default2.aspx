<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript" src="Scripts/jquery-1.10.2.min.js"></script>
    <!-- 调用Ajax -->
    <script type="text/javascript">
        /*$(function () {
            
        });
        function OnTest() {
            var s = $("#username").val();
            //Ajax取控件值
            $.ajax({
                url: "TestHandler.ashx",
                type: "post",
                data: { "user": s },
                success: function (result) {
                    alert(result);
                }
            });
            //调用Ajax
            //作业：通过事件触发自动判断用户名是否重复，并且把Ajax回调函数的弹出框改成显示在用户名的内容
        }*/
        $(function () {

        });
        function WhetherFocus() {
            var s = $("#username").val();
            //当焦点移动到passwd框开始对username查询是否重复
            $.ajax({
                url: "TestHandler.ashx",
                type: "post",
                data: { "user": s },
                success: function (result) {
                    if(result.trim()=="OK")
                    {
                        $("#message").html("用户名可以注册");
                        $("#message").css("color", "green");
                        //或者$("#message").text(result);
                        //.text()中只可以加文本
                        //.html可以添加html元素
                    }
                    else
                    {
                        $("#message").html("该用户名已存在");
                        $("#message").css("color", "red");
                    }
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" method="post" action="Handler.ashx"> 
    <!-- method属性设置表单提交方式 action属性指定处理程序 -->      
    <div>
        账号:<input type="text" id="username" name="username" value="" />
        <!-- 文本框 Ajax获取控件Value时通常通过控件id属性获取 -->
        <span id ="message"></span>
        <br />
        密码:<input type="password" id="passwd" name="passwd" value="" onfocus="WhetherFocus();"/>   
        <!-- 或者为账号框添加onblur(失去焦点)属性 -->
        <!-- 密码框 隐式显示 -->
        <p>
            <input type="radio" name="answer" value="Yes" checked="checked"/>是    
            <!-- 单选框 默认选中 -->
            <input type="radio" name="answer" value="No" />否    
            <!-- 同组单选框用相同的name来使同一时间只能选中一个 -->
        </p>      
        <p>
            <input type="checkbox" name="lesson" value="asp.net" />asp.NET  
            <!-- 多选框 多选框如果一个不选，则处理程序获取到的返回值为null-->
            <input type="checkbox" name="lesson" value="os" />操作系统  
            <!-- 如果选中多个，处理程序在页面输出多个多选框的值，中间用逗号隔开 -->
        </p>
        <p>
            <select name="hobby" multiple="multiple">   
                <!-- 下拉列表select，没有value属性 multiple多重的 当为多选下拉列表时，按住ctrl可以全部取消选中，处理程序接收到返回值为null -->
                <option value="sports">体育</option>     
                <!-- select子控件option没有name属性，有value属性 -->
                <option value="sing">音乐</option>
                <option value="draw" selected="selected">画画</option>    
                <!-- 下拉菜单项 默认选中 -->
            </select>
        </p>
        <p>
            <input type="submit" name="submit" value="登录" />
            <!--input type="button" name="AjaxSubmit" value="Ajax提交" onclick="OnTest();" />
            <!-- onclick属性设置触发click的处理程序 -->
        </p>
        <p>
            <textarea name="information" cols="30" rows="5" wrap="hard"> 
            </textarea>
            <!-- 多行文本输出处理 设置textarea wrap属性 -->
            <!-- soft 当在表单中提交时，textarea 中的文本不换行 默认值 -->
            <!-- hard 当在表单中提交时，textarea 中的文本换行（包含换行符）当使用 "hard" 时，必须规定 cols 属性 -->
            <!-- 处理程序中用<br>替换\n，再用空字符串替换<br> -->
        </p>
    </div>
    </form>
    <form id="form2" method="post" action="Handler2.ashx" enctype="multipart/form-data">
        <div>
            <p>
                <input type="file" name="files" multiple="multiple"/>
                <!-- 多文件上传处理 设置multiple属性 可以选中多个文件 -->
                <!-- 用HttpFileCollection的实例来获取HttpContext.Current.Request.Files集合 -->
                <!-- 并对集合元素编号0~n -->
                <!-- 循环遍历上传的文件集合依次处理 -->
                <input type="submit" name="upload" value="上传" />
            </p>
        </div>
    </form>
</body>
</html>
