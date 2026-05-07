<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<html>
<head>
    <title>删除购物车商品</title>
</head>
<body>
    <%
        // 1.从请求request中获取要删除的商品索引
        String indexStr = request.getParameter("index");
        if (indexStr != null) {
            int index = Integer.parseInt(indexStr);

            // 2.从session获取购物车集合
            List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");

            // 3.根据索引直接删除元素
            if (cart != null && index >= 0 && index < cart.size()) {
                cart.remove(index);
            }
        }

        // 4.重定向回购物车页面
        response.sendRedirect(request.getContextPath() + "/client/js/Cart.jsp");
    %>
</body>
</html>
