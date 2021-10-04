<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>기업회원 수정 Pro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id ="dto" class="team04.project.login.signupDTO" />
<jsp:setProperty property="*" name="dto" /> 

<% 
	// 넘어오는 데이터 : 기업명, 기업형태, 사업자번호, 홈페이지, 이메일주소
	
	String id = (String)session.getAttribute("cid");

	dto.setUserc_id(id);
	MypageDAO dao = MypageDAO.getInstance();
	int result = dao.updateUserC(dto);
	
	
%>
<body>
	<% if (result == 1) { %>
		<script>
			alert("기업정보가 수정되었습니다.");
			window.location.href="mypageCModifyForm.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("기업정보 수정 실패.");
			history.go(-1);
		</script>
	<%} %>

</body>
</html>