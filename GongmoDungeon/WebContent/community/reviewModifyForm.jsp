<%@page import="team04.project.community.Community_reviewWriteDTO"%>
<%@page import="team04.project.community.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="jquery-3.6.0.min.js"></script>
<link href="../common/style.css" type="text/css" rel="stylesheet">
<link href="style.css" type="text/css" rel="stylesheet">
<%
	if(session.getAttribute("nid")==null){%>
	<script type="text/javascript">
		alert("정상 경로를 사용해주세요.");
		window.location="../main/main.jsp";
	</script>
	<%}
	CommunityDAO dao = new CommunityDAO();
	String sid = (String)session.getAttribute("nid");
%>
<script type="text/javascript">
function checkForm(){
	var result = true;
	if($("input[name=subject]").val()==""){
		result = false;
		alert("제목을 입력해주세요.");
		$("input[name=subject]").focus();
	}else{
		if($("select[name=gmName]").val()=="nothing"){
			result = false;
			alert("공모전 참가 후 작성해주세요!");
			window.location = "../gongmo/gongmoList.jsp";
		}else{
			if($("input[name=review_file]").val()==""&&document.getElementById("nowFile").innerHTML=="현재 저장된 파일이 없습니다."){
				result = false;
				alert("증빙자료는 필수입니다!");
			}else{
				if($("textarea[name=content]").val()==""){
					result = false;
					alert("내용을 입력해주세요.");
					$("textarea[name=content]").focus();
				}
			}
		}
	}
	return result;
}
</script>
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
				<%if(sid!=null){ 
					int num = Integer.parseInt(request.getParameter("num"));
					String[] joinGMNames = dao.getUserJoinGM(sid);
					Community_reviewWriteDTO dto = dao.getReviewArticle(num);
				%>
				<div class="commuMain">
					<div class="writeForm">
						<form action="reviewModifyPro.jsp" enctype="multipart/form-data" method="post" onsubmit="return checkForm()">
							<input type="hidden" name="number" value="<%=num%>">
							<table class="gongmoWriteTable">
								<tr>
									<td>
										<span>카테고리</span>
									</td>
									<td>
										<select id="commuWrite" onchange="changeWrite()" style="pointer-events:none;">
											<option value="review">후기게시판</option>
											<option value="free">자유게시판</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<span>제목</span>
									</td>
									<td>
										<input type="text" name="subject" value="<%= dto.getReview_title() %>"/>
									</td>
								</tr>
								<tr>
									<td>
										<span>참가 공모 이름</span>
									</td>
									<td>
										<select name="gmName">
											<%
												try{for(String i : joinGMNames){
													int nums = Integer.parseInt(i);
													String name = dao.getGMName(nums);
													%>
														<option value="<%= i %>"
															<%if(i.equals(dto.getReview_targetGM())){%>
																selected
															<%}%>
														><%= name %></option>
													<%
												}}catch(Exception e){%>
													<option value="nothing">참여한 공모전이 없습니다.</option>
												<%}
											%>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<span>인증 첨부</span>
									</td>
									<td>
										<span>현재 선택된 파일 : </span>
										<span id="nowFile"><%= dto.getReview_file() %></span><button type="button" onclick="fileDelete('<%= dto.getReview_file() %>')">삭제</button><br/>
										<input type="file" name="review_file" onclick="return checks()"/>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<span>내용</span>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<textarea name="content"><%= dto.getReview_content().replace("<br/>","\r\n") %></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<input type="submit" value="저장"/>
										<input type="reset" value="재작성"/>
										<input type="button" value="취소" onclick="window.location='communityList.jsp'"/>
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<%}else{ %>
					일반 회원 로그인후 이용 가능합니다.
				<%} %>
			</div>
		</div>

		<!-- 풋터블럭 -->
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</div>
</body>

<!-- 자바스크립트 -->
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
	function fileDelete(fileName){
		 $.ajax({
				type: "POST",
				url: "fileDelete.jsp",
				data : "fileName="+fileName,
				success: function(){
					 document.getElementById("nowFile").innerHTML = "현재 저장된 파일이 없습니다.";
				},
				error : function(e) {
					console.log(e);
				}
			});
	}
	
	function checks(){
		var result = true;
		if(document.getElementById("nowFile").innerHTML!="현재 저장된 파일이 없습니다."){
			alert("인증파일 첨부는 하나만 가능합니다.\n현재 파일을 삭제 후 파일을 첨부해주세요.");
			result = false;
		}
		return result;
	}
</script>
</html>