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
<%
	request.setCharacterEncoding("UTF-8");
	String dropidn= request.getParameter("usern_id") ;
	System.out.println("일반아이디 = "+ dropidn);
	if(dropidn.equals("null")){%>
	<script type="text/javascript">
		alert("로그인 후 이용해주세요.");
		self.close();
	</script>
<%}else if(dropidn.equals(session.getAttribute("nid"))){%>
	<script type="text/javascript">
		alert("관리자 외 다른 사람만 추방 가능합니다.");
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

		<form action="dropmsgPro.jsp?usern_id=<%=dropidn%>" method="post" onsubmit="return check()">
	<table>
		<tr>
			<td>추방할 ID => <%= dropidn %></td>
		</tr>
		<tr>
			<td><textarea name="content"></textarea></td>
		</tr>
		<tr>
			<td><input type="submit" value="전송"/></td>
		</tr>
	</table>
</form>

</body>
</html>