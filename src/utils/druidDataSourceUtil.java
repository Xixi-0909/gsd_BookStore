package utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class druidDataSourceUtil {
    // 声明Druid数据源
    private static DataSource dataSource;
    // 静态代码块：初始化数据源
    static {
        try {
            // 读取配置文件
            Properties prop = new Properties();
            InputStream is = druidDataSourceUtil.class.getClassLoader().getResourceAsStream("druid.properties");
            prop.load(is);
            // 创建Druid数据源
            dataSource = DruidDataSourceFactory.createDataSource(prop);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 获取数据库连接
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    // 关闭数据库连接（归还到连接池）
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}