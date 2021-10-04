<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	isErrorPage="true" %>
	<% response.setStatus(200); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ErrorPage</title>
<link href="style.css" type="text/css" rel="stylesheet">
</head>
<!-- 전체 -->
<div class="wrap">

	<!-- 헤더블럭 -->
	<%@ include file="../common/header.jsp" %>
	
	<!-- 컨텐츠블럭 -->
	<div class="container" align="center">

	</div>
</div>
<body>

	<img src="imgs/error.png" width="500" height="500" />

	<!-- 풋터블럭 -->
	<%@ include file="../common/footer.jsp"%>
</body>
</html>