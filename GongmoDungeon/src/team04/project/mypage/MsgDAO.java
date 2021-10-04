package team04.project.mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MsgDAO {
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	public void insertMsg(String send, String receive, String content) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {

			conn = getConnection();
			String sql ="insert into msg values(?,?,?,sysdate)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, send);
			pstmt.setString(2, receive);
			pstmt.setString(3, content);
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
}
