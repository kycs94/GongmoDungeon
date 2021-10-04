<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 만들기</title>
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
	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	
	String maketeam_done="0";
	String maketeam_pnow="0";
	System.out.println(maketeam_pnow);
	System.out.println(maketeam_done);
%>
<!-- 전체 -->
	<div class="wrap">

		<!-- 헤더블럭 -->
		<%@ include file="../common/header.jsp" %>

	<!-- 컨텐츠블럭 -->
		<div class="container" align="center">
<body>
	<h1 align="left">팀 만들기</h1>
	
	<form action="gongmoTeamMakePro.jsp?gmboard_num=<%=num %>" method="post">
		
		<input type="hidden" name="maketeam_done" value="<%=maketeam_done %>" />
		<input type="hidden" name="maketeam_pnow" value="<%=maketeam_pnow %>" />
		<table>
			<tr>
				<td align="left">
					제	목
				</td>
				<td>
					<input type="text" name="maketeam_title" />
				</td>
			</tr>
			<tr>
				<td align="left">
					팀	명
				</td>
				<td>
					<input type="text" name="maketeam_name" />
				</td>
			</tr>
			<tr>
				<td align="left">
					모집인원
				</td>
				<td>
					<input type="text" name="maketeam_Ptotal" placeholder="ex) 5" />
				</td>
			</tr>
			<tr>
				<td align="left">
					지원 가능 직업
				</td>
				<td>
					<input type="checkbox" name="maketeam_job" value="warrior"/>전사(발표)
					<input type="checkbox" name="maketeam_job" value="magician"/>마법사(포토샵) <br /><br />
					<input type="checkbox" name="maketeam_job" value="rogue"/>도적(기획)
					<input type="checkbox" name="maketeam_job" value="archer"/>궁수(디자인) <br /><br />
					<input type="checkbox" name="maketeam_job" value="healer"/>힐러(문서작성)
				</td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					상세내용
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea rows="20" cols="50" placeholder="2000자 내외" maxlength="2000" name="maketeam_content"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="등록"/>
					<input type="reset" value="재작성"/>
					<input type="button" value="취소" onclick="window.location='gongmoContent.jsp'"/>
				</td>
			</tr>
		</table>
	</form>
</div>
		<!-- 풋터블럭 -->
			<%@ include file="../common/footer.jsp"%>
		</div>
</body>
</html>