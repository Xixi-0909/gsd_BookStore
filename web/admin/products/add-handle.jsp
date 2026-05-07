<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="product" class="domain.Product" scope="page"/>//引入javabean，创建Product类的实例，用于存储商品信息
<jsp:setProperty name="product" property="*"/>//将表单数据绑定到Product类的实例上

<%
    // 设置默认图片路径
    product.setImgurl("client/images/error.jpg");
    
    // 调用add方法添加商品
    boolean success = product.add(product);
    
    // 重定向到 home.jsp 页面，并携带参数 item=product_list，用户就可以在商品列表页面查看新添加的商品
    response.sendRedirect(request.getContextPath() + "/admin/login/home.jsp?item=product_list");
%>