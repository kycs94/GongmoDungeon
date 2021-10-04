<%@page import="team04.project.gongmo.GongmoTeamApplyDTO"%>
<%@page import="team04.project.gongmo.GongmoTeamMakeDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
<title>팀원 게시글</title>
<link href="style.css" type="text/css" rel="stylesheet">
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
	int anum = Integer.parseInt(request.getParameter("applyteam_num"));
	System.out.println("gmboard_num = " + num);
	System.out.println("maketeam_num = " + mnum);
	System.out.println("applyteam_num = " + anum);
	GongmoDAO dao = new GongmoDAO();
	// num 가지고 해당 게시글 내용 가져오기
	GongmoTeamMakeDTO dto = (GongmoTeamMakeDTO) dao.getListContent(mnum);
%>
</head>

<!-- 전체 -->
<div class="wrap">

	<!-- 헤더블럭 -->
	<%@ include file="../common/header.jsp"%>

	<!-- 컨텐츠블럭 -->
	<div class="container" align="center">


		<%--작성자와세션 아이디가 같을때 수정 삭제 가능하게 보여주는 화면 --%>
		<%
			if (session.getAttribute("nid").equals(dto.getMaketeam_id())) {
		%>

		<body>
			<div align="center">
				<!-- content 보여주기 !! -->
				<table>
					<tr>
						<td>제목 &nbsp;</td>
						<td><%=dto.getMaketeam_title()%> &nbsp;</td>
						<td>팀명 &nbsp;</td>
						<td><%=dto.getMaketeam_name()%> &nbsp;</td>
					</tr>
					<tr>
						<td>팀장</td>
						<td><%=dto.getMaketeam_id()%></td>
						<td>모집인원</td>
						<td><%=dto.getMaketeam_Ptotal()%>명</td>
					</tr>

					<tr>
						<td colspan="3">내용</td>
						<td><input type="button" value="수정" /> <input type="button"
							value="삭제" /></td>
					</tr>
					<tr>
						<td colspan="4" height="100" align="center"><%=dto.getMaketeam_content()%>
						</td>
					</tr>

				</table>

				<!-- MakeTeam 작성자 입장에서 볼때 지원현황 -->

				<%
					// 지원자가 잇는지 없는지 count
						List list = null;
						GongmoTeamApplyDTO adto = null;
						int count = 0;
						count = dao.applyListCount(mnum);
						System.out.println("applyteam count = " + count);
				%>
				<%
					if (count > 0) {
							list = dao.applyList(mnum);
				%>
				<table border="1">
					<tr>
						<td>지원자(별점)</td>
						<td>내용</td>
						<td>합격여부</td>
						<td>평가</td>
					</tr>

					<%
						for (int i = 0; i < list.size(); i++) {
									adto = (GongmoTeamApplyDTO) list.get(i);
									if (session.getAttribute("nid").equals(adto.getApplyteam_id()))
					%>
					<tr>
						<td><%=adto.getApplyteam_id()%></td>
						<td><%=adto.getApplyteam_comm()%></td>
						<td><button
								onclick="window.location='gongmoTeamResult.jsp?gmboard_num=<%=num%>&maketeam_num=<%=mnum%>&result=1&applyteam_id=<%=adto.getApplyteam_id()%>'">수락</button>
							/
							<button
								onclick="window.location='gongmoTeamResult.jsp?gmboard_num=<%=num%>&maketeam_num=<%=mnum%>&result=2&applyteam_id=<%=adto.getApplyteam_id()%>'">거절</button></td>
						<td>별점이 나와야함</tdl>
					</tr>
					<%
						}
					%>
					<tr>
						<td><button
								onclick="window.location='gongmoTeamList.jsp?gmboard_num=<%=num%>'">뒤로</button>
					</tr>

				</table>
				<%
					} else {
				%>
				<table border="1">
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
				<%
					}
				%>

			</div>
		</body>

		<%
			} // 일반회원 일때 보여주는 확면	
			else if (session.getAttribute("nid") != null) {
		%>

		<body>
			<div align="center">
				<!-- content 보여주기 !! -->
				<table>
					<tr>
						<td>제목 &nbsp;</td>
						<td><%=dto.getMaketeam_title()%> &nbsp;</td>
						<td>팀명 &nbsp;</td>
						<td><%=dto.getMaketeam_name()%> &nbsp;</td>
					</tr>
					<tr>
						<td>팀장</td>
						<td><%=dto.getMaketeam_id()%></td>
						<td>모집인원</td>
						<td><%=dto.getMaketeam_Ptotal()%>명</td>
					</tr>

					<tr>
						<td colspan="4">내용</td>
					<tr>
						<td colspan="4" height="100" align="center"><%=dto.getMaketeam_content()%>
						</td>
					</tr>

				</table>

				<!-- 지원자가 지원... -->
				<form
					action="gongmoApplyModifyPro.jsp?gmboard_num=<%=num%>&maketeam_num=<%=mnum%>&applyteam_num=<%=anum%>"
					method="post">
					<table>
						<tr>
							<td colspan="4" align="left">지원</td>
						</tr>
						<tr>
							<td colspan="4" height="40"><textarea rows="7" cols="38"
									name="applyteam_comm1"
									placeholder="<%=request.getParameter("applyteam_comm")%>"></textarea></td>
							<td><input type="submit" value="수정" /></td>
						</tr>

					</table>
				</form>

				<!-- 지원현황 -->

				<%
					// 지원자가 잇는지 없는지 count
						List list = null;
						GongmoTeamApplyDTO adto = null;
						int count = 0;
						count = dao.applyListCount(mnum);
						System.out.println("applyteam count = " + count);
				%>
				<%
					if (count > 0) {
							list = dao.applyList(mnum);
				%>
				<table border="1">
					<tr>
						<td>지원자(별점)</td>
						<td>내용</td>
						<td>합격여부</td>
						<td>평가</td>
					</tr>

					<%
						for (int i = 0; i < list.size(); i++) {
									adto = (GongmoTeamApplyDTO) list.get(i);
					%>
					<tr>
						<td><%=adto.getApplyteam_id()%></td>
						<td><%=adto.getApplyteam_comm()%> <%
 						if (session.getAttribute("nid").equals(adto.getApplyteam_id())) {
 						%>
							<button
								onclick="window.location='gongmoTeamContent.jsp?gmboard_num=<%=num%>&maketeam_num=<%=mnum%>&applyteam_comm=<%=adto.getApplyteam_comm()%>&applyteam_num=<%=adto.getApplyteam_num()%>'">수정</button>
							<button
								onclick="window.location='gongmoApplyDeletePro.jsp?gmboard_num=<%=num%>&maketeam_num=<%=mnum%>&applyteam_num=<%=adto.getApplyteam_num()%>&applyteam_comm=<%=adto.getApplyteam_comm()%>&applyteam_id=<%=adto.getApplyteam_id()%>'">삭제</button>
							<%
								}
							%></td>
						<td>
							<%
								if (adto.getApplyteam_result() == 0) {
							%> 평가중... <%
								} else if (adto.getApplyteam_result() == 1) {
							%>
							합격 <%
								} else if (adto.getApplyteam_result() == 2) {
							%> 불합격 <%
								}
							%>
						</td>
						<td align="center"><a onclick="showPopup();">X</a></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td><button
								onclick="window.location='gongmoTeamList.jsp?gmboard_num=<%=num%>'">뒤로</button>
					</tr>

				</table>
				<%
					} else {
				%>
				<table border="1">
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
				<%
					}
				%>

			</div>
		</body>


		<%
			} // 아무것도 아닌 
			else {
		%>
		<script>
			alert("접근 불가");
			history.go(-1);
		</script>
		<%
			}
		%>
	
</html>
</div>

<!-- 풋터블럭 -->
<%@ include file="../common/footer.jsp"%>
</div>