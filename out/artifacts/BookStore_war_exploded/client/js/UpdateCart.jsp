<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<html>
<head>
    <title>更新购物车</title>
</head>
<body>
    <%
        // 1.设置request的setCharacterEncoding属性，支持中文UTF-8
        request.setCharacterEncoding("UTF-8");

        // 2.从session获取购物车集合
        List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");

        // 3.更新购物车中的数量，并检查库存限制
        if (cart != null && !cart.isEmpty()) {
            for (int i = 0; i < cart.size(); i++) {
                String quantityStr = request.getParameter("quantity_" + i);
                if (quantityStr != null) {
                    int quantity = Integer.parseInt(quantityStr);
                    Map<String, String> item = cart.get(i);
                    int maxStock = Integer.parseInt(item.get("stock"));
                    // 数量不能超过库存
                    if (quantity < 1) {
                        quantity = 1;
                    } else if (quantity > maxStock) {
                        quantity = maxStock;
                    }
                    item.put("quantity", String.valueOf(quantity));
                }
            }
        }

        // 4.重定向回购物车页面
        response.sendRedirect(request.getContextPath() + "/client/js/Cart.jsp");
    %>
</body>
</html>
