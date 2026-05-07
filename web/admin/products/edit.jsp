<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="domain.Product" %>
<%
    String id = request.getParameter("id");
    Product product = null;
    if (id != null && !id.trim().isEmpty()) {
        Product p = new Product();
        product = p.searchById(id);
    }
    
    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/admin/products/list.jsp");
        return;
    }
    
    request.setAttribute("product", product);
%>
<html>
<head>
    <title>编辑商品</title>
    <style>
        .form-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
        }
        .form-title {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            font-size: 18px;
            font-weight: bold;
        }
        .form-row {
            display: flex;
            margin-bottom: 15px;
        }
        .form-item {
            flex: 1;
            margin-right: 20px;
        }
        .form-item:last-child {
            margin-right: 0;
        }
        .form-item label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        .form-item input[type="text"],
        .form-item input[type="number"],
        .form-item select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-item textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
            min-height: 100px;
        }
        .form-buttons {
            text-align: center;
            margin-top: 30px;
        }
        .form-buttons button,
        .form-buttons a {
            padding: 10px 20px;
            margin: 0 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-confirm {
            background-color: #4CAF50;
            color: white;
        }
        .btn-cancel {
            background-color: #9E9E9E;
            color: white;
        }
        .btn-back {
            background-color: #2196F3;
            color: white;
        }
        .id-display {
            color: #666;
            font-size: 12px;
        }
        .img-preview {
            max-width: 100px;
            max-height: 100px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="form-container">
    <div class="form-title">编辑商品</div>
    <form action="${pageContext.request.contextPath}/admin/products/edit-handle.jsp" method="post">
        <input type="hidden" name="id" value="${product.id}">
        
        <div class="form-row">
            <div class="form-item">
                <label>商品ID：</label>
                <span class="id-display">${product.id}</span>
            </div>
            <div class="form-item">
                <label>商品名称：</label>
                <input type="text" name="name" value="${product.name}" required>
            </div>
        </div>
        <div class="form-row">
            <div class="form-item">
                <label>商品价格：</label>
                <input type="number" name="price" step="0.01" min="0" value="${product.price}" required>
            </div>
            <div class="form-item">
                <label>商品数量：</label>
                <input type="number" name="pnum" min="0" value="${product.pnum}" required>
            </div>
        </div>
        <div class="form-row">
            <div class="form-item">
                <label>商品类别：</label>
                <select name="category" required>
                    <option value="">--选择商品类别--</option>
                    <option value="计算机" ${product.category == '计算机' ? 'selected' : ''}>计算机</option>
                    <option value="文学" ${product.category == '文学' ? 'selected' : ''}>文学</option>
                    <option value="历史" ${product.category == '历史' ? 'selected' : ''}>历史</option>
                    <option value="艺术" ${product.category == '艺术' ? 'selected' : ''}>艺术</option>
                    <option value="教育" ${product.category == '教育' ? 'selected' : ''}>教育</option>
                </select>
            </div>
        </div>
        <div class="form-row">
            <div class="form-item">
                <label>商品图片：</label>
                <span style="color: #666; font-size: 12px;">图片暂不支持修改</span>
                <br>
                <img src="${pageContext.request.contextPath}/${product.imgurl}" class="img-preview" alt="商品图片" onerror="this.src='${pageContext.request.contextPath}/client/images/error.jpg'">
                <input type="hidden" name="imgurl" value="${product.imgurl}">
            </div>
        </div>
        <div class="form-row">
            <div class="form-item" style="flex: 1;">
                <label>商品描述：</label>
                <textarea name="description">${product.description}</textarea>
            </div>
        </div>
        <div class="form-buttons">
            <button type="submit" class="btn-confirm">保存</button>
            <button type="button" class="btn-cancel" onclick="history.back()">取消</button>
            <a href="${pageContext.request.contextPath}/admin/products/list.jsp" class="btn-back">返回列表</a>
        </div>
    </form>
</div>
</body>
</html>
