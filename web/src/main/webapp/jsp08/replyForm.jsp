<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>replyForm.jsp</title>
   <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	//boardNum 은 새글이건, 댓극의 댓글이건 역서 채움
   int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	String replyPageNum = request.getParameter("replyPageNum");
	String pageNum =request.getParameter("pageNum");
	
	
   // replyBoard 테이블에 들어가야할 데이터를 초기화해서 // content 에서 boardNum= num 하는곳있음
   // hidden 태그로 같이 보내기. 
  	 int replyNum = 0, replyGrp = 1, replyStep = 0, replyLevel = 0; 
   // 새 댓글 = replyNum 0, 댓글의 댓글 = replyNum이 1이상 
   
		   
	//댓글의 댓글일 경우 체크해서 위변수들 조정(replyNum~replyLevel)
	//새댓글 = replyNum 파라미터가 안넘어오므로 null 이고
	//댓글의 댓글 = replyNum 파라미터가 넘어오므로 null 이 아니다.
	//content 에서 볼때 답글을 누를때만 replyNum이 넘어온다.
	if(request.getParameter("replyNum")!=null){
		//넘어온 파라미터 값들 다시 변수에 채워주기
		replyNum = Integer.parseInt(request.getParameter("replyNum"));
		replyGrp =Integer.parseInt(request.getParameter("replyGrp"));
		replyStep =Integer.parseInt(request.getParameter("replyStep"));
		replyLevel =Integer.parseInt(request.getParameter("replyLevel"));
	}
	
		   
%>
<body>
   <br />
   <h1 align="center"> Reply Form </h1>
   <form action="replyPro.jsp?pageNum=<%=pageNum%>&replyPageNum=<%=replyPageNum%>" method="post">
      <input type="hidden" name="boardNum" value="<%=boardNum%>" />
      <input type="hidden" name="replyNum" value="<%=replyNum%>" />
      <input type="hidden" name="replyGrp" value="<%=replyGrp%>" />
      <input type="hidden" name="replyStep" value="<%=replyStep%>" />
      <input type="hidden" name="replyLevel" value="<%=replyLevel%>" />
      <table>
         <tr>
            <td>내 용</td>
            <td><textarea rows="3" cols="40" name="reply"></textarea>  </td>
         </tr>
         <tr>
            <td>작성자</td>
            <td align="left"><input type="text" name="replyer" /> </td>
         </tr>
         <tr>
            <td colspan="2" align="left">
               <input type="submit" value="댓글저장" /> 
               <input type="button" value="취소" onclick="window.location='content.jsp?pageNum=<%=pageNum%>&num=<%=boardNum%>'" />
            </td>
         </tr>
      </table>
   </form>

   
</body>
</html>