<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<style>
    .menu-item {
        padding: 12px 20px;
        border-bottom: 1px solid #e8e8e8;
        cursor: pointer;
        color: #333;
        font-size: 14px;
        transition: background 0.2s;
        text-align: center;
    }
    .menu-item:hover {
        background: #f0f0f0;
    }
    .submenu {
        display: none;
        background: #fff;
    }
    .submenu-item {
        padding: 10px 20px 10px 40px;
        border-bottom: 1px solid #eee;
        cursor: pointer;
        font-size: 13px;
        color: #666;
        text-align: left;
    }
    .submenu-item:hover {
        background: #e8f4fc;
        color: #2196F3;
    }
    .submenu-item a {
        text-decoration: none;
        color: inherit;
        display: block;
    }
    .menu-active {
        background: #e8f4fc;
        color: #2196F3;
    }
</style>
<div class="left-menu" style="width:100%;height:100%;background:#f9f9f9;">
    <ul style="list-style:none;padding:0;margin:0;">
        <li style="padding:0;border-bottom:1px solid #e8e8e8;">
            <div class="menu-item" onclick="toggleSubmenu('productSubmenu')" id="productMenu">
                &#x5546;&#x54C1;&#x7BA1;&#x7406;
            </div>
            <div class="submenu" id="productSubmenu">
                <div class="submenu-item">
                    <a href="${pageContext.request.contextPath}/admin/login/home.jsp?item=product_list">&#x67E5;&#x770B;&#x5546;&#x54C1;</a>
                </div>
                <div class="submenu-item">
                    <a href="${pageContext.request.contextPath}/admin/login/home.jsp?item=product_add">&#x6DFB;&#x52A0;&#x5546;&#x54C1;</a>
                </div>
            </div>
        </li>
        <li class="menu-item">&#x9500;&#x552E;&#x699C;&#x5355;</li>
        <li class="menu-item">&#x8BA2;&#x5355;&#x7BA1;&#x7406;</li>
        <li class="menu-item">&#x516C;&#x544A;&#x7BA1;&#x7406;</li>
    </ul>
</div>
<script>
    function toggleSubmenu(id) {
        var submenu = document.getElementById(id);
        if (submenu.style.display === 'block') {
            submenu.style.display = 'none';
        } else {
            submenu.style.display = 'block';
        }
    }
    
    // 根据当前页面自动展开菜单
    var currentUrl = window.location.href;
    if (currentUrl.indexOf('item=product_list') !== -1 || currentUrl.indexOf('item=product_add') !== -1 ||
        currentUrl.indexOf('item=product_edit') !== -1 ||
        currentUrl.indexOf('product_list') !== -1 || currentUrl.indexOf('product_add') !== -1 || 
        currentUrl.indexOf('edit.jsp') !== -1 || currentUrl.indexOf('list.jsp') !== -1) {
        document.getElementById('productSubmenu').style.display = 'block';
        document.getElementById('productMenu').classList.add('menu-active');
    }
</script>

<!--防止中文乱码
   商品管理
   销售榜单
   订单管理
   公告管理
   查看商品
   添加商品-->
