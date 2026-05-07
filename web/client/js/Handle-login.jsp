<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="utils.druidDataSourceUtil" %>
<%
    // 设置编码
    request.setCharacterEncoding("UTF-8");
    
    // 获取传递的参数
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String remember = request.getParameter("remember");
    
    // 打印获取的参数（测试用）
    System.out.println("用户名：" + username);
    System.out.println("密码：" + password);
    System.out.println("记住用户名：" + remember);
    
    // 数据库操作
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean loginSuccess = false;
    
    try {
        // 从数据库连接池获取连接
        conn = druidDataSourceUtil.getConnection();
        
        // 编写 SQL 查询语句
        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        
        // 设置参数
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        
        // 执行 SQL
        rs = pstmt.executeQuery();
        
        // 处理结果
        if (rs.next()) {
            loginSuccess = true;
            System.out.println("登录成功：" + username);
            // 保存用户信息到 session
            session.setAttribute("loginUser", username);
            session.setAttribute("userId", rs.getInt("id"));
            session.setAttribute("userRole", rs.getInt("role"));
        } else {
            System.out.println("登录失败：用户名或密码错误");
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("数据库操作失败：" + e.getMessage());
    } finally {
        // 关闭资源，归还连接到数据库连接池
        druidDataSourceUtil.close(conn, pstmt, rs);
    }
    
    // 跳转到相应页面
    if (loginSuccess) {
        // 处理记住我功能
        if ("on".equals(remember)) {
            // 设置 cookie，有效期为7天
            Cookie usernameCookie = new Cookie("bookstore_username", username);
            usernameCookie.setMaxAge(7 * 24 * 60 * 60); // 7天
            usernameCookie.setPath(request.getContextPath());
            response.addCookie(usernameCookie);
            
            Cookie passwordCookie = new Cookie("bookstore_password", password);
            passwordCookie.setMaxAge(7 * 24 * 60 * 60); // 7天
            passwordCookie.setPath(request.getContextPath());
            response.addCookie(passwordCookie);
        } else {
            // 清除 cookie
            Cookie usernameCookie = new Cookie("bookstore_username", "");
            usernameCookie.setMaxAge(0);
            usernameCookie.setPath(request.getContextPath());
            response.addCookie(usernameCookie);
            
            Cookie passwordCookie = new Cookie("bookstore_password", "");
            passwordCookie.setMaxAge(0);
            passwordCookie.setPath(request.getContextPath());
            response.addCookie(passwordCookie);
        }
        
        // 跳转到登录成功页面
        response.sendRedirect(request.getContextPath() + "/client/js/loginsuccess.jsp");
    } else {
        // 登录失败，跳转到登录页面并显示错误信息
        String errorMsg = java.net.URLEncoder.encode("账号或密码错误", "UTF-8");
        response.sendRedirect("login.jsp?msg=" + errorMsg);
    }
%>