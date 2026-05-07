<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="domain.Product" %>
<%@ page import="java.util.List" %>

<%
    // 如果没有传入ProductList，则查询所有商品
    if (request.getAttribute("ProductList") == null) {
        Product product = new Product();
        List<Product> ps = product.searchAll();
        request.setAttribute("ProductList", ps);
    }
%>

<html>
<head>
    <title>商品目录</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/client/css/style.css">
</head>
<body>
    <%@ include file="/client/include/head.jsp" %>
    <%@ include file="/client/include/menu_search.jsp" %>

    <div class="page-wrap">
    <div style="width: 90%; margin: 0 auto; padding: 20px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
            <h2>全部商品目录</h2>
            <div>
                <a href="<%=request.getContextPath()%>/client/js/index.jsp" style="color: #0066cc; text-decoration: none;">首页</a> &gt; 全部商品
            </div>
        </div>
        <hr>
        <p>共${fn:length(ProductList)}件商品</p>

        <c:choose>
            <c:when test="${empty ProductList}">
                <p style="text-align: center; padding: 50px; color: #999;">暂无商品</p>
            </c:when>
            <c:otherwise>
                <table width="100%" border="0" cellspacing="20" cellpadding="0">
                    <tr>
                        <c:forEach items="${ProductList}" var="p" varStatus="status">
                            <td align="center">
                                <div style="border: 1px solid #ddd; padding: 20px; border-radius: 5px; width: 200px; margin: 0 auto;">
                                    <div class="divbookpic" style="margin-bottom: 15px;">
                                        <p>
                                            <c:choose>
                                                <c:when test="${p.imgurl != null && p.imgurl != ''}">
                                                    <img src="<%=request.getContextPath()%>/${p.imgurl}" width="150" height="170" border="0" alt="${p.name}" onerror="this.src='<%=request.getContextPath()%>/client/images/error.jpg'" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="<%=request.getContextPath()%>/client/images/productingImg/default.jpg" width="150" height="170" border="0" alt="${p.name}" onerror="this.src='<%=request.getContextPath()%>/client/images/error.jpg'" />
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                    <div class="divlisttitle" style="text-align: left; width: 200px; margin: 0 auto; height: 100px; display: flex; flex-direction: column; justify-content: space-between;">
                                        <form action="Handle-AddCart.jsp" method="post" style="height: 100%; display: flex; flex-direction: column; justify-content: space-between;">
                                            <input type="hidden" name="productId" value="${p.id}" />
                                            <div style="margin-bottom: 5px;">
                                                <span style="display: inline-block; width: 60px;">书名：</span>
                                                <input type="text" style="border:none; width: 130px;" name="PName" value="${p.name}" readonly="readonly"/>
                                            </div>
                                            <div style="margin-bottom: 5px;">
                                                <span style="display: inline-block; width: 60px;">售价：</span>
                                                <input type="text" style="border:none; width: 40px;" name="Price" value="${p.price}" readonly="readonly"/>
                                                <span>元</span>
                                            </div>
                                            <div style="margin-bottom: 5px;">
                                                <span style="display: inline-block; width: 60px;">库存：</span>
                                                <input type="text" style="border:none; width: 40px;" name="PNum" value="${p.pnum}" readonly="readonly"/>
                                            </div>
                                            <div style="text-align: center;">
                                                <input type="submit" name="book${status.count}" value="购买" style="padding: 5px 15px; font-size: 14px;" />
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </td>
                        </c:forEach>
                    </tr>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
    </div>

    <%@ include file="/client/include/foot.jsp" %>
</body>
</html>
