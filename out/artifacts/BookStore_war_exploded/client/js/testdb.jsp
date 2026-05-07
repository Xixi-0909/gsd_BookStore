<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>数据库测试 - 网上书城</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/client/css/style.css">
</head>
<body>
<%
    String ctx = request.getContextPath();
    String message = "";
    StringBuilder userList = new StringBuilder();
    
    // 数据库操作
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        // 1. 加载驱动
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // 2. 获取连接
        String url = "jdbc:mysql://localhost:3306/bookstore?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=Asia/Shanghai";
        conn = DriverManager.getConnection(url, "root", "root");
        
        // 3. 执行查询
        stmt = conn.createStatement();
        String sql = "SELECT * FROM user";
        rs = stmt.executeQuery(sql);
        
        // 4. 处理结果
        userList.append("<table border='1' style='margin: 20px auto; border-collapse: collapse;'>");
        userList.append("<tr><th>ID</th><th>用户名</th><th>密码</th><th>性别</th><th>电话</th><th>邮箱</th><th>个人介绍</th></tr>");
        
        while (rs.next()) {
            userList.append("<tr>");
            userList.append("<td>" + rs.getInt("id") + "</td>");
            userList.append("<td>" + rs.getString("username") + "</td>");
            userList.append("<td>" + rs.getString("password") + "</td>");
            userList.append("<td>" + rs.getString("gender") + "</td>");
            userList.append("<td>" + rs.getString("phone") + "</td>");
            userList.append("<td>" + rs.getString("email") + "</td>");
            userList.append("<td>" + rs.getString("intro") + "</td>");
            userList.append("</tr>");
        }
        
        userList.append("</table>");
        message = "数据库连接成功，用户表数据如下：";
        
    } catch (ClassNotFoundException e) {
        message = "驱动加载失败：" + e.getMessage();
        e.printStackTrace();
    } catch (SQLException e) {
        message = "数据库操作失败：" + e.getMessage();
        e.printStackTrace();
    } catch (Exception e) {
        message = "其他错误：" + e.getMessage();
        e.printStackTrace();
    } finally {
        // 5. 关闭资源
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<!-- 头部 -->
<%@ include file="/client/include/head.jsp" %>
<!-- 导航 -->
<%@ include file="/client/include/menu_search.jsp" %>

<!-- 测试结果区域 -->
<div class="content-area" style="text-align: center; padding: 50px 0;">
    <div class="register-box" style="max-width: 800px; margin: 0 auto;">
        <h2>数据库测试</h2>
        <div style="padding: 20px 0;">
            <p style="font-size: 16px; margin-bottom: 20px;"><%=message%></p>
            <%=userList.toString()%>
        </div>
        <div style="margin-top: 20px;">
            <a href="<%=request.getContextPath()%>/client/js/index.jsp" style="display: inline-block; padding: 10px 30px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px;">返回首页</a>
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