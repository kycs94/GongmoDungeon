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
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("nid");
	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
	String job[] = request.getParameterValues("maketeam_job");
	String str="";
	for(int i = 0; i<job.length;i++){
		if(i==job.length-1){
			str += job[i];
		}else{
			str += job[i]+",";
		}
	}
	System.out.println("수정된 job = "+str);
%>
<jsp:useBean id="maketeam" class="team04.project.gongmo.GongmoTeamMakeDTO"/>
<jsp:setProperty property="*" name="maketeam"/>
<%
	GongmoDAO dao = new GongmoDAO();
	boolean presult = dao.pnowCheck(mnum);
	System.out.println("presult = "+presult);
	if(!presult){
		System.out.println("팀수정 실패");%>
		<script>
			alert("팀원이 있습니다. 삭제 후 다시시도해주세요");
			history.go(-1);
		</script>
	<%
	}else {
		int result = dao.updatemakeTeam(maketeam, str, id,num, mnum);
		if(result == 1){
			System.out.println("result = "+result);
			System.out.println("팀수정 완료");
			response.sendRedirect("gongmoContent.jsp?gmboard_num="+num);
		}else{
			System.out.println("result = "+result);
			System.out.println("팀수정 실패");%>
			<script>
				alert("팀수정 실패 다시시도해주세요");
				history.go(-1);
			</script>
		<%}
		}%>
	
</body>
</html>
