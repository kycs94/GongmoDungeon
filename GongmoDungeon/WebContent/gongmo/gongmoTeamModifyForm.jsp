<%@page import="team04.project.gongmo.GongmoTeamMakeDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 수정</title>
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
	int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
	
	GongmoDAO dao = new GongmoDAO();
	// num 가지고 해당 게시글 내용 가져오기
	GongmoTeamMakeDTO dto = (GongmoTeamMakeDTO)dao.getListContent(mnum);
%>
<!-- 전체 -->
	<div class="wrap">

		<!-- 헤더블럭 -->
		<%@ include file="../common/header.jsp" %>

	<!-- 컨텐츠블럭 -->
		<div class="container" align="center">

<body>
	<h1 align="left">팀 수정</h1>
	
	<form action="gongmoTeamModifyPro.jsp?gmboard_num=<%=num %>&maketeam_num=<%=mnum %>" method="post">
		<table>
			<tr>
				<td align="left">
					제	목
				</td>
				<td>
					<input type="text" name="maketeam_title" value="<%=dto.getMaketeam_title()%>"/>
				</td>
			</tr>
			<tr>
				<td align="left">
					팀	명
				</td>
				<td>
					<input type="text" name="maketeam_name" value="<%=dto.getMaketeam_name() %>" />
				</td>
			</tr>
			<tr>
				<td align="left">
					모집인원
				</td>
				<td>
					<input type="text" name="maketeam_Ptotal" value="<%=dto.getMaketeam_Ptotal()%>"/>
				</td>
			</tr>
			<tr>
				<td align="left">
					지원 가능 직업
				</td>
				<%
				String job = (String)dto.getMaketeam_job();
				System.out.println("job = "+job);
				String str[] = job.split(",");
				%>
				<td>
					<input type="checkbox" name="maketeam_job" <%
																	for(String i : str){
																		if(i.equals("warrior")){
																			%>checked<%
																		}
																	}
																%> value="warrior"/>전사(발표)
					<input type="checkbox" name="maketeam_job" <%
																	for(String i : str){
																		if(i.equals("magician")){
																			%>checked<%
																		}
																	}
																%> value="magician"/>마법사(포토샵) <br /><br />
					<input type="checkbox" name="maketeam_job" <%
																	for(String i : str){
																		if(i.equals("rogue")){
																			%>checked<%
																		}
																	}
																%> value="rogue"/>도적(기획)
					<input type="checkbox" name="maketeam_job" <%
																	for(String i : str){
																		if(i.equals("archer")){
																			%>checked<%
																		}
																	}
																%> value="archer"/>궁수(디자인) <br /><br />
					<input type="checkbox" name="maketeam_job" <%
																	for(String i : str){
																		if(i.equals("healer")){
																			%>checked<%
																		}
																	}
																%> value="healer"/>힐러(문서작성)
				</td>
				
			</tr>
			<tr>
				<td align="left" colspan="2">
					상세내용
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea rows="20" cols="50" placeholder="2000자 내외" maxlength="2000" name="maketeam_content"><%=dto.getMaketeam_content() %></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정"/>
					<input type="reset" value="재작성"/>
					<input type="button" value="취소" onclick="window.location='../gongmo/gongmoTeamContent.jsp?gmboard_num=<%=num %>&maketeam_num=<%=mnum%>'"/>
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