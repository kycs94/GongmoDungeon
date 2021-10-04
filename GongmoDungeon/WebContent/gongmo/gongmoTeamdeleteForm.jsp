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
		int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
		
	%>
<body>
	<h1>팀원모집 삭제</h1>
	<form action="gongmoTeamdeletePro.jsp?gmboard_num=<%=num%>&maketeam_num=<%=mnum %>" method="post">
		<table>
			<tr>
			<td>삭제하시려면 회원 비밀번호를 입력하세요</td>
			</tr>
			<tr>
			<td><input type="password" name="usern_pw"/></td>
			</tr>
			<tr>
			<td>
			<input type="submit" value="삭제" />
			<input type="button" value="취소" onclick="self.close();"/></td>
			</tr>
		</table>
	
	</form>


</body>
</html>