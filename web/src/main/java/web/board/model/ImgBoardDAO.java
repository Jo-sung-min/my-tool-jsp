package web.board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ImgBoardDAO {

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 게시글 등록 메서드 
	public void insertArticle(ImgBoardDTO article) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "insert into imgBoard(bno, writer, subject, content, img, email, bpw) ";
			sql += "values(imgBoard_seq.nextval,?,?,?,?,?,?)"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getContent());
			pstmt.setString(4, article.getImg());
			pstmt.setString(5, article.getEmail());
			pstmt.setString(6, article.getBpw());
			
			int updateCount = pstmt.executeUpdate(); 
			System.out.println("insert update count : " + updateCount);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	// 전체 글의 개수 카운팅 메서드 
	public int getArticleCount() {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from imgBoard";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count; 
	}
	
	// 해당 페이지에 띄워줄 글 가져오기 
	public List getArticles(int start, int end) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from imgBoard order by reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					ImgBoardDTO article = new ImgBoardDTO(); 
					article.setBno(rs.getInt("bno"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setContent(rs.getString("content"));
					article.setImg(rs.getString("img"));
					article.setEmail(rs.getString("email"));
					article.setBpw(rs.getString("bpw"));
					article.setReg(rs.getTimestamp("reg"));
					article.setReadcount(rs.getInt("readcount"));
					list.add(article);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return list;
	}
	
	// 검색한 글의 총 개수 
	public int getArticleSearchCount(String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from imgBoard where "+sel+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}
	
	// 검색한 글 목록 가져오는 메서드 
	public List getArticlesSearch(int start, int end, String sel, String search) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from imgBoard where "+sel+" like '%"+search+"%'"
					+ " order by reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					ImgBoardDTO article = new ImgBoardDTO(); 
					article.setBno(rs.getInt("bno"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setContent(rs.getString("content"));
					article.setImg(rs.getString("img"));
					article.setEmail(rs.getString("email"));
					article.setBpw(rs.getString("bpw"));
					article.setReg(rs.getTimestamp("reg"));
					article.setReadcount(rs.getInt("readcount"));
					list.add(article);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return list; 
	}
	
	// 글 한개 가져오기 
	public ImgBoardDTO getOneArticle(int bno) {
		ImgBoardDTO article = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select * from imgBoard where bno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				article = new ImgBoardDTO(); 
				article.setBno(bno);
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setImg(rs.getString("img"));
				article.setReadcount(rs.getInt("readcount"));
				article.setReg(rs.getTimestamp("reg"));
				article.setBpw(rs.getString("bpw"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return article;
	}
	// 조회수 올리기 
	public void addReadcount(int bno) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "update imgBoard set readcount=readcount+1 where bno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			int result = pstmt.executeUpdate(); 
			System.out.println("update count : " + result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	// 글 수정 처리 
	public int updateArticle(ImgBoardDTO article) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from imgBoard where bno=? and bpw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getBno());
			pstmt.setString(2, article.getBpw());
			
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { // 결과 가져왔다 -> 비밀번호 맞으면 
				sql = "update imgBoard set subject=?, content=?, email=?, img=? where bno=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, article.getSubject());
				pstmt.setString(2, article.getContent());
				pstmt.setString(3, article.getEmail());
				pstmt.setString(4, article.getImg());
				pstmt.setInt(5, article.getBno());
				
				result = pstmt.executeUpdate(); 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return result;
	}
	
	// 글 삭제 
	public int deleteArticle(int bno, String bpw) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from imgBoard where bno=? and bpw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setString(2, bpw);
			
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { // 결과 가져왔다 -> 비밀번호 맞으면 
				sql = "delete from imgBoard where bno=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bno);
				
				result = pstmt.executeUpdate(); 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return result; 
	}
	
	
	
	
	
	
}
