<%@page import="team04.project.gongmo.GongmoContentQnADTO"%>
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
	if(session.getAttribute("nid")==null&&session.getAttribute("cid")==null){%>
	<script type="text/javascript">
		alert("정상 경로를 사용해주세요.");
		window.location="../main/main.jsp";
	</script>
	<%}
	request.setCharacterEncoding("UTF-8");
	GongmoDAO dao = new GongmoDAO();
	GongmoContentQnADTO dto = new GongmoContentQnADTO();
	int num = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("nid");
	if(id==null){
		id = (String)session.getAttribute("cid");	
	}

	dto.setGmqna_postnum(num);
	dto.setGmqna_id(id);
	dto.setGmqna_comm(request.getParameter("commentReContent"));
	dto.setGmqna_level(Integer.parseInt(request.getParameter("re_level")));
	dto.setGmqna_step(Integer.parseInt(request.getParameter("re_step")));
	dto.setGmqna_ref(Integer.parseInt(request.getParameter("ref")));
	
	int result = dao.insertQnaReComment(dto);
	
 	if(result==1){
		System.out.println("입력완료");
		response.sendRedirect("gongmoContent.jsp?gmboard_num="+num);
	}else{
		System.out.println("입력실패");
		response.sendRedirect("gongmoContent.jsp?gmboard_num="+num);
	}
%>
<body>

</body>
</html>