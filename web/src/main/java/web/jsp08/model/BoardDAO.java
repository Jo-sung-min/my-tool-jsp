package web.jsp08.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	//커넥션 만들어 리턴해주는 메서드
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env =(Context)ctx.lookup("java:comp/env");
		DataSource ds= (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
//글 작성 처리 메서드
	public void insertArticle(BoardDTO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn=getConnection();
			String sql ="insert into board values(board_seq.nextval,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getEmail());
			pstmt.setString(4, article.getContent());
			pstmt.setString(5, article.getPw());
			pstmt.setTimestamp(6, article.getReg());
			pstmt.setInt(7, article.getReadcount());
			
			int result =pstmt.executeUpdate();
			System.out.println(result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
	}
	
	
	//글 꺼내주는 메서드
	public List<BoardDTO> getAllArticles() {
		List<BoardDTO> list =null;
		Connection conn= null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		
		try {
			conn=getConnection();
			String sql="select * from board order by reg desc";
			pstmt= conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			list = new ArrayList<BoardDTO>();// 저장공간 만들고
			
			while(rs.next()) {
				BoardDTO article = new BoardDTO(); 
				// 레코드 하나 담을 article  반복할때마다 새로만들기
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setContent(rs.getString("content"));
				article.setSubject(rs.getString("subject"));
				article.setEmail(rs.getString("email"));
				article.setPw(rs.getString("pw"));
				article.setReg(rs.getTimestamp("reg"));
				article.setReadcount(rs.getInt("readcount"));
				list.add(article);
			}//while
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e2) {e2.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
		
		
		return list;
		
	}
	
	
	// 전체 글 개수 리턴해주는 메서드 버전1
	public int getArticleCount() {
		Connection conn= null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				count =rs.getInt(1);// 1번 컬럼에 있는값 꺼내서 준비해둔 변수에 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e2) {e2.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
		return count;
	}
	
	// 게시글 가져오기 페이징 처리 된것
	public List<BoardDTO> getArticleList(int start, int end) {
		List<BoardDTO> list= null;
		Connection conn= null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select B.* from (select rownum r, A.* from "
		               + "(select * from board order by reg desc) A ) B "
		               + "where r >= ? and r <= ?";//r은 고유번호
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList<BoardDTO>();
				do {
					BoardDTO article = new BoardDTO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setContent(rs.getString("content"));
					article.setEmail(rs.getString("email"));
					article.setPw(rs.getString("pw"));
					article.setReg(rs.getTimestamp("reg"));
					article.setReadcount(rs.getInt("readcount"));
					list.add(article);
					
				}while(rs.next());
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e2) {e2.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
		return list;
	}
	
	
	// 1.글 하나 가져오기 
	public BoardDTO getArticle(int num) {
		BoardDTO article = null;
		Connection conn= null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		
		
		try {
			conn= getConnection();
			String sql ="select * from board where num=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardDTO();// 결과가 있으면 메모리 점유해서 저장할 공간 준비
				article.setNum(num);
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setEmail(rs.getString("email"));
				article.setPw(rs.getString("pw"));
				article.setReg(rs.getTimestamp("reg"));
				article.setReadcount(rs.getInt("readcount"));
				
			}
		} catch (Exception e) {
			 e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e2) {e2.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
		
		return article;
	}
	
	
	
	//1.조회수 올려주는 메서드
	public void updateReadcount(int num){
		Connection conn= null;
		PreparedStatement pstmt = null;
		
		try {
			
			conn= getConnection();
			String sql ="update board set readcount=readcount+1 where num=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			int result =pstmt.executeUpdate();
			System.out.println(result);
					
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
		
	}

	
	//2 게시글 수정 처리 메서드
	public int updateArticle(BoardDTO article) {
		int result=-1;
		String dbpw="";	
		Connection conn= null;
		PreparedStatement pstmt=null;
		ResultSet  rs =null;
		
		try {
			conn =getConnection();
			//비밀번호 맞는지 체크하고.
			String sql = "select pw from board where num=?";
			pstmt=	conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs =pstmt.executeQuery();
			
			if(rs.next()) {
				dbpw=rs.getString("pw");
				if(dbpw.equals(article.getPw())) {// db 상의 pw 와 사용자가 입력한 pw 가같은지
					
					//맞으면 update
					 sql = "update board set subject=?,writer=?,content=?,email=? where num=?";
					 pstmt = conn.prepareStatement(sql);
					 pstmt.setString(1, article.getSubject());
					 pstmt.setString(2, article.getWriter());
					 pstmt.setString(3, article.getContent());
					 pstmt.setString(4, article.getEmail());
					 pstmt.setInt(5, article.getNum());
					 result = pstmt.executeUpdate(); // 1개 레코드가 잘 수정되면 1 리턴됨
					 
				}else {// 비번 불일치
					result =0;
				}
			}
				System.out.println("update처리 : "+result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e2) {e2.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
		
		
		return result;
	}

	
	
	
	
	
	// 삭제처리
	public int deleteArticle(int num,String pw) {
		int result= -1;
		String dbpw="";
		Connection conn= null;
		PreparedStatement pstmt=null;
		ResultSet  rs =null;
				
		try {
			conn=getConnection();
			//비밀번호 맞는지 체크하고.
			String sql = "select pw from board where num=?";
			pstmt=	conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs =pstmt.executeQuery();
			if(rs.next()) {
				dbpw=rs.getString("pw");
				if(dbpw.equals(pw)) {
					//맞으면 삭제
					sql="delete from board where num=?";
					pstmt= conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					result= pstmt.executeUpdate();
				
				}else {
					//비번틀리면 삭제 안함
					result=0;
				} 
			}
				System.out.println("delete result: "+result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e2) {e2.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
		
		return result;
	}
	
	
	
	
	
}
