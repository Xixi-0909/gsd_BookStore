<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加商品</title>
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
        .form-buttons button {
            padding: 10px 20px;
            margin: 0 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-confirm {
            background-color: #4CAF50;
            color: white;
        }
        .btn-reset {
            background-color: #f44336;
            color: white;
        }
        .btn-back {
            background-color: #2196F3;
            color: white;
        }
    </style>
</head>
<body>
<div class="form-container">
    <div class="form-title">添加商品</div>
    <form action="${pageContext.request.contextPath}/admin/products/add-handle.jsp" method="post">
        <div class="form-row">
            <div class="form-item">
                <label>商品名称：</label>
                <input type="text" name="name" required>
            </div>
            <div class="form-item">
                <label>商品价格：</label>
                <input type="number" name="price" step="0.01" min="0" required>
            </div>
        </div>
        <div class="form-row">
            <div class="form-item">
                <label>商品数量：</label>
                <input type="number" name="pnum" min="0" required>
            </div>
            <div class="form-item">
                <label>商品类别：</label>
                <select name="category" required>
                    <option value="">--选择商品类别--</option>
                    <option value="计算机">计算机</option>
                    <option value="文学">文学</option>
                    <option value="历史">历史</option>
                    <option value="艺术">艺术</option>
                    <option value="教育">教育</option>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-item">
                <label>商品图片：</label>
                <input type="file" name="imgurl" disabled>
            </div>
        </div>

        <div class="form-row">
            <div class="form-item" style="flex: 1;">
                <label>商品描述：</label>
                <textarea name="description"></textarea>
            </div>
        </div>
        <div class="form-buttons">
            <button type="submit" class="btn-confirm">确定</button>
            <button type="reset" class="btn-reset">重置</button>
            <button type="button" class="btn-back" onclick="window.history.back()">返回</button>
        </div>
    </form>
</div>
</body>
</html>