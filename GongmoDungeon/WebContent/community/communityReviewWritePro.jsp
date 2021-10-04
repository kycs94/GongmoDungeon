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
	if(session.getAttribute("nid")==null){%>
	<script type="text/javascript">
		alert("정상 경로를 사용해주세요.");
		window.location="../main/main.jsp";
	</script>
	<%}
	request.setCharacterEncoding("UTF-8");

	String path = request.getRealPath("gongmoFile");
	System.out.println(path);
	
	int max = 1024*1024*5;
	String enc = "UTF-8";
	//덮어쓰기 방지 객체 : 중복이름으로 파일 저장시 파일 이름 뒤에 1, 2, 3, .... 자동으로 붙혀줌
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	//MultipartRequest 객체 생성
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	String sid = (String)session.getAttribute("nid");
	
	String title = mr.getParameter("subject"); // 일반 파라미터 꺼내기
	String gmName = mr.getParameter("gmName"); // 일반 파라미터 꺼내기
	String contents = mr.getParameter("content");
	contents = contents.replace("\r\n", "<br/>");
	String content = mr.getParameter(contents); // 일반 파라미터 꺼내기
	String review_file = mr.getFilesystemName("review_file"); //업로드 파일 이름
	
	CommunityDAO dao = new CommunityDAO();
	int result = dao.viewWrite(title, gmName, content, review_file, sid);
	if(result==1){
		System.out.println("입력완료");
		response.sendRedirect("communityReviewList.jsp");
	}else{
		System.out.println("입력실패");
		response.sendRedirect("communityReviewList.jsp");
	}
%>
<body>

</body>
</html>