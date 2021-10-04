<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="team04.project.login.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 평가 Pro</title>
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
	int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
	int anum = Integer.parseInt(request.getParameter("applyteam_num"));
	String applyteam_id[]= new String[Integer.parseInt(request.getParameter("listsize"))];
	int popul[] = new int[Integer.parseInt(request.getParameter("listsize"))];
	
	int tresult =0;
	int dresult =0;
	
	LoginDAO lodao = LoginDAO.getInstance();
	GongmoDAO gmdao = new GongmoDAO();
	
	for(int i=0; i<Integer.parseInt(request.getParameter("listsize"));i++){
	applyteam_id[i] =request.getParameter("applyteam_id"+i);
	popul[i] = Integer.parseInt(request.getParameter("popul"+i));
	System.out.println("applyteam_id["+i+"] =" + applyteam_id[i]);
	System.out.println("popul["+i+"] =" + popul[i]);
	// 팀원 평가 점수 insert 하기 위한 메소드
	tresult = lodao.insertPopul(applyteam_id[i], popul[i]);
	}
	
	// 지원자가 팀원 평가를 완료했을때 maketeam_done에 id 넣으면서 X -> O로 바꾸기위한 메소드
	dresult = gmdao.donePopul(id,mnum);
	if(tresult == 1 && dresult ==1){%>
		<script type="text/javascript">
		self.close();
		// 기존의 페이지로 컴백홈
		opener.document.location="gongmoTeamContent.jsp?dresult="+<%=dresult%>+"&gmboard_num="+<%=num%>+"&maketeam_num="+<%=mnum%>;	
		</script>
<%	} else { // 둘다 1이 아닌경우 틀린 경우 %>
		<script type="text/javascript">
			alert("팀원평가 실패! 다시 시도해주세요");
			self.close();
		</script>
<% 	} %>
<body>

</body>
</html>