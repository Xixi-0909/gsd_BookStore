<%--
  Created by IntelliJ IDEA.
  User: ZHANG
  Date: 2026/3/26
  Time: 10:12
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    // 仅在当前页面定义一次ctx，避免重复定义（如果index.jsp已定义，可删除此行）
    // String ctx = request.getContextPath();
%>
<div class="site-nav" style="width: 100%; background: #f9a603; padding: 10px 0; border-bottom: 3px solid #32936f;">
    <div class="container nav-inner" style="width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center;">

        <!-- 左侧分类导航 -->
        <ul class="nav-categories" style="display: flex; gap: 16px; font-size: 14px; list-style: none; margin: 0; padding: 0; white-space: nowrap;">
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=文学" style="color: #fff; text-decoration: none; font-weight: bold;">文学</a></li>
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=生活" style="color: #fff; text-decoration: none; font-weight: bold;">生活</a></li>
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=计算机" style="color: #fff; text-decoration: none; font-weight: bold;">计算机</a></li>
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=外语" style="color: #fff; text-decoration: none; font-weight: bold;">外语</a></li>
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=经管" style="color: #fff; text-decoration: none; font-weight: bold;">经管</a></li>
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=励志" style="color: #fff; text-decoration: none; font-weight: bold;">励志</a></li>
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=社科" style="color: #fff; text-decoration: none; font-weight: bold;">社科</a></li>
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=学术" style="color: #fff; text-decoration: none; font-weight: bold;">学术</a></li>
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=少儿" style="color: #fff; text-decoration: none; font-weight: bold;">少儿</a></li>
            <li><a href="${pageContext.request.contextPath}/client/category.jsp?name=艺术" style="color: #fff; text-decoration: none; font-weight: bold;">艺术</a></li>
            <li><a href="${pageContext.request.contextPath}/client/js/ProductList.jsp" style="color: #006633; text-decoration: none; font-weight: bold;">全部商品目录</a></li>
        </ul>

        <!-- 右侧搜索框 -->
        <div class="search-area" style="display: flex; align-items: center;">
            <form action="${pageContext.request.contextPath}/MenuSearchServlet" method="get" style="display: flex; align-items: center; gap: 6px; position: relative;">
                <span style="color: #fff; font-weight: bold; font-size: 14px;">Search</span>
                <input type="text" id="searchKeyword" name="keyword" placeholder="请输入书名"
                       style="height: 26px; line-height: 26px; padding: 0 8px; border: 1px solid #ccc; width: 160px; font-size: 13px;">
                <!-- 搜索建议下拉框 -->
                <div id="searchSuggestions" style="display: none; position: absolute; top: 100%; left: 50px; right: 60px; background: white; border: 1px solid #ccc; border-top: none; z-index: 1000; max-height: 300px; overflow-y: auto;">
                </div>
                <button type="submit" style="border: none; background: url('${pageContext.request.contextPath}/client/images/serchbutton.gif') no-repeat center center; background-size: 100% 100%; width: 60px; height: 28px; cursor: pointer; color: transparent; text-indent: -9999px;">
                    搜索
                </button>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
(function() {
    var searchInput = document.getElementById('searchKeyword');
    var suggestionsBox = document.getElementById('searchSuggestions');
    var xhr = null;
    var timeout = null;

    // 输入时显示搜索建议
    searchInput.addEventListener('input', function() {
        var keyword = this.value.trim();

        // 清除之前的延迟
        if (timeout) {
            clearTimeout(timeout);
        }

        // 如果输入为空，隐藏建议框
        if (keyword.length === 0) {
            suggestionsBox.style.display = 'none';
            return;
        }

        // 延迟发送请求，避免频繁请求
        timeout = setTimeout(function() {
            fetchSuggestions(keyword);
        }, 200);
    });

    // 获取搜索建议
    function fetchSuggestions(keyword) {
        // 取消之前的请求
        if (xhr && xhr.readyState !== 4) {
            xhr.abort();
        }

        xhr = new XMLHttpRequest();
        xhr.open('GET', '${pageContext.request.contextPath}/SearchSuggestionServlet?keyword=' + encodeURIComponent(keyword), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var suggestions = JSON.parse(xhr.responseText);
                showSuggestions(suggestions);
            }
        };
        xhr.send();
    }

    // 显示搜索建议
    function showSuggestions(suggestions) {
        if (suggestions.length === 0) {
            suggestionsBox.style.display = 'none';
            return;
        }

        var html = '';
        for (var i = 0; i < suggestions.length; i++) {
            html += '<div class="suggestion-item" onclick="selectSuggestion(\'' + escapeHtml(suggestions[i]) + '\')"'
                  + ' onmouseover="this.style.backgroundColor=\'#f0f0f0\'"'
                  + ' onmouseout="this.style.backgroundColor=\'white\'"'
                  + ' style="padding: 8px 10px; cursor: pointer; font-size: 13px;">'
                  + suggestions[i] + '</div>';
        }
        suggestionsBox.innerHTML = html;
        suggestionsBox.style.display = 'block';
    }

    // 选择建议项
    window.selectSuggestion = function(suggestion) {
        searchInput.value = suggestion;
        suggestionsBox.style.display = 'none';
        // 提交表单
        searchInput.form.submit();
    };

    // 转义HTML，防止XSS
    function escapeHtml(text) {
        var div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML.replace(/'/g, "\\'");
    }

    // 点击其他地方关闭建议框
    document.addEventListener('click', function(e) {
        if (!searchInput.contains(e.target) && !suggestionsBox.contains(e.target)) {
            suggestionsBox.style.display = 'none';
        }
    });

    // 键盘事件：上下键选择，回车提交
    searchInput.addEventListener('keydown', function(e) {
        var items = suggestionsBox.querySelectorAll('.suggestion-item');
        if (suggestionsBox.style.display === 'none' || items.length === 0) {
            return;
        }

        var selectedIndex = -1;
        for (var i = 0; i < items.length; i++) {
            if (items[i].classList.contains('selected')) {
                selectedIndex = i;
                items[i].classList.remove('selected');
                break;
            }
        }

        if (e.key === 'ArrowDown') {
            e.preventDefault();
            selectedIndex = (selectedIndex + 1) % items.length;
            items[selectedIndex].classList.add('selected');
            items[selectedIndex].style.backgroundColor = '#f0f0f0';
        } else if (e.key === 'ArrowUp') {
            e.preventDefault();
            selectedIndex = selectedIndex <= 0 ? items.length - 1 : selectedIndex - 1;
            items[selectedIndex].classList.add('selected');
            items[selectedIndex].style.backgroundColor = '#f0f0f0';
        } else if (e.key === 'Enter' && selectedIndex >= 0) {
            e.preventDefault();
            items[selectedIndex].click();
        }
    });
})();
</script>