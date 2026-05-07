<!-- first.jsp作为登录页   跳转到    home.jsp主框架-->
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<jsp:forward page="home.jsp">
    <jsp:param name="msg" value="这是使用 jsp:forward 从 first 页面跳转过来的~"/>
</jsp:forward>


