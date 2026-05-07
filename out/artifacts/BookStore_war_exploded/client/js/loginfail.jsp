<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>登录失败 - 网上书城</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/client/css/style.css">
    <script>
        // 倒计时函数
        function countdown() {
            var seconds = 3;
            var countdownElement = document.getElementById('countdown');

            var timer = setInterval(function() {
                seconds--;
                countdownElement.textContent = seconds;

                if (seconds <= 0) {
                    clearInterval(timer);
                    // 跳转到登录页面
                    window.location.href = '<%=request.getContextPath()%>/client/js/login.jsp';
                }
            }, 1000);
        }

        // 页面加载完成后开始倒计时
        window.onload = countdown;
    </script>
</head>
<body>
<%
    String ctx = request.getContextPath();
    String errorMessage = (String) session.getAttribute("errorMessage");
%>
<!-- 头部 -->
<%@ include file="/client/include/head.jsp" %>
<!-- 导航 -->
<%@ include file="/client/include/menu_search.jsp" %>

<!-- 登录失败提示区域 -->
<div class="page-wrap">
<div class="content-area" style="text-align: center; padding: 50px 0;">
    <div class="register-box" style="max-width: 500px; margin: 0 auto;">
        <h2>登录失败</h2>
        <div style="padding: 30px 0;">
            <img src="<%=request.getContextPath()%>/client/images/error.jpg" alt="失败" style="width: 100px; height: 100px;">
            <p style="font-size: 18px; margin-top: 20px; color: #dc3545;">登录失败！</p>
            <p style="font-size: 14px; margin-top: 10px; color: #666;"><%=errorMessage != null ? errorMessage : "账号或密码错误" %></p>
            <p style="font-size: 14px; margin-top: 10px; color: #666;">3秒后自动返回登录页面 <span id="countdown" style="color: #007bff; font-weight: bold;">3</span></p>
        </div>
        <div style="margin-top: 20px;">
            <a href="<%=request.getContextPath()%>/client/js/login.jsp" style="display: inline-block; padding: 10px 30px; background-color: #dc3545; color: white; text-decoration: none; border-radius: 4px;">返回登录</a>
        </div>
    </div>
</div>
</div>

<!-- 底部 -->
<div class="site-footer">
    <div class="container footer-row">
        <div class="footer-text">网上书城 - 书趣的书城</div>
        <div class="footer-bottom">书里的城，城里的书</div>
    </div>
</div>
</body>
</html>
