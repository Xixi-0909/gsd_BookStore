<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户登录 - 网上书城</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/client/css/style.css">
    <script>
        // 页面加载时检查 cookie 并填充表单
        window.onload = function() {
            // 读取 cookie
            var username = getCookie('bookstore_username');
            var password = getCookie('bookstore_password');
            
            // 如果 cookie 存在，填充表单
            if (username) {
                document.getElementById('username').value = username;
            }
            if (password) {
                document.getElementById('password').value = password;
                document.getElementById('remember').checked = true;
            }
        };
        
        // 表单校验函数
        function checkForm() {
            // 获取表单元素
            var username = document.getElementById('username');
            var password = document.getElementById('password');
            
            // 校验用户名
            if (username.value.trim() === '') {
                alert('请输入用户名');
                username.focus();
                return false;
            }
            
            // 校验密码
            if (password.value.trim() === '') {
                alert('请输入密码');
                password.focus();
                return false;
            }
            
            // 校验通过
            return true;
        }
        
        // 获取 cookie 值的函数
        function getCookie(name) {
            var cookieValue = '';
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = cookies[i].trim();
                if (cookie.indexOf(name + '=') === 0) {
                    cookieValue = cookie.substring(name.length + 1);
                    break;
                }
            }
            return cookieValue;
        }
    </script>
</head>
<body>
<%
    String ctx = request.getContextPath();// 获取项目名
%>
<!-- 头部 -->
<%@ include file="/client/include/head.jsp" %>
<!-- 导航 -->
<%@ include file="/client/include/menu_search.jsp" %>

<!-- 登录表单区域 -->
<div class="page-wrap">
<div class="content-area">
    <div class="register-box" style="max-width: 400px; margin: 0 auto;">
        <h2>用户登录</h2>
        <%-- 错误信息显示 --%>
        <% if (request.getParameter("msg") != null) { %>
        <div style="color: red; text-align: center; margin-bottom: 15px;"><%= request.getParameter("msg") %></div>
        <% } %>
        <form action="Handle-login.jsp" method="post" onsubmit="return checkForm()">
            <div class="form-item">
                <label>用户名：</label>
                <input type="text" id="username" name="username" placeholder="请输入用户名" required/>
            </div>
            <div class="form-item">
                <label>密码：</label>
                <input type="password" id="password" name="password" placeholder="请输入密码" required/>
            </div>
            <div class="form-item">
                <label></label>
                <div class="checkbox-item">
                    <input type="checkbox" name="remember" id="remember"/>
                    <label for="remember" style="width: auto; padding: 0;">记住用户名</label>
                </div>
            </div>
            <div style="text-align: center; margin-top: 20px;">
                <input type="submit" value="登录" style="width: 120px; height: 40px; border: none; outline: none; cursor: pointer; background-color: #4CAF50; color: white; font-size: 16px; border-radius: 4px;"/>
            </div>
            <div style="text-align: center; margin-top: 15px;">
                <a href="register.jsp" style="color: #007bff; text-decoration: none;">新用户注册</a>
            </div>
        </form>
    </div>
</div>

<!-- 底部 -->
</div>
<div class="site-footer">
    <div class="container footer-row">
        <div class="footer-text">网上书城 - 书趣的书城</div>
        <div class="footer-bottom">书里的城，城里的书</div>
    </div>
</div>
</body>
</html>
