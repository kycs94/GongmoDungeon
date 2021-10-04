<%@page import="team04.project.login.signupDTO"%>
<%@page import="team04.project.gongmo.GongmoTeamMakeDTO"%>
<%@page import="team04.project.login.LoginDAO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀에서 모집하는 포지션 인지 확인</title>
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
	String id = (String)session.getAttribute("nid");
	GongmoDAO dao = new GongmoDAO();
	LoginDAO lodao = LoginDAO.getInstance();
	// 팀에서 원하는 직업 가져오기
	GongmoTeamMakeDTO gmdto = dao.JobCheck(mnum);
	// 나의 직업 가져오기
	signupDTO sdto = lodao.usernteamIdchar(id);

	System.out.println("지원 가능한 직업 : "+ gmdto.getMaketeam_job());
	System.out.println("내 직업 : "+ sdto.getUsern_job());
	System.out.println("팀장 아이디 : "+ gmdto.getMaketeam_id());
	System.out.println("세션아이디 : "+ id);
%>
<%
	//팀장이랑 세션 id가 동일할때
	if(id.equals(gmdto.getMaketeam_id())){
		System.out.println(id.equals(gmdto.getMaketeam_id()));
		%>
		<script>
			self.close();
			opener.document.location="gongmoTeamContent.jsp?gmboard_num="+<%=num%>+"&maketeam_num="+<%=mnum%>;
		</script>		
	<%}else{
		if(gmdto.getMaketeam_job().contains(sdto.getUsern_job())){%>
			<script>
				self.close();
				// 기존페이지로 이동
				opener.document.location="gongmoTeamContent.jsp?gmboard_num="+<%=num%>+"&maketeam_num="+<%=mnum%>;
			</script>
		<%}else{%>
			<script>
				alert("지원가능한 직업이 아닙니다. 다른팀을 찾아주세요.");
				self.close();
			</script>
		<%}
	}
%>
<body>
</body>
</html>