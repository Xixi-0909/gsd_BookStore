<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>网上书城</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/client/css/style.css">

</head>
<body>
<div class="page-wrap">
    <%@ include file="/client/include/head.jsp" %>
    <%@ include file="/client/include/menu_search.jsp" %>

    <div class="content-area">
        <div class="carousel" id="carousel">
            <!-- 第 1 张：Java 基础入门 -->
            <div class="slide active">
                <img src="<%=request.getContextPath()%>/client/images/index_ad1.jpg" alt="Java 基础入门" style="width: 100%; height: 400px; object-fit: cover; display: block;"/>
                <div class="slide-caption">
                    <div class="slide-title">JAVA 基础入门</div>
                    <div class="slide-subtitle">学习、练习、提升你的编程能力</div>
                </div>
            </div>
            <!-- 第 2 张：软件开发实战 -->
            <div class="slide">
                <img src="<%=request.getContextPath()%>/client/images/index_ad2.jpg" alt="精选童书" style="width: 100%; height: 400px; object-fit: cover; display: block;"/>
                <div class="slide-caption">
                    <div class="slide-title">精选童书，五折抢购</div>
                    <div class="slide-subtitle">好书知时节，润物细无声</div>
                </div>
            </div>
            <!-- 第 3 张：数据结构与算法 -->
            <div class="slide">
                <img src="<%=request.getContextPath()%>/client/images/index_ad.jpg" alt="Lonely planet" style="width: 100%; height: 400px; object-fit: cover; display: block;"/>
                <div class="slide-caption">
                    <div class="slide-title">Lonely planet</div>
                    <div class="slide-subtitle">尼泊尔 Lonely planet旅游指南系列</div>
                </div>
            </div>
            <!-- 指示器 -->
            <div class="carousel-indicators">
                <span class="indicator active" data-index="0">1</span>
                <span class="indicator" data-index="1">2</span>
                <span class="indicator" data-index="2">3</span>
            </div>
        </div>

        <div class="index-grid">
            <div class="panel">
                <div class="panel-title">
                    <img src="<%=request.getContextPath()%>/client/images/billboard.gif" alt="公告板" style="vertical-align: middle; margin-right: 8px;"/>
                    公告板
                </div>
                <div class="panel-body" style="background: #fffae6; padding: 15px;">
                    <div style="text-align: center; margin-bottom: 10px;">
                    </div>
                    <strong style="color: #ff6600;">尊敬的网上书城用户：</strong><br/>
                    <div style="text-indent: 2em; color: #666; line-height: 1.8;">
                        为了让大家有更好的购物体验，3 月 25 日起，当日达业务关小黑屋<br/>
                        回炉升级！<br/>
                        具体开放时间请留意公告，感谢您的支持与理解，祝大家购物愉快！
                    </div>
                </div>
                <div class="panel-img">
                    <img src="<%=request.getContextPath()%>/client/images/index_ad5.jpg" alt="本周热卖" style="width: 100%;"/>
                </div>
            </div>
            <div class="panel">
                <div class="panel-title">
                    <img src="<%=request.getContextPath()%>/client/images/hottitle.gif" alt="本周热卖" style="vertical-align: middle; margin-right: 8px;"/>
                    本周热卖

                </div>
                <div class="panel-body" style="background: #fffae6; padding: 15px;">
                    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px;">
                        <div style="text-align: center;">
                            <img src="<%=request.getContextPath()%>/client/images/index_ad.jpg" alt="Java 基础入门" style="width: 100%; max-width: 150px; border: 1px solid #eee; padding: 5px;"/>
                            <div style="font-size: 13px; color: #333; margin-top: 5px;">Java 基础入门</div>
                            <div style="color: #ff6600; font-weight: bold;">￥39.80</div>
                        </div>
                        <div style="text-align: center;">
                            <img src="<%=request.getContextPath()%>/client/images/index_ad0.jpg" alt="Web 前端开发" style="width: 100%; max-width: 150px; border: 1px solid #eee; padding: 5px;"/>
                            <div style="font-size: 13px; color: #333; margin-top: 5px;">Web 前端开发</div>
                            <div style="color: #ff6600; font-weight: bold;">￥45.00</div>
                        </div>
                        <div style="text-align: center;">
                            <img src="<%=request.getContextPath()%>/client/images/index_ad1.jpg" alt="数据库设计" style="width: 100%; max-width: 150px; border: 1px solid #eee; padding: 5px;"/>
                            <div style="font-size: 13px; color: #333; margin-top: 5px;">数据库设计</div>
                            <div style="color: #ff6600; font-weight: bold;">￥52.00</div>
                        </div>
                        <div style="text-align: center;">
                            <img src="<%=request.getContextPath()%>/client/images/index_ad2.jpg" alt="算法通关秘籍" style="width: 100%; max-width: 150px; border: 1px solid #eee; padding: 5px;"/>
                            <div style="font-size: 13px; color: #333; margin-top: 5px;">算法通关秘籍</div>
                            <div style="color: #ff6600; font-weight: bold;">￥48.00</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/client/include/foot.jsp" %>
</div>

<style>
    /* 轮播图容器 */
    .carousel {
        position: relative;
        width: 100%;
        height: 400px;
        overflow: hidden;
        margin-bottom: 20px;
    }
    
    /* 幻灯片 */
    .slide {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        opacity: 0;
        transition: opacity 0.8s ease-in-out;
    }
    
    .slide.active {
        opacity: 1;
    }
    
    /* 图片样式 */
    .slide img {
        width: 100%;
        height: 400px;
        object-fit: cover;
    }
    
    /* 标题容器 */
    .slide-caption {
        position: absolute;
        bottom: 60px;
        left: 40px;
        color: #fff;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
    }
    
    .slide-title {
        font-size: 36px;
        font-weight: bold;
        margin-bottom: 10px;
    }
    
    .slide-subtitle {
        font-size: 18px;
    }
    
    /* 指示器 */
    .carousel-indicators {
        position: absolute;
        bottom: 20px;
        right: 30px;
        display: flex;
        gap: 10px;
        z-index: 10;
    }
    
    .indicator {
        width: 40px;
        height: 30px;
        background: rgba(255, 255, 255, 0.5);
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        font-weight: bold;
        transition: all 0.3s;
    }
    
    .indicator:hover {
        background: rgba(255, 255, 255, 0.8);
    }
    
    .indicator.active {
        background: #ff6600;
        color: #fff;
    }
</style>

<script type="text/javascript">
    // 轮播图自动切换 + 指示器
    (function () {
        var carousel = document.getElementById("carousel");
        if (!carousel) return;

        var slides = carousel.getElementsByClassName("slide");
        var indicators = carousel.getElementsByClassName("indicator");
        var idx = 0;
        var timer = null;

        // 切换到指定幻灯片
        function show(i) {
            // 移除所有 active
            for (var s = 0; s < slides.length; s++) {
                slides[s].classList.remove("active");
                indicators[s].classList.remove("active");
            }
            // 添加当前 active
            slides[i].classList.add("active");
            indicators[i].classList.add("active");
            idx = i;
        }

        // 下一张
        function next() {
            var nextIdx = (idx + 1) % slides.length;
            show(nextIdx);
        }

        // 启动自动播放
        function startAutoPlay() {
            timer = setInterval(next, 3000);
        }

        // 停止自动播放
        function stopAutoPlay() {
            if (timer) {
                clearInterval(timer);
                timer = null;
            }
        }

        // 绑定指示器点击事件
        for (var i = 0; i < indicators.length; i++) {
            (function(index) {
                indicators[i].addEventListener("click", function() {
                    stopAutoPlay();
                    show(index);
                    startAutoPlay();
                });
            })(i);
        }

        // 鼠标悬停时暂停播放
        carousel.addEventListener("mouseenter", stopAutoPlay);
        carousel.addEventListener("mouseleave", startAutoPlay);

        // 启动
        startAutoPlay();
    })();
</script>
</body>
</html>