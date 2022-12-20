<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.jsp08.model.BoardDTO"%>
<%@page import="web.jsp08.model.BoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>



<%
//현재 요청된 게시판 페이지 번호
String pageNum=request.getParameter("pageNum");
if(pageNum==null){// pageNum 파라미터가 안넘어왔을떄는(../jsp08/list.jsp 라고만 요청했을떄)
	pageNum="1";// 1페이지 보여주기 위해 pageNum 값을 1 로채워주기
	
}
 System.out.println("pageNum:"+pageNum);
//현재 페이지에서 보여줄 게시글의 시작과 끝 등의 정보세팅
int pageSize=3;							// 한페이지에 보여줄 게시글의 개수
int currentPage= Integer.parseInt(pageNum); // 연산을 위해 pageNum을 숫자로 형변환

int startRow = (currentPage-1) * pageSize + 1; // DB에서 잘라올 페이지 시작글 번호
int endRow = currentPage * pageSize;			//DB에서 잘라올 페이지 마지막 글 번호
System.out.println("startRow"+startRow);
System.out.println("endRow"+endRow);
//작성시간 원하는 형태로 화면에 출력하기 위한 보조 클래스 객체 생성
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm");


BoardDAO dao = new BoardDAO();
//DB에서 전체 글 개수 가져오기 //글 작성이후에 가져오는것
int count =  dao.getArticleCount();
System.out.println(count);



List<BoardDTO> list=null;// 글 가져올 변수 미리선언
if(count>0){// db에 저장된 게시글이 한개이상 있으면
//목록에 보여줄 게시글 가져오기, 게시글이 하나도 없으면 굳이 가져올 필요없다.
	//list= dao.getAllArticles();// 버젼1(페이징처리 x)
	list=dao.getArticleList(startRow, endRow);//버젼2
	

}

int number = count - (currentPage-1) * pageSize; // 화면에 뿌려줄 글 번호(DB 상 글 고유번호 아님)

%>


<body>
<br/>
<h1 align="center">게시판</h1>	

<%
if(count==0){%>
	
	
	<table>
			<tr>
				<td colspan="5" align="left"> 
					<button onclick="window.location='writeForm.jsp'">글작성</button> 
				</td>
			</tr>
			<tr>
				<td>게시글이 없습니다.</td>
			</tr>	
	</table>
	
<%}else{%>
<table>
	<tr>
		<td colspan="5" align="left"> 
			<button onclick="window.location='writeForm.jsp'">글작성</button> 
		</td>
	</tr>
	
	<tr>
		<td>No.</td>
		<td>제	목</td>
		<td>작성자</td>
		<td>시	간</td>
		<td>조회수</td>
	</tr>
	
	<%
	for(int i = 0;i< list.size(); i++){
		BoardDTO article =list.get(i);// 글 한개 레코드 추출
		//한개의 글에대한 정보를 td 에 출력 %>
		
	<tr>
		<td><%=number-- %></td>
		<%--제목 a태그로 묶어 클릭(이동)할 수 있게 하고, 
		href에는 content.jsp 와 클릭한 글의DB상 글 고유번호 파리마터로 전달 
		contect.jsp 에서는 넘어온 글 고유번호 받아서 DB에 
		접근해 해당 글 하나만 가져와 화면에 뿌려준다--%>
		<td> <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>"><%=article.getSubject() %></a> </td>
		<td> <a href="mailto:<%=article.getEmail()%>"><%=article.getWriter() %></a> </td>
		<td><%=sdf.format(article.getReg())%></td>
		<td><%=article.getReadcount() %></td>
	</tr>
		
	
	<%}//for%>

</table>

<% }//else(count==0)%>

<%--게시글 목록 밑에 페이지 번호 뷰어 추가 --%>
<br/>
<div align="center">
	<%
		if(count>0){
			//10페이지 번호씩 보여주겠다.
			// 총 몇페이지 나오는지 계산-> 뿌려야 되는 페이지번호 
			int pageCount = count / pageSize+ (count % pageSize==0? 0: 1);
			int pageNumSize =3; // 한 페이지에 보여줄 페이지 번호 개수
			int startPage = (int)((currentPage-1) / pageNumSize) * pageNumSize +1;
			int endPage= startPage+ pageNumSize-1;

			
			//전체 페이지수보다 위에 계산된 페이지 마지막 번호가 더 크면안되므로.
			//아래서 endPage 다시 조정하기
			if(endPage>pageCount){endPage= pageCount;}
				
			System.out.println("pageCount : "+pageCount);
			System.out.println("startPage : "+startPage);
			System.out.println("endPage : "+endPage);
			
			
			//페이지 번호 뿌리기
			if(startPage> pageNumSize){%>
			<a class="pageNums" href="list.jsp?pageNum=<%=startPage-1 %>"> &lt; &nbsp; </a>
			
			<%}
			
			for(int i = startPage; i <=endPage; i++){%>
			<a class="pageNums" href="list.jsp?pageNum=<%=i %>"> &nbsp;<%=i %> &nbsp; </a>			
			
			<%}
			
			if(endPage<pageCount){%>
				<a class="pageNums" href="list.jsp?pageNum=<%=startPage+pageNumSize %>"> &nbsp; &gt; </a>
			<%}
			
			
		}
	
	%>



</div>







</body>
</html>