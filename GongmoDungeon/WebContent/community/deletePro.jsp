<%@page import="team04.project.community.CommunityDAO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String wheres = request.getParameter("wheres");
	CommunityDAO dao = new CommunityDAO();
	
	if(wheres.equals("free")){
		dao.deleteFreecontent(num);
		response.sendRedirect("communityFreeList.jsp");
	}
	
	if(wheres.equals("comm")){
		String nums = request.getParameter("nums");
		dao.deleteComm(num);
		response.sendRedirect("communityFreeContent.jsp?num="+nums);
	}
	
	if(wheres.equals("review")){
		String file = request.getParameter("fileName");
		String path = request.getRealPath("gongmoFile");
		System.out.println("서버저장주소 : "+path);
		path += "//" + file;
		File f = new File(path);
		f.delete();
		dao.deleteReview(num);
		response.sendRedirect("communityReviewList.jsp");
	}
%>
<body>

</body>
</html>