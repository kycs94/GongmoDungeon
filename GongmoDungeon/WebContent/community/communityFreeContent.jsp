<%@page import="team04.project.community.Community_freeCommentDTO"%>
<%@page import="team04.project.community.Community_writeDTO"%>
<%@page import="team04.project.community.CommunityDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
</head>
<script src="jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function checkForm(){
	var result = true;
	if(<%=session.getAttribute("nid")%>==null){
		alert("일반회원 로그인 후 이용 가능합니다.");
		result = false;
	}else{
		if($("textarea[name=commentContent]").val()==""){
			result = false;
			alert("내용을 입력해주세요.");
			$("textarea[name=commentContent]").focus();
		}
	}
	$("textarea[name=commentContent]").val().replace(/\n/g, "<br>");
	return result;
}
function checkCommForm(){
	var result = true;
	if(<%=session.getAttribute("nid")%>==null){
		alert("일반회원 로그인 후 이용 가능합니다.");
		result = false;
	}else{
		if($("textarea[name=commentReContent]").val()==""){
			result = false;
			alert("내용을 입력해주세요.");
			$("textarea[name=commentReContent]").focus();
		}
	}
	$("textarea[name=commentReContent]").val().replace(/\n/g, "<br>");
	return result;
}
</script>
<link href="../common/style.css" type="text/css" rel="stylesheet">
<link href="style.css" type="text/css" rel="stylesheet">
<%
	CommunityDAO dao = new CommunityDAO();
	String nums = request.getParameter("num");
	int num = Integer.parseInt(request.getParameter("num"));
	String sender = (String)session.getAttribute("nid");
	if(sender==null){
		sender = (String)session.getAttribute("cid");
	}
	
	Community_writeDTO dto = dao.getFreeContent(num);
	
	int commCount = dao.getCommCount(num);

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
					<% if(dto.getCMBoard_id().equals((String)session.getAttribute("nid"))){%>
						<div>
							<button onclick="modifyCon()">수정</button>
							<button onclick="deleteCon()">삭제</button>
						</div>
					<%} %>
					<table class="freeContent">
						<tr>
							<td>
								제목
							</td>
							<td>
								<%= dto.getCMBoard_title() %>
							</td>
							<td>
								조회수
							</td>
							<td>
								<%= dto.getCMBoard_view() %>
							</td>
						<tr>
						<tr>
							<td>
								작성자
							</td>
							<td>
								<%= dto.getCMBoard_id() %>
							</td>
							<td>
								작성날짜
							</td>
							<td>
								<%= dto.getCMBoard_reg() %>
							</td>
						<tr>
						<tr>
							<td colspan="4" id="textCon">
								<%= dto.getCMBoard_content() %>
							</td>
						<tr>
					</table>
					<%
						int ref = 1, re_step = 0, re_level = 0;
					%>
					
					<div>
						<form action="commentPro.jsp?num=<%=num%>" method="post" name="commForm" onsubmit="return checkForm()">
							<input type="hidden" name="ref" value="<%=ref %>"/>
							<input type="hidden" name="re_step" value="<%=re_step %>"/>
							<input type="hidden" name="re_level" value="<%=re_level %>"/>
							<table>
								<tr>
									<td>댓글</td>
								</tr>
								<tr>
									<td><textarea name="commentContent" wrap="hard"></textarea></td>
									<td><input type="submit" value="등록"/></td>
								</tr>
							</table>
						</form>
					</div>
					<%
						if(commCount>0){
							System.out.println(num);
							// 한 페이지에서 보여줄 게시글의 수
							int commSize = 10;
							
							// 현재 페이지 
							String commNum = request.getParameter("commNum"); // 요청시 페이지 번호가 넘어왔으면 꺼내서 담기.
							if(commNum == null){ // list.jsp 라고만 요청(페이지넘 파라미터가 안넘어온 경우)
								commNum = "1";
							}
							
							// 현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅(게시판의 리스트)
							int currentPage = Integer.parseInt(commNum); //계산을 위해 숫자로 형 변환
							int startRow = (currentPage - 1) * commSize + 1; //페이지의 시작글 번호
							
							int endRow = currentPage * commSize; // 페이지의 마지막 글 번호
							int count = 0;//전체(검색된)글 개수
							List commentDTO = null; 
							commentDTO = dao.getCommArticle(num, startRow, endRow); 
						%>
							<div>
								<table>
								<%
									for(int i=0; i<commentDTO.size(); i++){
										Community_freeCommentDTO commArticle = (Community_freeCommentDTO)commentDTO.get(i);
								%>
									<tr>
										<%for(int a=0; a<commArticle.getCmComment_level();a++){%>
											<%if(a==commArticle.getCmComment_level()-1){%>
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
											<a href="../msg/sendmsgForm.jsp?send=<%=sender%>&receive=<%= commArticle.getCmComment_id() %>"
										onclick="window.open(this.href, '메시지 보내기', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;"
										><%= commArticle.getCmComment_id() %></a>
										</td>
										<td>
											작성날짜
										</td>
										<td>
											<%= commArticle.getCmComment_reg() %>
										</td>
									</tr>
									<tr>
										<td colspan="4">
										
											<div class ="modifyComm01">
											 <% if(commArticle.getCmComment_comm().indexOf("({[DeLeTe]})")!=-1){
													String id = (String)session.getAttribute("nid");
													String comm = commArticle.getCmComment_comm();
													if(id!=null){
														if(id.equals("admin")){%>
															<%= comm.substring(0,commArticle.getCmComment_comm().indexOf("({[DeLeTe]})")) %>
														<%}else{%>
															<span class="commMsg"><%= comm.substring(commArticle.getCmComment_comm().indexOf("({[DeLeTe]})")+12,comm.length()) %></span>
														<%}
													}else{%>
														<span class="commMsg"><%= comm.substring(commArticle.getCmComment_comm().indexOf("({[DeLeTe]})")+12,comm.length()) %></span>
													<%}
												}else{%> 
												<span class="commMsg"><%= commArticle.getCmComment_comm() %></span>
											<%} %> 
											</div>
											
											<div class ="modifyComm02" style="display: none; visibility: hidden;">
												<textarea class="modiInput" wrap="hard"></textarea>
												<input type="hidden" value="<%= commArticle.getCmComment_num() %>"/>
											</div> 
										</td>
									</tr>
									<tr class="targetcomm">
										<td colspan="4">
										
											<div class ="modifyComm03">
											<% if(commArticle.getCmComment_id().equals((String)session.getAttribute("nid"))){
												if(commArticle.getCmComment_comm().indexOf("({[DeLeTe]})")==-1){%>
													<button onclick="deleteComm(<%= commArticle.getCmComment_num() %>)">삭제</button>											
													<button class="openCommBtn">답글</button>
													<button class="modifyComm">수정</button>
												<%} %>
											<%}else{ 
												if(commArticle.getCmComment_comm().indexOf("({[DeLeTe]})")==-1){%>
													<button class="openCommBtn">답글</button>
												<%} %>
											<%} %>
											</div>
											
											<div class ="modifyComm04" style="display:none; visibility:hidden;">
												<button class="modifiyPro">저장</button><button class="closeModify">취소</button>				
											</div>
										</td>
									</tr>
									<tr class="commcomm">
										<form action="reCommentPro.jsp?num=<%=num%>&ref=<%=commArticle.getCmComment_ref()%>&re_step=<%=commArticle.getCmComment_step()%>&re_level=<%=commArticle.getCmComment_level()%>" method="post" onsubmit="return checkCommForm()">
											<td Colspan="3"><textarea name="commentReContent" class="commentfocus" wrap="hard"></textarea></td>
											<td Colspan="1"><input type="submit" value="등록"/><input type="button" value="취소" class="closeComm"/></td>
										</form>
									</tr>
									<%} %>
								</table>
							</div>	
							<div>
								<%
									// 페이지 번호를 몇개까지 보여줄것인지 지정
									int pageBlock = 5;
									
									// 총 몇페이지가 나오는지 계산
									int pageCount = commCount/commSize + (count%commSize == 0 ? 0 : 1);
									
									//현재 페이지에서 보여줄 첫번째 페이지 번호
									int startPage = (int)((currentPage-1)/pageBlock) * pageBlock + 1;
									
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
					<%}%>
				</div>
			</div>
		</div>

		<!-- 풋터블럭 -->
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</div>
</body>

<!-- 자바스크립트 -->
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var submenu = $(".menu1 .openmenu").next("ul");
    if( submenu.is(":visible") ){
        submenu.slideUp();
    }else{
        submenu.slideDown();
    }
    $(".allmenu").find(".cMenu").removeClass('active');
    $(".menu1").find(".cMenu1").addClass('active');
})

function deleteCon(){
	var result = confirm("게시물을 삭제하시겠습니까?");
	if(result){
		window.location = "deletePro.jsp?num="+<%=dto.getCMBoard_num()%>+"&wheres=free";
	}
}

function deleteComm(num){
	var result = confirm("댓글을 삭제하시겠습니까?");
	if(result){
		window.location = "deletePro.jsp?num="+num+"&wheres=comm&nums="+<%=dto.getCMBoard_num()%>;
	}
}

function modifyCon(){
	window.location = "freeModifyForm.jsp?num="+<%=dto.getCMBoard_num()%>;
}

$(".modifyComm").click(function(){
	var parent = $(this).parents(".modifyComm03");
	parent[0].style.display = "none";
	parent[0].style.visibility = "hidden";
	var a = parent.next();
	a[0].style.display = "block";
	a[0].style.visibility = "visible";
	
	var parents = $(this).parents(".targetcomm");
	var friend = parents.prev();
	friend.find(".modifyComm01")[0].style.display = "none";
	friend.find(".modifyComm01")[0].style.visibility = "hidden";
	friend.find(".modifyComm02")[0].style.display = "block";
	friend.find(".modifyComm02")[0].style.visibility = "visible";
	
	var msg = friend.find(".modifyComm01").children(".commMsg")[0].innerHTML;
	msg = msg.replaceAll('<br>', '\n');
	friend.find(".modifyComm02").children(".modiInput")[0].innerHTML = msg;
});

$(".closeModify").click(function(){
	var parent = $(this).parents(".modifyComm04");
	parent[0].style.display = "none";
	parent[0].style.visibility = "hidden";
	var a = parent.prev();
	a[0].style.display = "block";
	a[0].style.visibility = "visible";
	
	var parents = $(this).parents(".targetcomm");
	var friend = parents.prev();
	friend.find(".modifyComm01")[0].style.display = "block";
	friend.find(".modifyComm01")[0].style.visibility = "visible";
	friend.find(".modifyComm02")[0].style.display = "none";
	friend.find(".modifyComm02")[0].style.visibility = "hidden";
	
	friend.find(".modifyComm02").children(".modiInput")[0].innerHTML = "";
});

$(".modifiyPro").on('click')

$(".modifiyPro").click(function(){
	var th = $(this);
	var parents = $(this).parents(".targetcomm");
	var friend = parents.prev();
	var msg = friend.find(".modifyComm02").children(".modiInput")[0].value;
	var num = friend.find(".modifyComm02").children(".modiInput").next()[0].value;
	
	$.ajax({
		type: "POST",
		url: "commModifyPro.jsp",
		data : {
			"msg" : msg,
			"num" : num
			
		},
		dataType : 'json',
		success: function(data){
			if(data==1){
				var parent = th.parents(".modifyComm04");
				console.log(parent);
				parent[0].style.display = "none";
				parent[0].style.visibility = "hidden";
				var a = parent.prev();
				a[0].style.display = "block";
				a[0].style.visibility = "visible";
				
				var parents = th.parents(".targetcomm");
				var friend = parents.prev();
				friend.find(".modifyComm01")[0].style.display = "block";
				friend.find(".modifyComm01")[0].style.visibility = "visible";
				friend.find(".modifyComm02")[0].style.display = "none";
				friend.find(".modifyComm02")[0].style.visibility = "hidden";
				
				friend.find(".modifyComm01").children(".commMsg")[0].innerHTML = msg;	
			}
		},
		error : function(e) {
			console.log(e);
		}
	});
});






</script>
</html>