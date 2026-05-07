<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>数据库调试 - 网上书城</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/client/css/style.css">
    <style>
        .debug-info {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            margin: 10px 0;
            font-family: monospace;
            white-space: pre-wrap;
        }
        .error {
            color: #dc3545;
        }
        .success {
            color: #28a745;
        }
    </style>
</head>
<body>
<%
    String ctx = request.getContextPath();
    StringBuilder debugInfo = new StringBuilder();
    
    // 数据库操作
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        debugInfo.append("=== 开始数据库调试 ===\n");
        
        // 1. 加载驱动
        debugInfo.append("1. 加载驱动...\n");
        Class.forName("com.mysql.cj.jdbc.Driver");
        debugInfo.append("   ✓ 驱动加载成功\n");
        
        // 2. 获取连接
        debugInfo.append("2. 连接数据库...\n");
        String url = "jdbc:mysql://localhost:3306/bookstore?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=Asia/Shanghai";
        conn = DriverManager.getConnection(url, "root", "root");
        debugInfo.append("   ✓ 数据库连接成功\n");
        
        // 3. 检查数据库是否存在
        debugInfo.append("3. 检查数据库...\n");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT DATABASE()");
        if (rs.next()) {
            debugInfo.append("   当前数据库: " + rs.getString(1) + "\n");
        }
        
        // 4. 检查 user 表是否存在
        debugInfo.append("4. 检查 user 表...\n");
        rs = stmt.executeQuery("SHOW TABLES LIKE 'user'");
        if (rs.next()) {
            debugInfo.append("   ✓ user 表存在\n");
            
            // 5. 检查表结构
            debugInfo.append("5. 检查表结构...\n");
            rs = stmt.executeQuery("DESCRIBE user");
            debugInfo.append("   表结构:\n");
            while (rs.next()) {
                debugInfo.append("     " + rs.getString("Field") + " (" + rs.getString("Type") + ") " + rs.getString("Null") + " " + rs.getString("Key") + "\n");
            }
            
            // 6. 检查现有数据
            debugInfo.append("6. 检查现有数据...\n");
            rs = stmt.executeQuery("SELECT COUNT(*) FROM user");
            if (rs.next()) {
                debugInfo.append("   用户总数: " + rs.getInt(1) + "\n");
            }
            
            // 7. 测试插入操作
            debugInfo.append("7. 测试插入操作...\n");
            String testUsername = "test" + System.currentTimeMillis();
            String insertSql = "INSERT INTO user (username, password, gender, phone, email, intro) VALUES ('" + testUsername + "', 'test123', '男', '13800138000', 'test@example.com', '测试用户')";
            int rows = stmt.executeUpdate(insertSql);
            debugInfo.append("   ✓ 插入成功，影响行数: " + rows + "\n");
            
            // 8. 验证插入结果
            debugInfo.append("8. 验证插入结果...\n");
            rs = stmt.executeQuery("SELECT * FROM user WHERE username = '" + testUsername + "'");
            if (rs.next()) {
                debugInfo.append("   ✓ 插入的用户信息: " + rs.getString("username") + " (ID: " + rs.getInt("id") + ")\n");
            } else {
                debugInfo.append("   ✗ 未找到插入的用户\n");
            }
            
        } else {
            debugInfo.append("   ✗ user 表不存在\n");
            
            // 尝试创建表
            debugInfo.append("   尝试创建 user 表...\n");
            String createTableSql = "CREATE TABLE user (" +
                "id INT PRIMARY KEY AUTO_INCREMENT, " +
                "username VARCHAR(50) NOT NULL, " +
                "password VARCHAR(50) NOT NULL, " +
                "gender VARCHAR(10) NOT NULL, " +
                "phone VARCHAR(20) NOT NULL, " +
                "email VARCHAR(100) NOT NULL, " +
                "intro TEXT" +
                ")";
            stmt.executeUpdate(createTableSql);
            debugInfo.append("   ✓ user 表创建成功\n");
        }
        
        debugInfo.append("=== 调试完成 ===\n");
        
    } catch (ClassNotFoundException e) {
        debugInfo.append("✗ 驱动加载失败: " + e.getMessage() + "\n");
        e.printStackTrace();
    } catch (SQLException e) {
        debugInfo.append("✗ 数据库操作失败: " + e.getMessage() + "\n");
        e.printStackTrace();
    } catch (Exception e) {
        debugInfo.append("✗ 其他错误: " + e.getMessage() + "\n");
        e.printStackTrace();
    } finally {
        // 关闭资源
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

<!-- 调试结果区域 -->
<div class="content-area" style="padding: 50px 0;">
    <div class="register-box" style="max-width: 800px; margin: 0 auto;">
        <h2>数据库调试</h2>
        <div class="debug-info">
            <%=debugInfo.toString()%>
        </div>
        <div style="margin-top: 20px; text-align: center;">
            <a href="<%=request.getContextPath()%>/client/js/index.jsp" style="display: inline-block; padding: 10px 30px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px;">返回首页</a>
            <a href="<%=request.getContextPath()%>/client/js/register.jsp" style="display: inline-block; padding: 10px 30px; background-color: #2196F3; color: white; text-decoration: none; border-radius: 4px; margin-left: 20px;">去注册</a>
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