<%@page import="team04.project.login.signupDTO"%>
<%@page import="team04.project.login.LoginDAO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="team04.project.gongmo.GongmoTeamMakeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 모집</title>
<script>
	function jobCheck(num1, mnum){
		 window.open("gongmoJobCheck.jsp?gmboard_num="+num1+"&maketeam_num="+mnum, "a", "width=400, height=300, left=100, top=50"); 
	}
</script>
</head>
<!-- 외부CSS링크 네이밍 변경 필요 -->
<link href="style.css" type="text/css" rel="stylesheet">
<%

	//현재 페이지 번호
	String pageNum=request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	// 한페이지에 담을 수 있는 게시글 수
	int pageSize = 10;
	// 현재페이지 문자열 -> 숫자 형변환
	int currentPage = Integer.parseInt(pageNum);
	// 시작 페이지 번호
	int startNum = (Integer.parseInt(pageNum) -1) * pageSize +1;
	// 끝 페이지 번호
	int endNum = currentPage * pageSize;
	int count =0;
	int num1 = Integer.parseInt(request.getParameter("gmboard_num"));
	GongmoTeamMakeDTO dto;
	GongmoDAO dao1= new GongmoDAO();
	LoginDAO lodao = LoginDAO.getInstance();
	// gmboard_num 이랑 같은 게시물이 있는지 없는지 카운트 체크
	count = dao1.showTeamListCount(num1);
	System.out.println("count = "+count);
	List list;	
%>

			<%
			if(session.getAttribute("nid")!=null){
				
				if(count >0){ 
					list = dao1.showTeamList(num1, startNum, endNum);
					System.out.println("리스트 개수 = "+ list);
				%>
					<table>
					<%for(int i=0; i<list.size();i++){ 
						System.out.println("리스트 사이즈 = "+list.size());
						dto = (GongmoTeamMakeDTO)list.get(i);
					%>
				<tr>
					<td colspan="3"><a onclick="jobCheck(<%=num1%>,<%=dto.getMaketeam_num() %>)" style="cursor: pointer">제목 : <%=dto.getMaketeam_title() %></a></td>
					<td >조회수 : <%=dto.getMaketeam_view()%></td>
				</tr>
				<tr>
					<td>팀명 : <%=dto.getMaketeam_name() %>  &nbsp; </td>
					<td>팀장 : <%=dto.getMaketeam_id() %> &nbsp; </td>
					<td>모집인원 : <%=dto.getMaketeam_Ptotal() %></td>
				</tr>
				<tr>
				<td colspan="1">
				<%
					int Ptotal = dto.getMaketeam_Ptotal();
					System.out.println("Ptotal = "+Ptotal);
					String str = dto.getMaketeam_pnow();
					String Pnow[] = str.split(",");
					int Pnows=Pnow.length;
					System.out.println("Pnows ="+Pnows);
					System.out.println("job ="+dto.getMaketeam_job());
					if(Pnows >= Ptotal){%>
						<img src="../common/imgs/teamdone.png" width="120" height="50" onclick="jobCheck(<%=num1%>,<%=dto.getMaketeam_num()%>)" style="cursor: pointer"/>
					<%}else{%>
						<img src="../common/imgs/teaming2.png" width="120" height="50" onclick="jobCheck(<%=num1%>,<%=dto.getMaketeam_num() %>)" style="cursor: pointer"/>
				<%} %>
				</td>
				<td colspan="3">
					<%
						// 팀장 캐릭터 꺼내오기
						String maketeam_id = dto.getMaketeam_id();
						System.out.println("팀장 아이디 = "+dto.getMaketeam_id());
						signupDTO sdto = lodao.maketeamIdchar(maketeam_id);
						System.out.println("팀장 직업 = "+sdto.getUsern_job());
							if(sdto.getUsern_job().equals("warrior")){%>
								<img src="../common/imgs/warrior.png" width="90" height="50"/>
							<%}else if(sdto.getUsern_job().equals("magician")){%>
								<img src="../common/imgs/magician.png" width="90" height="50"/>	
							<%}else if(sdto.getUsern_job().equals("rogue")){%>
								<img src="../common/imgs/rogue.png" width="90" height="50"/>	
							<%}else if(sdto.getUsern_job().equals("archer")){%>
								<img src="../common/imgs/archer.png" width="90" height="50"/>	
							<%}else if(sdto.getUsern_job().equals("healer")){%>
								<img src="../common/imgs/healer.png" width="90" height="50"/>	
							<%}
							if(dto.getMaketeam_pnow().equals("0")){
								for(int j=0;j <= Ptotal-1;j++){	%>
								<img src="../common/imgs/user.png" width="60" height="50" />
							<%}
							}else{// 지원자 캐릭터 꺼내오기
							int mnum = dto.getMaketeam_num();
							for(int j=0;j<Pnows;j++){
								String id1[] = new String[Pnows];
								List list1 = dao1.applyIdJob(mnum);
								System.out.println("리스트 = "+list1);
								signupDTO sdto1=(signupDTO)list1.get(j);
								 id1[j]= sdto1.getUsern_id();
								signupDTO sdto2 =lodao.maketeamIdchar(id1[j]);
								
								if(sdto2.getUsern_job().equals("warrior")){%>
								<img src="../common/imgs/warrior.png" width="90" height="50"/>
								<%}else if(sdto2.getUsern_job().equals("magician")){%>
								<img src="../common/imgs/magician.png" width="90" height="50"/>	
								<%}else if(sdto2.getUsern_job().equals("rogue")){%>
								<img src="../common/imgs/rogue.png" width="90" height="50"/>	
								<%}else if(sdto2.getUsern_job().equals("archer")){%>
								<img src="../common/imgs/archer.png" width="90" height="50"/>	
								<%}else if(sdto2.getUsern_job().equals("healer")){%>
								<img src="../common/imgs/healer.png" width="90" height="50"/>	
								<%}
							}
							// 모집 인원 만큼 for 문을 돌려
							for(int j=0;j <= Ptotal-1-Pnows;j++){	%>
							<img src="../common/imgs/user.png" width="60" height="45" />
							<%}%>
				</td>
				</tr>
				<tr>
					<td colspan="4">-----------------------------------------------------------------------</td>
				</tr>
				<%}}%>
				<tr>
					<td colspan="4" align="right"><input type="button" value="팀만들기" onclick="window.location='gongmoTeamMakeForm.jsp?gmboard_num=<%=num1%>'"/></td>
				</tr>
			
			</table>
					
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
					
					<a href="gongmoContent.jsp?gmboard_num=<%=num1 %>&pageNum=<%=startPage-pageBlock %>" class=pageNums">&lt;</a>
				<%}
				
				// 페이지번호 뿌리기						&nbsp : html에서 띄어쓰기 한칸!
				for(int i=startPage; i<=endPage;i++){ %>
					<a href="gongmoContent.jsp?gmboard_num=<%=num1 %>&pageNum=<%=i%> " class=pageNums">  &nbsp; <%= i %> &nbsp; </a>
				<%}	
				// 오른쪽 페이지 이동 : 전체페이지 개수인 pageCount가 endPage보다 클 경우
				if(endPage< pageCount){%>
					<a href="gongmoContent.jsp?gmboard_num=<%=num1 %>&pageNum=<%=startPage+pageBlock %>" class=pageNums">&gt;</a>
				<%}
				
			}%>
			
			<h3 class="pageNums">현재 페이지 : <%=pageNum %> </h3>
		</div>		
					
			<%}else {%>
			<table >
				<tr>
					<td>
						팀원 모집이 없습니다.
					</td>
					
					<td align="right"><input type="button" value="팀만들기" onclick="window.location='gongmoTeamMakeForm.jsp?gmboard_num=<%=num1%>'"/></td>
				</tr>
			</table>
			<%}}else if(session.getAttribute("cid")!=null){%>
				<table >
				<tr>
					<td>
						일반 회원만 이용 가능한 서비스 입니다.
					</td>
				</tr>
			</table>
			<%}else{%>
				<table >
				<tr>
					<td>
						일반회원 로그인 후 이용 가능합니다.
					</td>
				</tr>
			</table>
	<%} %>
</html>