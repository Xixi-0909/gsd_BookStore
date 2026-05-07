<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<html>
<head>
    <title>添加购物车</title>
</head>
<body>
    <%
        // 1、设置request的setCharacterEncoding属性，支持中文UTF-8
        request.setCharacterEncoding("UTF-8");

        // 2、获取购物车集合（从session作用域）
        List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");

        // 3.初始化购物车（首次访问时创建）
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // 4.获取商品ID
        String productId = request.getParameter("productId");
        String productName = request.getParameter("PName");
        String price = request.getParameter("Price");
        String stock = request.getParameter("PNum");

        // 5.检查购物车中是否已有该商品，如果有则合并数量
        boolean found = false;
        if (productId != null && !productId.trim().isEmpty()) {
            for (Map<String, String> item : cart) {
                if (productId.equals(item.get("id"))) {
                    // 该商品已存在，数量+1
                    int currentQty = Integer.parseInt(item.get("quantity"));
                    int maxStock = Integer.parseInt(stock);
                    if (currentQty < maxStock) {
                        item.put("quantity", String.valueOf(currentQty + 1));
                    }
                    found = true;
                    break;
                }
            }
        }

        // 6.如果没有找到相同商品，则添加新条目
        if (!found) {
            Map<String, String> item = new HashMap<>();
            item.put("id", productId != null ? productId : "");
            item.put("name", productName);    //商品名称
            item.put("price", price);         //商品价格
            item.put("stock", stock);         //商品库存
            item.put("quantity", "1");        //商品数量，默认为1
            cart.add(item);
        }

        // 7.重定向回购物车页面
        response.sendRedirect(request.getContextPath() + "/client/js/Cart.jsp");
    %>
</body>
</html>
