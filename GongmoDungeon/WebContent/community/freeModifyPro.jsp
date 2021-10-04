<%@page import="team04.project.community.CommunityDAO"%>
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
	CommunityDAO dao = new CommunityDAO();
	int num = Integer.parseInt(request.getParameter("number"));
	String title = request.getParameter("subject");
	String content = request.getParameter("content");
	dao.updateFreeContent(num, title, content);
	response.sendRedirect("communityFreeContent.jsp?num="+num);
%>
<body>

</body>
</html>