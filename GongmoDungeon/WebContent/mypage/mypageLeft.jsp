<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
	#left{
		float: left;
		width:200px;
		height: 400px;
	}
	</style>
</head>
<%
	String nid = (String)session.getAttribute("nid");
	String cid = (String)session.getAttribute("cid");
%>
<body>
	<%if(cid==null && nid.equals("admin") ){%>
	<div id="left">
		<a style="cursor : pointer;" onclick="window.location='myUsernInfo.jsp'">일반회원 관리</a> <br />
		<a style="cursor : pointer;" onclick="window.location='myUsercInfo.jsp'">기업회원 관리</a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageMsg.jsp'">쪽지함</a> <br />
	</div>
	<%}else if(nid != null){ %>
	<div id="left">
		<a style="cursor : pointer;" onclick="window.location='mypageMyinfo.jsp'"> 내 정보 </a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageNModifyForm.jsp'">회원정보 수정 </a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypagePwModifyForm.jsp'"> 비밀번호 변경 </a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageMsg.jsp'">쪽지함</a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageMyScrap.jsp'">스크랩 내역</a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageMyTeam.jsp'"> 팀원 관리 </a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageMyHistory.jsp'">참가 내역 </a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageDropForm.jsp'">회원 탈퇴 </a> <br />
	</div>
	<%}else if(cid != null) { %>
	<div id="left">
		<a style="cursor : pointer;" onclick="window.location='mypageMyinfo.jsp'"> 내 정보 </a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageGongmoWrite.jsp'"> 공모등록 </a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageCModifyForm.jsp'">회원정보 수정 </a><br />
		<a style="cursor : pointer;" onclick="window.location='cmypagePwModifyForm.jsp'"> 비밀번호 변경 </a> <br />
		<a style="cursor : pointer;" onclick="window.location='mypageDropForm.jsp'">회원 탈퇴 </a> <br />
	</div>
	<%}else{ %>
		<h2> 로그인이 필요합니다. </h2>
		<button onclick="window.location='/gongmo/login/loginForm.jsp'">메인으로</button>
	<%} %>
</body>
</html>