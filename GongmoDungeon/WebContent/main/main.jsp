<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.login.signupDTO"%>
<%@page import="team04.project.login.LoginDAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공모던전</title>
</head>
<%
	LoginDAO dao = LoginDAO.getInstance();
	List hallOfFameList = null;
	hallOfFameList = dao.getHallOfFameList();
	
	List populList = null;
	populList = dao.getPopulList();
	
	List gongmoList = null;
	gongmoList = dao.getGongmoList();
%>

<body>

<%@ include file="../common/header.jsp" %>
		<!-- 컨텐츠블럭 -->
		<div class="container" align="center">
			<div class="content">
				<div>	
					<h2>★☆★☆★☆★☆ 명예의전당 ☆★☆★☆★☆★</h2>
					
					<div style="float:left; width:33%;">
						<h3>수상횟수 TOP3</h3>
						<%
						if(hallOfFameList != null){
							for(int i = 0; i < hallOfFameList.size(); i++){
								signupDTO hallOfFame = (signupDTO)hallOfFameList.get(i); 
							%>
								<tr>
									<td> <%=(i+1) + "위." %> <%=hallOfFame.getUsern_id()%> <br /> </td>
								</tr>
							<% }
						}else {%>
							수상자가 없습니다.
						<%}%>
						
					</div>
					<div style="float:left; width:33%;">
						<img src="../common/imgs/trophy.png" width="150" height="150" />
					</div>
					<div style="float:left; width:33%;">
						<h3>평판점수 TOP3</h3>
						<%
						if(populList != null){
							for(int i = 0; i < populList.size(); i++){
								signupDTO popul = (signupDTO)populList.get(i); 
							%>
								<tr>
									<td> <%=(i+1) + "위." %> <%=popul.getUsern_id()%> <br /> </td>
								</tr>
							<% }
						}else {%>
								평판 좋은 사람이 없습니다.
						<%} %>
						
					</div>
				</div>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<br /><br /><br /><br />
				<h2>★☆★☆★☆★☆ 최신 공고 ☆★☆★☆★☆★</h2>
				<h3 style="margin-left:900px;"><a href="../gongmo/gongmoList.jsp">[더보기]</a></h3>
				<div style="display: inline-flex;">
					<%
					if(gongmoList != null){
						for(int i = 0; i < gongmoList.size(); i++){
							GongmoWriteDTO gm = (GongmoWriteDTO)gongmoList.get(i);
							SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
							// 마감날짜 String -> Date 형식 변환
							Date eday1 = sd.parse(gm.getGmboard_eday());
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
						<div style="display:inline-block; text-align: center; width: 250px; height: 200px;" onclick="window.location='../gongmo/gongmoContent.jsp?gmboard_num=<%=gm.getGmboard_num()%>'">
							<div align="left">
								<%
								if(Dday >0){%>
									D-<%=Dday-1 %>
								<%}else{%>
									D+<%=Math.abs(Dday) %>
								<%}%> | 조회수 : <%=gm.getGmboard_view() %>
							</div>
							<img src="../gongmoFile/<%=gm.getGmboard_poster()%>" width="150" height="200" style="cursor: pointer;" /> <br />
							<%=gm.getGmboard_title()%> <br />
							<%=gm.getGmboard_name()%>
							
						</div>
						
						<% }
					}else{%>
						게시글이 없습니다.
					<%}%>
					
				</div>
				
			</div>
		</div>
		<br /><br /><br /><br /><br /><br />
<%@ include file="../common/footer.jsp" %>

</body>
</html>