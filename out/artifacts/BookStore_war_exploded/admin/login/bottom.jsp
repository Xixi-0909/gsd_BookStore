<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    java.util.concurrent.ConcurrentMap<String, String> onlineUsers =
        (java.util.concurrent.ConcurrentMap<String, String>) application.getAttribute("onlineUsers");
    int onlineCount = (onlineUsers != null) ? onlineUsers.size() : 0;
    java.util.Set<String> userList = (onlineUsers != null) ? onlineUsers.values() : new java.util.HashSet<String>();
%>
<div style="width:100%;height:100%;display:flex;flex-direction:column;align-items:center;padding:20px;box-sizing:border-box;font-family:Arial,sans-serif;">
    <div style="width:100%;max-width:600px;">
        <div style="font-size:18px;font-weight:bold;color:#2c3e50;margin-bottom:15px;text-align:center;">
            &#x5728;&#x7EBF;&#x7528;&#x6237;&#x5217;&#x8868;
            <span style="font-size:14px;color:#666;font-weight:normal;">&#xFF08;&#x5171;<strong style="color:#e74c3c;"><%=onlineCount%></strong>&#x4EBA;&#xFF09;</span>
        </div>
        <% if (onlineCount == 0) { %>
        <div style="text-align:center;color:#999;padding:20px;">&#x6CA1;&#x6709;&#x5728;&#x7EBF;&#x7528;&#x6237;</div>
        <% } else { %>
        <table style="width:100%;border-collapse:collapse;font-size:14px;">
            <thead>
                <tr style="background:#3498db;color:#fff;">
                    <th style="padding:10px;text-align:center;border:1px solid #ddd;">&#x5E8F;&#x53F7;</th>
                    <th style="padding:10px;text-align:center;border:1px solid #ddd;">&#x7528;&#x6237;&#x540D;</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int idx = 1;
                    for (String username : userList) {
                %>
                <tr style="background:<%= (idx % 2 == 0) ? "#f9f9f9" : "#ffffff" %>;">
                    <td style="padding:10px;text-align:center;border:1px solid #ddd;color:#333;"><%=idx%></td>
                    <td style="padding:10px;text-align:center;border:1px solid #ddd;color:#333;"><%=username%></td>
                </tr>
                <%
                        idx++;
                    }
                %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>
