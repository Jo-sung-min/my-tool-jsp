package web.jsp05.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SignupDAO {
	//커넥션 메서드
	private Connection getConnection() throws Exception {
		
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		Connection conn = ds.getConnection();
		return conn;
	}
	
	
	
	
	// 회원가입 처리 메서드 : insert into signup(id, pw, name, email...) value(?,?,?...); 
	public void insertMember(SignupDTO dto) {
		//커넥션
		
		//finally 영역에서 아래 변수에 접근해 close() 하기위해, try 에서 선언하지 않고
		//try 전에 미리 변수만 선언해둠.
		Connection conn = null;
		PreparedStatement pstmt =null;
		
		
		try {
			/*
			Context ctx = new InitialContext();
			// java 컴포넌트로 만들어진 환경설정 찾아오기
			Context env= (Context)ctx.lookup("java:comp/env");
			// Object 지만 context 한번더 쓰기위해 형변환 해서 담아줌
			
			//환경설정 정보에서 jdbc/orcl 이라는 이름부여한 정보 다시한번 찾아오기
			DataSource ds = (DataSource)env.lookup("jdbc/orcl"); 
			// DataSource 를 통해서 커넥션 연결 (객체 얻기)
			conn= ds.getConnection();
			*/
			conn= getConnection();
			
			// 쿼리문작성 -> pstmt
			String sql = "insert into signup values(?,?,?,?,?,?,?,?,?,?,?,sysdate)";
			//커넥션으로 준비한 쿼리문 주고 실행기능 갖는 pstmt 리터받기 (쿼리문 준비)
			pstmt =conn.prepareStatement(sql);
			//물음표(placeholer)에 대치되어야할 데이터들 체우기
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getGender());
			pstmt.setString(6, dto.getJob());
			pstmt.setString(7, dto.getMusic());
			pstmt.setString(8, dto.getSports());
			pstmt.setString(9, dto.getTravel());
			pstmt.setString(10, dto.getMovies());
			pstmt.setString(11, dto.getBio());
			//실행
			int result=	pstmt.executeUpdate();
			System.out.println(result);
			//결과??

			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {// 무조건 실행해주는 거라서 finally에 close 넣음
			if(pstmt!=null) {try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (Exception e2) {e2.printStackTrace();}}
			
			
		}
	}
	
	
	
	// 회원 전체조회 메서드
	public List<SignupDTO> getAllMembers() {
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		List<SignupDTO> list =null; // db테이블에 레코드가 하나도 없으면 null 로 리턴
		
		try {
			 //우리가 분리해서 만들어 놓은 메서드 호출하여 커넥션 얻어오기
			conn = getConnection();
			// 쿼리문 작성, pstmt 로 준비
			String sql = "select * from signup";
			pstmt =conn.prepareStatement(sql);
			// 실행
			rs =pstmt.executeQuery();
			// 결과 잘 정리해서
			
			// 하나의 레코드 -> DTO
			// DTO 여러개 -> ArrayList > 애를 리턴
			
			if(rs.next()) { // 쿼리문 실행한 결과가 있으면 (테이블에 레코드가 하나라도 있으면  
				list = new ArrayList<SignupDTO>(); // list 에 객체생성해주고 (list !=null)

				
				do {
				SignupDTO dto = new SignupDTO(); // dto 만들어서 rs 에서 값 꺼내 dto에 채우기
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setGender(rs.getString("gender"));
				dto.setMovies(rs.getString("movies"));
				dto.setMusic(rs.getString("music"));
				dto.setSports(rs.getString("sports"));
				dto.setTravel(rs.getString("travel"));
				dto.setJob(rs.getString("job"));
				dto.setBio(rs.getString("bid"));
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto); // list 에 dto 추가
				}
				while(rs.next());
				
			}
			// dto 들을 담아줄 arryList  준비
				
				
			
			
		} catch (Exception e) {
				e.printStackTrace();
		} finally {
			if(rs!=null) {try {rs.close();} catch (Exception e2) {e2.printStackTrace();}}
			if(pstmt!=null) {try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (Exception e2) {e2.printStackTrace();}}
			
			
			
			// close() 자원해제
		}
		// 결과물 리턴 : 메서드에서 리턴할 수 있는 값이 1개.메서드 마지막에 작성
		return list;
		
	}
	
	// 회원 한명 조회 메서드
	// 회원 정보 수정 메서드
	// 회원 정보 삭제 메서드
}
