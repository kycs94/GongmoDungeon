<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 탈퇴</title>
	<link href="style.css" rel="stylesheet" type="text/css" >	
</head>
<body>
	<!-- 전체 -->
	<div class="wrap">

		<!-- 헤더블럭 -->
		<%@ include file="../common/header.jsp" %>

		<!-- 컨텐츠블럭 -->
		<div class="container">
			<%@ include file="/mypage/mypageLeft.jsp" %>
			<h1>회원 탈퇴</h1> 
			<hr>
			<form action="mypageDropPro.jsp" method="post">
				<table height="120" style="text-align:center;"> 
					<tr>
						<td> 탈퇴를 원하시면 비밀번호를 입력해주세요.</td>
					</tr>
					<tr>
						<td> <input type="password" name="pw" /> </td>
					</tr>
					<tr>
						<td>
							<input type="submit" value="탈퇴" />
							<input type="button" value="취소" onclick="window.location='mypageMyinfo.jsp'"/>
						</td>
					</tr>
				</table>	
			</form>
		</div>
		
		<!-- 풋터블럭 -->
		<%@ include file="../common/footer.jsp" %>
	</div>
</body>
</html>