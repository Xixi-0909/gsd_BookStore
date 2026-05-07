package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

// 配置为处理所有请求
@WebFilter("/*")
public class EncodingFilter implements Filter {

    /**
     * 过滤器初始化方法
     * 服务器启动时执行一次，可用于初始化配置
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("初始化成功");
    }

    /**
     * 核心过滤方法，处理全站编码
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        // 设置请求编码，解决POST乱码
        request.setCharacterEncoding("UTF-8");
        // 设置响应编码，解决页面输出乱码
        response.setCharacterEncoding("UTF-8");
        // 设置响应内容类型，让浏览器以UTF-8解析页面
        response.setContentType("text/html;charset=UTF-8");

        // 放行请求，让请求继续访问目标资源
        chain.doFilter(request, response);
    }

    /**
     * 过滤器销毁方法
     * 服务器关闭时执行一次，可用于释放资源
     */
    @Override
    public void destroy() {
        System.out.println("销毁成功");
    }
}