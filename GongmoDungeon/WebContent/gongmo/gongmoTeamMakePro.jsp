<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MakeTeamPro</title>
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

	String id = (String)session.getAttribute("nid");
	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	String job[] = request.getParameterValues("maketeam_job");
	String str="";
	for(int i = 0; i<job.length;i++){
		if(i==job.length-1){
			str += job[i];
		}else{
			str += job[i]+",";
		}
	}
	System.out.println(str);
%>
<jsp:useBean id="maketeam" class="team04.project.gongmo.GongmoTeamMakeDTO"/>
<jsp:setProperty property="*" name="maketeam"/>
<%
	GongmoDAO dao = new GongmoDAO();
	int result = dao.insertmakeTeam(maketeam, str, id,num);
	
	System.out.println(maketeam.getMaketeam_num());
	System.out.println(num);
	System.out.println(id);
	System.out.println(maketeam.getMaketeam_title());
	System.out.println(maketeam.getMaketeam_name());
	System.out.println(maketeam.getMaketeam_Ptotal());
	System.out.println(str);
	System.out.println(maketeam.getMaketeam_view());
	System.out.println(maketeam.getMaketeam_content());
	System.out.println(maketeam.getMaketeam_pnow());
	System.out.println(maketeam.getMaketeam_done());
	System.out.println(maketeam.getMaketeam_reg());
	System.out.println("===============================");
	
	if(result == 1){
		System.out.println("result = "+result);
		System.out.println("팀등록 완료");
		response.sendRedirect("gongmoContent.jsp?gmboard_num="+num);
	}else{
		System.out.println("result = "+result);
		System.out.println("팀등록 실패");%>
		<script>
			alert("팀등록 실패 다시시도해주세요");
			history.go(-1);
		</script>
	<%}
%>
<body>

</body>
</html>