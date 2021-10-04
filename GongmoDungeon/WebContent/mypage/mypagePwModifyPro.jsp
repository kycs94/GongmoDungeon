<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head> 
<%
	request.setCharacterEncoding("UTF-8");
	String pw = request.getParameter("pw");
	String newPw = request.getParameter("newPw");
%>
<jsp:useBean id="dto" class="team04.project.login.signupDTO" />
<jsp:setProperty property="*" name="dto"/> 

<%
	// 현재 pw 확인하고 바꿔야 함 -> 틀리면 변경 노
	// 근데 pw가 똑같은 회원 존재 가능 -> id도 확인
	
	String id = (String)session.getAttribute("nid");
	dto.setUsern_id(id);
	
	MypageDAO dao = MypageDAO.getInstance();
	int result = dao.updateNuserPw(dto, pw, newPw); 
	
	
%>

<body>
	<jsp:include page="mypageLeft.jsp" />
	<br/>
	<% if(result == 1) { 
		response.sendRedirect("mypageMyinfo.jsp");
	%>
	<%}else{%>
		<script>
			alert("비밀번호를 다시 확인해 주세요.");
			history.go(-1);
		</script>
	<%} %>

</body>
</html>