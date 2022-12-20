package web.jsp04.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class TestDAO {
	//DB 커넥션 메서드
	//회원정보 모두 가져오기 : select * from test

	public List selectAll() {
		//회원정보 모두 담아서 마지막에 jsp 로 리턴해줄 변수생성
		
		List list = new ArrayList();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//DB 연결 (커넥션 풀)
			Context ctx = new InitialContext(); // 컨텍스트 (설정) 정보 가져오기위해 객체생성
			Context env= (Context)ctx.lookup("java:comp/env"); // java 컴포넌트로 만들어진 환경설정을 찾아 리턴해줘~
			DataSource ds=  (DataSource)env.lookup("jdbc/orcl");
			conn =ds.getConnection();
			
			//쿼리문 작성, pstmt 생성
			String sql = "select * from test";
			pstmt = conn.prepareStatement(sql);
			//쿼리 실행
			rs = pstmt.executeQuery(); // select 날려야되서 쿼리
			
			//결과 받아와 jsp로 리턴
			while(rs.next()) {
				//레코드 한줄의 데이터를 정리해 담을 DTO 객체생성
				TestDTO dto = new TestDTO();
				//rs 에서 id 꺼내 dto에 저장
			    dto.setId(rs.getString("id")); 
	            dto.setPw(rs.getString("pw")); 
	            dto.setAge(rs.getInt("age")); 
	            dto.setReg(rs.getTimestamp("reg")); 
	            list.add(dto);   // list에 dto 추가 

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
	
	
	
	
	
	
	    //회원가입 처리 메서드
	public void insertMember(String id,String pw,int age ) {
		Connection conn= null;
		PreparedStatement pstmt = null;
		try {
			//DB 연결 (커넥션 풀)
			Context ctx = new InitialContext(); // 컨텍스트 (설정) 정보 가져오기위해 객체생성
			Context env= (Context)ctx.lookup("java:comp/env"); // java 컴포넌트로 만들어진 환경설정을 찾아 리턴해줘~
			DataSource ds=  (DataSource)env.lookup("jdbc/orcl");
			conn =ds.getConnection();
			
				//쿼리문 작성, pstmt
			String sql ="insert into test values(?,?,?,sysdate)"; 
			// 값을 채워야하는부분을? (placeholder) 로 대체하고 , pstmt 객체 얻어 이후에 채워준다!
				 pstmt =conn.prepareStatement(sql);
			// 물음표 채우기 (위 쿼리문 작성상 1 부터 시작하는 물음표의 번호, 채워줄 값);
			// 이때 setXxx() Xxx의 타입은 테이블상의 데이터타입을 기준으로 (채우는 데이터도 형변환 필요.) 
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				pstmt.setInt(3, age);
			// 쿼리문 실행	
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
	
	
	
	
	
	