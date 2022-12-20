<%@page import="web.jsp08.model.ReplyDTO"%>
<%@page import="web.jsp08.model.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="style.css" rel="stylesheet" type="text/css" />
</head>


<%
	//댓글 고유 번호 
	int replyNum= Integer.parseInt(request.getParameter("replyNum"));

	String replyPageNum = request.getParameter("replyPageNum");
	String pageNum =request.getParameter("pageNum");
	
	
	
	// 아래 폼에 뿌려줄 기존 내용 DB 가서 가져오기
	ReplyDAO dao = new ReplyDAO();
	ReplyDTO replyDTO = dao.getOneReply(replyNum);


%>


<body>
<br/>
<h1 align="center">reply Modify</h1>
<form action="replyModifyPro.jsp?pageNum=<%=pageNum %>&replyPageNum=<%=replyPageNum %>" method="post">
		<input type="hidden" name="replyNum" value="<%=replyNum%>" />
		<input type="hidden" name="boardNum" value="<%=replyDTO.getBoardNum()%>" />	
		<%-- replyModifyPro에서 처리후 content 로 돌아가야하는 그때 boardNum이 필요하고,
		replyModifyPro에는 boardNum정보가 없으니, 이전페이지인 여기 replyModify에서
		미리 보내중다. --%>
		
		<table>
			<tr>
				<td>내	용</td>
				<td> <textarea rows="3" cols="40" name ="reply"><%=replyDTO.getReply() %></textarea> </td>
			</tr>			
			<tr>	
				<td>작성자 </td>
				<td align="left"> <input type="text" name="replyer"  value="<%=replyDTO.getReplyer()%>">  </td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<input type="submit" value="댓글저장"/>
					<input type="button" value="취소" onclick="history.go(-1)"/>
				</td>
			</tr>
		</table>
</form>



</body>
</html>