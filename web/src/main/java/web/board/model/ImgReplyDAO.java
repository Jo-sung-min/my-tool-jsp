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

public class ImgReplyDAO {

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 본문글에 해당하는 댓글의 개수 조회 
	public int getReplyCount(int bno) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from imgReply where bno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
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
	
	// 본문에해당하는 댓글들 가져오기 (페이징처리까지) 
	public List getReplies(int bno, int start, int end) {
		List replyList = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select A.*, rownum r from "
					+ "(select * from imgReply where bno = ? "
					+ "order by replyGrp desc, replyStep asc) A "
					+ "order by replyGrp desc, replyStep asc) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				replyList = new ArrayList(); 
				do {
					ImgReplyDTO reply = new ImgReplyDTO(); 
					reply.setBno(bno);
					reply.setRno(rs.getInt("rno"));
					reply.setReply(rs.getString("reply"));
					reply.setReplyer(rs.getString("replyer"));
					reply.setReplyGrp(rs.getInt("replyGrp"));
					reply.setReplyLevel(rs.getInt("replyLevel"));
					reply.setReplyStep(rs.getInt("replyStep"));
					reply.setReplyReg(rs.getTimestamp("replyReg"));
					replyList.add(reply);
				}while(rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return replyList;
	}
	
	// 댓글 등록 처리 
	public void insertReply(ImgReplyDTO dto) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		// 새댓글, 댓글의 댓글인지에 따라 조정이 필요한 값들 미리 뽑아 놓기 
		int rno = dto.getRno(); 				// 새 댓글  = 0, 댓글의 댓글 = 1 이상
		int replyGrp = dto.getReplyGrp(); 		// 1			 1이상 
		int replyLevel = dto.getReplyLevel(); 	// 0			 
		int replyStep = dto.getReplyStep();		// 0
		int number = 0; 						// replyGrp 체워줄때 필요한 임시변수
		try {
			conn = getConnection(); 
			String sql = "select max(rno) from imgReply";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			if(rs.next()) number = rs.getInt(1) + 1; //댓글이 있고, 가장 큰번호 
			else number = 1; // 댓글이 하나도 없을 경우 
			
			// 댓글의 댓글 
			if(rno != 0) {
				sql = "update imgReply set replyStep=replyStep+1 where replyGrp=? and replyStep > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, replyGrp);
				pstmt.setInt(2, replyStep);
				pstmt.executeUpdate();
				
				// insert 날리기위해 1씩 증가해주기
				replyStep += 1; 
				replyLevel += 1;
			}else { // 새댓글 
				replyGrp = number;
				replyStep = 0; 
				replyLevel = 0; 
			}

			sql = "insert into imgReply(rno,reply,replyer,bno,replyGrp,replyLevel,replyStep) ";
			sql += "values(imgReply_seq.nextval,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getReply());
			pstmt.setString(2, dto.getReplyer());
			pstmt.setInt(3, dto.getBno());
			pstmt.setInt(4, replyGrp);
			pstmt.setInt(5, replyLevel);
			pstmt.setInt(6, replyStep);
			
			int result = pstmt.executeUpdate(); 
			System.out.println("insert result : " + result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	// 댓글 하나 가져오기 
	public ImgReplyDTO getOneReply(int rno) {
		ImgReplyDTO reply = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select * from imgReply where rno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rno);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				reply = new ImgReplyDTO(); 
				reply.setRno(rno);
				reply.setReply(rs.getString("reply"));
				reply.setReplyer(rs.getString("replyer"));
				reply.setReplyGrp(rs.getInt("replyGrp"));
				reply.setReplyLevel(rs.getInt("replyLevel"));
				reply.setReplyStep(rs.getInt("replyStep"));
				reply.setReplyReg(rs.getTimestamp("replyReg"));
				reply.setBno(rs.getInt("bno"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return reply;
	}
	
	// 댓글 수정 
	public void updateReply(int rno, String reply) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "update imgReply set reply=? where rno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reply);
			pstmt.setInt(2, rno);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		
	}
	
	// 댓글 삭제 
	public void deleteReply(int rno) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "delete from imgReply where rno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rno);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	
	
	
	
}
