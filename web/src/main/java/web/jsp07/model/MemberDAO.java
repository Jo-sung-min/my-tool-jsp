package web.jsp07.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {

		private Connection getConnection () throws Exception {
		
		Context ctx = new InitialContext();
		Context env =(Context)ctx.lookup("java:comp/env");
		DataSource ds= (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
		
		
	} 

	// 회원가입처리
	public void addMember(MemberDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
			try {
				conn=getConnection();
				String sql = "insert into member values(?,?,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getId());
				pstmt.setString(2, dto.getPw());
				pstmt.setString(3, dto.getName());
				pstmt.setString(4, dto.getGender());
				pstmt.setString(5, dto.getEmail());
				
				
				int result =pstmt.executeUpdate();
				System.out.println(result);
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
					if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
					if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
			}
	}
	
	//로그인 처리 : id . pw 일치 여부 확인
	public boolean idPwCheck(String id, String pw) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from member where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				result = true;
			}
			
		} catch (Exception e) {
				e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result; 
	}
	
	
	
	// 회원 1명 정보 가져오기 : select * from member where id=?;
	
	public MemberDTO getMember(String id) {
		MemberDTO member =null;
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		try {
			conn= getConnection();
			String sql = "select * from member where id=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) { // 결과가 있으면
				member = new MemberDTO();// dto 객체 생성
				
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setGender(rs.getString("gender"));
				member.setEmail(rs.getString("email"));
				member.setReg(rs.getTimestamp("reg"));
			}
			
		} catch (Exception e) {
				e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		
		return member;
	}
	
	

	// 회원 정보 수정 처리 메서드
	public void updateMember(MemberDTO member) {
		Connection conn= null;
		PreparedStatement pstmt = null;
		
		try {
			conn=getConnection();
			String sql = "update member set pw=? ,  name=?,email=? where id=?";
			pstmt=conn.prepareCall(sql);
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getId());
		
			int result =pstmt.executeUpdate();
			System.out.println(result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		
	}
	
	

	
	
	// 회원 탈퇴 처리 메서드
	public int deleteMember(String id, String pw) {
		int result =0;
		String dbpw=""; // db에서 pw 만 꺼내 담아줄 변수
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try {
			//id,pw 맞는지 검사하고, 맞으면 데이터 삭제
			conn = getConnection();
			String sql ="select pw from member where id =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs= pstmt.executeQuery();
			if(rs.next()) {// 결과를 하나 가져왔으면
				dbpw= rs.getString("pw"); // db 에서저장된 pw 꺼내기
				if(dbpw.equals(pw)) {//비번 일치할떄
					//회원정보 삭제 처리
					sql = "delete from member where id=?";
					pstmt =conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					result =1; //비번 맞고 삭제 성공
				}else {
					result =0; //비번 틀림
					
					}
				}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	
	
	//아이디 중복확인 처리 메서드
	
	
	public boolean confirmId(String id) {
		boolean result=false;
		int count = 0;
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try {
			conn= getConnection();
			String sql = "select count(*) from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count =rs.getInt(1);
				System.out.println("count:"+count);
				if(count==1) {
					result =true;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		//값이 true 면 이미 존재 false 면 존재하지 않는다
		return result;
	}
	
	
	
	
	
	
	
	
}

	
	
	
	
	

