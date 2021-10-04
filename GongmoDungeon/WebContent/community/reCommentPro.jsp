<%@page import="team04.project.community.Community_freeCommentDTO"%>
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
	if(session.getAttribute("nid")==null){%>
	<script type="text/javascript">
		alert("정상 경로를 사용해주세요.");
		window.location="../main/main.jsp";
	</script>
	<%}
	request.setCharacterEncoding("UTF-8");
	CommunityDAO dao = new CommunityDAO();
	Community_freeCommentDTO dto = new Community_freeCommentDTO();
	int num = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("nid");

	dto.setCmComment_postNum(num);
	dto.setCmComment_id(id);
	String contents = request.getParameter("commentReContent");
	contents = contents.replace("\r\n", "<br/>");
	dto.setCmComment_comm(contents);
	dto.setCmComment_level(Integer.parseInt(request.getParameter("re_level")));
	dto.setCmComment_step(Integer.parseInt(request.getParameter("re_step")));
	dto.setCmComment_ref(Integer.parseInt(request.getParameter("ref")));
	
	int result = dao.insertReComment(dto); 
	
	if(result==1){
		System.out.println("입력완료");
		response.sendRedirect("communityFreeContent.jsp?num="+num);
	}else{
		System.out.println("입력실패");
		response.sendRedirect("communityFreeContent.jsp?num="+num);
	}
%>
<body>

</body>
</html>