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
		int sresult = Integer.parseInt(request.getParameter("scrap"));
		int num = Integer.parseInt(request.getParameter("gmboard_num"));
		String id="";
		if(session.getAttribute("nid") != null){
			id = (String)session.getAttribute("nid");
		}else if(session.getAttribute("cid")!=null){
			id = (String)session.getAttribute("cid");
		}
		System.out.println(sresult);
		System.out.println(num);
		System.out.println(id);
		GongmoDAO dao = new GongmoDAO();
		
		// 넘어오는 값이 1 일때
		if(sresult == 1){
			int deleteresult = dao.scrapdelete(id , num);
			if(deleteresult == 1){
				System.out.println("스크랩 삭제 완료");
				response.sendRedirect("gongmoContent.jsp?gmboard_num="+num+"&scrap=0");
			}
		// 그 외
		}else{
			int insertresult = dao.scrapinsert(id, num);
			if(insertresult == 1){
				System.out.println("스크랩 저장 완료");
				response.sendRedirect("gongmoContent.jsp?gmboard_num="+num+"&scrap="+insertresult);
			}
		}
	%>

<body>

</body>
</html>