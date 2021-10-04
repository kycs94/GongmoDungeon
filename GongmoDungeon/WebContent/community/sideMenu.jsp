<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
				<div class="commuSideMenu rb-color-1">
				    <ul class="allmenu">
				    	<li class="cMenu active">
				    		<span class="stop-dragging"><a href="communityList.jsp">전체 게시글</a></span>
				    	</li>
				        <li class="menu menu1">
				            <span class="stop-dragging openmenu">공모전</span>
				            <ul class="hide">
				                <li class="cMenu cMenu1"><span class="stop-dragging"><a href="communityFreeList.jsp">자유게시판</a></span></li>
				                <li class="cMenu cMenu2"><span class="stop-dragging"><a href="communityTeamList.jsp">팀원 모집</a></span></li>
				                <li class="cMenu cMenu3"><span class="stop-dragging"><a href="communityReviewList.jsp">수상 후기</a></span></li>
				            </ul>
				        </li>
				 
				        <li class="menu menu2">
				            <span class="stop-dragging openmenu">대외활동</span>
				            <ul class="hide">
				                <li class="cMenu cMenu1"><span class="stop-dragging">자유게시판</span></li>
				                <li class="cMenu cMenu2"><span class="stop-dragging">팀원 모집</span></li>
				                <li class="cMenu cMenu3"><span class="stop-dragging">수상 후기</span></li>
				            </ul>
				        </li>
				        <%if(session.getAttribute("nid")!=null){ %>
				        <li class="cMenu4">
				    		<span class="stop-dragging"><a href="myList.jsp">내가 쓴 글</a></span>
				    	</li>
				    	<%} %>
				    </ul>
				</div>
</body>
</html>