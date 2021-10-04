<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공모리스트</title>
</head>
<%
 String strReferer = request.getHeader("referer");
 
 if(strReferer == null){
%>
 <script language="javascript">
  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다. 정상적인 경로를 통해 다시 접근해 주십시오.");
  document.location.href="../main/main.jsp";
 </script>
<%
  return;
 }
%>
<%
	//현재 페이지 번호
	String pageNum=request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	// 한페이지에 담을 수 있는 게시글 수
	int pageSize = 12;
	// 현재페이지 문자열 -> 숫자 형변환
	int currentPage = Integer.parseInt(pageNum);
	// 시작 페이지 번호
	int startNum = (Integer.parseInt(pageNum) -1) * pageSize +1;
	// 끝 페이지 번호
	int endNum = currentPage * pageSize;



	request.setCharacterEncoding("UTF-8");
	GongmoDAO dao = new GongmoDAO();
	String list = request.getParameter("list");
	String list2 = request.getParameter("list2");
	String search = request.getParameter("searchWord");
	
	int count =0;
%>
<body>
	<!-- 전체 -->
	<div class="wrap">

		<!-- 헤더블럭 -->
		<%@ include file="../common/header.jsp"%>

		<!-- 컨텐츠블럭 -->
		<div class="container" align="center" >
		<br /><br />

			<%
				//일반회원일때
				if (session.getAttribute("nid") != null) {
			%>
			<form action="gongmoList.jsp">
				<div align="right">
					<select name="list">
						<option value="gmboard_title">제목</option>
						<option value="gmboard_content">내용</option>
						<option value="gmboard_name">기업명</option>
					</select> <input type="text" placeholder="검색하세요" name="searchWord" /> 
					<input type="image" src="../common/imgs/search.png" width="15" height="15" alt="검색"/>
					</div>
			</form>
			<br />
			<%	// list이랑 검색 했을때,
				if(list != null && search != null){
					count = dao.searchGongmoCount(list, search);	
				}else if(list2 != null) {
					count = dao.showGongmoCount();
				}else{
					count = dao.showGongmoCount();
				}
			
			%>
			<div align="left">공모전 수 : <%=count %> 건</div>
			<%
				if(search !=null){%>
					<div align="center">검색내용 : <%=search %></div>
				<%}
			%>
			<br />
			<form action="gongmoList.jsp">
			<div align="right">
				<select name="list2" onchange="this.form.submit()">
					<option value="gmboard_reg" <%
													if(list2 != null){
														if(list2.equals("gmboard_reg")){%>
															selected="selected"
														<%}
													}
													%>>최신순</option>
					<option value="gmboard_eday" <%
													if(list2 != null){
														if(list2.equals("gmboard_eday")){%>
															selected="selected"
														<%}
													}
													%>>마감순</option>
					<option value="gmboard_view" <%
													if(list2 != null){
														if(list2.equals("gmboard_view")){%>
															selected="selected"
														<%}
													}
													%>>조회순 </option>
					<option value="gmboard_num" <%
													if(list2 != null){
														if(list2.equals("gmboard_num")){%>
															selected="selected"
														<%}
													}
													%>>스크랩순</option>
				</select>
			</div>
			</form>
			<%	// 기업회원 일때
				} else if (session.getAttribute("cid") != null) {
			%>
			<form action="gongmoList.jsp">
				<div align="right">
					<select name="list">

						<option value="gmboard_title">제목</option>
						<option value="gmboard_content">내용</option>
						<option value="gmboard_name">기업명</option>
					</select> 
					<input type="text" placeholder="검색하세요" name="searchWord" />
					<input type="image" src="../common/imgs/search.png" width="15" height="15" alt="검색"/> 
					</div>
			</form>
			<br />
			<%
				if(list != null && search != null){
					count = dao.searchGongmoCount(list, search);	
				}else if(list2 != null) {
					count = dao.showGongmoCount();
				}else{
					count = dao.showGongmoCount();
				}
			
			%>
			<div align="left">공모전 수 : <%=count %> 건</div>
			<%
				if(search !=null){%>
					<div align="center">검색내용 : <%=search %></div>
				<%}
			%>
			<div align="right"><input type="button" value="공모등록" onclick="window.location='gongmoWriteForm.jsp'" /></div>
			<br />
				<form action="gongmoList.jsp">
			<div align="right">
				<select name="list2" onchange="this.form.submit()">
					<option value="gmboard_reg" <%
													if(list2 != null){
														if(list2.equals("gmboard_reg")){%>
															selected="selected"
														<%}
													}
													%>>최신순</option>
					<option value="gmboard_eday" <%
													if(list2 != null){
														if(list2.equals("gmboard_eday")){%>
															selected="selected"
														<%}
													}
													%>>마감순</option>
					<option value="gmboard_view" <%
													if(list2 != null){
														if(list2.equals("gmboard_view")){%>
															selected="selected"
														<%}
													}
													%>>조회순 </option>
					<option value="gmboard_num" <%
													if(list2 != null){
														if(list2.equals("gmboard_num")){%>
															selected="selected"
														<%}
													}
													%>>스크랩순</option>
				</select>
			</div>
			</form>
			<%
				}// 기업회원 끝
				else { // 비로그인 일때  %>
					<form action="gongmoList.jsp">
					<div align="right">
						<select name="list">
							<option value="gmboard_title">제목</option>
							<option value="gmboard_content">내용</option>
							<option value="gmboard_name">기업명</option>
						</select> <input type="text" placeholder="검색하세요" name="searchWord" /> 
						<input type="image" src="../common/imgs/search.png" width="15" height="15" alt="검색"/>
						</div>
				</form>
				<br />
				<%	// list이랑 검색 했을때,
					if(list != null && search != null){
						count = dao.searchGongmoCount(list, search);	
					}else if(list2 != null) {
						count = dao.showGongmoCount();
					}else{
						count = dao.showGongmoCount();
					}
				
				%>
				<div align="left">공모전 수 : <%=count %> 건</div>
				<%
					if(search !=null){%>
						<div align="center">검색내용 : <%=search %></div>
					<%}
				%>
				<br />
				<form action="gongmoList.jsp">
				<div align="right">
					<select name="list2" onchange="this.form.submit()">
						<option value="gmboard_reg" <%
														if(list2 != null){
															if(list2.equals("gmboard_reg")){%>
																selected="selected"
															<%}
														}
														%>>최신순</option>
						<option value="gmboard_eday" <%
														if(list2 != null){
															if(list2.equals("gmboard_eday")){%>
																selected="selected"
															<%}
														}
														%>>마감순</option>
						<option value="gmboard_view" <%
														if(list2 != null){
															if(list2.equals("gmboard_view")){%>
																selected="selected"
															<%}
														}
														%>>조회순 </option>
						<option value="gmboard_num" <%
														if(list2 != null){
															if(list2.equals("gmboard_num")){%>
																selected="selected"
															<%}
														}
														%>>스크랩순</option>
					</select>
				</div>
				</form>
					
				<%}
				// list에서 검색했을때 !
				if (list != null && search !=null) {
					// 검색에 충족하는 공모전 리스트 있는지 없는지 뽑아올거다
					count = dao.searchGongmoCount(list, search);
					List gmlist;
					GongmoWriteDTO gmboard = null;
					System.out.println("검색된 글 개수 = "+count);
					//System.out.println("select = "+list2);
					if (count > 0) {
						gmlist = dao.showsearchGongmoList(startNum,endNum, list,search);
						System.out.println("리스트 몇개인지 = "+gmlist.size());
			%>
			<div style="display: inline-flex;" >
				<%
					for (int i = 0; i < gmlist.size(); i++) {
								gmboard = (GongmoWriteDTO) gmlist.get(i);
								SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
								// 마감날짜 String -> Date 형식 변환
								Date eday1 = sd.parse(gmboard.getGmboard_eday());
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
				<div style="display: inline-block; text-align: center; width: 300px; height: 200px"
					onclick="window.location='gongmoContent.jsp?gmboard_num=<%=gmboard.getGmboard_num()%>'">
					<div align="left">
						<%
						if(Dday >0){%>
							D-<%=Dday-1 %>
						<%}else{%>
							D+<%=Math.abs(Dday) %>
						<%}%> | 조회수 :<%=gmboard.getGmboard_view() %></div>
					<img src="../gongmoFile/<%=gmboard.getGmboard_poster()%>"
						width="200" height="250" style="cursor: pointer;" /><br />
					<%=gmboard.getGmboard_title()%><br />
					<%=gmboard.getGmboard_name()%>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<%
					if ((i + 1) % 3 == 0) {
				%>
			</div>
			<br /> <br /><br /> <br /><br /> <br /><br /> <br /><br /> <br />
			<div style="display: inline-flex;">
				<%
					}
				%><%
					}// 리스트 뽑는 for문 끝
						} else {%>
				<div align="center">
					<table>
						<tr>
							<td>게시글 없음</td>
						</tr>
					</table>

				</div>
				<div align="center">
				<%
					}
				%>
			</div>
			<%
				}//맨위 if 문 끝
				else if(list2 != null) {
					// 검색에 충족하는 공모전 리스트 있는지 없는지 뽑아올거다
					count = dao.showGongmoCount();
					List gmlist;
					GongmoWriteDTO gmboard = null;
					System.out.println("전체 글 개수 = "+count);
					//System.out.println("select = "+list2);
					if (count > 0) {
						gmlist = dao.showList2GongmoList(startNum,endNum, list2);
						System.out.println("리스트 몇개인지 = "+gmlist.size());
			%>
			<div style="display: inline-flex;">
				<%
					for (int i = 0; i < gmlist.size(); i++) {
						gmboard = (GongmoWriteDTO) gmlist.get(i);
						SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
						// 마감날짜 String -> Date 형식 변환
						Date eday1 = sd.parse(gmboard.getGmboard_eday());
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
				<div style="display: inline-block; text-align: center; width: 300px; height: 200px"
					onclick="window.location='gongmoContent.jsp?gmboard_num=<%=gmboard.getGmboard_num()%>'">
					<div align="left">
						<%
						if(Dday >0){%>
							D-<%=Dday-1 %>
						<%}else{%>
							D+<%=Math.abs(Dday) %>
						<%}%> | 조회수 :<%=gmboard.getGmboard_view() %></div>
					<img src="../gongmoFile/<%=gmboard.getGmboard_poster()%>"
						width="200" height="250" style="cursor: pointer;" /><br />
					<%=gmboard.getGmboard_title()%><br />
					<%=gmboard.getGmboard_name()%>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<%
					if ((i + 1) % 3 == 0) {
				%>
			</div>
			<br /> <br /><br /> <br /><br /> <br /><br /> <br /><br /> <br />
			<div style="display: inline-flex;">
				<%
					}
				%><%
					}// 리스트 뽑는 for문 끝
						} else {%>
				<div align="center">
					<table>
						<tr>
							<td>게시글 없음</td>
						</tr>
					</table>

				</div>
				<div align="center">
				<%
					}
				%>
			</div>
			<%
				}// else if 문 끝			
				else { // 검색안했을때
					// 공모전 리스트 있는지 없는지 뽑아올거다
					count = dao.showGongmoCount();
					List gmlist;
					GongmoWriteDTO gmboard = null;
					//System.out.println(list2);
					if (count > 0) {
						gmlist = dao.showGongmoListY(startNum,endNum);
						System.out.println("공모전 게시글 개수 = "+gmlist.size());
			%>
			<div style="display: inline-flex;">
				<%
					for (int i = 0; i < gmlist.size(); i++) {
						gmboard = (GongmoWriteDTO) gmlist.get(i);
						SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
						// 마감날짜 String -> Date 형식 변환
						Date eday1 = sd.parse(gmboard.getGmboard_eday());
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
				<div style="display: inline-block; text-align: center; width: 300px; height: 200px"
					onclick="window.location='gongmoContent.jsp?gmboard_num=<%=gmboard.getGmboard_num()%>'">
					<div align="left">
						<%
						if(Dday >0){%>
							D-<%=Dday-1 %>
						<%}else{%>
							D+<%=Math.abs(Dday) %>
						<%}%>
						 | 조회수 :<%=gmboard.getGmboard_view() %></div>
					<img src="../gongmoFile/<%=gmboard.getGmboard_poster()%>"
						width="200" height="250" style="cursor: pointer;" /><br />
					<%=gmboard.getGmboard_title()%><br />
					<%=gmboard.getGmboard_name()%>
					
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<%
					if ((i + 1) % 3 == 0) {
				%>
			</div>
			<br /> <br /><br /> <br /><br /> <br /><br /> <br /><br /> <br />
			<div style="display: inline-flex;">
				<%
					}
				%>
				<%}%>
					
				<%} else {%>
				<div align="center">
					<table>
						<tr>
							<td>게시글 없음</td>
						</tr>
					</table>

				</div>
				<%
					}
				} //맨위 if - else 문 끝
				%>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div align="center">
		<%
			if(count >0){
			
				// 페이지 번호를 몇개까지 보여줄것인지 지정
				int pageBlock = 10;
				// 총 몇페이지 나오는지 계산
				int pageCount= count / pageSize + (count % pageSize ==0 ? 0 : 1);
				// 현재 페이지에서 보여줄 첫번째 페이지번호
				int startPage = (int)((currentPage-1)/pageBlock) * pageBlock +1;
				// 현재페이지에서 보여줄 마지막 페이지 번호
				int endPage = startPage + pageBlock -1;
				// 마지막에 보여줄 페이지번호는, 전체 페이지 수에 따라 달라질 수 있다.
				// 전체페이지수(pageCount)가 위에서 계산한 endPage(10단위씩 끊기)보다 작으면
				// 전체 페이지수가 endPage가 된다.
				if(endPage > pageCount){
					endPage=pageCount;
				}
				
				// 왼쪽 페이지 이동 : StartPage가 PageBlock(10)보다 크면 보여준다.
				if(startPage > pageBlock){%>
					
					<a href="gongmoList.jsp?pageNum=<%=startPage-pageBlock %>" class=pageNums">&lt;</a>
				<%}
				
				if(list2 != null){
					// 페이지번호 뿌리기						&nbsp : html에서 띄어쓰기 한칸!
					for(int i=startPage; i<=endPage;i++){ %>
						<a href="gongmoList.jsp?pageNum=<%=i%>&list2=<%=list2 %> " class=pageNums">  &nbsp; <%=i %> &nbsp; </a>
					<%}	
					// 오른쪽 페이지 이동 : 전체페이지 개수인 pageCount가 endPage보다 클 경우
					if(endPage< pageCount){%>
						<a href="gongmoList.jsp?pageNum=<%=startPage+pageBlock %>" class=pageNums">&gt;</a>
					<%}
				}else if(list != null && search != null){
					// 페이지번호 뿌리기						&nbsp : html에서 띄어쓰기 한칸!
					for(int i=startPage; i<=endPage;i++){ %>
						<a href="gongmoList.jsp?pageNum=<%=i%>&list=<%=list %>&searchWord=<%=search %> " class=pageNums">  &nbsp; <%=i %> &nbsp; </a>
					<%}	
					// 오른쪽 페이지 이동 : 전체페이지 개수인 pageCount가 endPage보다 클 경우
					if(endPage< pageCount){%>
						<a href="gongmoList.jsp?pageNum=<%=startPage+pageBlock %>" class=pageNums">&gt;</a>
					<%}
				}
				
				else{
					for(int i=startPage; i<=endPage;i++){ %>
					<a href="gongmoList.jsp?pageNum=<%=i%> " class=pageNums">  &nbsp; <%=i %> &nbsp; </a>
				<%}	
				// 오른쪽 페이지 이동 : 전체페이지 개수인 pageCount가 endPage보다 클 경우
				if(endPage< pageCount){%>
					<a href="gongmoList.jsp?pageNum=<%=startPage+pageBlock %>" class=pageNums">&gt;</a>
				<%}
				}
								
			}%>
			<h3 class="pageNums">현재 페이지 : <%=pageNum %> </h3>
		</div>
			
			<!-- 풋터블럭 -->
			<%@ include file="../common/footer.jsp"%>
		</div>
</body>
</html>