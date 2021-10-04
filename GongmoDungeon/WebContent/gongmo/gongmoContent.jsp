<%@page import="team04.project.login.signupDTO"%>
<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GmBoardContent</title>
<link href="style.css" type="text/css" rel="stylesheet">
<style>
	#circle{
		width:60px;
		height: 60px;
		border-radius: 50%;
		background: yellow;
		font-size: 15px;
		text-align: center;
	}
	ul{
		list-style: none;
		text-align: center;
	}
	li{
		display: inline-block;
		float: left;
		margin-left: 15%;
	}
	h2:hover{
		color: blue;
	}
</style>
</head>
<%
 String strReferer = request.getHeader("referer");
 
 if(strReferer == null){
%>
 <script language="javascript">
  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.정상적인 경로를 통해 다시 접근해 주십시오.");
  document.location.href="../main/main.jsp";
 </script>
<%
  return;
 }
%>
<%	
	String id =(String)session.getAttribute("cid");
	if(id==null){
		id =(String)session.getAttribute("nid");
	}
	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	System.out.println("gmborad num = "+ num);
	

	GongmoDAO dao = new GongmoDAO();
	GongmoWriteDTO gmdto = dao.getGmBoardList(num);
	String path = request.getRealPath("gongmoFile");
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 전체 -->
	<div class="wrap">

		<!-- 헤더블럭 -->
		<%@ include file="../common/header.jsp" %>

	<!-- 컨텐츠블럭 -->
		<div class="container" align="center">
	
	<body>
		<table width="950" style="table-layout: fixed;">
			<tr>
				<td width="300"><h3><%=gmdto.getGmboard_title() %></h3></td>
				<%
				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
				// 마감날짜 String -> Date 형식 변환
				Date eday1 = sd.parse(gmdto.getGmboard_eday());
				System.out.println("eday1 = "+eday1);
				// 오늘 날짜
				Date today = new Date();
				System.out.println("today = "+today.getTime());
				long eday2 = Math.abs(eday1.getTime());
				long Dday = (eday2-today.getTime())/1000;
				Dday= Dday/(24*60*60);
				System.out.println("eDays = "+ eday2);
				System.out.println("Dday = "+ Dday);
				%>
				<td width="120">
				<b style="color: blue;">
				<%
						if(Dday >0){%>
							D-<%=Dday-1 %></b>
						<%}else{%>
							D+<%=Math.abs(Dday) %></b>
						<%}%>
				</td>
				<!-- 스크랩에 id,pw 가 맞는게 있고 없고 체크 -->
				<%
				// 일반회원 로그인시에만 스크랩 기능 활성화 시키기
				if(session.getAttribute("nid") != null && session.getAttribute("nid").equals("admin")){%>
					<td width="250"> </td>
				<%}else if(session.getAttribute("nid") != null){
					int sresult = dao.scrapYN(id, num);
					if(sresult ==1){%>
						<td width="250"><img src="../common/imgs/heart.png" width="30" height="30" onclick="window.location='gongmoScrapPro.jsp?gmboard_num=<%=num%>&scrap=<%=sresult%>'"></td>
					<%}else{%>
						<td width="250"><img src="../common/imgs/like.png" width="30" height="30" onclick="window.location='gongmoScrapPro.jsp?gmboard_num=<%=num%>&scrap=<%=sresult%>'"></td>
					<%}%>
				<%}else if(session.getAttribute("cid")!=null) {
					// 기업회원 or 비로그인한 or admin 사람 한테는 안보임%>
					<td width="250"> </td>
				<%}else{%>
					<td width="250"> </td>
				<%} %>
				
					<%
						if(session.getAttribute("cid") != null && id.equals(gmdto.getGmboard_id())){%>
							<td><button onclick="window.location='gongmoModifyForm.jsp?gmboard_num=<%=num%>'">수정</button></td>
							<td><button onclick="deletePopup()">삭제</button></td>
						<%}else if(session.getAttribute("nid") != null && session.getAttribute("nid").equals("admin")){%>
							<td></td>
							<td><button onclick="deletePopup()">삭제</button></td>
						<%}else {%>
							<td width="80"></td>
							<td width="120"></td>
						<%}%>
			</tr>
			<tr>
				<td rowspan="5"><img src="../gongmoFile/<%=gmdto.getGmboard_poster() %>" width="300" height="300" /></td>
				<td><b style="color: blue;">기업명</b></td> <td><%=gmdto.getGmboard_name() %></td>
				<td><b style="color: blue;">대상자</b></td> <td><%=gmdto.getGmboard_target() %></td>
			</tr>
			<tr>		
			  	
				<td><b style="color: blue;">기관형태</b></td>
				<td>
				<%
					if(gmdto.getGmboard_type().equals("major")){%>
							대기업
					<%}else if(gmdto.getGmboard_type().equals("startup")){%>
							중소기업/스타트업
					<%}else if(gmdto.getGmboard_type().equals("public")){%>
							공공기관/공기업
					<%}else if(gmdto.getGmboard_type().equals("foreign")){%>
							외국계기업
					<%}else if(gmdto.getGmboard_type().equals("midsize")){%>
							중견기업
					<%}else if(gmdto.getGmboard_type().equals("association")){%>
							비영리단체/협회/교육재단
					<%}else if(gmdto.getGmboard_type().equals("band")){%>
							동아리/학생자치단체
					<%}else if(gmdto.getGmboard_type().equals("hospital")){%>
							경원
					<%}else if(gmdto.getGmboard_type().equals("etc")){%>
							기타
					<%}
				%>
					
				 </td>
				<td><b style="color: blue;">수상인원</b></td> <td><%=gmdto.getGmboard_winner() %>명</td>
			</tr>
			<tr>
				<td><b style="color: blue;">기간</b></td> <td><%=gmdto.getGmboard_sday() %> ~ <%=gmdto.getGmboard_eday() %> </td>
				<td><b style="color: blue;">분야</b></td> <td><%=gmdto.getGmboard_favor() %></td>
			</tr>
			<tr>
				<td><b style="color: blue;">시상규모</b></td> <td><%if(gmdto.getGmboard_money().equals("none")){%>
												상금 X
										<%}else if(gmdto.getGmboard_money().equals("money1")){%>
											5천만원 이상
										<%}else if(gmdto.getGmboard_money().equals("money2")){%>
											3천만원 ~ 5천만원
										<%}else if(gmdto.getGmboard_money().equals("money3")){%>
											1천만원 ~ 3천만원
										<%}else if(gmdto.getGmboard_money().equals("money4")){%>
											1천만원 이하
										<%}else if(gmdto.getGmboard_money().equals("money5")){%>
											상금 X
										<%}
				
										%></td>
				<td><b style="color: blue;">시상혜택</b></td> <td><%=gmdto.getGmboard_benefit() %></td>
			</tr>
			<tr>
				<td><b style="color: blue;">홈페이지 지원</b></td> <td colspan="2"><a href="http://<%=gmdto.getGmboard_url()%>" style="text-decoration:none"><%=gmdto.getGmboard_url() %></button></td>
				<td>
				<%
				// history에 해당 공모가 있으면 참가 완료 없으면 참가하기 버튼 활성화
				// 기업 회원 또는 admin 일때 
				
				
				
				
				if(session.getAttribute("nid") != null){
					signupDTO sdto = dao.userhistory(id);
					//gmboard_num 비교하기 위해 String 타입으로 받기
					String num1 = request.getParameter("gmboard_num");
					System.out.println("참가완료 공모전 = "+sdto.getUsern_history());
					System.out.println("공모전 번호 = "+num1);
					if(sdto.getUsern_history().contains(num1)){%>
						참가완료
					<%}else if(session.getAttribute("cid")!=null || session.getAttribute("nid").equals("admin")){%>
						
					<%}else {%>
						<input id="circle" type="button" value="참가" onclick="window.location='gongmohistory.jsp?gmboard_num=<%=num%>'" style="cursor: pointer;"/>
					<%}
					}%>
				
				</td>
			</tr>
			<tr>
				<td colspan="5" align="center">
				<br /><br />
				<ul>
					<li id="content" style="cursor: pointer;"><h2>상세내용</h2></li>
					<li id="teamlist" style="cursor: pointer;"><h2>팀원모집</h2></li>
					<li id="contentqna" style="cursor: pointer;"><h2>Q&A</h2></li>
				</ul>
			</tr>
			<tr>
				<td colspan="5" align="center">
				<div id="a1">
				<br />
					<%=gmdto.getGmboard_content()%><br /><br /><br />
					첨부파일 : <a href="../community/filedownload.jsp?fileName=<%=gmdto.getGmboard_file()%>"><%=gmdto.getGmboard_file()%></a>
					
				</div>
				<div id="b1">
					<br />
					<%@ include file="gongmoTeamList.jsp"%>
				</div>
				<div id="c1">
				<br />
					<%@ include file="../gongmo/gongmoContentQnA.jsp"%>
				</div>							
				</td>
			</tr>		
		</table>
	
</div>
		<!-- 풋터블럭 -->
			<%@ include file="../common/footer.jsp"%>
		</div>

</body>
<script>
	$(document).ready(function(){
	    $("#a1").show();
	    $("#b1").hide();
	    $("#c1").hide();
	})
	function deletePopup() { 
	  window.open("gongmoDeleteForm.jsp?gmboard_num="+<%=num%>, "a", "width=400, height=300, left=100, top=50"); 
	  }
	$('#content').click(function() {
	    $("#a1").show();
	    $("#b1").hide();
	    $("#c1").hide();
	    // content을 클릭하면 a1를 보여줘라
	})
	$('#teamlist').click(function() {
		 $("#a1").hide();
		 $("#b1").show();
		 $("#c1").hide();
	    // teamlist을 클릭하면 b1를 숨겨라
	 
	})
	$('#contentqna').click(function() {
		 $("#a1").hide();
		 $("#b1").hide();
		 $("#c1").show();
	    // contentqna을 클릭하면 c1를 숨겨라
	 
	})
</script>
</html>