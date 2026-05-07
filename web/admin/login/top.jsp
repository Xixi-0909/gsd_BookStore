<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div style="width:100%;height:100%;display:flex;flex-direction:column;">
    <!-- 顶部标题栏 -->
    <div style="width:100%;height:50px;display:flex;justify-content:center;align-items:center;background:#FFA500;border-bottom:3px solid #000;">
        <div style="font-size:32px;font-weight:700;color:#000;letter-spacing:2px;">&#x7F51;&#x4E0A;&#x4E66;&#x57CE;&#x540E;&#x53F0;&#x7BA1;&#x7406;&#x7CFB;&#x7EDF;</div>
    </div>
    <!-- 日期和退出栏 -->
    <div style="width:100%;height:50px;display:flex;justify-content:space-between;align-items:center;background:#e8e8e8;padding:0 15px;font-size:14px;color:#333;">
        <span id="currentDate" style="font-size:14px;color:#333;">2019&#x5E74;3&#x6708;13&#x65E5; &#x661F;&#x671F;&#x4E09;</span>
        <span style="font-size:14px;color:#333;">&#x5728;&#x7EBF;&#x4EBA;&#x6570;&#xFF1A;<strong style="color:#e74c3c;">
            <%
                java.util.concurrent.ConcurrentMap<String, String> onlineUsers =
                    (java.util.concurrent.ConcurrentMap<String, String>) application.getAttribute("onlineUsers");
                int onlineCount = (onlineUsers != null) ? onlineUsers.size() : 0;
            %><%=onlineCount%>
        </strong></span>
        <a href="<%=request.getContextPath()%>/index.jsp" style="color:#333;text-decoration:none;padding:6px 15px;background:#f5f5f5;border-radius:3px;font-size:13px;display:inline-block;">&#x9000;&#x51FA;&#x7CFB;&#x7EDF;</a>
    </div>
</div>
