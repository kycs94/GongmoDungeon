<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공모전 등록</title>
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
<script>
	// 유효성 검사
	function cCheck(){
			var inputs = document.inputForm;
			
			if(!inputs.gmboard_title.value){
				alert("제목을 입력하세요.");
				return false;
			}
			if(!inputs.gmboard_winner.value){
				alert("수상인원을 입력하세요.");
				return false;
			}
			if(!inputs.gmboard_money.value){
				alert("시상규모를 선택하세요.");
				return false;
			}
			if(!inputs.gmboard_content.value){
				alert("모집요강을 입력하세요.");
				return false;
			}
	}

</script>
<body>
<%@ include file="../common/header.jsp" %>
		<!-- 컨텐츠블럭 -->
		<div class="container" align="center" style="display: flex;">
		<%@ include file="/mypage/mypageLeft.jsp" %>
			<div class="content">
	<h1 align="left">공모전 등록</h1>
	
	<%
	String id = (String)session.getAttribute("cid");
	System.out.println("cid = "+id);
	%>
	
	<form action="gongmoWritePro.jsp" method="post" enctype="multipart/form-data" name="inputForm" onsubmit="return cCheck()">
		<table>
			<tr>
				<td align="left">
					제	목
				</td>
				<td>
					<input type="text" name="gmboard_title" />
				</td>
			</tr>
			<tr>
				<td align="left">
					분	야
				</td>
				<td>
					<input type="checkbox" name="gmboard_favor" value="디자인" />디자인 
					<input type="checkbox" name="gmboard_favor" value="서포터즈" />서포터즈
					<input type="checkbox" name="gmboard_favor" value="과학" />과학
				</td>
			</tr>
			<tr>
				<td align="left">
					참가대상
				</td>
				<td>
					<input type="checkbox" name="gmboard_target" value="청소년" />청소년 
					<input type="checkbox" name="gmboard_target" value="대학생" />대학생
					<input type="checkbox" name="gmboard_target" value="직장인/일반인" />직장인/일반인
					<input type="checkbox" name="gmboard_target" value="제한없음" />제한없음
				</td>
			</tr>
			<tr>
				<td align="left">
					수상인원
				</td>
				<td>
					<input type="text" name="gmboard_winner" placeholder="ex) 5" />
				</td>
			</tr>
			<tr>
				<td align="left">
					수상혜택
				</td>
				<td>
					<input type="checkbox" name="gmboard_benefit" value="가산점" />가산점 
					<input type="checkbox" name="gmboard_benefit" value="인턴채용" />인턴 채용
					<input type="checkbox" name="gmboard_benefit" value="해외연수" />해외연수
					<input type="checkbox" name="gmboard_benefit" value="상금" />상금
				</td>
			</tr>
			<tr>
				<td align="left">
					시상규모
				</td>
				<td>
					<select name="gmboard_money" >
						<option value="none">=== 선택 ===</option>
						<option value="money1">5천만원 이상</option>
						<option value="money2">3천만원 ~ 5천만원</option>
						<option value="money3">1천만원 ~ 3천만원</option>
						<option value="money4">1천만원 이하</option>
						<option value="money5">없음</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="left">
					접수기간
				</td>
				<td>
					<input type="date" name="gmboard_sday"/> ~ <input type="date" name="gmboard_eday"/>
				</td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					모집요강
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea rows="20" cols="50" placeholder="2000자 내외" maxlength="2000" name="gmboard_content" wrap="hard"></textarea>
				</td>
			</tr> 
			<tr>
				<td align="left">
					포스터
				</td>
				<td>
					<input type="file" name="gmboard_poster"/>
				</td>
			</tr>
			<tr>
				<td align="left">
					첨부파일
				</td>
				<td>
					<input type="file" name="gmboard_file"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="등록"/>
					<input type="reset" value="재작성"/>
				</td>
			</tr>
		</table>
	</form>
			</div>
		</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>