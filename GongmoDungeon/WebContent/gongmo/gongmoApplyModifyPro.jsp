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

	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
	int anum = Integer.parseInt(request.getParameter("applyteam_num"));
	String applyteam_comm1 = request.getParameter("applyteam_comm1");
	System.out.println("gmboard_num = "+ num);
	System.out.println("maketeam_num = "+ mnum);
	System.out.println("applyteam_num = "+anum);
	System.out.println("applyteam_comm1 = "+applyteam_comm1);
	
	GongmoDAO dao = new GongmoDAO();
	
	int result =0;
	result = dao.applyModify(anum, applyteam_comm1);
	if(result == 1){
		System.out.println("result = "+result);
		System.out.println("수정 완료");
		response.sendRedirect("gongmoTeamContent.jsp?gmboard_num="+num+"&maketeam_num="+mnum+"&applyteam_num="+anum);
	}else{
		System.out.println("result = "+result);
		System.out.println("수정 실패");%>
		<script>
			alert("수정 실패 다시시도해주세요");
			history.go(-1);
		</script>
<%}%>
<body>

</body>
</html>