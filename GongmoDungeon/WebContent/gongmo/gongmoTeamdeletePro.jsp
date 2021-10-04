<%@page import="team04.project.gongmo.GongmoDAO"%>
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
 <script language="javascript">
  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다. 정상적인 경로를 통해 다시 접근해 주십시오.");
  document.location.href="../main/main.jsp";
 </script>
<%
  return;
 }
%>
<%
		String id =(String)session.getAttribute("nid");
		String usern_pw=request.getParameter("usern_pw");
		int num = Integer.parseInt(request.getParameter("gmboard_num"));
		int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
		
		GongmoDAO dao = new GongmoDAO();
		int result =0;
		result = dao.deleteTeam(id,usern_pw, mnum);
		if(result == 1) { // 비밀번호 맞음 	%>
			<script type="text/javascript">
			self.close();
			// 기존의 페이지로 컴백홈
			opener.document.location="gongmoContent.jsp?gmboard_num="+<%=num%>;	
			</script>
	<%	} else { // 비밀번호가 틀린 경우 %>
			<script type="text/javascript">
				alert("비밀번호가 틀렸습니다!");
				self.close();
			</script>
	<% 	} %>
<body>

</body>
</html>