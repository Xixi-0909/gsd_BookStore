<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>新用户注册 - 网上书城</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/client/css/style.css">

    <!-- 引入表单验证脚本 -->
    <script src="<%=request.getContextPath()%>/client/js/form.js"></script>

</head>
<body>
<%
    String ctx = request.getContextPath();// 获取项目名
%>
<!-- 头部 -->
<%@ include file="/client/include/head.jsp" %>
<!-- 导航 -->
<%@ include file="/client/include/menu_search.jsp" %>


<!-- 注册表单区域 -->
<div class="page-wrap">
<div class="content-area">
    <div class="register-box">
        <h2>新用户注册</h2>
        <form action="Handle-register.jsp" method="post" onsubmit="return checkForm()">
            <div class="form-item">
                <label>用户名：</label>
                <input type="text" id="username" name="username" placeholder="字母数字下划线 1 到 10 位" required/>
                <span class="tip" id="userTip">字母开头，长度 1-10</span>
            </div>
            <div class="form-item">
                <label>密码：</label>
                <input type="password" id="pwd" name="password" placeholder="密码请设置 6-16 位字符" required/>
                <span class="tip" id="pwdTip">6-16 位字母/数字/符号</span>
            </div>
            <div class="form-item">
                <label>重复密码：</label>
                <input type="password" id="repwd" name="repassword" placeholder="请再次输入密码" required/>
                <span class="tip" id="repwdTip">两次密码需一致</span>
            </div>
            <div class="form-item">
                <label>性别：</label>
                <div class="radio-group">
                    <input type="radio" name="gender" value="男" checked id="male"/>
                    <label for="male" style="width: auto; padding: 0;">男</label>
                    <input type="radio" name="gender" value="女" id="female"/>
                    <label for="female" style="width: auto; padding: 0;">女</label>
                </div>
            </div>
            <div class="form-item">
                <label>联系电话：</label>
                <input type="tel" id="phone" name="phone" placeholder="请输入 11 位有效手机号" required/>
                <span class="tip" id="phoneTip">11 位数字，不含空格</span>
            </div>
            <div class="form-item">
                <label>邮箱：</label>
                <input type="email" id="email" name="email" placeholder="请输入有效的邮箱地址" required/>
                <span class="tip" id="emailTip">例：xxx@163.com</span>
            </div>
            <div class="form-item">
                <label>验证码：</label>
                <input type="text" id="code" name="code" placeholder="请输入 4 位数字验证码" required/>
                <span class="code-box" id="codeBox" onclick="createCode()" title="点击刷新验证码">1117</span>
                <span class="tip" id="codeTip">示例：1117</span>
            </div>
            <div class="form-item">
                <label>个人介绍：</label>
                <textarea id="intro" name="intro" placeholder="请简要介绍自己"></textarea>
                <span class="tip" id="introTip" style="display:block; margin-top:5px;">不超过 200 字</span>
            </div>
            <div class="form-item">
                <label></label>
                <div class="checkbox-item">
                    <input type="checkbox" name="remember" id="remember"/>
                    <label for="remember" style="width: auto; padding: 0;">记住用户名和密码</label>
                </div>
            </div>
            <div style="text-align: center; margin-top: 20px;">
                <input type="submit" value="" title="同意并提交" style="width: 160px; height: 45px; border: none; outline: none; cursor: pointer; background: url('<%=request.getContextPath()%>/client/images/signup.gif') no-repeat center center; background-size: 100% 100%;"/>
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