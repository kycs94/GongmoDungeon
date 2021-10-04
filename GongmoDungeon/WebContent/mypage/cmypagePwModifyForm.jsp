<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script>
		function pwCheck(){
			var inputs = document.inputForm;
			if(!inputs.pw.value) {
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(!inputs.newPw.value){
				alert("새로운 비밀번호를 입력하세요.");
				return false;
			}
			if(!inputs.newPwCh.value) {
				alert("새로운 비밀번호 확인을 입력하세요.");
				return false;
			}
			if(inputs.newPw.value != inputs.newPwCh.value) {
				alert("새로운 비밀번호를 동일하게 입력하세요.");
				return false;
			}
		}
	</script>
</head>
<%
	if(session.getAttribute("cid") == null) { %>
	<script>
		alert("로그인을 해주세요.");
		window.location='../main/main.jsp';
	</script>	
<%	}else{
	String id = (String)session.getAttribute("cid");
	}
%>
<body class="container">
<%@ include file="../common/header.jsp" %>
<jsp:include page="mypageLeft.jsp"></jsp:include>
	<h3> 비밀번호 변경 </h3>
	<hr />
	
	<form action="cmypagePwModifyPro.jsp" method="post" name="inputForm" onsubmit="return pwCheck()">
		<table>
			<tr>
				<td> <%=session.getAttribute("cid") %>, 님 </td>
			</tr>
			<tr>
				<td> <br /> 현재 비밀번호 <input type="password" name="pw"> </td>
			</tr>
			<tr>
				<td> <br /> 새 비밀번호 <input type="password" name="newPw"/> </td>
			</tr>
			<tr>
				<td> <br /> 새 비밀번호 확인 <input type="password" name="newPwCh"/> </td>
			</tr>
			<tr>
				<td> <br /> <button> 변경 </button> <input type="reset" value="취소" /></td>
			</tr>
			
		</table>
	</form>
<%@ include file="../common/footer.jsp" %>
</body>
</html>