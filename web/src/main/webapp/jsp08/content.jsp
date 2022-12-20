<%@page import="web.jsp08.model.ReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.jsp08.model.ReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.jsp08.model.BoardDTO"%>
<%@page import="web.jsp08.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>글 본문</title>
   <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
   // list에서 제목클릭해 넘어올때 같이 넘겨준 DB상 글 고유번호 num 파라미터 꺼내기 
   int num = Integer.parseInt(request.getParameter("num")); 
   String pageNum = request.getParameter("pageNum"); 
   
   
   // 위 글 고유번호 주고, DB에서 글 하나에 해당하는 정보가져옴 -> BoardDTO
   BoardDAO dao = new BoardDAO(); 
   BoardDTO article = dao.getArticle(num); 
   dao.updateReadcount(num);  // 조회수 하나 올려주는 메서드  

   // 댓글 페이징처리 
   // 현재 요청된 게시판 페이지 번호 
   String replyPageNum = request.getParameter("replyPageNum"); 
   if(replyPageNum == null || replyPageNum.equals("null") || replyPageNum.equals(" ")){ 
      replyPageNum = "1";   // 1페이지 보여주기위해 replyPageNum 값 "1"로 체워주기 
   }
   
   System.out.println("replyPageNum : " + replyPageNum);

   // 현재 페이지에서 보여줄 게시글의 시작과 끝 등의 정보 세팅
   int pageSize = 5;                          // 한페이지에 보여줄 게시글의 개수 
   int currentPage = Integer.parseInt(replyPageNum);    // 연산을 위해 pageNum을 숫자로 형변환
   int startRow = (currentPage -1) * pageSize + 1; // DB에서 잘라올 페이지 시작글 번호 
    int endRow = currentPage * pageSize; // DB에서 잘라올 페이지 마지막 글 번호 
   System.out.println("startRow : " + startRow);
   System.out.println("endRow : " + endRow);
   
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
   // 해당 게시글의 전체 댓글수 긁어오기 
   ReplyDAO replyDAO = new ReplyDAO(); 
   int count = replyDAO.getReplyCount(article.getNum()); // 해당 게시글 고유번호 주기  
   
   // 댓글 목록 DB에서 가져오기 (댓글의 개수가 0보다 크면)
   List<ReplyDTO> replyList = null; 
   if(count > 0){
      replyList = replyDAO.getReplies(num, startRow, endRow);
   }
   
%>
<body>
   <br />
   <h1 align="center"> Content </h1>
   <table>
      <tr>
         <td colspan="2"> <%= article.getSubject() %></td>
      </tr>
      <tr>
         <td colspan="2"> <textarea cols="50" rows="5" disabled><%= article.getContent() %></textarea> </td>
      </tr>
      <tr>
         <td> posted by 
            <a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a> 
            at <%= sdf.format(article.getReg()) %>
         </td>
         <td> <%=article.getReadcount() %> viewed </td>
      </tr>
      <tr>
         <td colspan="2"> 
            <button onclick="window.location='modifyForm.jsp?num=<%=num%>&pageNum<%=pageNum%>'">수정</button>
            <button onclick="window.location='deleteForm.jsp?num=<%=num%>&pageNum<%=pageNum%>'">삭제</button>
            <button onclick="window.location='list.jsp?pageNum=<%=pageNum%>'">리스트</button>
         </td>
      </tr>
   </table>

   <br /><br />
   <%-- 댓글 list 보여주기 --%>
   <%
   if(replyList == null){ // 댓글 없음 %>
   
   <table>
      <tr>
         <td colspan="3"> <b>댓  글</b> 
            <button onclick="window.location='replyForm.jsp?boardNum=<%=num%>&pageNum=<%=pageNum%>'">댓글작성</button> 
         </td>
      </tr>
      <tr>
         <td>댓글이 없습니다.</td>
      </tr>
   </table>
      
<%   }else{ // 댓글 있다. %>
      
   <table>
      <tr>
         <td colspan="4"> <b>댓  글</b> 
            <button onclick="window.location='replyForm.jsp?boardNum=<%=num%>&pageNum=<%=pageNum%>'">댓글작성</button> 
         </td>
      </tr>
      <tr>
         <td>내  용</td>
         <td>작성자</td>
         <td>작성시간</td>
         <td>수정 삭제</td>
         <td>Num / Grp / Step / Level</td>
      <tr>
      <%-- 댓글 있는만큼 반복해서 tr묶음 뿌리기 --%>
      <%
      for(int i = 0; i < replyList.size(); i++){
         ReplyDTO dto = replyList.get(i); %>
         
         <tr>
            <td align="left">
               <% //댓글내용에 들여쓰기 효과추가
                  int wid = 0; 
                  if(dto.getReplyLevel() > 0){
                     wid = 12 * (dto.getReplyLevel()); %>
                  <img src="img/tabImg.PNG" width="<%=wid%>" />   
                  <img src="img/replyImg.png" width="11" />                        
               <%   }%>
               <%= dto.getReply() %>
            </td>
            <td><%= dto.getReplyer() %></td>
            <td><%= sdf.format(dto.getReplyReg()) %></td>
            <td>
               <button onclick="window.location='replyForm.jsp?&pageNum=<%=pageNum%>&replyPageNum=<%=replyPageNum%>&replyNum=<%=dto.getReplyNum()%>&replyGrp=<%=dto.getReplyGrp()%>&replyStep=<%=dto.getReplyStep()%>&replyLevel=<%=dto.getReplyLevel()%>&boardNum=<%=dto.getBoardNum()%>'">답글</button>
               <button onclick="window.location='replyModify.jsp?&pageNum=<%=pageNum%>&replyPageNum=<%=replyPageNum%>&replyNum=<%=dto.getReplyNum()%>'">수정</button>
               <button onclick="window.location='replyDeletePro.jsp?&pageNum=<%=pageNum%>&replyPageNum=<%=replyPageNum%>&replyNum=<%=dto.getReplyNum()%>&boardNum=<%=num%>'">삭제</button>
            </td>
            <td>
               <%=dto.getReplyNum()%> / <%=dto.getReplyGrp()%> / <%=dto.getReplyStep()%> / <%=dto.getReplyLevel()%>
            </td>
         <tr>
			         
      <%} // for %>
      
   
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
         System.out.println("pageCount : " + pageCount);
         System.out.println("startPage : " + startPage);
         System.out.println("endPage : " + endPage);
         
         // 페이지 번호 뿌리기 
         
         if(startPage > pageNumSize) { %>
            <a class="pageNums" href="content.jsp?&pageNum=<%=pageNum%>&replyPageNum=<%=startPage-1%>&num=<%=num%>"> &lt; &nbsp; </a>
         <%}
         
         for(int i = startPage; i <= endPage; i++){ %>
            <a class="pageNums" href="content.jsp?&pageNum=<%=pageNum%>&replyPageNum=<%=i%>&num=<%=num%>"> &nbsp; <%=i%> &nbsp; </a>
         <%}
         
         if(endPage < pageCount) { %>
            <a class="pageNums" href="content.jsp?&pageNum=<%=pageNum%>&replyPageNum=<%=startPage+pageNumSize%>&num=<%=num%>"> &nbsp; &gt; </a>
         <%}
         
      }
   %>
   </div>
   
   
<%}%>

   <br /><br /><br /><br /><br />

</body>
</html>



