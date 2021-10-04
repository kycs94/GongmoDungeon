<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그아웃</title>
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
	// 로그아웃 처리
	session.invalidate(); // 세션 속성 전체 삭제
	
	//쿠키가 있으면 쿠키도 삭제
	Cookie[] coos = request.getCookies();
	if(coos != null){
		for(Cookie c : coos){
			if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoCh") || c.getName().equals("orgTypeCh")){
				c.setDomain("localhost");
				c.setPath("/project_1");
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
	}
	
	response.sendRedirect("../main/main.jsp"); // main으로 이동
%>
<body>

</body>
</html>