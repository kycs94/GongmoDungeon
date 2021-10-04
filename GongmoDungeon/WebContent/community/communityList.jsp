<%@page import="team04.project.community.Community_writeDTO"%>
<%@page import="team04.project.community.CommunityDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 전체 게시글</title>
</head>
<script src="jquery-3.6.0.min.js"></script>
<link href="../common/style.css" type="text/css" rel="stylesheet">
<link href="style.css" type="text/css" rel="stylesheet">
<%
	CommunityDAO dao = new CommunityDAO();

	// 한 페이지에서 보여줄 게시글의 수
	int pageSize = 10;
	
	
	
	// 현재 페이지 
	String pageNum = request.getParameter("pageNum"); // 요청시 페이지 번호가 넘어왔으면 꺼내서 담기.
	if(pageNum == null){ // list.jsp 라고만 요청(페이지넘 파라미터가 안넘어온 경우)
		pageNum = "1";
	}
	
	// 현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅(게시판의 리스트)
	int currentPage = Integer.parseInt(pageNum); //계산을 위해 숫자로 형 변환
	int startRow = (currentPage - 1) * pageSize + 1; //페이지의 시작글 번호
	
	int endRow = currentPage * pageSize; // 페이지의 마지막 글 번호
	int count = 0;//전체(검색된)글 개수
	List articleList = null;
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	if(sel!=null&&search!=null){//검색함
		count = dao.getSearchCount(sel, search);
		if(count>0){
			articleList = dao.getSearchList(startRow, endRow, sel, search);
		}
	}else{//검색 안함
		// 전체 글의 개수 가져오기
		count = dao.getAllCount(); // DB에 저장되어있는 전체 글의 개수를 담아놓을 변수
		
		// 글이 하나라도 있으면 글들을 다시 가져오기
		if(count > 0){
			articleList = dao.getAllList(startRow, endRow);
		}
	}
	int number = count - (currentPage - 1) * pageSize;
	//날짜 출력 형태 패턴 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyy.MM.dd HH:mm");
	
%>
<body>
	<!-- 전체 -->
	<div class="wrap">

		<!-- 헤더블럭 -->
		<%@ include file="../common/header.jsp" %>

		<!-- 컨텐츠블럭 -->
		<div class="container">
			<div class="commu">
				<!-- 사이드 메뉴 블럭 -->
				<jsp:include page="sideMenu.jsp"></jsp:include>
				
				<div class="commuMain">
					<div class="commuHead"  style="text-align:right;">
					<%if(session.getAttribute("nid")!=null){ %>
						<button onclick="window.location='communityWriteForm.jsp'">글쓰기</button>
					<%} %>
					</div>
					<div class="commuBody">
						<table class="allCommuList">
							<tr>
								<td>NO.</td>
								<td>제목</td>
								<td>글쓴이</td>
								<td>등록일</td>
								<td>조회수</td>
							</tr>

							<!-- 데이터 넘겨 받아 뿌려줄 부분 -->
							<%
							if(count>0){for(int i=0; i<articleList.size(); i++){
								Community_writeDTO article = (Community_writeDTO)articleList.get(i);
								String[] title = article.getCMBoard_title().split("/");
									%>
								<tr>
									<td><%= number-- %></td>
									<td>
										<%
											if(title[1].equals("CMBoard")){%>
												<a href="communityFreeContent.jsp?num=<%=article.getCMBoard_num()%>">
											<%}else if(title[1].equals("Review")){%>
												<a href="communityReviewContent.jsp?num=<%=article.getCMBoard_num()%>">
											<%}
										%>
										<%= title[0] %></a>
									</td>
									<td>
										<a href=""><%= article.getCMBoard_id() %></a>
									</td>
									<td><%= sdf.format(article.getCMBoard_reg()) %></td>
									<td><%= article.getCMBoard_view() %></td> 
								</tr>
							<%}}else{%>
							<!-- 데이터 넘겨 받아 뿌려줄 부분 -->
								<tr><td colspan="5">게시물이 없습니다.</td></tr>
							<%} %>
						</table>

						<!-- 페이지 리스트 버튼 -->
						<div class="pageNumList" style="text-align:center;">
						<%
							if(count>0){
								// 페이지 번호를 몇개까지 보여줄것인지 지정
								int pageBlock = 10;
								
								// 총 몇페이지가 나오는지 계산
								int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
								
								//현재 페이지에서 보여줄 첫번째 페이지 번호
								int startPage = (int)((currentPage-1)/pageBlock) * pageBlock + 1;
								
								//현재 페이지에서 보여줄 마지막 페이지 번호(얘는 무조건 10개 단위)
								int endPage = startPage + pageBlock - 1;
								
								//마지막에 보여줄 페이지 번호는 전체 페이지 수에 따라 달라질 수 있다.
								// 위에 엔드페이지는 10개 단위라 그보다 적으면 pagecount가 엔드페이지로 들어감
								if(pageCount<endPage){endPage = pageCount;}
								
								// 검색시, 페이지 번호 처리
								if(sel!=null&&search!=null){ // 검색 했을때
									//왼쪽 꺽쇄 : startPage 가 pageBlock(10) 보다 크면 보여줌
									if(startPage > pageBlock){%>
										<a href="communityList.jsp?pageNum=<%=startPage - pageBlock%>&sel=<%=sel%>&search=<%=search%>">&lt;</a>
										
									<%}
									
									// 페이지 번호 뿌리기
									for(int i = startPage; i <= endPage; i++){%>
										<a href="communityList.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>" 
											<% if(i==Integer.parseInt(pageNum)){%>class="active"<%} %>
										 >&nbsp;<%=i%>&nbsp;</a>
									<%}
									
									
									//오른쪽 꺽쇄 : 전체 페이지 개수가 현재 보이는 페잊에서 마지막 번호보다 크면 보여줌
									if(endPage < pageCount){%>
									<a href="communityList.jsp?pageNum=<%=startPage + pageBlock%>&sel=<%=sel%>&search=<%=search%>" class="pageNums">&gt;</a>
									<%}
								}else{ // 검색 안했을때
									//왼쪽 꺽쇄 : startPage 가 pageBlock(10) 보다 크면 보여줌
									if(startPage > pageBlock){%>
										<a href="communityList.jsp?pageNum=<%=startPage - pageBlock%>" >&lt;</a>
										
									<%}
									
									// 페이지 번호 뿌리기
									for(int i = startPage; i <= endPage; i++){%>
										<a href="communityList.jsp?pageNum=<%=i%>" 
											<% if(i==Integer.parseInt(pageNum)){%>class="active"<%} %>
										>&nbsp;<%=i%>&nbsp;</a>
									<%}
									
									
									//오른쪽 꺽쇄 : 전체 페이지 개수가 현재 보이는 페잊에서 마지막 번호보다 크면 보여줌
									if(endPage < pageCount){%>
									<a href="communityList.jsp?pageNum=<%=startPage + pageBlock%>">&gt;</a>
									<%}
								}
							}
						%>
						</div>
					</div>
					<div class="commuFoot" style="text-align:center;">
						<form action="communityList.jsp">
							<select name="sel">
								<option value="CMBoard_title" 
									<% if(sel!=null&&sel.equals("CMBoard_title")){ %>
										selected
									<%} %>
								>제목</option>
								<option value="CMBoard_id"
									<% if(sel!=null&&sel.equals("CMBoard_id")){ %>
										selected
									<%} %>
								>글쓴이</option>
							</select>
							<input type="text" name="search" 
								<% if(search!=null){ %>
									value="<%= search %>"
								<% } %>
							/>
							<input type="submit" value="검색"/>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- 풋터블럭 -->
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</div>
</body>

<!-- 자바스크립트 -->
<script type="text/javascript" src="./script.js"></script>
</html>