<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>登录成功 - 网上书城</title>
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
                    // 跳转到首页
                    window.location.href = '<%=request.getContextPath()%>/client/js/index.jsp';
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
    String username = (String) session.getAttribute("loginUser");
%>
<!-- 头部 -->
<%@ include file="/client/include/head.jsp" %>
<!-- 导航 -->
<%@ include file="/client/include/menu_search.jsp" %>

<!-- 登录成功提示区域 -->
<div class="page-wrap">
<div class="content-area" style="text-align: center; padding: 50px 0;">
    <div class="register-box" style="max-width: 500px; margin: 0 auto;">
        <h2>登录成功</h2>
        <div style="padding: 30px 0;">
            <img src="<%=request.getContextPath()%>/client/images/IconTexto_WebDev_009.jpg" alt="成功" style="width: 100px; height: 100px;">
            <p style="font-size: 18px; margin-top: 20px; color: #333;">登录成功！</p>
            <p style="font-size: 14px; margin-top: 10px; color: #666;">欢迎回来，<%=username != null ? username : "用户" %>！</p>
            <p style="font-size: 14px; margin-top: 10px; color: #666;">3秒后自动跳转回首页 <span id="countdown" style="color: #007bff; font-weight: bold;">3</span></p>
        </div>
        <div style="margin-top: 20px;">
            <a href="<%=request.getContextPath()%>/client/js/index.jsp" style="display: inline-block; padding: 10px 30px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px;">返回首页</a>
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