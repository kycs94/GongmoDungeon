<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 삭제</title>
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
	%>
<body>
	<h1>공모 삭제</h1>
	<%
	if(session.getAttribute("nid") != null &&session.getAttribute("nid").equals("admin")){
		GongmoDAO dao = new GongmoDAO();
		// 관리자권한으로 공모전 삭제
		int result = dao.admindeletegongmo(num);
		if(result == 1){%>
			<script>
				alert("관리자 권한으로 공모전을 삭제하였습니다.");
				self.close();
				// 기존의 페이지로 컴백홈
				opener.document.location="gongmoList.jsp";
			</script>
		<%}else{%>
			<script>
				alert("공모전 삭제 실패. 다시시도해주세요.");
				history.go(-1);
			</script>
		<%}
	}else if(session.getAttribute("cid") != null){%>
		<form action="gongmoDeletePro.jsp?gmboard_num=<%=num%>" method="post">
		<table>
			<tr>
			<td>삭제하시려면 회원 비밀번호를 입력하세요</td>
			</tr>
			<tr>
			<td><input type="password" name="userc_pw"/></td>
			</tr>
			<tr>
			<td>
			<input type="submit" value="삭제" />
			<input type="button" value="취소" onclick="self.close();"/></td>
			</tr>
		</table>
	
	</form>
	<%}
	%>
	


</body>
</html>