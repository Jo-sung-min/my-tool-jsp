<%@page import="web.board.model.ImgReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.board.model.ImgReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.board.model.ImgBoardDTO"%>
<%@page import="web.board.model.ImgBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>content</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	int bno = Integer.parseInt(request.getParameter("bno")); 
	String pageNum = request.getParameter("pageNum");
	
	ImgBoardDAO dao = new ImgBoardDAO(); 
	// 글 조회수 올리기 
	dao.addReadcount(bno);   
	ImgBoardDTO article = dao.getOneArticle(bno);  
	
	// ***************************************************************************
	// 댓글 페이징 처리 
	// 페이징 처리 	
	String replyPageNum = request.getParameter("replyPageNum");
	if(replyPageNum == null){ // replyPageNum 파라미터 안넘어오면, 1페이지 보여지게 
		replyPageNum = "1";   // 1로 값 체우기 
	}
	System.out.println("replyPageNum : " + replyPageNum);
	
	int pageSize = 5;  // 현재 페이지에서 보여줄 글 목록의 수 
	int currentPage = Integer.parseInt(replyPageNum); // replyPageNum int로 형변환 -> 숫자 연산 
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize; 
	
	// 댓글 목록 가져오기 
	ImgReplyDAO replyDAO = new ImgReplyDAO();
	int count = replyDAO.getReplyCount(bno);   // 본문글의 해당하는 댓글들의 개수만 조회해오기 

	List replyList = null;
	if(count > 0) {
		// 댓글 목록 가져오기
		replyList = replyDAO.getReplies(bno, startRow, endRow); 
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
%>
<body>
	<br />
	<h1 align="center"> 글 내용 </h1>
	<table>
		<tr>
			<td colspan="2"><b><%=article.getSubject()%></b></td>
		</tr>
		<tr>
			<td colspan="2"><textarea rows="10" cols="50" readonly><%=article.getContent()%></textarea></td>
		</tr>
		<tr>
			<td colspan="2"><img src="/web/save/<%=article.getImg()%>" width="300" /></td>
		</tr>
		<tr>
			<td>
				posted by <a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a> 
				at <%=sdf.format(article.getReg())%> 
			</td>
			<td>
				<%=article.getReadcount()%> viewed
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button onclick="window.location='modifyForm.jsp?bno=<%=article.getBno()%>&pageNum=<%=pageNum%>'">수정</button>
				<button onclick="window.location='deleteForm.jsp?bno=<%=article.getBno()%>&pageNum=<%=pageNum%>'">삭제</button>
				<button onclick="window.location='list.jsp?pageNum=<%=pageNum%>'">리스트</button>
			</td>
		</tr>
	</table>
	<br />
	
	<%--- 댓글 --%>
	<%
	if(count == 0) { %>
	<table>
		<tr>
			<td colspan="4"> <b>댓  글</b> 
				<button onclick="window.location='replyForm.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'">댓글작성</button> 
			</td>
		</tr>
		<tr>
			<td> 댓글이 없습니다.</td>
		<tr>
	</table>
	
	<%}else{ %>
	
	<table>
		<tr>
			<td colspan="4"> <b>댓  글</b> 
				<button onclick="window.location='replyForm.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>'">댓글작성</button> 
			</td>
		</tr>
		<tr>
			<td>내  용</td>
			<td>작성자</td>
			<td>작성시간</td>
			<td>수정 삭제</td>
		<tr>
		<%
		for(int i = 0; i < replyList.size(); i++){
			ImgReplyDTO reply = (ImgReplyDTO)replyList.get(i); %>
			
			<tr>
				<td align="left">
					<% // 댓글의 댓글 들여쓰기 효과 주기 
					int wid = 0; 
					if(reply.getReplyLevel() > 0) { 
						wid = 12 * reply.getReplyLevel(); %>
						<img src="img/tabImg.PNG" width="<%=wid%>"/>
						<img src="img/replyImg.png" width="12" />
					<%}%>
					<%=reply.getReply()%>
				</td>
				<td><%=reply.getReplyer()%></td>
				<td><%=sdf.format(reply.getReplyReg())%></td>
				<td>
					<button onclick="window.location='replyForm.jsp?rno=<%=reply.getRno()%>&replyGrp=<%=reply.getReplyGrp()%>&replyStep=<%=reply.getReplyStep()%>&replyLevel=<%=reply.getReplyLevel()%>&bno=<%=bno%>&pageNum=<%=pageNum%>'">답글</button>
					<button onclick="window.location='replyModify.jsp?rno=<%=reply.getRno()%>&bno=<%=bno%>&pageNum=<%=pageNum%>'">수정</button>
					<button onclick="window.location='replyDeletePro.jsp?rno=<%=reply.getRno()%>&bno=<%=bno%>&pageNum=<%=pageNum%>'">삭제</button>
				</td>
			<tr>
			
		<%}%>
	</table>
	
	
	
	<%-- 댓글 목록 밑에 페이지 번호 뷰어 추가 --%>
	<br />
	<div align="center">
	<%
		if(count > 0){
			// 10페이지 번호씩 보여주겠다 
			// 총 몇페이지 나오는지 계산 -> 뿌려야되는 페이지번호 
			int pageCount = count / pageSize + (count % pageSize == 0? 0 : 1);
			int pageNumSize = 3;  // 한페이지에 보여줄 페이지번호 개수
			int startPage = (int)((currentPage-1)/pageNumSize)*pageNumSize + 1; 
			int endPage = startPage + pageNumSize - 1;
			// 전체 페이지수보다 위에 계산된 페이지 마지막번호가 더 크면 안되므로, 
			// 아래서 endPage다시 조정하기 
			if(endPage > pageCount) { endPage = pageCount; } 
			
			// 페이지 번호 뿌리기 
			
			if(startPage > pageNumSize) { %>
				<a class="pageNums" href="content.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage-1%>&bno=<%=bno%>"> &lt; &nbsp; </a>
			<%}
			
			for(int i = startPage; i <= endPage; i++){ %>
				<a class="pageNums" href="content.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=i%>&bno=<%=bno%>"> &nbsp; <%=i%> &nbsp; </a>
			<%}
			
			if(endPage < pageCount) { %>
				<a class="pageNums" href="content.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=startPage+pageNumSize%>&bno=<%=bno%>"> &nbsp; &gt; </a>
			<%}
			
		}
	%>
	</div>
	
	
<%	}// else%>

	<br /><br /><br /><br /><br />
	
	
	

</body>
</html>



