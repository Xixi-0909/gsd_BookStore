<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="domain.Product" %>
<%
    String id = request.getParameter("id");
    
    if (id != null && !id.trim().isEmpty()) {
        Product product = new Product();
        product.delete(id);
    }
    
    // 重定向到商品列表页面
    response.sendRedirect(request.getContextPath() + "/admin/login/home.jsp?item=product_list");
%>
