<%@page import="team04.project.login.signupDTO"%>
<%@page import="team04.project.gongmo.GongmoTeamApplyDTO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.gongmo.GongmoTeamMakeDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 게시글</title>
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
	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
	System.out.println("gmboard_num = "+num);
	System.out.println("maketeam_num = "+mnum);
	
	String sender = (String)session.getAttribute("nid");
	if(sender==null){
		sender = (String)session.getAttribute("cid");
	}
	GongmoDAO dao = new GongmoDAO();
	// num 가지고 해당 게시글 내용 가져오기5
	GongmoTeamMakeDTO dto = (GongmoTeamMakeDTO)dao.getListContent(mnum);
	// 공모전 eday 가져옴
			GongmoWriteDTO dto1=(GongmoWriteDTO)dao.getEndday(num);
			System.out.println(dto1.getGmboard_eday());
			//String -> Date 변환
			SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
			Date eday1 = fm.parse(dto1.getGmboard_eday());
			//Date -> Calendar로 변환
			Calendar cal = Calendar.getInstance();
			cal.setTime(eday1);
			cal.add(cal.DATE, +1);
			Date eday11 = cal.getTime();
			Date today = new Date();
			// 공모전 마감날짜 Date 형식으로 변환한거 출력한 값
			System.out.println("eday1+1 = "+eday11 );
			// 공모전 마감날짜+1 한거를 Date 형식으로 변환한거 출력한 값
			System.out.println("today = "+today );
			cal.setTime(eday11);
			cal.setTime(today);
			System.out.println("zzzzz = "+eday11.getTime());
			System.out.println("bbbbb = "+today.getTime());

%>
<script  language="javascript">
	function deletePopup() { 
		window.open("gongmoTeamdeleteForm.jsp?gmboard_num="+<%=num%>+"&maketeam_num="+<%=mnum%>, "a", "width=400, height=300, left=100, top=50"); 
	}
	function populPopup(eday11, today, anum, result) {
		console.log(eday11);
		console.log(today);
		if(today > eday11){
			console.log(eday11 < today);
			window.open("gongmoPersonPopulForm.jsp?gmboard_num="+<%=num%>+"&maketeam_num="+<%=mnum%>+"&applyteam_num="+anum+"&applyteam_result="+result+"&eday1="+eday11+"&eday2="+today
					 , "a", "width=400, height=300, left=100, top=50");		
		}else{
			alert("평가기간이 아닙니다.")
		}
	}

	function check(){ // <-- checkForm <- this.form 객체 받음
		var result = true; 		
		var x = document.getElementsByName("writerId");
		
		var xl = document.getElementsByName("writerId").length;
		var id = '<%=session.getAttribute("nid")%>';
		for(var a =0;a<xl;a++){
			if(x[a].innerHTML==id){
				result = false;
				alert("이미 지원하셨습니다.");
				document.getElementById("textaeras").value = "";
			}
		}
		return result;
	}

	

  </script>
</head>

<%@ include file="../common/header.jsp" %>
	<%--작성자와세션 아이디가 같을때 수정 삭제 가능하게 보여주는 화면 --%>
	<% if(session.getAttribute("nid").equals(dto.getMaketeam_id()) || session.getAttribute("nid").equals("admin") ) { %>

		<!-- 컨텐츠블럭 -->
		<div class="container" align="center">
			<div class="content">
<body>
	<div  align="center">
	<!-- content 보여주기 !! -->
	<table width="600" style="table-layout: fixed;">
		<tr>
			<td width="50">제목  &nbsp; </td>
			<td width="300"><%=dto.getMaketeam_title() %>  &nbsp;</td>
			<td width="80">팀명  &nbsp; </td>
			<td width="170"><%=dto.getMaketeam_name() %>  &nbsp;</td>
		</tr>
		<tr>
			<td>팀장 </td>
			<td><%=dto.getMaketeam_id() %></td>
			<td>모집인원</td>
			<td><%=dto.getMaketeam_Ptotal() %>명</td>
		</tr>
		
		<tr>
			<td colspan="3">내용 </td>
			<td>
			<input type="button" value="수정" onclick="window.location='gongmoTeamModifyForm.jsp?gmboard_num=<%=num %>&maketeam_num=<%=mnum %>'"/> 
			<input type="button" value="삭제" onclick="deletePopup();"/>
			</td>
		</tr>
		<tr >
				<td colspan="4" height="100" align="center"> <%=dto.getMaketeam_content() %> </td>
		</tr>
		
		
	</table>
	
	<!-- MakeTeam 작성자 입장에서 볼때 지원현황 -->
	
	<%
		// 지원자가 잇는지 없는지 count
		List list=null;
		GongmoTeamApplyDTO adto=null;
		int count =0;
		count = dao.applyListCount(mnum);
		System.out.println("applyteam count = "+count);
	%>
	<%
	if(count >0){
		list = dao.applyList(mnum);
		%>
		<table width="600" style="table-layout: fixed;">
			<tr>
				<td width="100">지원자</td>
				<td width="320">내용</td>
				<td width="120">합격여부</td>
				<td width="60">평점</td>				
			</tr>
			
			<%			
				for(int i=0;i<list.size();i++){
					adto=(GongmoTeamApplyDTO)list.get(i);
					// 세션과 지원자 아이디가 같지않을때, 지원자 입장에서 볼때
					if(session.getAttribute("nid").equals(adto.getApplyteam_id()))
					%>
					<tr>
						<td ><a href="../msg/sendmsgForm.jsp?send=<%=sender%>&receive=<%=adto.getApplyteam_id()%>"
										onclick="window.open(this.href, '메시지 보내기', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;"
										><%=adto.getApplyteam_id() %></a></td>
						<td><%=adto.getApplyteam_comm() %></td>
						<td>
							<%
						if(adto.getApplyteam_result() == 1){
							%>
							합격
							 /
							 <button onclick="window.location='gongmoTeamResult.jsp?gmboard_num=<%=num%>&maketeam_num=<%=mnum%>&outresult=3&result=1&applyteam_id=<%=adto.getApplyteam_id()%>'">추방</button>
						<%}else if(adto.getApplyteam_result() == 2){%>
							불합격
						<%}else { %>
							<button onclick="window.location='gongmoTeamResult.jsp?gmboard_num=<%=num %>&maketeam_num=<%=mnum %>&result=1&outresult=1&applyteam_id=<%=adto.getApplyteam_id()%>'">수락</button>
							 / 
							 <button onclick="window.location='gongmoTeamResult.jsp?gmboard_num=<%=num %>&maketeam_num=<%=mnum %>&result=2&outresult=2&applyteam_id=<%=adto.getApplyteam_id()%>'">거절</button>
						<%} %>
						</td>
						<td align="center"><%
							// 지원자 ID로 별점 가져오기
							signupDTO sdto = dao.getApplyIdPopul(adto.getApplyteam_id());%><%=sdto.getUsern_popul() %>점</td>
					</tr>
				<%}	%>
			<tr>
			<td><button onclick="window.location='gongmoContent.jsp?gmboard_num=<%=num%>'">뒤로</button>
			</tr>
			
		</table>
				<%}
	else{%>
		<table width="600" style="table-layout: fixed;">
			<tr>
				<td>지원자(별점)</td>
				<td>내용</td>
				<td>합격여부</td>
				<td>평가</td>				
			</tr>
						
			<tr>
				<td colspan="4" align="center">지원자가 없습니다.</td>
			</tr>
			
		</table>

	<%}%>
	
	</div>
	
	<%} // 세션 아이디와 maketeam_id가 같을때 끝
	
	// 일반회원 일때 보여주는 확면	
		else if(session.getAttribute("nid") != null ) {%>
	<div  align="center">
	<!-- content 보여주기 !! -->
	<table  width="600" style="table-layout: fixed;">
		<tr>
			<td width="50">제목  &nbsp; </td>
			<td width="300"><%=dto.getMaketeam_title() %></td>
			<td width="80">팀명  &nbsp; </td>
			<td width="170"><%=dto.getMaketeam_name() %>  &nbsp;</td>
		</tr>
		<tr>
			<td>팀장 </td>
			<td><%=dto.getMaketeam_id() %></td>
			<td>모집인원</td>
			<td><%=dto.getMaketeam_Ptotal() %>명</td>
		</tr>
		
		<tr>
			<td colspan="4">내용 </td>
		<tr >
				<td colspan="4" height="100" align="center"> <%=dto.getMaketeam_content() %> </td>
		</tr>
		
	</table>
	
	<!-- 지원자가 지원... -->
	<form action="gongmoTeamContentPro.jsp?gmboard_num=<%=num %>&maketeam_num=<%=mnum %>" method="post" id="checkForm" onsubmit="return check()">
		<input type="hidden" name="id" id="nowid" value="<%=session.getAttribute("nid") %>" />
		<table  width="600" style="table-layout: fixed;">
			<tr>
				<td colspan="4" align="left">지원</td>
			</tr>
			<tr>
				<td colspan="4" height="40" ><textarea rows="7" cols="70" name="applyteam_comm" id="textaeras"></textarea></td>
				<td><input type="submit" value="접수"/></td>			
			</tr>
		</table>
	</form>
	
	<!-- 지원현황 -->
	
	<%
		// 지원자가 잇는지 없는지 count
		List list=null;
		GongmoTeamApplyDTO adto=null;
		int count =0;
		count = dao.applyListCount(mnum);
		System.out.println("applyteam count = "+count);
	%>
	<%
	if(count >0){
		list = dao.applyList(mnum);
		%>
		<table width="600" style="table-layout: fixed;">
			<tr align="center">
				<td width="100">지원자</td>
				<td width="320">내용</td>
				<td width="100">합격여부</td>
				<td width="80">평가</td>				
			</tr>
						
			<%
				for(int i=0;i<list.size();i++){
					adto=(GongmoTeamApplyDTO)list.get(i);
					%>
					<tr>
						<td name="writerId" ><%=adto.getApplyteam_id() %></td>
						<td><%=adto.getApplyteam_comm() %>
						<%
							if(session.getAttribute("nid").equals(adto.getApplyteam_id())){%>
								<button onclick="window.location='gongmoApplyModifyForm.jsp?gmboard_num=<%=num %>&maketeam_num=<%=mnum%>&applyteam_comm=<%=adto.getApplyteam_comm()%>&applyteam_num=<%=adto.getApplyteam_num()%>'">수정</button>
								<button onclick="window.location='gongmoApplyDeletePro.jsp?gmboard_num=<%=num %>&maketeam_num=<%=mnum%>&applyteam_num=<%=adto.getApplyteam_num()%>&applyteam_comm=<%=adto.getApplyteam_comm()%>&applyteam_id=<%=adto.getApplyteam_id()%>'">삭제</button>
							<%}
						%>
						</td>
						<td align="center">
							<%
								if(adto.getApplyteam_result() ==0){ %>
									평가중...
								<%}else if(adto.getApplyteam_result() == 1){%>
										합격
								<%}else if(adto.getApplyteam_result()==2){ %>
										불합격
								<%} %>
						</td>
						<%
							System.out.println(dto.getMaketeam_done().contains(adto.getApplyteam_id()));
							if(dto.getMaketeam_done().contains(adto.getApplyteam_id())){%>
								<td align="center">O</td>
							<%}else{ 
								if(adto.getApplyteam_result()==2){%>
									<td align="center">X</td>
								<%}else if(adto.getApplyteam_id().equals(session.getAttribute("nid"))) {%>
								<td align="center" onclick="populPopup(<%=eday11.getTime() %>,<%=today.getTime() %>,<%=adto.getApplyteam_num() %>, <%=adto.getApplyteam_result()%>);" style="cursor: pointer;">X</td>
								<%}else {%>
								<td align="center">X</td>
								<%} %>
							<%}%>					
					</tr>
				<%}	%>
			<tr>
			<td><button onclick="window.location='gongmoContent.jsp?gmboard_num=<%=num%>'">뒤로</button>
			</tr>		 
		</table>
	<%}else{	%>
		<table width="600" style="table-layout: fixed;">
			<tr>
				<td>지원자(별점)</td>
				<td>내용</td>
				<td>합격여부</td>
				<td>평가</td>				
			</tr>
						
			<tr>
				<td colspan="4" align="center">지원자가 없습니다.</td>
			</tr>
			
		</table>
	<%}%>
	
	</div>
			</div>
		</div>
			<%}else{//아무것도 아닌%>
			<script>
				alert("접근 불가");
				history.go(-1);
			</script>
	<%} %>
<%@ include file="../common/footer.jsp" %>
</body>	

</html>