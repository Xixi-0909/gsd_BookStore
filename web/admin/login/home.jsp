<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    String msg = request.getParameter("msg");
    if (msg == null || msg.trim().isEmpty()) {
        // 用 Unicode 转义避免 JSP 源文件编码不一致导致中文乱码
        msg = "\u767B\u5F55\u6210\u529F\uFF01";
    }
    request.setAttribute("msg", msg);

    String item = request.getParameter("item");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台首页</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/css/admin.css" type="text/css">
</head>
<body style="margin:0;background:#f5f5f5;">
<div class="admin-page" id="container" style="width:100%;min-height:100vh;display:flex;flex-direction:column;">
    <div id="header" style="background-color:#FFA500;">
        <%@ include file="top.jsp"%>
    </div>

    <div id="main" style="flex:1;display:flex;min-height:0;margin-top:15px;">
        <div id="menu" style="background-color:#f9f9f9;width:180px;min-height:0;border-right:1px solid #e8e8e8;border-top:1px solid #e8e8e8;">
            <jsp:include page="left.jsp"/>
        </div>
        <div id="content" style="flex:1;background:#fff;min-height:0;">
            <div style="padding:20px;">
                <%                    if (item != null && "product_list".equals(item)) {                %>
                <jsp:include page="/admin/products/list.jsp"/>
                <%                    } else if (item != null && "product_add".equals(item)) {                %>
                <jsp:include page="/admin/products/add.jsp"/>
<%--  当item的值等于 "product_add" 时， 动态加载 /admin/products/add.jsp 页面，并将商品添加表单和 add.jsp 的执行结果嵌入到 home.jsp 的内容区域--%>
                <%                    } else if (item != null && "product_edit".equals(item)) {                %>
                <jsp:include page="/admin/products/edit.jsp"/>
                <%                    } else {                %>
                <jsp:include page="welcome.jsp"/>
                <%                    }                %>
            </div>
        </div>
    </div>

    <div id="footer" style="background-color:#ffa500;border-top:1px solid #ffa500;height:40px;">
        <%@ include file="bottom.jsp"%>
    </div>
</div>
</body>
</html>
