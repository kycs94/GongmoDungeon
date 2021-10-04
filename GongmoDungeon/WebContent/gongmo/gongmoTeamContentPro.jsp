<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>contentTeamPro</title>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("nid");
%>
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
	//contentTeam에서 apply 누르면 여기로 이동했다가 다시 페이지로 갈거다...
	int mnum=Integer.parseInt(request.getParameter("maketeam_num"));
	int num =Integer.parseInt(request.getParameter("gmboard_num"));
	String applyteam_comm = request.getParameter("applyteam_comm");
	System.out.println("maketeam_num = "+mnum);
	System.out.println(applyteam_comm);

	GongmoDAO dao = new GongmoDAO(); 
	int result = dao.insertApplyTeam(mnum, applyteam_comm,id);
	
	if(result == 1){
		System.out.println("저장완료");
		response.sendRedirect("gongmoTeamContent.jsp?gmboard_num="+num+"&maketeam_num="+mnum);
	}
	else{%>
		<script>
			alert("저장실패!! 다시시도하세요");
			history.go(-1);
			</script>
	<%}%>
<body>

</body>
</html>