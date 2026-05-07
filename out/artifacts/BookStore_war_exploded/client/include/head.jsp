<%--
  Created by IntelliJ IDEA.
  User: ZHANG
  Date: 2026/3/26
  Time: 10:12
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<!-- 头部容器 -->
<div class="site-header" style="width: 100%; padding: 20px 0; border-bottom: 1px solid #eee;">
    <% 
        String sessionUsername = (String) session.getAttribute("loginUser");
    %>
    <div class="container" style="width: 1200px; margin: 0 auto;">
        <!-- 第一行：品牌和导航链接 -->
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <!-- 左侧：网上书城（a标签+图片） -->
            <div class="brand">
                <a href="${pageContext.request.contextPath}/client/js/index.jsp" class="brand-link" style="text-decoration: none; display: flex; align-items: center;">
                    <img src="${pageContext.request.contextPath}/client/images/logo_2.jpg" alt="网上书城" class="brand-img"
                         style="height: 50px; vertical-align: middle;"
                         onerror="this.style.display='none'"/>
                    <span class="brand-text" style="font-size: 36px; font-weight: bold; color: #333; margin-left: 10px;">网上书城</span>
                </a>
            </div>

            <!-- 右侧：功能链接（含购物车图标） -->
            <div class="header-links" style="display: flex; align-items: center; gap: 15px; font-size: 16px;">
                <!-- 购物车：图标+文字 -->
                <a href="${pageContext.request.contextPath}/client/js/Cart.jsp" style="text-decoration: none; color: #0066cc; display: flex; align-items: center;">
                    <img src="${pageContext.request.contextPath}/client/images/cart.gif" alt="购物车"
                         style="width: 30px; height: 30px; vertical-align: middle; margin-right: 5px;"/>
                    购物车
                </a>
                <span style="color: #999;">|</span>
                <a href="${pageContext.request.contextPath}/client/help.jsp" style="text-decoration: none; color: #0066cc;">帮助中心</a>
                <span style="color: #999;">|</span>
                <a href="${pageContext.request.contextPath}/client/user/account.jsp" style="text-decoration: none; color: #0066cc;">我的帐户</a>
                <span style="color: #999;">|</span>
                <% 
                    if (sessionUsername != null && !sessionUsername.isEmpty()) {
                %>
                    <a href="${pageContext.request.contextPath}/client/js/logout.jsp" style="text-decoration: none; color: #0066cc;">用户退出</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/client/js/register.jsp" style="text-decoration: none; color: #0066cc;">新用户注册</a>
                    <span style="color: #999;">|</span>
                    <a href="${pageContext.request.contextPath}/client/js/login.jsp" style="text-decoration: none; color: #0066cc;">用户登录</a>
                <% } %>
            </div>
        </div>
        
        <!-- 第二行：欢迎语 + 在线用户数 -->
        <div style="margin-top: 10px; display: flex; justify-content: space-between; align-items: center;">
            <%
                if (sessionUsername != null && !sessionUsername.isEmpty()) {
            %>
            <span style="color: #333; font-size: 14px;">欢迎您：<%=sessionUsername%></span>
            <%
                } else {
            %>
            <span></span>
            <%
                }
                java.util.concurrent.ConcurrentMap<String, String> onlineUsers =
                    (java.util.concurrent.ConcurrentMap<String, String>) application.getAttribute("onlineUsers");
                int onlineCount = (onlineUsers != null) ? onlineUsers.size() : 0;
            %>
            <span style="color: #666; font-size: 14px;">&#x5728;&#x7EBF;&#x4EBA;&#x6570;&#xFF1A;<strong style="color: #e74c3c;"><%=onlineCount%></strong></span>
        </div>
    </div>
</div>