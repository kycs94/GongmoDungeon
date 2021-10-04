<%@page import="team04.project.login.signupDTO"%>
<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>기업회원정보 수정</title>
	<link href="../common/style.css" rel="stylesheet" type="text/css" >	
</head> 
<%
	String id = null;
		
	// 기업회원. 비회원 구분 처리
	if(session.getAttribute("cid")!=null){
		id = (String)session.getAttribute("cid");
		MypageDAO dao = MypageDAO.getInstance();
		signupDTO userc = dao.getUserC(id);
		%> 
		<body>
		<!-- 전체 -->
		<div class="wrap">
	
			<!-- 헤더블럭 -->
			<%@ include file="../common/header.jsp" %>
	
			<!-- 컨텐츠블럭 -->
			<div class="container">
				<%@ include file="/mypage/mypageLeft.jsp" %>
				<h1>회원정보 수정</h1>
				<hr><br/>
				<form action="mypageCModifyPro.jsp" method="post">
					<table>
						<tr> 
							<td width="100">기업명</td>
							<td>
								<input type="text" name="userc_name" size="20" value="<%=userc.getUserc_name()%>"/>
							</td>
						</tr>
						<tr>
							<td>기업형태</td>
							<td>
								<select name="userc_type" >  
									<option value="major" <%if(userc.getUserc_type().equals("major")){%> selected <%}%>>대기업</option>
									<option value="startup" <%if(userc.getUserc_type().equals("startup")){%> selected <%}%>>중소기업/스타트업</option>
									<option value="public" <%if(userc.getUserc_type().equals("public")){%> selected <%}%>>공공기관/공기업</option>
									<option value="foreign" <%if(userc.getUserc_type().equals("foreign")){%> selected <%} %>>외국계기업</option>
									<option value="midsize" <%if(userc.getUserc_type().equals("midsize")){%> selected <%}%>>중견기업</option>
									<option value="association" <%if(userc.getUserc_type().equals("association")){%> selected <%}%>>비영리단체/협회/교육재단</option>
									<option value="band" <%if(userc.getUserc_type().equals("band")){%> selected <%}%>>동아리/학생자치단체</option>
									<option value="hospital" <%if(userc.getUserc_type().equals("hospital")){%> selected <%} %>>병원</option>
									<option value="etc" <%if(userc.getUserc_type().equals("etc")){%> selected <%} %>>기타</option> 
								</select>
						</tr>
						<tr>
							<td>사업자번호</td>
							<td>
								<%if(userc.getUserc_num()==null){ %>
									<input type="text" name="userc_num" size="20" />
								<%}else{ %>	
									<input type="text" name="userc_num" size="20" value="<%=userc.getUserc_num()%>"/>
								<%} %>
							</td>
						</tr>
						<tr>
							<td>홈페이지</td>
							<td>
								<%if(userc.getUserc_url()==null){ %>
									<input type="text" name="userc_url" size="20" />
								<%}else{ %>	
									<input type="text" name="userc_url" size="20" value="<%=userc.getUserc_url()%>"/>
								<%} %>
							</td>
						</tr>
						<tr>
							<td>이메일주소</td>
							<td>
								<%if(userc.getUserc_email()==null){ %>
									<input type="text" name="userc_email" size="20" />
								<%}else{ %>	
									<input type="text" name="userc_email" size="20" value="<%=userc.getUserc_email()%>"/>
								<%} %>
							</td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<input type="submit" value="수정" />										
								<input type="reset" value="재작성" />					
								<input type="button" value="취소" onclick="window.location='mypageMyinfo.jsp'" />
							</td>
						</tr> 
					</table>
				</form>
			</div>

		<!-- 풋터블럭 -->
		<%@ include file="../common/footer.jsp" %>
		</div>
		</body>
	<%}else{%>	
		<script>
			alert("로그인해주세요.");
			window.location.href="../main/main.jsp";
		</script>
	<%}%>	
</html>