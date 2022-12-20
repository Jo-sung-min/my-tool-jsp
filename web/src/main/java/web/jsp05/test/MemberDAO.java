package web.jsp05.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class MemberDAO {
	
	public List selectAll() {

		
		List list = new ArrayList();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Context ctx = new InitialContext(); 
			Context env= (Context)ctx.lookup("java:comp/env"); 
			DataSource ds=  (DataSource)env.lookup("jdbc/orcl");
			conn =ds.getConnection();
			
			String sql = "select * from bandmember";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
			    dto.setId(rs.getString("id")); 
			    dto.setPw(rs.getString("pw")); 
			    dto.setName(rs.getString("name")); 
			    dto.setTel(rs.getString("tel")); 
			    dto.setAddr(rs.getString("addr")); 
			    dto.setFavorite(rs.getString("favorite"));
			    
	            list.add(dto);   
			}
			
		} catch (Exception e) {
			e.printStackTrace();
	      }finally {
	          if(rs != null) try { rs.close(); }catch(Exception e) { e.printStackTrace();}
	          if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace();}
	          if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace();}
	       }
	       return list; 
	    }
	
	
	
	public void Memberinsert(String id,String pw,String name,String tel,String addr,String favorite ) {
		Connection conn= null;
		PreparedStatement pstmt = null;
		try {
			
			Context ctx = new InitialContext(); 
			Context env= (Context)ctx.lookup("java:comp/env");
			DataSource ds=  (DataSource)env.lookup("jdbc/orcl");
			conn =ds.getConnection();
			
				
			String sql ="insert into bandmember values(?,?,?,?,?,?,sysdate)"; 

				pstmt =conn.prepareStatement(sql);
				
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				pstmt.setString(3, name);
				pstmt.setString(4, tel);
				pstmt.setString(5, addr);
				pstmt.setString(6, favorite);
			
				int result=	pstmt.executeUpdate();
				System.out.println(result);
			
			
			
		} catch (Exception e) {
				e.printStackTrace();

		}finally {
			 
	          if(pstmt != null) try { pstmt.close(); }catch(Exception e) { e.printStackTrace();}
	          if(conn != null) try { conn.close(); }catch(Exception e) { e.printStackTrace();}
		}
		
		
	}    


	    
	
    

    
    
 }
	
	
	
