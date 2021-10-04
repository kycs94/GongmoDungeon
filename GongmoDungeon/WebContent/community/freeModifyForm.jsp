<%@page import="team04.project.community.Community_writeDTO"%>
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
<script type="text/javascript">
function checkForm(){
	var result = true;
	if($("input[name=subject]").val()==""){
		result = false;
		alert("제목을 입력해주세요.");
		$("input[name=subject]").focus();
	}else{
		if($("textarea[name=content]").val()==""){
			result = false;
			alert("내용을 입력해주세요.");
			$("textarea[name=content]").focus();
		}
	}
	return result;
}
</script>
	<%if(session.getAttribute("nid")==null){%>
		<script type="text/javascript">
			alert("정상 경로를 사용해주세요.");
			window.location="../main/main.jsp";
		</script>
	<%}%>
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
				<%if(session.getAttribute("nid")!=null){
					int num = Integer.parseInt(request.getParameter("num"));
					CommunityDAO dao = new CommunityDAO();
					Community_writeDTO dto = dao.getFreeArticle(num);
				%>
				
				<div class="commuMain">
					<div class="writeForm">
						<form action="freeModifyPro.jsp" method="post" onsubmit="return checkForm()">
							<input type="hidden" name="number" value="<%=num%>">
							<table class="gongmoWriteTable">
								<tr>
									<td>
										<span>카테고리</span>
									</td>
									<td>
										<select id="commuWrite" onchange="changeWrite()" style="pointer-events:none;" >
											<option value="free">자유게시판</option>
											<option value="review">후기게시판</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<span>제목</span>
									</td>
									<td>
										<input type="text" name="subject" value="<%=dto.getCMBoard_title()%>"/>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<span>내용</span>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<textarea name="content"><%=dto.getCMBoard_content().replace("<br/>","\r\n") %></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<input type="submit" value="저장"/>
										<input type="reset" value="재작성"/>
										<input type="button" value="취소" onclick="window.location='communityList.jsp'"/>
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<%}else{ %>
					일반회원 로그인 후 이용가능합니다.
				<%} %>
			</div>
		</div>

		<!-- 풋터블럭 -->
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</div>
</body>

<!-- 자바스크립트 -->
<script type="text/javascript" src="script.js"></script>
</html>