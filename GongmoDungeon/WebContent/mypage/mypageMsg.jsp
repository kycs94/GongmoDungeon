<%@page import="team04.project.mypage.MsgDTO"%>
<%@page import="team04.project.mypage.MypageDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>쪽지함</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
</head> 
<jsp:useBean id="dto" class="team04.project.mypage.MsgDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%if(session.getAttribute("nid") != null){ %>

<%
	// 받은 쪽지함 default
	
	// 세션 id
	String id = (String)session.getAttribute("nid");

	// 쪽지 가져오기
	MypageDAO dao = MypageDAO.getInstance();
	int count = dao.RecMsgGetCount(id);
	
	// 페이징 처리
	int pageSize = 5;
	
	// 현재 페이지 번호
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	// 현재 페이지에 보여줄 게시글 시작과 끝
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	// if문 전에 미리 선언
	List articlelist = null;
	int number = 1;
	
	String sender = (String)session.getAttribute("nid");
	if(sender==null){
		sender = (String)session.getAttribute("cid");
	}
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
	
	<button>받은 쪽지함</button> <button onclick="window.location='mypageMsgSend.jsp'"> 보낸 쪽지함 </button>
	
	<h3>받은 쪽지함</h3> 
	<%if(count > 0) { %>
	<table border="1" style="border-collapse:collapse";>
		<tr align="center" width="700" height="50">
			<td>No. </td>
			<td>보낸 사람</td>
			<td>내	용</td>
			<td>받은 날짜</td>
		</tr>
		<%articlelist = dao.RecMsgGetArticles(startRow, endRow, id);

		for(int i = 0; i < articlelist.size(); i++) {
			MsgDTO article = (MsgDTO)articlelist.get(i);
		%>
		<tr align="center" width="700" height="50">
			<td><%= number++ %></td>
			<td><a href="../msg/sendmsgForm.jsp?send=<%=sender%>&receive=<%= article.getMsg_sid() %>"
										onclick="window.open(this.href, '메시지 보내기', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;"
										><%= article.getMsg_sid() %></a></td>
			<td><%=article.getMsg_content() %></td>
			<td><%=article.getMsg_reg() %></td>
		</tr>
	<%	}
	%>
	</table>
	<%}else{ %>
		<br/>
		받은 메세지가 없습니다.
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
			<a href="mypageMsg.jsp?pageNum=<%=startPage-pageBlock %>" class="pageNums"> &lt; &nbsp;</a>
		<%}
		
		// 페이지 번호 뿌리기
		for(int i = startPage; i <= endPage; i++) { %>
			<a href="mypageMsg.jsp?pageNum=<%=i%>" class="pageNum"> &nbsp; <%=i %> &nbsp; </a>
		<%}
		
		// <
		if(endPage < pageCount) { %>
			&nbsp; <a href="mypageMsg.jsp?pageNum=<%=startPage+pageBlock%>" class="pageNums"> &gt; </a>
		<%}
	}%>
	</div>
</div>
</div>	
	
<%}else{ %>
	<script>
		alert("일반 회원만 접근 가능합니다.");
		history.go(-1);
	</script>
<%} %>
<%@ include file="../common/footer.jsp" %>
</body>
</html>