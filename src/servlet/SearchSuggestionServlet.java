package servlet;

import domain.Product;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.druidDataSourceUtil;

@WebServlet("/SearchSuggestionServlet")
public class SearchSuggestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        String keyword = req.getParameter("keyword");
        List<String> suggestions = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            suggestions = getBookNameSuggestions(keyword.trim());
        }

        // 手动拼接JSON字符串
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < suggestions.size(); i++) {
            if (i > 0) {
                json.append(",");
            }
            json.append("\"").append(escapeJson(suggestions.get(i))).append("\"");
        }
        json.append("]");
        resp.getWriter().write(json.toString());
    }

    // JSON字符串转义
    private String escapeJson(String str) {
        if (str == null) {
            return "";
        }
        return str.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    private List<String> getBookNameSuggestions(String keyword) {
        List<String> suggestions = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = druidDataSourceUtil.getConnection();
            String sql = "SELECT name FROM product WHERE name LIKE ? LIMIT 10";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                suggestions.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            druidDataSourceUtil.close(conn, pstmt, rs);
        }

        return suggestions;
    }
}
