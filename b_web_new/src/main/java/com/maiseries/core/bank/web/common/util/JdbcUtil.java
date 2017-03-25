package com.maiseries.core.bank.web.common.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class JdbcUtil {
	/**
	 * Get the Connection
	 * 
	 * @return connection
	 * @throws JasperReportException
	 */
	public static Connection getConnection() throws Exception {
		Connection con;

		try {

			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://192.168.1.105:3306/fx_tester", "tester", "mysql_tester");
			con.setAutoCommit(false);
			return con;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Get JDBC Connection Error");
		}
	}

	public static String read(String sql) {
		String result = null;
		Connection conn = null;
		try {
			conn = getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if (rs != null && rs.next()) {
				rs.close();
				return "1";
			} else {
				rs.close();
				return "0";
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "exception:" + e.getMessage();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					result = "exception:" + e.getMessage();
				}
			}
		}

		return result;
	}
	//读取短信内容
	public static List<Object[]> readSmsContent(String sql) {
		Connection conn = null;
		List<Object[]> list = new ArrayList<Object[]>();
		try {
			conn = getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs != null && rs.next()){
				Object[] obj = {rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5)};
				list.add(obj);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	public static String write(int id, String name, String path) {
		String result = null;
		Connection conn = null;
		try {
			conn =getConnection();
			PreparedStatement stmt = conn.prepareStatement("insert into pro_doc(d_id,d_name,d_path) values(?,?,?)");
			stmt.setInt(1, id);
			stmt.setString(2, name);
			stmt.setString(3, path);
			int count = stmt.executeUpdate();
			result = "result:write " + count + " row record.";
		} catch (Exception e) {
			e.printStackTrace();
			result = "exception:" + e.getMessage();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					result = "exception:" + e.getMessage();
				}
			}
		}

		return result;
	}
	public static int executeUpdateBatch(List sqlgroup) {
		int rset = 0;
		Statement stmt = null;
		Connection _conn = null;
		int sqlgroupsize = 0;
		sqlgroupsize = sqlgroup.size();
		try {
			_conn = getConnection();
			if (_conn != null) {
				_conn.setAutoCommit(false);
				stmt = _conn.createStatement();
				for (int i = 0; i < sqlgroupsize; i++) {
					String sql = (String) sqlgroup.get(i);
					stmt.addBatch(sql);
				}

				stmt.executeBatch();
				_conn.commit();
				rset = 1;
			}
		} catch (SQLException e) {
			System.out.println("Error code: " + e + " ");
			try {
				if (_conn != null) {
					_conn.rollback();
				}
				rset = 0;
			} catch (SQLException ex) {
				System.out.println("Error code: " + ex + " ");
			}
		} finally {
			try {
				if (_conn != null) {
					_conn.close();
				}
			} catch (SQLException e) {
				System.out.println("Error code: " + e + " ");
			}

			return rset;
		}
	}
	public static String  checkLoginStatus(String userName,String password){
		String sql = "SELECT 1 from t_base_info t where t.mobile_phone = '"+userName+"'";
		String str = read(sql);
		if("0".equals(str)){
			return "01";//用户不存在
		}else{
			sql = "SELECT 1 from t_base_info t where t.mobile_phone = '"+userName+"' and t.password='"+password+"'";
			str = read(sql);
			if("0".equals(str)){
				return "02";//密码不正确
			}else{
				return "03";//成功
			}
		}
	}
}
