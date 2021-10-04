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
	GongmoDAO dao = new GongmoDAO();
	String nid = request.getParameter("usern_id");
	String content = request.getParameter("content");
	int result = dao.dropUsern(nid, content);
	System.out.println("추방 결과 = "+ result);
	if(result == 1){%>
		<script>
			self.close();
			// 기존의 페이지로 컴백홈
			opener.document.location="myUsernInfo.jsp";	
		</script>
	<%}else{%>
		<script type="text/javascript">
				alert("추방 실패!");
				self.close();
			</script>
	<%}
%>
<body>

</body>
</html>