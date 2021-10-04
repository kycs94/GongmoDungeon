<%@page import="team04.project.login.signupDTO"%>
<%@page import="team04.project.login.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login pro</title>
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
	// 파라미터 받기 : loginForm 타고 왔을때 처리 (main에서 바로 날아왔으면 아래 변수는 null 상태로 끝남)
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	String auto = request.getParameter("auto"); // 자동로그인 체크 박스 값 꺼내기
	String orgType = request.getParameter("orgType");

	Cookie[] coos = request.getCookies();
	if (coos != null) {
		for (Cookie c : coos) {
			if (c.getName().equals("autoId")) {
				user_id = c.getValue();
			}
			if (c.getName().equals("autoPw")) {
				user_pw = c.getValue();
			}
			if (c.getName().equals("autoCh")) {
				auto = c.getValue();
			}
			if (c.getName().equals("orgTypeCh")) {
				orgType = c.getValue();
			}
		}
	}
		// 로그인 체크
		LoginDAO dao = LoginDAO.getInstance();
		// 일반 회원일때
		if (orgType.equals("normal")) {
			signupDTO sdto = dao.activeCheck(user_id, orgType);
			if (sdto.getUsern_active() == 1) { // active가 1이면 추방당한 일반 회원	
%>
<script>
	alert("<%=user_id%>, 님 '<%=sdto.getUsern_dropmsg()%>' 이유로 관리자에게 추방되었습니다.");
	window.location = "../main/main.jsp";
</script>
<%
	} else { // active 가 1 이 아닐때 로그인 시켜야지...
			boolean res = dao.idPwCheck(user_id, user_pw, orgType);
			if (res) { // 사용자가 입력한 id,pw가 맞다 -> 로그인 처리

				if (auto != null) { // 자동로그인 체크하고 로그인 시도했다.
					// 쿠키 생성
					Cookie c1 = new Cookie("autoId", user_id);
					c1.setDomain("localhost");
					c1.setPath("/team04");
					Cookie c2 = new Cookie("autoPw", user_pw);
					c2.setDomain("localhost");
					c2.setPath("/team04");
					Cookie c3 = new Cookie("autoCh", auto);
					c3.setDomain("localhost");
					c3.setPath("/team04");
					Cookie c4 = new Cookie("orgTypeCh", orgType);
					c4.setDomain("localhost");
					c4.setPath("/team04");
					c1.setMaxAge(60 * 60 * 24); // 24시간 // 쿠키기간 갱신
					c2.setMaxAge(60 * 60 * 24); // 24시간
					c3.setMaxAge(60 * 60 * 24); // 24시간
					c4.setMaxAge(60 * 60 * 24); // 24시간
					response.addCookie(c1);
					response.addCookie(c2);
					response.addCookie(c3);
					response.addCookie(c4);
				}
				if ("normal".equals(orgType)) { // 일반회원
					session.setAttribute("nid", user_id);
				} else { // 기업회원
					session.setAttribute("cid", user_id);
				}
				// 세션에 속성 추가 == 로그인 처리함
				response.sendRedirect("../main/main.jsp"); // main으로 이동

			} else {
%>

<script>
	alert("id 또는 pw가 일치하지 않습니다. 다시 시도해주세요.");
	history.go(-1);
</script>

<%
	}
		}
	} else { // normal이 아닐때 그말은 즉, 기업회원 일때
		boolean res = dao.idPwCheck(user_id, user_pw, orgType);
		if (res) { // 사용자가 입력한 id,pw가 맞다 -> 로그인 처리

			if (auto != null) { // 자동로그인 체크하고 로그인 시도했다.
				// 쿠키 생성
				Cookie c1 = new Cookie("autoId", user_id);
				c1.setDomain("localhost");
				c1.setPath("/team04");
				Cookie c2 = new Cookie("autoPw", user_pw);
				c2.setDomain("localhost");
				c2.setPath("/team04");
				Cookie c3 = new Cookie("autoCh", auto);
				c3.setDomain("localhost");
				c3.setPath("/team04");
				Cookie c4 = new Cookie("orgTypeCh", orgType);
				c4.setDomain("localhost");
				c4.setPath("/team04");
				c1.setMaxAge(60 * 60 * 24); // 24시간 // 쿠키기간 갱신
				c2.setMaxAge(60 * 60 * 24); // 24시간
				c3.setMaxAge(60 * 60 * 24); // 24시간
				c4.setMaxAge(60 * 60 * 24); // 24시간
				response.addCookie(c1);
				response.addCookie(c2);
				response.addCookie(c3);
				response.addCookie(c4);
			}
			if ("normal".equals(orgType)) { // 일반회원
				session.setAttribute("nid", user_id);
			} else { // 기업회원
				session.setAttribute("cid", user_id);
			}
			// 세션에 속성 추가 == 로그인 처리함
			response.sendRedirect("../main/main.jsp"); // main으로 이동

		} else {
%>

<script>
	alert("id 또는 pw가 일치하지 않습니다. 다시 시도해주세요.");
	history.go(-1);
</script>

<%
	}
	}
%>
<body>


</body>
</html>