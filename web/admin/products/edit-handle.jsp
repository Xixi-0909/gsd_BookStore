<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="product" class="domain.Product" scope="page"/>
<jsp:setProperty name="product" property="*"/>
<%
    // 获取表单参数
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String priceStr = request.getParameter("price");
    String pnumStr = request.getParameter("pnum");
    String category = request.getParameter("category");
    String description = request.getParameter("description");
    String imgurl = request.getParameter("imgurl");
    
    // 验证必填字段
    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/admin/products/list.jsp");
        return;
    }
    
    // 设置商品属性
    product.setId(id);
    product.setName(name != null ? name.trim() : "");
    product.setCategory(category != null ? category.trim() : "");
    product.setDescription(description != null ? description.trim() : "");
    product.setImgurl(imgurl != null ? imgurl.trim() : "client/images/error.jpg");
    
    // 处理价格
    double price = 0;
    try {
        price = Double.parseDouble(priceStr);
    } catch (Exception e) {
        price = 0;
    }
    product.setPrice(price);
    
    // 处理库存
    int pnum = 0;
    try {
        pnum = Integer.parseInt(pnumStr);
    } catch (Exception e) {
        pnum = 0;
    }
    product.setPnum(pnum);
    
    // 调用update方法更新商品
    boolean success = product.update(product);
    
    // 重定向到商品列表页面
    response.sendRedirect(request.getContextPath() + "/admin/login/home.jsp?item=product_list");
%>
