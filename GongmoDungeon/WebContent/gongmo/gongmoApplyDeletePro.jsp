<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원 삭제 Pro</title>
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
	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
	int anum = Integer.parseInt(request.getParameter("applyteam_num"));
	String applyteam_comm = request.getParameter("applyteam_comm");
	String applyteam_id = request.getParameter("applyteam_id");
	System.out.println("num = "+num);
	System.out.println("mnum = "+mnum);
	System.out.println("anum ="+anum);
	System.out.println("applyteam_comm = "+applyteam_comm);
	System.out.println("applyteam_id = "+applyteam_id);
	
	
	int result=0;
	GongmoDAO dao = new GongmoDAO();
	dao.deleteModify(anum,applyteam_id,applyteam_comm);
	if(result == 0){
		System.out.println("result = "+result);
		System.out.println("삭제 완료");
		response.sendRedirect("gongmoTeamContent.jsp?gmboard_num="+num+"&maketeam_num="+mnum);
	}else{
		System.out.println("result = "+result);
		System.out.println("삭제 실패");%>
		<script>
			alert("삭제 실패 다시시도해주세요");
			history.go(-1);
		</script>
<%}%>
<body>

</body>
</html>