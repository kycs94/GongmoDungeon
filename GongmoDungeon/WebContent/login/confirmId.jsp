<%@page import="team04.project.login.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>중복확인</title>
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
	String user_id = request.getParameter("user_id");
	LoginDAO dao = LoginDAO.getInstance();
	boolean result = dao.confirmId(user_id);
%>
<body>
	<% if(result){ %>
		<table>
			<tr>
				<td><%=user_id%>, 이미 사용중인 아이디 입니다.</td>
			</tr>
		</table>
		<br />
		<form action="confirmId.jsp" method="post">
			<table>
				<tr>
					<td> 다른 아이디를 입력하세요. <br />
						<input type="text" name="user_id" />
						<input type="submit" value="중복확인" />
					</td>
				</tr>
			</table>
		</form>
		
	<% }else{ %>
		<table>
			<tr>
				<td> 입력하신 <%=user_id%>는 사용 가능한 아이디 입니다. <br />
					<input type="button" value="닫기" onclick="setId()" />
				</td> 
			</tr>
		</table>
	<% } %>
	
	<script>
		function setId(){
			if(opener.document.inputFormN.user_id.value != ""){
				 opener.document.inputFormN.user_id.value = "<%=user_id%>"
			}
			if(opener.document.inputFormC.user_id.value != ""){
				 opener.document.inputFormC.user_id.value = "<%=user_id%>"
			}
			opener.document.getElementById('duplCheck').setAttribute('value', "true");
			self.close();
		}
	</script>
</body>
</html>