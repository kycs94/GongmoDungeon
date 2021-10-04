<%@page import="team04.project.login.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입 pro</title>
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
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class="team04.project.login.signupDTO" />
<jsp:setProperty property="*" name="dto" />
<%
	if(dto.getUser_favor()!= null){
		dto.setUsern_favor(dto.getUser_favor().replaceAll(",$", ""));
	}
	LoginDAO dao = LoginDAO.getInstance();
	dao.insertMember(dto);
%>
<body>
	<script>
		alert("회원가입 완료");
		window.location.href="../main/main.jsp";
	</script>
</body>
</html>