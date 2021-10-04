<%@page import="team04.project.login.signupDTO"%>
<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일반회원정보 수정</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
</head>
<%
	String id = null;
		
	//일반회원.비회원 구분처리
	if(session.getAttribute("nid")!=null){
		id = (String)session.getAttribute("nid");
		
		MypageDAO dao = MypageDAO.getInstance();
		signupDTO usern = dao.getUserN(id);
	 	%>  
		<body>
		<!-- 전체 -->
		<div class="wrap">
	
			<!-- 헤더블럭 -->
			<%@ include file="../common/header.jsp" %>
	
			<!-- 컨텐츠블럭 -->
			<div class="container">
				<%@ include file="/mypage/mypageLeft.jsp" %>
				<h1>일반회원정보 수정</h1>
				<hr><br/>
				<form action="mypageNModifyPro.jsp" method="post">
					<table>
						<tr> 
							<td width="100">이름</td>
							<td>
								<input type="text" name="usern_name" size="20" value="<%=usern.getUsern_name()%>"/>
							</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>
								<%if(usern.getUsern_email()==null){ %>
									<input type="text" name="usern_email" size="20" />
								<%}else{ %>	
									<input type="text" name="usern_email" size="20" value="<%=usern.getUsern_email()%>"/>
								<%} %>
							</td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td>
								<%if(usern.getUsern_email()==null){ %>
									<input type="text" name="usern_phone" size="20" />
								<%}else{ %>	
									<input type="text" name="usern_phone" size="20" value="<%=usern.getUsern_phone()%>"/>
								<%} %>
							</td> 
						</tr>
						<tr>
							<td>소속</td>
							<td> 
								<select name="usern_attach" >  
									<option value="teenager" <%if(usern.getUsern_attach().equals("teenager")){%> selected <%} %>> 청소년</option>
									<option value="nolimit" <%if(usern.getUsern_attach().equals("nolimit")){%> selected <%} %>> 대상제한없음</option>
									<option value="student" <%if(usern.getUsern_attach().equals("student")){%> selected <%} %>>대학생</option>
									<option value="worker" <%if(usern.getUsern_attach().equals("worker")){%> selected <%} %>>직장인/일반인</option> 
								</select>
							</td>
						</tr>
						<tr>
						<td> 지역 </td>
						<td>
							<select name="usern_local">
								<option value="seoul" <%if(usern.getUsern_local().equals("seoul")){%> selected <%} %>>서울</option>
								<option value="incheon" <%if(usern.getUsern_local().equals("incheon")){%> selected <%} %>>인천</option>
								<option value="gyeonggi" <%if(usern.getUsern_local().equals("gyeonggi")){%> selected <%} %>>경기도</option>
								<option value="gangwon" <%if(usern.getUsern_local().equals("gangwon")){%> selected <%} %>>강원도</option>
								<option value="chungcheong" <%if(usern.getUsern_local().equals("chungcheong")){%> selected <%} %>>충청도</option>
								<option value="gyeongsang" <%if(usern.getUsern_local().equals("gyeongsang")){%> selected <%} %>>경상도</option>
								<option value="jeolla" <%if(usern.getUsern_local().equals("jeolla")){%> selected <%} %>>전라도</option>
								<option value="jeju" <%if(usern.getUsern_local().equals("jeju")){%> selected <%} %>>제주도</option>
							</select>
						</tr>
						<tr>
							<td> 관심분야 </td>
							<td>
								<% if (usern.getUsern_favor() == null) {%>
									<input type="checkbox" name="usern_favor" value="design" /> 디자인
									<input type="checkbox" name="usern_favor" value="supporters" /> 서포터즈
									<input type="checkbox" name="usern_favor" value="science" /> 과학
								<% }else {%>
									<%try { %>
									<input type="checkbox" name="usern_favor" value="design" <%if(usern.getUsern_favor().equals("design")){%> checked <%} %>/> 디자인
									<input type="checkbox" name="usern_favor" value="supporters" <%if(usern.getUsern_favor().equals("supporters")){%> checked <%} %>/> 서포터즈
									<input type="checkbox" name="usern_favor" value="science" <%if(usern.getUsern_favor().equals("science")){%> checked <%} %>/> 과학
									<%} catch (Exception e){
										e.printStackTrace();
									}
								}%>
							</td>
						</tr>
						<tr>
							<td> 직업 </td>
							<td>
								<% if (usern.getUsern_favor() == null) {%>
									<input type="radio" name="usern_job" value="warrior" /> 전사(발표)
									<input type="radio" name="usern_job" value="magician" /> 마법사(포토샵)
									<input type="radio" name="usern_job" value="rogue" /> 도적(기획)
									<input type="radio" name="usern_job" value="archer" /> 궁수(디자인)
									<input type="radio" name="usern_job" value="healer" /> 힐러(문서작성)
								<% }else {%>
									<%try { %>
									<input type="radio" name="usern_job" value="warrior" <%if(usern.getUsern_job().equals("warrior")){%> checked <%} %>/> 전사(발표)
									<input type="radio" name="usern_job" value="magician" <%if(usern.getUsern_job().equals("magician")){%> checked <%} %>/> 마법사(포토샵)
									<input type="radio" name="usern_job" value="rogue" <%if(usern.getUsern_job().equals("rogue")){%> checked <%} %>/> 도적(기획)
									<input type="radio" name="usern_job" value="archer" <%if(usern.getUsern_job().equals("archer")){%> checked <%} %>/> 궁수(디자인)
									<input type="radio" name="usern_job" value="healer" <%if(usern.getUsern_job().equals("healer")){%> checked <%} %>/> 힐러(문서작성)
									<%} catch (Exception e){
										e.printStackTrace();
									}
								}%>						
							</td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<input type="submit" value="수정" />										
								<input type="reset" value="재작성" />
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