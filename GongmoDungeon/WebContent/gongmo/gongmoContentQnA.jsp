<%@page import="team04.project.gongmo.GongmoContentQnADTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function checkForm(){
	var result = true;
	if(<%=session.getAttribute("nid")%>==null&&<%=session.getAttribute("cid")%>==null){
		alert("로그인 후 이용 가능합니다.");
		result = false;
	}else{
		if($("textarea[name=commentContent]").val()==""){
			result = false;
			alert("내용을 입력해주세요.");
			$("textarea[name=commentContent]").focus();
		}
	}
	return result;
}
function checkCommForm(){
	var result = true;
	if(<%=session.getAttribute("nid")%>==null&&<%=session.getAttribute("cid")%>==null){
		alert("로그인 후 이용 가능합니다.");
		result = false;
	}else{
		if($("textarea[name=commentReContent]").val()==""){
			result = false;
			alert("내용을 입력해주세요.");
			$("textarea[name=commentReContent]").focus();
		}
	}
	return result;
}
</script>
<style type="text/css">
	.vdtToggle{
		display: table-row !important;
		visibility: visible !important;
	}
</style>
<body>
<%
	GongmoDAO dao2 = new GongmoDAO();
	String nums = request.getParameter("gmboard_num");
	int num2 = Integer.parseInt(request.getParameter("gmboard_num"));
	
	int commCount = dao2.getCommCount(num2);
	int ref = 1, re_step = 0, re_level = 0;

%>

<div>
	<form action="qnacommentPro.jsp?gmboard_num=<%=num2%>" method="post" name="commForm" onsubmit="return checkForm()">
		<input type="hidden" name="ref" value="<%=ref %>"/>
		<input type="hidden" name="re_step" value="<%=re_step %>"/>
		<input type="hidden" name="re_level" value="<%=re_level %>"/>
		<table>
			<tr>
				<td>질문 등록</td>
			</tr>
			<tr>
				<td><textarea name="commentContent" placeholder="Q&A는 수정, 삭제가 불가능합니다."></textarea></td>
				<td><input type="submit" value="등록"/></td>
			</tr>
		</table>
	</form>
</div>
<%
if(commCount>0){
	System.out.println(num2);
	// 한 페이지에서 보여줄 게시글의 수
	int commSize = 6;
	
	// 현재 페이지 
	String commNum = request.getParameter("commNum"); // 요청시 페이지 번호가 넘어왔으면 꺼내서 담기.
	if(commNum == null){ // list.jsp 라고만 요청(페이지넘 파라미터가 안넘어온 경우)
		commNum = "1";
	}
	
	// 현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅(게시판의 리스트)
	int currentPage1 = Integer.parseInt(commNum); //계산을 위해 숫자로 형 변환
	int startRow = (currentPage1 - 1) * commSize + 1; //페이지의 시작글 번호
	
	int endRow = currentPage1 * commSize; // 페이지의 마지막 글 번호
	int count1 = 0;//전체(검색된)글 개수
	List commentDTO = null; 
	commentDTO = dao2.getCommArticle(num2, startRow, endRow);
%>
<div>
	<table>
	<%
	for(int i=0; i<commentDTO.size(); i++){
		GongmoContentQnADTO commArticle = (GongmoContentQnADTO)commentDTO.get(i);
	%>
		<tr>
			<%for(int a=0; a<commArticle.getGmqna_level();a++){%>
				<%if(a==commArticle.getGmqna_level()-1){%>
					<td rowspan="4" style="text-align: right;">▷</td>
				<%}else{ %>
					<td rowspan="4"></td>
				<%} %>
			<%} %>
		</tr>
		<tr>
			<td>
				작성자
			</td>
			<td>
				<%= commArticle.getGmqna_id() %>
			</td>
			<td>
				작성날짜
			</td>
			<td>
				<%= commArticle.getGmqna_reg() %>
			</td>
		</tr>
		<tr>
			<td colspan="4">
			
				<div class ="modifyComm01">
					<span class="commMsg"><%= commArticle.getGmqna_comm() %></span>
				</div>
				
				<div class ="modifyComm02" style="display: none; visibility: hidden;">
					<input type="text" class="modiInput"/>
					<input type="hidden" value="<%= commArticle.getGmqna_num() %>"/>
				</div> 
			</td>
		</tr>
		<tr class="targetcomm">
			<td colspan="4">
				<div class ="modifyComm03">
					<button class="openCommBtn">답변</button>
				</div>
			</td>
		</tr>
		<tr class="commcomm" style="display:none; visibility:hidden;">
			<form action="reQnaCommentPro.jsp?num=<%=num2%>&ref=<%=commArticle.getGmqna_ref()%>&re_step=<%=commArticle.getGmqna_step()%>&re_level=<%=commArticle.getGmqna_level()%>" method="post" onsubmit="return checkCommForm()">
				<td Colspan="3"><textarea name="commentReContent" class="commentfocus"></textarea></td>
				<td Colspan="1"><input type="submit" value="등록"/><input type="button" value="취소" class="closeComm"/></td>
			</form>
		</tr>
		<%} %>
	</table>
</div>	
<div>
	<%
		// 페이지 번호를 몇개까지 보여줄것인지 지정
		int pageBlock = 3;
		
		// 총 몇페이지가 나오는지 계산
		int pageCount = commCount/commSize + (count1%commSize == 0 ? 0 : 1);
		
		//현재 페이지에서 보여줄 첫번째 페이지 번호
		int startPage = (int)((currentPage1-1)/pageBlock) * pageBlock + 1;
		
		//현재 페이지에서 보여줄 마지막 페이지 번호(얘는 무조건 10개 단위)
		int endPage = startPage + pageBlock - 1;
		
		//마지막에 보여줄 페이지 번호는 전체 페이지 수에 따라 달라질 수 있다.
		// 위에 엔드페이지는 10개 단위라 그보다 적으면 pagecount가 엔드페이지로 들어감
		if(pageCount<endPage){endPage = pageCount;}
		System.out.println(pageCount+", "+startPage+", "+endPage);
		//왼쪽 꺽쇄 : startPage 가 pageBlock(10) 보다 크면 보여줌
		if(startPage > pageBlock){%>
			<a href="communityFreeContent.jsp?num=<%= nums %>&commNum=<%=startPage - pageBlock%>" class="pageNums">&lt;</a>											
		<%}
			
		// 페이지 번호 뿌리기
		for(int i = startPage; i <= endPage; i++){%>
			<a href="communityFreeContent.jsp?num=<%= nums %>&commNum=<%=i%>" 
				<% if(i==Integer.parseInt(commNum)){%>class="active"<%} %>
			>&nbsp;<%=i%>&nbsp;</a>
		<%}
				
		//오른쪽 꺽쇄 : 전체 페이지 개수가 현재 보이는 페잊에서 마지막 번호보다 크면 보여줌
		if(endPage < pageCount){%>
			<a href="communityFreeContent.jsp?num=<%= nums %>&commNum=<%=startPage + pageBlock%>" class="pageNums">&gt;</a>
	<%}%>
</div>
<%}else{%>
	등록된 질문이 없습니다.
<%} %>
</body>
<script type="text/javascript">
$(".openCommBtn").click(function(){
	var parent = $(this).parents("tr");
	var commcomm = $(parent).next();
	var allComm = $(".closeComm").click();
	console.log(commcomm);
	$(commcomm).addClass('vdtToggle');
	$(".commentfocus").focus();
});

$(".closeComm").click(function(){
	var parent = $(this).parents("tr");
	$(parent).find(".commentfocus").val("");
	$(parent).removeClass('vdtToggle');
});
</script>
</html>