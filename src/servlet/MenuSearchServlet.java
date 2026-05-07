package servlet;

import domain.Product;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/MenuSearchServlet")
public class MenuSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        String keyword = req.getParameter("keyword");
        List<Product> ps = new ArrayList<Product>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            ps = Product.search(keyword);
        }
        req.setAttribute("ProductList", ps);
        req.getRequestDispatcher("/client/js/ProductList.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        doGet(req, resp);
    }
}
