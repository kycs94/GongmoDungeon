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
 <script>
  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다. 정상적인 경로를 통해 다시 접근해 주십시오.");
  document.location.href="../main/main.jsp";
 </script>
<%
  return;
 }
%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	String sender = request.getParameter("send");
	String receiver = request.getParameter("receive");
	if(sender.equals("null")){%>
		<script type="text/javascript">
			alert("로그인 후 이용해주세요.");
			self.close();
		</script>
	<%}else if(sender.equals(receiver)){%>
		<script type="text/javascript">
			alert("다른사람에게만 쪽지를 보낼 수 있습니다.");
			self.close();
		</script>
	<%}
%>
<script type="text/javascript">
	function check(){
		var result = true;
		if($("textarea[name=content]").val()==""){
			result = false;
			alert("내용을 입력해주세요.");
			$("textarea[name=content]").focus();
		}
		return result;
	}
</script>
<body>
<form action="sendmsgPro.jsp?send=<%=sender%>&receive=<%= receiver %>" method="post" onsubmit="return check()">
	<table>
		<tr>
			<td>보내는 사람</td>
			<td><%= sender %></td>
		</tr>
		<tr>
			<td>받는 사람</td>
			<td><%= receiver %></td>
		</tr>
		<tr>
			<td colspan="2"><textarea name="content"></textarea></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="전송"/></td>
		</tr>
	</table>
</form>
</body>
</html>