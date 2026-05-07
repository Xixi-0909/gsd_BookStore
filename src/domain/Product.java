package domain;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import utils.druidDataSourceUtil;

public class Product {
    //把products表中的各个属性转化为JavaBean中的私有类型属性
    private String id;
    private String name;
    private double price;
    private String category;
    private int pnum;
    private String imgurl;
    private String description;
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public int getPnum() {
        return pnum;
    }
    public void setPnum(int pnum) {
        this.pnum = pnum;
    }
    public String getImgurl() {
        return imgurl;
    }
    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    
    /**
     * 查询所有商品
     */
    public List<Product> searchAll() {
        List<Product> ps = new ArrayList<Product>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = druidDataSourceUtil.getConnection(); //使用数据库连接池连接
            String sql = "SELECT * FROM product";
            pstmt = conn.prepareStatement(sql);   //预处理SQL语句，防止SQL注入
            rs = pstmt.executeQuery();

            while (rs.next()) { //遍历结果集，将每行数据封装为Product对象
                Product p = new Product(); 
                p.setId(rs.getString(1));
                p.setName(rs.getString(2));
                p.setPrice(rs.getDouble(3));
                p.setCategory(rs.getString(4));
                p.setPnum(rs.getInt(5));
                p.setImgurl(rs.getString(6));
                p.setDescription(rs.getString(7));
                ps.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        } finally {
            druidDataSourceUtil.close(conn, pstmt, rs); //关闭数据库连接
        }
        return ps;
    }
    
    /**
     * 根据ID查询单个商品
     */
    public Product searchById(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Product p = null;
        try {
            conn = druidDataSourceUtil.getConnection();
            String sql = "SELECT * FROM product WHERE id = ?";//根据商品ID查询商品信息
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                p = new Product();
                p.setId(rs.getString(1));
                p.setName(rs.getString(2));
                p.setPrice(rs.getDouble(3));
                p.setCategory(rs.getString(4));
                p.setPnum(rs.getInt(5));
                p.setImgurl(rs.getString(6));
                p.setDescription(rs.getString(7));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            druidDataSourceUtil.close(conn, pstmt, rs);
        }
        return p;
    }
    
    /**
     * 多条件查询商品（单条件或多条件组合）
     * @param name 商品名称（模糊匹配）
     * @param category 商品类别（精确匹配）
     * @param minPrice 最低价格
     * @param maxPrice 最高价格
     */
    public List<Product> searchByConditions(String name, String category, String minPrice, String maxPrice) {
        List<Product> ps = new ArrayList<Product>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = druidDataSourceUtil.getConnection();
            
            StringBuilder sql = new StringBuilder("SELECT * FROM product WHERE 1=1");
            List<Object> params = new ArrayList<Object>();
            
            // 商品名称（模糊查询）
            if (name != null && !name.trim().isEmpty()) {
                sql.append(" AND name LIKE ?");
                params.add("%" + name.trim() + "%");
            }
            
            // 商品类别（精确查询）
            if (category != null && !category.trim().isEmpty()) {
                sql.append(" AND category = ?");
                params.add(category.trim());
            }
            
            // 最低价格
            if (minPrice != null && !minPrice.trim().isEmpty()) {
                try {
                    double min = Double.parseDouble(minPrice.trim());
                    sql.append(" AND price >= ?");
                    params.add(min);
                } catch (NumberFormatException e) {
                    // 忽略无效的数字格式
                }
            }
            
            // 最高价格
            if (maxPrice != null && !maxPrice.trim().isEmpty()) {
                try {
                    double max = Double.parseDouble(maxPrice.trim());
                    sql.append(" AND price <= ?");
                    params.add(max);
                } catch (NumberFormatException e) {
                    // 忽略无效的数字格式
                }
            }
            
            sql.append(" ORDER BY id DESC");
            
            pstmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getString(1));
                p.setName(rs.getString(2));
                p.setPrice(rs.getDouble(3));
                p.setCategory(rs.getString(4));
                p.setPnum(rs.getInt(5));
                p.setImgurl(rs.getString(6));
                p.setDescription(rs.getString(7));
                ps.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            druidDataSourceUtil.close(conn, pstmt, rs);
        }
        return ps;
    }
    
    /**
     * 添加商品
     */
    public boolean add(Product product) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = druidDataSourceUtil.getConnection();
            String sql = "INSERT INTO product (id, name, price, category, pnum, imgurl, description) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            
            String id = UUID.randomUUID().toString();//生成商品ID，使用UUID随机数
            
            pstmt.setString(1, id);
            pstmt.setString(2, product.getName()); //使用 .getName() 等方法获取属性值，JavaBean规范
            pstmt.setDouble(3, product.getPrice());
            pstmt.setString(4, product.getCategory());
            pstmt.setInt(5, product.getPnum());
            pstmt.setString(6, product.getImgurl() != null ? product.getImgurl() : "client/images/error.jpg");
            pstmt.setString(7, product.getDescription() != null ? product.getDescription() : "");
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL错误：" + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            druidDataSourceUtil.close(conn, pstmt, null);
        }
    }
    
    /**
     * 更新商品
     */
    public boolean update(Product product) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = druidDataSourceUtil.getConnection();
            String sql = "UPDATE product SET name = ?, price = ?, category = ?, pnum = ?, imgurl = ?, description = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, product.getName());
            pstmt.setDouble(2, product.getPrice());
            pstmt.setString(3, product.getCategory());
            pstmt.setInt(4, product.getPnum());
            pstmt.setString(5, product.getImgurl() != null ? product.getImgurl() : "client/images/error.jpg");
            pstmt.setString(6, product.getDescription() != null ? product.getDescription() : "");
            pstmt.setString(7, product.getId());
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL错误：" + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            druidDataSourceUtil.close(conn, pstmt, null);
        }
    }
    
    /**
     * 删除商品
     */
    public boolean delete(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = druidDataSourceUtil.getConnection();
            String sql = "DELETE FROM product WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL错误：" + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            druidDataSourceUtil.close(conn, pstmt, null);
        }
    }


    //查询数据库表products里的所有商品记录，并返回一个商品List。
    public static List<Product> search(String searchfield) {
        List<Product> ps = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 1. 获取数据库连接
            conn = druidDataSourceUtil.getConnection();

            // 2. 模糊查询SQL语句（注意用 ? 占位符，防止SQL注入）
            // 这里假设是按商品名称name模糊查询，也可以改成其他字段
            String sql = "SELECT * FROM product WHERE name LIKE ?";

            // 3. 预处理SQL语句
            pstmt = conn.prepareStatement(sql);
            // 给占位符赋值：模糊查询需要拼接 %
            pstmt.setString(1, "%" + searchfield + "%");

            // 4. 执行查询，获取结果集
            rs = pstmt.executeQuery();

            // 5. 遍历结果集，封装为Product对象
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getString(1));
                p.setName(rs.getString(2));
                p.setPrice(rs.getDouble(3));
                p.setCategory(rs.getString(4));
                p.setPnum(rs.getInt(5));
                p.setImgurl(rs.getString(6));
                p.setDescription(rs.getString(7));
                ps.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 6. 关闭资源（和你searchAll方法里的工具类用法保持一致）
            druidDataSourceUtil.close(conn, pstmt, rs);
        }

        return ps;
    }
}
