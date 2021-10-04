<%@page import="team04.project.mypage.MsgDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	String sender = request.getParameter("send");
	String receiver = request.getParameter("receive");
	String content = request.getParameter("content");
	MsgDAO dao = new MsgDAO();
	
	dao.insertMsg(sender, receiver, content);
%>
<body>
<div style="text-align:center;">
	<div style="display: inline-block;">
		<span>전송되었습니다.</span><br/>
		<button onclick="window.close();">닫기</button>
	</div>
</div>
</body>
</html>