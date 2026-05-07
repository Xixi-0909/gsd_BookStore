<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    // 思路1：设置编码
    request.setCharacterEncoding("UTF-8");

    // 获取传递的参数
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String repassword = request.getParameter("repassword");
    String gender = request.getParameter("gender");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String code = request.getParameter("code");
    String intro = request.getParameter("intro");
    String remember = request.getParameter("remember");

    // 打印获取的参数（测试用）
    System.out.println("用户名：" + username);
    System.out.println("密码：" + password);
    System.out.println("重复密码：" + repassword);
    System.out.println("性别：" + gender);
    System.out.println("联系电话：" + phone);
    System.out.println("邮箱：" + email);
    System.out.println("验证码：" + code);
    System.out.println("个人介绍：" + intro);
    System.out.println("记住密码：" + remember);

    // 思路2：数据库操作
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        // 1. 加载驱动
        System.out.println("开始加载驱动...");
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("驱动加载成功！");

        // 2. 获取连接（数据库名：bookstore，用户名：root，密码：root）
        System.out.println("开始连接数据库...");
        String url = "jdbc:mysql://localhost:3306/bookstore?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=Asia/Shanghai";
        conn = DriverManager.getConnection(url, "root", "root");
        System.out.println("数据库连接成功！");

        // 3. 编写 SQL 插入语句（根据实际 user 表字段）
        System.out.println("准备执行 SQL 语句...");
        String sql = "INSERT INTO user (username, PASSWORD, gender, telephone, email, introduce) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        // 4. 设置参数
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        pstmt.setString(3, gender);
        pstmt.setString(4, phone);
        pstmt.setString(5, email);
        pstmt.setString(6, intro);

        // 5. 执行 SQL
        int rows = pstmt.executeUpdate();
        System.out.println("插入成功，影响行数：" + rows);

    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        System.out.println("驱动加载失败：" + e.getMessage());
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("数据库操作失败：" + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("其他错误：" + e.getMessage());
    } finally {
        // 6. 关闭资源（顺序：ResultSet → Statement → Connection）
        try {
            if (pstmt != null) {
                pstmt.close();
                System.out.println("PreparedStatement 关闭成功");
            }
            if (conn != null) {
                conn.close();
                System.out.println("数据库连接关闭成功");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

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
    }

    // 思路3：跳转到注册成功页面
    response.sendRedirect(request.getContextPath() + "/client/js/registersuccess.jsp");
%>