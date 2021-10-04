<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 탈퇴</title>
	<link href="style.css" rel="stylesheet" type="text/css" >	
</head>

<% 

	String id = null;
	String pw = null;
	//넘어온 유저 nid/cid/비회원에 따라 각각처리
	
	if(session.getAttribute("nid")!=null){ //일반회원일때
		id = (String)session.getAttribute("nid");
		pw = request.getParameter("pw");
	
		MypageDAO dao = MypageDAO.getInstance();  
		int result = dao.deleteUserN(id,pw);
		// result == 1: 성공 / 0: 비번잘못 / -1:비번확인부터 잘못되었음.
		if(result == 1){
			// 회원 탈퇴시 로그아웃 처리도 함께
			session.invalidate();				
	%>
		<body>
			<script>
				alert("탈퇴되었습니다.");
				window.location.href="../main/main.jsp";
			</script>
		</body>
		<% }else{ %>
			<script>
				alert("비밀번호가 맞지 않습니다. 다시 시도해주세요.");
				history.go(-1);
			</script>
		<% } 
	} else if(session.getAttribute("cid")!=null){ //기업회원일때
		id = (String)session.getAttribute("cid");
		pw = request.getParameter("pw");
	
		MypageDAO dao = MypageDAO.getInstance();  
		int result = dao.deleteUserC(id,pw);  
		// result == 1: 성공 / 0: 비번잘못 / -1:비번확인부터 잘못되었음.
		if(result == 1){
			// 회원 탈퇴시 로그아웃 처리도 함께
			session.invalidate();				
	%>
		<body>
			<script>
				alert("탈퇴되었습니다.");
				window.location.href="../main/main.jsp";
			</script>
		</body>
		<% }else{ %>
			<script>
				alert("비밀번호가 맞지 않습니다. 다시 시도해주세요.");
				history.go(-1);
			</script>
		<% } 		
	} else { // 비회원일때%>
		<script>
		alert("로그인해주세요.");
		window.location.href="../main/main.jsp";
		</script>	
	<%}%>
</html>