<%@page import="java.util.List"%>
<%@page import="team04.project.gongmo.GongmoTeamApplyDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 평가 페이지</title>
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
	String id = (String)session.getAttribute("nid");
	int num = Integer.parseInt(request.getParameter("gmboard_num"));
	int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
	int anum = Integer.parseInt(request.getParameter("applyteam_num"));
	int applyteam_result = Integer.parseInt(request.getParameter("applyteam_result"));
	
	GongmoDAO dao = new GongmoDAO(); 
	GongmoTeamApplyDTO adto=null;
	boolean result = false;
	List list = null;
	result = dao.getapplyName(anum, id);
	System.out.println(result);
	if(result){
		list = dao.applyTeamList(mnum, id);%>
	
		<%for(int i=0;i<list.size();i++){
			adto=(GongmoTeamApplyDTO)list.get(i);%>
			<form action="gongmoPersonPopulPro.jsp?gmboard_num=<%=num%>&maketeam_num=<%=mnum%>&applyteam_num=<%=anum%>&listsize=<%=list.size() %>" method="post">
			<input type="hidden" name="applyteam_id<%=i %>" value="<%=adto.getApplyteam_id() %>" />
		<table>
				<tr>
					<td><%=i+1 %>. 닉네임 : <%=adto.getApplyteam_id() %></td>
				</tr>
				<tr>
					<td>점수 : <select name="popul<%=i%>">
						<option value="10">10</option>
						<option value="9">9</option>
						<option value="8">8</option>
						<option value="7">7</option>
						<option value="6">6</option>
						<option value="5">5</option>
						<option value="4">4</option>
						<option value="3">3</option>
						<option value="2">2</option>
						<option value="1">1</option>
					</select></td>
				</tr>
		<%}%>
			<tr>
					<td>
					<input type="submit" value="평가" />
					<input type="button" value="취소" onclick="self.close();" /></td>
				</tr>
		</table>
		</form>
	<%}else{%>
		<script>
			alert("평가 대상이 아닙니다. 아이디를 확인하세요.");
			self.close();
			
		</script>
	<%}
%>
<body>

</body>
</html>