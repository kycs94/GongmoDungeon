<%@page import="team04.project.login.signupDTO"%>
<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>내 정보 확인</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
	
</head> 
<%
	String id = null;
	//넘어온 유저 nid/cid/비회원에 따라 각각처리
	
	if(session.getAttribute("nid")!=null){
		id = (String)session.getAttribute("nid");
		
		//DB 가져오기
		MypageDAO dao = MypageDAO.getInstance();
		signupDTO infoN = dao.infoN(id);
		%>
		
		<body>
		<!-- 전체 -->
		<div class="wrap">
	
			<!-- 헤더블럭 -->
			<%@ include file="../common/header.jsp" %>
	
			<!-- 컨텐츠블럭 -->
			<div class="container">
			<%@ include file="/mypage/mypageLeft.jsp" %>
				<h1>내 정보</h1>
				<hr>
				<table> 
					<tr > 
						<td width="100">닉네임</td>
						<td><%=infoN.getUsern_id() %></td>
					</tr> 
					<tr>
						<td>이름</td>
						<td><%=infoN.getUsern_name() %></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>
							<%if (infoN.getUsern_email() == null) {%>등록된 이메일이 없습니다.<%} 
							else {%>
								<%=infoN.getUsern_email() %>
							<%}%> 
						<td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>
							<%if (infoN.getUsern_phone() == null) {%>등록된 이메일이 없습니다.<%} 
							else {%>
								<%=infoN.getUsern_phone() %>
							<%}%> 
						<td>
					</tr>
					<tr>
						<td>소속</td>
						<td>
						<% if (infoN.getUsern_attach() == null) {%>등록된 소속이 없습니다.<%}
						else if (infoN.getUsern_attach().equals("teenager")) {%>청소년<%}
						else if (infoN.getUsern_attach().equals("nolimit")) {%>대상 제한 없음<%}
						else if (infoN.getUsern_attach().equals("student")) {%>대학생<%}
						else if (infoN.getUsern_attach().equals("worker")) {%>직장인/일반인<%}
						else {%>소속 오류<%}%>
					</td>
					</tr>
					<tr>
						<td>지역</td>
						<td>
						<% if (infoN.getUsern_local() == null) {%>등록된 지역이 없습니다.<%}
						else if (infoN.getUsern_local().equals("seoul")) {%>서울<%}
						else if (infoN.getUsern_local().equals("incheon")) {%>인천<%}
						else if (infoN.getUsern_local().equals("gyeonggi")) {%>경기도<%}
						else if (infoN.getUsern_local().equals("gangwon")) {%>강원도<%}
						else if (infoN.getUsern_local().equals("chungcheong")) {%>충청도<%}
						else if (infoN.getUsern_local().equals("gyeongsang")) {%>경상도<%}
						else if (infoN.getUsern_local().equals("jeolla")) {%>전라도<%}
						else if (infoN.getUsern_local().equals("jeju")) {%>제주도<%}
						else {%>지역 오류<%}%>
					</td>
					</tr>
					<tr>
						<td>관심분야</td>
						<td>
						<% if (infoN.getUsern_favor() == null) {%>등록된 관심분야가 없습니다.<%}
						else if (infoN.getUsern_favor().equals("design,supporters,science")) {%>디자인, 서포터즈, 과학<%}
						else if (infoN.getUsern_favor().equals("design,supporters")) {%>디자인, 서포터즈<%}
						else if (infoN.getUsern_favor().equals("design,science")) {%>디자인, 과학<%}
						else if (infoN.getUsern_favor().equals("supporters,science")) {%>서포터즈, 과학<%}
						else if (infoN.getUsern_favor().equals("design")) {%>디자인<%}
						else if (infoN.getUsern_favor().equals("supporters")) {%>서포터즈<%}
						else if (infoN.getUsern_favor().equals("science")) {%>과학<%}
						else {%>관심분야 오류<%}%>
					</td>
					</tr>
					<tr>
						<td>직업</td>
						<td>
						<% if (infoN.getUsern_job() == null) {%>등록된 직업이 없습니다.<%}
						else if (infoN.getUsern_job().equals("warrior")) {%>전사(발표)<%}
						else if (infoN.getUsern_job().equals("magician")) {%>마법사(포토샵)<%}
						else if (infoN.getUsern_job().equals("rogue")) {%>도적(기획)<%}
						else if (infoN.getUsern_job().equals("archer")) {%>궁수(디자인)<%}
						else if (infoN.getUsern_job().equals("healer")) {%>힐러(문서작성)<%}
						else {%>직업 오류<%}%>
					</td>
					</tr>
					<tr>
						<td>별점</td>
						<td>
						<% if (infoN.getUsern_popul() < 2){ %>
							<img src="../common/imgs/star.png" width="20"/>
						<% } else if (infoN.getUsern_popul() >= 2 && infoN.getUsern_popul() < 4) { %>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
						<% } else if (infoN.getUsern_popul() >= 4 && infoN.getUsern_popul() < 6) { %>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
						<% } else if (infoN.getUsern_popul() >= 6 && infoN.getUsern_popul() < 8) { %>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
						<% } else if (infoN.getUsern_popul() >= 8) { %>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
							<img src="../common/imgs/star.png" width="20"/>
						<% } else { %>
							별점 오류
						<%} %>
						</td>
						<td><%=infoN.getUsern_popul() %></td>
					</tr>
					<tr>
						<td>참여횟수</td>
						<td><%
						if (infoN.getUsern_history() == null) { %>
							0회
						<%} else {
							String history = dao.historyList(id);
							String[] historyarr = history.split(","); %>
							<%=historyarr.length %> 회
						
						<%}%>
					<input type="button" value="자세히보기" onclick="window.location='mypageMyHistory.jsp'"/></td>
					</tr>								
				</table>
			</div>
			
			<!-- 풋터블럭 -->
			<%@ include file="../common/footer.jsp" %>
		</div>
		</body>
	<%}else if(session.getAttribute("cid")!=null){
		id = (String)session.getAttribute("cid");
		
		//DB 가져오기
		MypageDAO dao = MypageDAO.getInstance();
		signupDTO infoC = dao.infoC(id);  	
		%>
		
		<body>
		<!-- 전체 -->
		<div class="wrap">
	
			<!-- 헤더블럭 -->
			<%@ include file="../common/header.jsp" %>
	
			<!-- 컨텐츠블럭 -->
			<div class="container">
			<%@ include file="/mypage/mypageLeft.jsp" %>
			<h1>내 정보</h1>
			<hr>
			<table> 
				<tr > 
					<td width="100">아이디</td>
					<td><%=infoC.getUserc_id() %></td>
				</tr> 
				<tr>
					<td>기업명</td>
					<td><%=infoC.getUserc_name() %></td>
				</tr>
				<tr>
					<td>기업형태</td>
					<td>
						<% if (infoC.getUserc_type().equals("major")) {%>대기업<%} 
						else if (infoC.getUserc_type().equals("startup")) {%>중소기업/스타트업<%}
						else if (infoC.getUserc_type().equals("public")) {%>공공기관/공기업<%}
						else if (infoC.getUserc_type().equals("foreign")) {%>외국계기업<%}
						else if (infoC.getUserc_type().equals("midsize")) {%>중견기업<%}
						else if (infoC.getUserc_type().equals("association")) {%>비영리단체/협회/교육재단<%}
						else if (infoC.getUserc_type().equals("band")) {%>동아리/학생자치단체<%}
						else if (infoC.getUserc_type().equals("hospital")) {%>병원<%}
						else if (infoC.getUserc_type().equals("etc")) {%>기타<%}
						else {%>선택된 기업형태가 없습니다.<%}%>
					</td>
				</tr>
				<tr>
					<td>사업자번호</td> 
					<td><%=infoC.getUserc_num() %></td>
				</tr> 
				<tr>
					<td>홈페이지</td>
					<td>
						<%if (infoC.getUserc_url() == null) {%>등록된 홈페이지가 없습니다.<%} 
						 else {%>
							<%=infoC.getUserc_url()%>
						<%}%>
					<td>		
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<%if (infoC.getUserc_email() == null) {%>등록된 이메일이 없습니다.<%} 
						else {%>
							<%=infoC.getUserc_email()%>
						<%}%>
					<td> 
				</tr>							
			</table>
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