package web.jsp10.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import oracle.net.aso.c;

public class ImgSignupDAO {

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 회원 가입 처리 메서드 
	public void insertMember(ImgSignupDTO member) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "insert into imgSignup values(?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getGender());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getPhoto());
			
			int result = pstmt.executeUpdate(); 
			System.out.println("insert imgmember result : " + result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
	}
	
	// 로그인 처리 : id,pw 체크 
	public int idPwCheck(String id, String pw) {
		System.out.println(1);
		//int result = 0;  vers.1
		int result = -1; // '아이디가 없다'값으로 초기화  
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			System.out.println(2);
			// 사용자가 작성한 id와 동일한 id값이 db에 있는지 꺼내오기 
			String sql = "select id from imgSignup where id=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			System.out.println(3);
			rs = pstmt.executeQuery(); 
			System.out.println(4);
			if(rs.next()) {
				System.out.println(5);
				sql = "select count(*) from imgSignup where id=? and pw=?";
				pstmt = conn.prepareStatement(sql); 
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					System.out.println(6);
					result = rs.getInt(1); // 비번맞으면 1, 안맞으면 0 
				}
			}
			System.out.println(7);
			/*else { vers.1
				result = -1; // 아이디 없다 : 초기값으로 미리 넣어놔서 if 안타면 -1로 처리됨.
			}*/
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		return result; 
	}
	
	// 사용자 id 주면 그 사용자의 photo컬럼값 돌려주는 메서드 
	public String getPhoto(String id) {
		String photo = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select photo from imgSignup where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				System.out.println("dao if rs.next() ok!");
				photo = rs.getString("photo");
			}
			System.out.println("dao photo : " + photo);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		return photo; 
	}
	
	// 회원 한명 정보 가져오는 메서드 
	public ImgSignupDTO getMember(String id) {
		ImgSignupDTO member = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			conn = getConnection(); 
			String sql = "select * from imgSignup where id=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과가 있으면 
				member = new ImgSignupDTO(); // DTO 객체생성해서 준비(결과가 없으면 객체생성도 안하겠다) 
				member.setId(id);
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setGender(rs.getString("gender"));
				member.setReg(rs.getTimestamp("reg"));
				member.setPhoto(rs.getString("photo"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try{ rs.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		return member; 
	}
	
	// 회원 정보 수정 메서드 
	public int updateMember(ImgSignupDTO member) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "update imgSignup set pw=?, email=?, photo=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getEmail());
			pstmt.setString(3, member.getPhoto());
			pstmt.setString(4, member.getId());
			
			result = pstmt.executeUpdate(); // 잘되면 리턴1, 잘안되면 리턴0 
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
		return result; 
	}
	
	// 회원 탈퇴 처리 메서드 
	public void deleteMember(String id) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "delete from imgSignup where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);

			int result = pstmt.executeUpdate();
			System.out.println("delete member result : " + result);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
		}
	}
	
	
	
	
	
	
	
}
