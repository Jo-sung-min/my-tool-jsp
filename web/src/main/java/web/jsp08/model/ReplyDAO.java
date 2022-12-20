package web.jsp08.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import oracle.jdbc.proxy.annotation.Pre;

public class ReplyDAO {

	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env =(Context)ctx.lookup("java:comp/env");
		DataSource ds= (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	
	//댓글 등록 처리 메서드
	public void insertReply(ReplyDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		//  새 댓글인지, 댓글의 댓글인지에 따라 조정이 필요한 값들 일단 변수에 꺼내기
		int replyNum= dto.getReplyNum(); // 새댓글 = 0 댓글의댓글 1이상
		int replyGrp = dto.getReplyGrp(); // 댓글 그룹 새댓글 1
		int replyStep = dto.getReplyStep(); // 정렬순서 새댓글 0
		int replyLevel = dto.getReplyLevel(); // 댓글의 레벨 새댓글 = 0
		int number=0;							// DB 저장된 가장 큰수 뽑아서+1해 담을 임시변수
		try {
			// 새 댓글 : replyGrp = 시퀀스로 자동으로 채워질 replyNum과 같은 수 
			// 댓글의 댓글 : replyGrp = 원본댓글의 replyNum으로 저장
			
			//>DB 상에서 가장 큰 replyNum 값을 찾아서 +1 한 다음 replyGrp 으로 사용
			// 만약 DB 에 레코드가 한개도 없으면 replyGrp 을 1로 처리
			
			conn=getConnection();
			String sql ="select max(replyNum) from replyBoard";
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				number=rs.getInt(1)+1;
			}else {
				number=1;
			}
			
		
			//댓글의 댓글일때 분기처리
			if(replyNum!=0) {
				// DB에 기존에 달린 댓글의 댓글(replyStep이 0보다큰 )이 있다면,
				// 지금 작성하는 댓글의 댓글이 1이 되기위해 
				//해당 기존 댓글의 댓글들의 step 을 +1 해라-> 최근 댓글이 위로 올라오게
				sql = "update replyBoard set replyStep=replyStep+1 where replyGrp=? and replyStep > ?";
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, replyGrp);
				pstmt.setInt(2, replyStep);
				pstmt.executeUpdate();
				// 이번에 처리해야될 댓글의 댓글 쿼리문 날리기전에,전달 받아온 값에서 +1 하여 밑에 달릭 해주기
				replyStep +=1;
				replyLevel+=1;
				System.out.println("replyLevel1 ::::"+replyLevel);
			}else {
				// 새댓글 작성일때.
				replyGrp = number;
				replyStep = 0;
				replyLevel =0;
				System.out.println("replyLevel2"+replyLevel);
			}
			 sql ="insert into replyBoard values(reply_seq.nextval,?,?,sysdate,?,?,?,?)";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, dto.getReply());
			 pstmt.setString(2, dto.getReplyer());
			 pstmt.setInt(3, dto.getBoardNum());
			 pstmt.setInt(4, replyGrp);
			 pstmt.setInt(5, replyLevel);
			 pstmt.setInt(6, replyStep);
			 
			 int result =pstmt.executeUpdate();
			 System.out.println("reply insert result: "+result);
			 
		
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e2) {e2.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
	}

	
	
	
	
	//댓글 목록 가져오기
	
	public List<ReplyDTO> getReplies(int boardNum,int start, int end){// 게시판 글 고유번호
		List<ReplyDTO> list =null;
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		
			try {
				conn =getConnection();
				// 게시판 글 하나에 해당하는 모든 댓글 가져오기
				String sql ="select B.* from"
						+ "(select rownum r, A.* from"
						+ "(select * from replyBoard where boardNum=? "
						+ "order by replyGrp desc, replyStep asc)A "
						+ "order by replyGrp desc, replyStep asc)B where r>=? and r<=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,boardNum);
				pstmt.setInt(2,start);
				pstmt.setInt(3,end);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList<ReplyDTO>();//list 객체 생성(null이 아니게됨)
					//댓글이 없으면 list=null 상태로 남아 null 리턴
					do {// 이미 커서가 내려갔기 떄문에
						ReplyDTO reply = new ReplyDTO();
						reply.setReplyNum(rs.getInt("replyNum"));
						reply.setReply(rs.getString("reply"));
						reply.setReplyer(rs.getString("replyer"));
						reply.setReplyReg(rs.getTimestamp("replyReg"));
						reply.setBoardNum(boardNum);
						reply.setReplyGrp(rs.getInt("replyGrp"));
						reply.setReplyLevel(rs.getInt("replyLevel"));
						reply.setReplyStep(rs.getInt("replyStep"));
						list.add(reply);
						
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
	
	
	// 댓글 한개 가져오기
	public ReplyDTO getOneReply(int replyNum) {
			ReplyDTO replyDTO = null;	//레코드 한줄 찾아서 리턴해줄 변수 미리 선언
			Connection conn=null;
			PreparedStatement pstmt =null;
			ResultSet rs =null;
				
			try {
				
				conn = getConnection();
				String sql = "select * from replyBoard where replyNum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, replyNum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					replyDTO = new ReplyDTO();
					
					replyDTO.setReplyNum(replyNum);
					replyDTO.setReply(rs.getString("reply"));
					replyDTO.setReplyer(rs.getString("replyer"));
					replyDTO.setReplyReg(rs.getTimestamp("replyReg"));
					replyDTO.setBoardNum(rs.getInt("boardNum"));
					replyDTO.setReplyGrp(rs.getInt("replyGrp"));
					replyDTO.setReplyLevel(rs.getInt("replyLevel"));
					replyDTO.setReplyStep(rs.getInt("replyStep"));
					
					
					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null)try {rs.close();} catch (Exception e2) {e2.printStackTrace();}
				if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
				if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
			}
	
		
		
				return replyDTO;
	}
	
	
	
	// 댓글 수정 처리 메서드
	
	public void updateReply(ReplyDTO dto) {
		Connection conn=null;
		PreparedStatement pstmt =null;
		
		try {
			conn=getConnection();
			String sql ="update replyBoard set reply=?, replyer=? where replyNum=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getReply());
			pstmt.setString(2, dto.getReplyer());
			pstmt.setInt(3, dto.getReplyNum());
			int result = pstmt.executeUpdate();
			System.out.println("reply update:"+result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
		
	}
	
	//댓글 삭제 처리 메서드
	public void deleteReply(int replyNum) {
		Connection conn=null;
		PreparedStatement pstmt =null;
		try {
			
			conn=getConnection();
			String sql = "delete from replyBoard where replyNum=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, replyNum);
			int result =pstmt.executeUpdate();
			System.out.println("delete: "+result);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();} catch (Exception e2) {e2.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e2) {e2.printStackTrace();}
		}
	}
	
	
	
	
	//게시글에 해당하는 댓글의 전체 개수 알아오기
	
	public int getReplyCount(int boardNum){
		int count = 0;
		Connection conn=null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			
			conn=getConnection();
			String sql = "select count(*) from replyBoard where boardNum=?";
			pstmt =	conn.prepareCall(sql);
			pstmt.setInt(1, boardNum);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				count =rs.getInt(1);
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
	
	
	
	
	}
	
	
	
	
	

