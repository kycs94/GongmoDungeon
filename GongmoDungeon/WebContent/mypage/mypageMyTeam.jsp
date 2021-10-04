<%@page import="team04.project.gongmo.GongmoTeamMakeDTO"%>
<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>My Team</title>
</head>
<jsp:useBean id="dto" class="team04.project.gongmo.GongmoTeamMakeDTO" />
<jsp:setProperty property="*" name="dto"/>
<%if(session.getAttribute("nid") != null){ %>

 
<%
	
	// 내 파티가 default 페이지
	// 내 파티 -> MakeTeam_id 가 나여야 함
	// 파티명 : MakeTeam_name
	// 제목 : MakeTeam_title
	// 제목을 누르면 공모 게시글로 이동 : MakeTeam_targetGM
	
	// 세션에 담긴 id 가져오기
	String id = (String)session.getAttribute("nid");
	
	// 글 가져오기
	MypageDAO dao = MypageDAO.getInstance();
	int count = dao.makeGetArticleCount(id);
	
	//게시글 페이지 관련 정보 세팅
	// 한 페이지에 보여줄 게시글의 수
	int pageSize = 5;
	
	// 현재 페이지 번호
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	//현재 페이지에 보여줄 게시글 시작과 끝 정보 세팅
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	// if문 시작 전에 선언
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
	<h1> 팀원 관리 </h1>
	<hr>
	
	<button>내 파티</button> <button onclick="window.location='mypageEnterMyTeam.jsp'"> 내가 참가한 파티 </button>
	
	<h3>내 파티</h3>
	<table>
	<%if(count > 0) {
		articlelist = dao.makeGetArticles(startRow, endRow, id); // id 받아오기 
		for(int i = 0; i < articlelist.size(); i++) {
			GongmoTeamMakeDTO article = (GongmoTeamMakeDTO)articlelist.get(i);
		%>
		<tr>
			<td> <%=number++ %>.</td>
			<td> <%=article.getMaketeam_name() %> </td>
			<td onclick="window.location='../gongmo/gongmoContent.jsp?gmboard_num=<%= article.getMaketeam_targetGM() %>'" style="cursor: pointer;"> [ <%=article.getMaketeam_title() %> ]</td>
		</tr>
	<%	}
	%>
	</table>
	<%}else{ %>
		<br/>
		만든 파티가 없습니다.
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
			<a href="mypageMyTeam.jsp?pageNum=<%=startPage-pageBlock %>" class="pageNums"> &lt; &nbsp;</a>
		<%}
		
		// 페이지 번호 뿌리기
		for(int i = startPage; i <= endPage; i++) { %>
			<a href="mypageMyTeam.jsp?pageNum=<%=i%>" class="pageNum"> &nbsp; <%=i %> &nbsp; </a>
		<%}
		
		// <
		if(endPage < pageCount) { %>
			&nbsp; <a href="mypageMyTeam.jsp?pageNum=<%=startPage+pageBlock%>" class="pageNums"> &gt; </a>
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