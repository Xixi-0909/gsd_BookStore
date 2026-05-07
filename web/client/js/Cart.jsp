<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<html>
<head>
    <title>购物车</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/client/css/style.css">
</head>
<body>
    <%@ include file="/client/include/head.jsp" %>
    <%@ include file="/client/include/menu_search.jsp" %>

    <div class="page-wrap">
    <div style="width: 90%; margin: 0 auto; padding: 20px; background-color: white; border: 1px solid #ddd; border-radius: 5px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
            <h2>购物车</h2>
            <div>
                <a href="<%=request.getContextPath()%>/client/js/index.jsp" style="color: #0066cc; text-decoration: none;">首页</a> &gt; 购物车
            </div>
        </div>
        <hr>

        <%
            // 从session获取购物车集合
            List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");

            // 判断购物车cart是否为空
            if (cart == null || cart.isEmpty()) {
        %>
            <div style="text-align: center; padding: 50px; background-color: #fff9e6; border-radius: 5px;">
                <p>购物车为空，<a href="<%=request.getContextPath()%>/client/js/ProductList.jsp" style="padding: 5px 15px; background-color: #f9a603; color: white; text-decoration: none; border-radius: 3px;">去选购商品</a></p>
            </div>
        <%
            } else {
                // 计算总价
                double totalPrice = 0;
                for (Map<String, String> item : cart) {
                    totalPrice += Double.parseDouble(item.get("price")) * Integer.parseInt(item.get("quantity"));
                }
        %>
            <form action="<%=request.getContextPath()%>/client/js/UpdateCart.jsp" method="post">
                <div style="padding: 20px; border-radius: 5px; background-color: #fff9e6;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="15" style="font-size: 18px;">
                        <tr style="border-bottom: 1px solid #ddd; font-weight: bold;">
                            <th width="5%">序号</th>
                            <th width="30%">商品名称</th>
                            <th width="15%">单价</th>
                            <th width="10%">库存</th>
                            <th width="15%">数量</th>
                            <th width="15%">小计</th>
                            <th width="10%">操作</th>
                        </tr>
                        <%
                            int index = 1;
                            int itemIndex = 0;
                            for (Map<String, String> item : cart) {
                                int stock = Integer.parseInt(item.get("stock"));
                                int quantity = Integer.parseInt(item.get("quantity"));
                                double itemTotal = Double.parseDouble(item.get("price")) * quantity;
                                boolean outOfStock = quantity > stock;
                        %>
                            <tr style="border-bottom: 1px solid #ddd;">
                                <td align="center"><%= index++ %></td>
                                <td align="center"><%= item.get("name") %></td>
                                <td align="center"><%= item.get("price") %> 元</td>
                                <td align="center"><%= item.get("stock") %></td>
                                <td align="center">
                                    <input type="number" name="quantity_<%= itemIndex %>" value="<%= item.get("quantity") %>" min="1" max="<%= item.get("stock") %>" style="width: 60px; text-align: center;" />
                                    <% if (outOfStock) { %>
                                        <span style="color: red; font-size: 12px;">库存不足</span>
                                    <% } %>
                                </td>
                                <td align="center"><%= String.format("%.2f", itemTotal) %> 元</td>
                                <td align="center">
                                    <a href="<%=request.getContextPath()%>/client/js/DeleteCart.jsp?index=<%= itemIndex %>">
                                        <img src="<%=request.getContextPath()%>/client/images/productingImg/delete.png" width="20" height="20" border="0" alt="删除" />
                                    </a>
                                </td>
                            </tr>
                        <%
                                itemIndex++;
                            }
                        %>
                        <tr>
                            <td colspan="5" align="right" style="font-weight: bold; font-size: 20px;">合计：</td>
                            <td align="center" style="font-weight: bold; font-size: 20px; color: #e64340;"><%= String.format("%.2f", totalPrice) %> 元</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="7" align="right">
                                <input type="submit" value="更新购物车" style="padding: 8px 20px; margin-right: 10px; cursor: pointer;" />
                                <a href="<%=request.getContextPath()%>/client/js/ProductList.jsp" style="padding: 8px 20px; background-color: #f9a603; color: white; text-decoration: none; border-radius: 3px;">继续购物</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
        <%
            }
        %>
    </div>
    </div>

    <%@ include file="/client/include/foot.jsp" %>
</body>
</html>
