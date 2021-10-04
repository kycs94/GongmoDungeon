<%@page import="team04.project.community.Community_reviewWriteDTO"%>
<%@page import="team04.project.community.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="jquery-3.6.0.min.js"></script>
<link href="../common/style.css" type="text/css" rel="stylesheet">
<link href="style.css" type="text/css" rel="stylesheet">
<%
	CommunityDAO dao = new CommunityDAO();
	int num = Integer.parseInt(request.getParameter("num"));
	
	Community_reviewWriteDTO dto = dao.getReviewContent(num);
	String path = request.getRealPath("gongmoFile");
	
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
			<div class="commu">
				<!-- 사이드 메뉴 블럭 -->
				<jsp:include page="sideMenu.jsp"></jsp:include>
				
				<div class="commuMain">
					<% if(dto.getReview_id().equals((String)session.getAttribute("nid"))){%>
						<div>
							<button onclick="modifyReview()">수정</button>
							<button onclick="deleteReview()">삭제</button>
						</div>
					<%} %>
					<table class="freeContent">
						<tr>
							<td>
								제목
							</td>
							<td>
								<%= dto.getReview_title() %>
							</td>
							<td>
								조회수
							</td>
							<td>
								<%= dto.getReview_view() %>
							</td>
						<tr>
						<tr>
							<td>
								작성자
							</td>
							<td>
								<a href="../msg/sendmsgForm.jsp?send=<%=sender%>&receive=<%= dto.getReview_id() %>"
										onclick="window.open(this.href, '메시지 보내기', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;"
										><%= dto.getReview_id() %></a>
							</td>
							<td>
								작성날짜
							</td>
							<td>
								<%= dto.getReview_reg() %>
							</td>
						<tr>
					
						<tr>
							<td colspan="2">
								공모전 이름
							</td>
							<td colspan="2">
								<%= dao.getGMName(Integer.parseInt(dto.getReview_targetGM())) %>
							</td>
						<tr>
						<tr>
							<td colspan="2">
								첨부파일
							</td>
							<td colspan="2">
								<a href="filedownload.jsp?fileName=<%=dto.getReview_file()%>"><%=dto.getReview_file()%></a>
							</td>
						<tr>
						<tr>
							<td colspan="4">
								<%= dto.getReview_content() %>
							</td>
						<tr>
					</table>
				</div>
			</div>
		</div>

		<!-- 풋터블럭 -->
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</div>
</body>

<!-- 자바스크립트 -->
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var submenu = $(".menu1 .openmenu").next("ul");
    if( submenu.is(":visible") ){
        submenu.slideUp();
    }else{
        submenu.slideDown();
    }
    $(".allmenu").find(".cMenu").removeClass('active');
    $(".menu1").find(".cMenu3").addClass('active');
})

function deleteReview(){
	var result = confirm("게시물을 삭제하시겠습니까?");
	if(result){
		window.location = "deletePro.jsp?num="+<%=dto.getReview_num()%>+"&wheres=review&fileName=<%=dto.getReview_file()%>";
	}
}

function modifyReview(){
	window.location = "reviewModifyForm.jsp?num="+<%=dto.getReview_num()%>+"&fileName=<%=dto.getReview_file()%>";
}
</script>
</html>