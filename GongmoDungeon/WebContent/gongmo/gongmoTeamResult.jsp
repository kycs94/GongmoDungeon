<%@page import="team04.project.gongmo.GongmoTeamMakeDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>!! 합격여부 !!</title>
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
	int result = Integer.parseInt(request.getParameter("result"));
	int outresult = Integer.parseInt(request.getParameter("outresult"));
	System.out.println("outresult = " + outresult);
	String applyteam_id = request.getParameter("applyteam_id");
	System.out.println("applyteam_id = " + applyteam_id);
	GongmoDAO dao = new GongmoDAO();
	int okresult = 0;
	int noresult = 0;
	int oresult =0;
	int presult = 0;
	
	// 합격이였는데 추방 눌었을때 maketeam_pnow에서 강퇴시키기
	if(result == 1 && outresult ==3){
		GongmoTeamMakeDTO gmdto = dao.updatemaketeamPnowO(mnum);
		String pnow = gmdto.getMaketeam_pnow();
		
		System.out.println("pnow = "+pnow);
		String str[] = pnow.split(",");
		String newPnow="";
		for(String i : str){
			if(!i.equals(applyteam_id)){
				newPnow +=i+",";
			}
		}
		System.out.println("newPnow = "+newPnow);
		oresult = dao.outresult(mnum,newPnow);
		if(oresult ==1){
			System.out.println(applyteam_id+"님, 추방하셨습니다.");
			dao.noresult(mnum, applyteam_id);
			response.sendRedirect("gongmoTeamContent.jsp?gmboard_num=" + num + "&maketeam_num=" + mnum+ "&noresult=2");
		}
	}	
	// 수락을 눌렀을때
	else if (result == 1) {
		okresult = dao.okresult(mnum, applyteam_id);
		presult = dao.updatemaketeamPnowY(mnum, applyteam_id);
		System.out.println("okresult = " + okresult);
		if (okresult == 1 && presult == 1) {
			System.out.println("합격과 동시에 팀원으로 승격!!");
			response.sendRedirect("gongmoTeamContent.jsp?gmboard_num=" + num + "&maketeam_num=" + mnum
					+ "&okresult=" + okresult);
		}
	} else {
		// 거절을 눌렀을때
		noresult = dao.noresult(mnum, applyteam_id);
		System.out.println("noresult = " + noresult);
		if (noresult == 1) {
			response.sendRedirect(
					"gongmoTeamContent.jsp?gmboard_num=" + num + "&maketeam_num=" + mnum + "&noresult=2");
		}
	}
%>
<body>

</body>
</html>