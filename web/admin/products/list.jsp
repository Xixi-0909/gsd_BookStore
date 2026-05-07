<%-- 用于商品列表展示 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="domain.Product"%>  <%-- 导入Product类 --%>
<%@ page import="java.util.*" %>    <%-- 导入Java类包 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- 导入JSTL核心标签库，替代 JSP 页面里的 Java 代码 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>商品列表</title>
    <style>
        .search-container {
            background-color: #f9f9f9;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .search-title {
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        .search-form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }
        .search-item {
            display: flex;
            align-items: center;
        }
        .search-item label {
            margin-right: 5px;
            font-weight: normal;
        }
        .search-item input[type="text"],
        .search-item input[type="number"],
        .search-item select {
            padding: 6px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-group {
            display: flex;
            gap: 5px;
        }
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-search {
            background-color: #2196F3;
            color: white;
        }
        .btn-reset {
            background-color: #9E9E9E;
            color: white;
        }
        .btn-add {
            background-color: #4CAF50;
            color: white;
        }
        .btn-edit {
            background-color: #FF9800;
            color: white;
        }
        .btn-delete {
            background-color: #f44336;
            color: white;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        table th {
            background-color: #4CAF50;
            color: white;
        }
        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .img-thumb {
            width: 50px;
            height: 50px;
        }
        .action-cell {
            white-space: nowrap;
        }
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .no-data {
            text-align: center;
            padding: 20px;
            color: #666;
        }
    </style>
</head>
<body>
<% 
    // 处理搜索参数：从请求参数中获取搜索条件，如果没有搜索条件，默认查询所有商品
    // 获取搜索参数：.getParameter方法获取请求参数
    String searchName = request.getParameter("searchName") != null ? request.getParameter("searchName").trim() : "";
    String searchCategory = request.getParameter("searchCategory") != null ? request.getParameter("searchCategory").trim() : "";
    String searchMinPrice = request.getParameter("searchMinPrice") != null ? request.getParameter("searchMinPrice").trim() : "";
    String searchMaxPrice = request.getParameter("searchMaxPrice") != null ? request.getParameter("searchMaxPrice").trim() : "";
    Product product = new Product();//创建Product类的实例
    // 调用Product类的方法进行查询：.searchByConditions方法根据搜索条件查询商品列表
    List<Product> productList = product.searchByConditions(searchName, searchCategory, searchMinPrice, searchMaxPrice);
    request.setAttribute("productList", productList);
    request.setAttribute("searchName", searchName);
    request.setAttribute("searchCategory", searchCategory);
    request.setAttribute("searchMinPrice", searchMinPrice);
    request.setAttribute("searchMaxPrice", searchMaxPrice);
%>

<div class="search-container">
    <div class="search-title">商品查询</div>
    <form method="get" class="search-form" onsubmit="return keepItemParam()">
        <input type="hidden" name="item" value="product_list">
        <div class="search-item">
            <label>商品名称：</label>
            <input type="text" name="searchName" value="<c:out value='${searchName}' default='' escapeXml='false'/>" placeholder="请输入商品名称">
        </div>
        <div class="search-item">
            <label>商品类别：</label>
            <select name="searchCategory">
                <option value="">--全部类别--</option>
                <option value="计算机" <c:if test="${searchCategory == '计算机'}">selected</c:if>>计算机</option>
                <option value="文学" <c:if test="${searchCategory == '文学'}">selected</c:if>>文学</option>
                <option value="历史" <c:if test="${searchCategory == '历史'}">selected</c:if>>历史</option>
                <option value="艺术" <c:if test="${searchCategory == '艺术'}">selected</c:if>>艺术</option>
                <option value="教育" <c:if test="${searchCategory == '教育'}">selected</c:if>>教育</option>
            </select>
        </div>
        <div class="search-item">
            <label>价格区间：</label>
            <input type="number" name="searchMinPrice" value="<c:out value='${searchMinPrice}' default='' escapeXml='false'/>" placeholder="最低价" style="width: 80px;"> -
            <input type="number" name="searchMaxPrice" value="<c:out value='${searchMaxPrice}' default='' escapeXml='false'/>" placeholder="最高价" style="width: 80px;">
        </div>
        <div class="btn-group">
            <button type="submit" class="btn btn-search">查询</button>
            <button type="button" class="btn btn-reset" onclick="location.href='${pageContext.request.contextPath}/admin/login/home.jsp?item=product_list'">重置</button>
        </div>
    </form>
</div>

<div class="top-bar">
    <span style="font-weight: bold;">商品列表 (共 ${fn:length(productList)} 条记录)</span>
    <a href="${pageContext.request.contextPath}/admin/login/home.jsp?item=product_add" class="btn btn-add">添加商品</a>
               <%-- 当用户点击这个按钮时，会跳转到 home.jsp 页面，并携带参数 item=product_add --%>
</div>

<table>
    <tr>
        <th>商品ID</th>
        <th>商品名称</th>
        <th>价格</th>
        <th>分类</th>
        <th>库存</th>
        <th>商品图片</th>
        <th>描述</th>
        <th>操作</th>
    </tr>
    <%-- 判断商品列表是否为空 --%>
    <c:choose>
        <c:when test="${not empty productList}">
            <%-- 遍历商品列表，每个商品用p表示 --%>
            <c:forEach var="p" items="${productList}">
                <tr>
                    <td>${p.id}</td>
                    <td>${p.name}</td>
                    <td>${p.price}</td>
                    <td>${p.category}</td>
                    <td>${p.pnum}</td>
                    <td><img src="${pageContext.request.contextPath}/${p.imgurl}" alt="商品图片" class="img-thumb" onerror="this.src='${pageContext.request.contextPath}/client/images/error.jpg'"></td>
                    <td>${p.description}</td>
                    <td class="action-cell">
                        <a href="${pageContext.request.contextPath}/admin/products/edit.jsp?id=${p.id}" class="btn btn-edit">编辑</a>
                        <a href="${pageContext.request.contextPath}/admin/products/delete-handle.jsp?id=${p.id}" class="btn btn-delete" onclick="return confirm('确定要删除商品【${p.name}】吗？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="9" class="no-data">没有找到符合条件的商品</td>
            </tr>
        </c:otherwise>
    </c:choose>
<%--    如果 商品列表不为空：--%>
<%--    遍历每个商品，显示一行数据--%>
<%--    否则：--%>
<%--    显示"没有找到符合条件的商品"--%>

</table>
<script>
    function keepItemParam() {
        var form = document.querySelector('.search-form');
        var itemInput = form.querySelector('input[name="item"]');
        if (!itemInput) {
            itemInput = document.createElement('input');
            itemInput.type = 'hidden';
            itemInput.name = 'item';
            itemInput.value = 'product_list';
            form.appendChild(itemInput);
        }
        return true;
    }
</script>
</body>
</html>
