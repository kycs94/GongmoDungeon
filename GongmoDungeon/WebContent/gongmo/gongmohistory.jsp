<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>참가내역 표시하기</title>
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
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("nid");
	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	
	GongmoDAO dao = new GongmoDAO();
	int hresult = dao.inserthistory(id, num);
	System.out.println("참가내역 등록 = "+ hresult);
	if(hresult == 1){%>
		<script>
			alert("참가완료 !");
			window.location="gongmoContent.jsp?gmboard_num="+<%=num%>;
		</script>
	<%}else{%>
		<script>
		alert("참가실패 다시 확인해주세요. ");
		history.go(-1);
	</script>
	<%}
%>
<body>

</body>
</html>