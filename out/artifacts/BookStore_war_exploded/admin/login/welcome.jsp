<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    String msg = (String) request.getAttribute("msg");
    if (msg == null || msg.trim().isEmpty()) {
        // 用 Unicode 转义避免 JSP 源文件编码不一致导致中文乱码：“登录成功！”
        msg = "\u767B\u5F55\u6210\u529F\uFF01";
    }
%>
<div class="welcome-box" style="width:100%;">
    <div style="padding:40px 20px;text-align:center;">
        <div style="font-size:20px;color:#333;font-weight:bold;"><%=msg%></div>
    </div>
</div>
