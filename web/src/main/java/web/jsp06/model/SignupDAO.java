package web.jsp06.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SignupDAO {

	private Connection getConnection () throws Exception {
		
		Context ctx = new InitialContext();
		Context env =(Context)ctx.lookup("java:comp/env");
		DataSource ds= (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
		
		
	} 
	
	//로그인 : id pw 체크해주는 메서드
	// 			id. pw 맞으면 true 둘중하나라도 틀리거나 없으면 false
	public boolean idPwCheck(String id, String pw) {
		boolean result = false; // 최종결과 리턴해줄 변수 미리 선언
		
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {
			conn = getConnection();
			String sql ="select * from signup where id=? and pw=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			// rs 에 돌려받은 결과에 따라 result 변수값 변경 
			if(rs.next()) {
				result =true;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	
	
	
	
	
}
