<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일반회원 수정 Pro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id ="dto" class="team04.project.login.signupDTO" />
<jsp:setProperty property="*" name="dto" /> 

<%
	// 넘어오는 데이터 : 이름, 이메일, 전화번호, 소속, 지역, 관심분야, 직업
	
	String id = (String)session.getAttribute("nid");

	dto.setUsern_id(id);
	MypageDAO dao = MypageDAO.getInstance();
	int result = dao.updateUserN(dto);
	
	 
%>
<body>
	<% if (result == 1) { %>
		<script>
			alert("회원정보가 수정되었습니다.");
			window.location.href="mypageNModifyForm.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("회원정보 수정 실패.");
			history.go(-1);
		</script>
	<%} %>
</body>
</html>