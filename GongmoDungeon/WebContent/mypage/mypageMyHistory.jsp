<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>참가 내역</title>
</head>
<jsp:useBean id="dto" class="team04.project.login.signupDTO" />
<jsp:setProperty property="*" name="dto"/>

<%if(session.getAttribute("nid") != null){ %>

<%
	// 세션 id
	String id = (String)session.getAttribute("nid");

	// 내역 가져오기
	// 몇 개를 참가했든 있으면 count 1, 없으면 0
	MypageDAO dao = MypageDAO.getInstance();
	int count = dao.historyCount(id);
	
	// 페이징 처리
	int pageSize = 5;
	
	// 현재 페이지 번호
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	// 현재 페이지에서 보여줄 게시글 시작과 끝
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
			<h2> 참가 내역 </h2>
			<hr />
			<table border="1" style="border-collapse:collapse";>
			<%if(count > 0) { %>
				<tr align="center" width="700" height="50">
					<td>No. </td>
					<td>공모 제목</td>
					<td>수상 여부</td>
					<td>참가 단위</td>
				</tr>
				<%String history = dao.historyList(id);
				String[] historyarr = history.split(",");
				String his[] = new String[historyarr.length];
				for(int i = 0; i < historyarr.length; i++) {
					his[i] = historyarr[i];
					String title = dao.histitle(startRow, endRow, his[i]);
					%>
						<tr align="center" width="700" height="50">
							<td><%= number++ %></td>
							<td><%= title %></td>
							<%int result = dao.historyresult(his[i], id); 
							if(result == 1) {%>
							<td> O </td>
							<%}else{ %>
							<td> X </td>
							<%} %>
							<%int makeresult = dao.maketeamresult(his[i], id);
							int applyresult = dao.applyteamresult(his[i], id);
							if(makeresult == 1 || applyresult == 1) {%>
							<td> 팀 </td>
							<%}else{ %>
							<td> 개인 </td>
							<%} %>
						</tr>
			<%	}%>
			
			</table>
			<%}else{ %>
				<h3>참가 내역이 없습니다.</h3><br /><br /><br />
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
					<a href="mypageMyHistory.jsp?pageNum=<%=startPage-pageBlock %>" class="pageNums"> &lt; &nbsp;</a>
				<%}
				
				// 페이지 번호 뿌리기
				for(int i = startPage; i <= endPage; i++) { %>
					<a href="mypageMyHistory.jsp?pageNum=<%=i%>" class="pageNum"> &nbsp; <%=i %> &nbsp; </a>
				<%}
				
				// <
				if(endPage < pageCount) { %>
					&nbsp; <a href="mypageMyHistory.jsp?pageNum=<%=startPage+pageBlock%>" class="pageNums"> &gt; </a>
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