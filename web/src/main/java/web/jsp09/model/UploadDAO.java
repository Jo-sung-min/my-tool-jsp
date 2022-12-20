package web.jsp09.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UploadDAO {

	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env =(Context)ctx.lookup("java:comp/env");
		DataSource ds= (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	// 저장
	public void insertData(String writer,String upload) {
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = getConnection();
			String sql = "insert into uploadImg values(?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setString(2, upload);
			int result=	pstmt.executeUpdate();
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}	
			if(conn!=null) try {conn.close();} catch (Exception e2) {e2.printStackTrace();}	
			
		}
		
	}
	
	
	//작성자에 해당하는 이미지들 가져오는 메서드
	public List<UploadDTO> getImgs(String writer){
		List<UploadDTO> list =null;
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		try {
			conn = getConnection();
			String sql = "select * from uploadImg where writer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			
			rs =pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList<UploadDTO>();
				do {
					UploadDTO dto = new UploadDTO();
					dto.setWriter(writer);
					dto.setUpload(rs.getString("upload"));
					list.add(dto);
				}
				while(rs.next());
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();} catch (Exception e2) {e2.printStackTrace();}	
			if(pstmt!=null) try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}	
			if(conn!=null) try {conn.close();} catch (Exception e2) {e2.printStackTrace();}	
		}
		return list ;
	}
	


	
	
	
	
	
}
