<%@page import="team04.project.community.CommunityDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="dto" class="team04.project.community.Community_writeDTO"></jsp:useBean>
<%
	if(session.getAttribute("nid")==null){%>
	<script type="text/javascript">
		alert("정상 경로를 사용해주세요.");
		window.location="../main/main.jsp";
	</script>
	<%}
	request.setCharacterEncoding("UTF-8");

	dto.setCMBoard_title(request.getParameter("subject"));
	String contents = request.getParameter("content");
	contents = contents.replace("\r\n", "<br/>");
	dto.setCMBoard_content(contents);
	
	String sid = (String)session.getAttribute("nid");

	dto.setCMBoard_id(sid);
	
	CommunityDAO dao = new CommunityDAO();
	int result = dao.freeWrite(dto);
	if(result==1){
		System.out.println("입력완료");
		response.sendRedirect("communityList.jsp");
	}else{
		System.out.println("입력실패");
		response.sendRedirect("communityList.jsp");
	}
%>
<body>

</body>
</html>