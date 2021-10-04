<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.mypage.MypageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스크랩내역</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
	<style>
		table {
			width : 100%
			border : 1px solid #444444;
			border-collapse: collapse;
  		}
  		th, td {
    		border: 1px solid #444444;
    		padding : 10px;
		} 
	</style>
</head>
<%
	
	String id = null;
	// 넘어온 유저 nid/비회원에 따라 각각처리	
	if(session.getAttribute("nid")!=null){
		id = (String)session.getAttribute("nid");	
	
		// Scrap DB 가져오기
		MypageDAO dao = MypageDAO.getInstance();
	
		// 한페이지에 보여줄 게시글의 수
		int pageSize = 3;
	
		//현재 페이지 번호
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
	
		//현재페이지에 보여줄 게시글 시작과끝 세팅
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage -1) * pageSize + 1;
		int endRow = currentPage * pageSize;
	
		// 밖에서 사용가능하게 미리 선언
		List scrapList = null; // 게시글들 담아줄 변수
		int count = 0; // 전체 글 갯수
		int number = 0; // 가상글번호
		
		// 전체 글의 개수 가져오기
		count = dao.getScrapCount(id); 
		//확인 (제대로 됨) 
		System.out.println("count : " + count);
		
		// 글 가져오기
		if (count > 0){
			scrapList = dao.getScraps(startRow, endRow, id);
		
		
		// 게시판 목록에 뿌려줄 가상의 글 번호
		number = count - (currentPage-1)*pageSize;
		
		
	%>
	<body>
		<!-- 전체 -->
		<div class="wrap">
	
			<!-- 헤더블럭 -->
			<%@ include file="../common/header.jsp" %>
	
			<!-- 컨텐츠블럭 -->
			<div class="container">
				<%@ include file="/mypage/mypageLeft.jsp" %>
				<h1>스크랩 내역</h1>
				<hr>
				<table>
					<tr>
						<td width=50 style="word-break:break-all">번호</td>
						<td width=100 style="word-break:break-all">남은 날짜</td>
						<td width=1040 style="word-break:break-all">제목</td>
					</tr>
					<%int dDays = 0;
					try {
						for(int i = 0; i < scrapList.size(); i++){
							GongmoWriteDTO scrap = (GongmoWriteDTO)scrapList.get(i);%>
						<tr>
							<td><%= number-- %></td>
							<td>
								<% 								
								SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
								// 마감날짜 String -> Date 형식 변환
								Date eday1 = sd.parse(scrap.getGmboard_eday());
								System.out.println("eday1 = "+eday1);
								// 오늘 날짜
								Date today = new Date();
								System.out.println("today = "+today.getTime());
								long eday2 = Math.abs(eday1.getTime());
								long Dday = (eday2-today.getTime())/1000;
								Dday= Dday/(24*60*60);
								System.out.println("eDays = "+ eday2);
								System.out.println("Dday = "+ Dday);
								if(Dday >0){%>
									D-<%=Dday-1 %>
								<%}else{%>
									D+<%=Math.abs(Dday) %>
								<%}%>		
							</td>
							<td><a href="../gongmo/gongmoContent.jsp?gmboard_num=<%=scrap.getGmboard_num()%>"><%= scrap.getGmboard_title() %></a></td>
						</tr>
						<% }// for
						}catch (Exception e){
							e.printStackTrace(); %>										
					<%} %>
				</table>
				<!-- 페이지 번호 -->
				<br/><br/>
				<div align ="center">
				<% if (count > 0){
					int pageBlock = 2; // 보여줄 총 페이지 번호
					// 총 몇페이지가 나오는지?
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					// 현재 페이지에서 보여줄 첫 번째 번호
					int startPage = (int)((currentPage-1)/pageBlock) * pageBlock + 1;
					// 현재 페이지에서 보여줄 마지막 번호
					int endPage = startPage + pageBlock - 1;
					if (endPage > pageCount) endPage = pageCount;
					
					// 왼쪽 꺽쇄 : startPage가 pageBlock보다 크면?
					if (startPage > pageBlock){ %>		
						<a href="mypageMyScrap.jsp?pageNum=<%=startPage-pageBlock %>" class="pageNums"> &lt; &nbsp;</a>
				<%  }
					
					// 페이지 번호 뿌리기
					for(int i = startPage; i <= endPage; i++){ %>
						<a href="mypageMyScrap.jsp?pageNum=<%=i %>" class="pageNums"> &nbsp; <%= i %> &nbsp; </a>
				<% }
					
					// 오른쪽 꺽쇄 : 전체 페이지 개수 (pageCount)가 endPage(현재 보는 페이지에서의 마지막번호) 보다 크면
					if (endPage < pageCount) { %>
						&nbsp; <a href="mypageMyScrap.jsp?pageNum=<%=startPage+pageBlock%>" class="pageNums"> &gt; </a>		
				<% }	
				} //if(count > 0) %>
				
				</div>	
			</div>
			<!-- 풋터블럭 -->
			<%@ include file="../common/footer.jsp" %>
		</div>		
		</body>
		<% } else  { // 스크랩한거 하나도 없을때 %>
			<body>
				<!-- 전체 -->
				<div class="wrap">
					<!-- 헤더블럭 -->
					<%@ include file="../common/header.jsp" %>
					<!-- 컨텐츠블럭 -->
					<div class="container">
					<%@ include file="/mypage/mypageLeft.jsp" %>
					<h1>스크랩 내역</h1>
					<hr>
					<br/><br/>
					스크랩한 게시물이 없습니다.
					<br/><br/><br/><br/><br/>
					</div>
				</div>
			</body>
			<%@ include file="../common/footer.jsp" %>		
			<% }

		}else{	//id값 없을떄 %>
		<script>
			alert("로그인해주세요.");
			window.location.href="../main/main.jsp";
		</script>
	<%}%>
</html>