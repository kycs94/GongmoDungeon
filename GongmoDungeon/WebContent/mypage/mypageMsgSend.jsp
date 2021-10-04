<%@page import="team04.project.mypage.MsgDTO"%>
<%@page import="team04.project.mypage.MypageDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<jsp:useBean id="dto" class="team04.project.mypage.MsgDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%if(session.getAttribute("nid") != null){ %>

<% 
	// 보낸 쪽지함
	// 세션 id
	String id = (String)session.getAttribute("nid");

	// 쪽지 가져오기
	MypageDAO dao = MypageDAO.getInstance();
	int count = dao.SendMsgGetCount(id);
	
	// 페이징 처리
	int pageSize = 5;
	
	// 현재 페이지 번호
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	// 현재 페이지에 보여줄 게시글 시작과 끝
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	// if문 전에 미리 선언
	List articlelist = null;
	
	int number = 1;
%>

<body>
<!-- 전체 -->
<div class="wrap">
	
<!-- 헤더블럭 -->
<%@ include file="../common/header.jsp" %>
	
<!-- 컨텐츠블럭 -->
<div class="container">
<%@ include file="/mypage/mypageLeft.jsp" %>
	<h1>쪽지함</h1>
	<hr>
	
	<button onclick="window.location='mypageMsg.jsp'">받은 쪽지함</button> <button> 보낸 쪽지함 </button>
	
	
	<h3>보낸 쪽지함</h3>
	<%if(count > 0) { %>
	<table border="1" style="border-collapse:collapse";>
		<tr align="center" width="700" height="50">
			<td>No. </td>
			<td>받은 사람</td>
			<td>내	용</td>
			<td>보낸 날짜</td>
		</tr>
		<%articlelist = dao.SendMsgGetArticles(startRow, endRow, id);
		for(int i = 0; i < articlelist.size(); i++) {
			MsgDTO article = (MsgDTO)articlelist.get(i);
		%>
		<tr align="center" width="700" height="50">
			<td><%= number++ %></td>
			<td><%=article.getMsg_rid() %></td>
			<td><%=article.getMsg_content() %></td>
			<td><%=article.getMsg_reg() %></td>
		</tr>
	<%	}
	%>
	</table>
	<%}else{ %>
		<br/>
		보낸 메세지가 없습니다.
	<%} %>
	<%-- 페이지 번호 --%>
	<div align="center">
	<%if(count > 0) {
		// 페이지 번호 몇개 지정
		int pageBlock = 5;
		// 총 페이지
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		// 현재 페이지에서 보여줄 첫번째 페이지 번호
		int startPage = (int)((currentPage-1)/pageBlock) * pageBlock + 1;
		// 현재 페이지에서 보여줄 마지막 페이지 번호
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > pageBlock) { %>
			<a href="mypageMsgSend.jsp?pageNum=<%=startPage-pageBlock %>" class="pageNums"> &lt; &nbsp;</a>
		<%}
		
		// 페이지 번호 뿌리기
		for(int i = startPage; i <= endPage; i++) { %>
			<a href="mypageMsgSend.jsp?pageNum=<%=i%>" class="pageNum"> &nbsp; <%=i %> &nbsp; </a>
		<%}
		
		// <
		if(endPage < pageCount) { %>
			&nbsp; <a href="mypageMsgSend.jsp?pageNum=<%=startPage+pageBlock%>" class="pageNums"> &gt; </a>
		<%}
	}%>
	
	
	</div>
	
<%}else{ %>
	<script>
		alert("일반 회원만 접근 가능합니다.");
		history.go(-1);
	</script>
<%} %>
<!-- 풋터블럭 -->
<%@ include file="../common/footer.jsp" %>
</div>
</div> 
</body>
</html>