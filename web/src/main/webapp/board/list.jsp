<%@page import="web.board.model.ImgBoardDTO"%>
<%@page import="web.board.model.ImgBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판 목록</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	// 페이징 처리 	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){ // pageNum 파라미터 안넘어오면, 1페이지 보여지게 
		pageNum = "1";   // 1로 값 체우기 
	}
	System.out.println("pageNum : " + pageNum);
	
	int pageSize = 5;  // 현재 페이지에서 보여줄 글 목록의 수 
	int currentPage = Integer.parseInt(pageNum); // pageNum을 int로 형변환 -> 숫자 연산 
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize; 

	// 게시글 가져오기 
	// 전체 글의 개수 구하고, 
	ImgBoardDAO dao = new ImgBoardDAO(); 
	
	int count = 0; 				// (전체/검색) 전체 글 개수 담을 변수 
	List articleList = null; 	// (전체/검색) 글 목록 리턴받을 변수 
		
	// 검색 여부 판단 
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 
	if(sel != null && search != null) { // 검색일때 
		count = dao.getArticleSearchCount(sel, search);  // 검색에 맞는 게시글에 개수 가져오기 
		if(count > 0) {
			// 검색한 글 목록 가져오기 
			articleList = dao.getArticlesSearch(startRow, endRow, sel, search); 
		}
	}else { // 일반 게시판일때 
		count = dao.getArticleCount();  // 그냥 전체 게시글 개수 가져오기
		// 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
		if(count > 0){
			articleList = dao.getArticles(startRow, endRow); 
		}
	}
	System.out.println("article count : " + count);
	System.out.println(articleList);
	
	
	int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm"); 
	
%>
<body>
	<br />
	<h1 align="center"> 게시판 </h1>
	<% if(count == 0){ // 글이 없으면  %>
		<table>
			<tr>
				<td colspan="5"><button onclick="window.location='writeForm.jsp'">글작성</button></td>
			</tr>
			<tr>
				<td colspan="5">게시글이 없습니다.</td>
			</tr>
		</table>
	<%	}else { // 글이 하나라도 있으면 %> 
	
		<table>
			<tr>
				<td colspan="5"><button onclick="window.location='writeForm.jsp'">글작성</button></td>
			</tr>
			<tr>
				<td>No.</td>
				<td>제  목</td>
				<td>작성자</td>
				<td>작성시간</td>
				<td>조회수</td>
			</tr>
			<%-- 게시글 목록 반복해서 뿌리기 tr-td묶음 --%>
			<%
			for(int i = 0; i < articleList.size(); i++){
				// List에 제네릭타입을 지정안했기때문에 get()으로 꺼내면 Object타입으로 리턴해줌. 
				// DTO로 우리가 list에 추가해 이미 DTO타입을 알기때문에 바로 형변환해서 변수에 담아주자.
				ImgBoardDTO article = (ImgBoardDTO)articleList.get(i);  %>
				
				<tr>
					<td><%=number--%></td>
					<td align="left">
						<a href="content.jsp?bno=<%=article.getBno()%>&pageNum=<%=pageNum%>">
							<img src="/web/save/<%=article.getImg()%>" width="40" />
							<%= article.getSubject() %>
						</a>
					</td>
					<td>
						<a href="mailto:<%=article.getEmail()%>"> 
							<%= article.getWriter() %> 
						</a>
					</td>
					<td><%= sdf.format(article.getReg()) %></td>
					<td><%= article.getReadcount() %></td>
				</tr>
			<%} %>
		</table>
		
	<%	}//else %>
	
	
	<br />
	<%-- 게시판 목록 페이지 번호 뷰어 --%>
	<div align="center">
	<% if(count > 0) { 
		// 한페이지에 보여줄 번호의 개수 
		int pageNumSize = 5; 
		// 총 몇페이지 나오는지 계산 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		// 현재 페이지에 띄울 첫번째 페이지 번호 
		int startPage = ((currentPage - 1) / pageSize) * pageNumSize + 1; 
		// 현재 페이지에 띄울 마지막 페이지번호  (startPage ~ endPage까지 번호 반복해서 뿌릴)
		int endPage = startPage + pageNumSize - 1; 
		if(endPage > pageCount) { endPage = pageCount; } // 마지막 페이지번호 조정 

		if(startPage > pageNumSize) { 
			if(sel != null && search != null) { %>
				<a class="pageNums" href="list.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
			<%}else{%>
				<a class="pageNums" href="list.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
			<%}
		}
		
		for(int i = startPage; i <= endPage; i++) { 
			if(sel != null && search != null) { %>
				<a class="pageNums" href="list.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
			<%}else{ %>
				<a class="pageNums" href="list.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
			<%} 
		}
		
		if(endPage < pageCount) { 
			if(sel != null && search != null) { %>
				<a class="pageNums" href="list.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
		<%	}else{ %>
				<a class="pageNums" href="list.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
		<%	}
		} 
		
		}//if count > 0 %>
		<br /><br />
		
		<%-- 작성자/내용 검색 --%>
		<form action="list.jsp">
			<select name="sel">
				<option value="writer" selected>작성자</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="search" /> 
			<input type="submit" value="검색" />
		</form>
		<br />
		
		<button onclick="window.location='list.jsp'"> 전체 게시글 </button>
	
	</div>
	
	
	
	
	

</body>
</html>



