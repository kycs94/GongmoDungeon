<%@page import="team04.project.community.CommunityDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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

	String path = request.getRealPath("gongmoFile");
	System.out.println(path);

	int max = 1024*1024*5;
	String enc = "UTF-8";
	//덮어쓰기 방지 객체 : 중복이름으로 파일 저장시 파일 이름 뒤에 1, 2, 3, .... 자동으로 붙혀줌
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	String review_file = mr.getFilesystemName("review_file");
	int num = Integer.parseInt(mr.getParameter("number"));
	
	if(review_file==null){
		String title = mr.getParameter("subject"); // 일반 파라미터 꺼내기
		String gmName = mr.getParameter("gmName"); // 일반 파라미터 꺼내기
		String content = mr.getParameter("content"); // 일반 파라미터 꺼내기
		CommunityDAO dao = new CommunityDAO();
		dao.updateViewNoFile(title, gmName, content, num); 
		response.sendRedirect("communityReviewContent.jsp?num="+num);
	}else{
		String title = mr.getParameter("subject"); // 일반 파라미터 꺼내기
		String gmName = mr.getParameter("gmName"); // 일반 파라미터 꺼내기
		String content = mr.getParameter("content"); // 일반 파라미터 꺼내기
		CommunityDAO dao = new CommunityDAO();
		dao.updateViewFile(title, gmName, content, num, review_file);
		response.sendRedirect("communityReviewContent.jsp?num="+num);
	}
	
%>
<body>

</body>
</html>