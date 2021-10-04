<%@page import="team04.project.community.Community_reviewWriteDTO"%>
<%@page import="team04.project.community.Community_writeDTO"%>
<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.login.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- 외부CSS링크 네이밍 변경 필요 -->
	<link href="../common/style.css" type="text/css" rel="stylesheet">
</head>
<%
 String strReferer = request.getHeader("referer");
 
 if(strReferer == null){
%>
 <script>
  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다. 정상적인 경로를 통해 다시 접근해 주십시오.");
  document.location.href="../main/main.jsp";
 </script>
<%
  return;
 }
%>
<%
	String search = request.getParameter("search");
	LoginDAO dao = LoginDAO.getInstance();
	List titleList1 = null;
	List titleList2 = null;
	List titleList3 = null;
	titleList1 = dao.getGongmoTitleList(search); //공모전
	titleList2 = dao.getFreeTitleList(search); //자유게시판
	titleList3 = dao.getReviewTitleList(search); //후기게시판
	int count1 = 0;
	int count2 = 0;
	int count3 = 0;
	count1 = dao.getGongmoTitlecount(search); //공모전
 	count2 = dao.getFreeTitlecount(search); //자유게시판
	count3 = dao.getReviewTitlecount(search); //후기게시판
%>

<%	if(search == "" | search == null){ %>
	<script>
		alert("검색어 입력하세요");
		history.go(-1);
	</script>
<%	} %>

<body>
<%@ include file="../common/header.jsp" %>
	<div class="container">
		<div>
		<h2>[공모전]</h2>
			<tr>
				<%
				if(count1>0){
					for(int i = 0; i < titleList1.size(); i++){
						GongmoWriteDTO article = (GongmoWriteDTO)titleList1.get(i);
				%>
				<td>
					<a href="../gongmo/gongmoContent.jsp?gmboard_num=<%=article.getGmboard_num()%>"><%=article.getGmboard_title()%></a>
				</td>
				<%} %> <br />
				<td><a href="../gongmo/gongmoList.jsp">더보기</a></td>
				<% }else{%>
					<h4>검색결과가 없습니다.</h4>
				<%} %>
			</tr>
		</div>
		
	<h2>[커뮤니티]</h2>
		<div>
			<h3>ㆍ자유게시판</h3>
			<div>
				<tr>
				    <%
				    if(count2>0){
					    for(int i = 0; i < titleList2.size(); i++){
							Community_writeDTO article = (Community_writeDTO)titleList2.get(i);
					%>
					<td>
						<a href="../community/communityFreeContent.jsp?num=<%=article.getCMBoard_num()%>"><%=article.getCMBoard_title()%></a>
					</td>
					<%} %> <br />
					<td><a href="../community/communityList.jsp">더보기</a></td>
					<%}else{ %>
						<h4>검색결과가 없습니다.</h4>
					<%} %>
				</tr>
			</div>
		</div>
		
		<div>
			<h3>ㆍ후기게시판</h3>
			<div>
				<tr>
					<%
					if(count3>0){
						for(int i = 0; i < titleList3.size(); i++){
							Community_reviewWriteDTO article = (Community_reviewWriteDTO)titleList3.get(i);
					%>
					<td>
						<a href="../community/communityReviewContent.jsp?num=<%=article.getReview_num()%>"><%=article.getReview_title()%></a>
					</td>
					<%} %> <br />
					<td><a href="../community/communityReviewList.jsp">더보기</a></td>
					<%}else{%>
						<h4>검색결과가 없습니다.</h4>
					<%} %>
				</tr>
			</div>
		</div>
		
	</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>