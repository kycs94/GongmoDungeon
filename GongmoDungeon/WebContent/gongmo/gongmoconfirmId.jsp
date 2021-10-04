<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="team04.project.gongmo.GongmoTeamApplyDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원자가 지원을 했었는지 안했는지</title>
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
<script type="text/javascript">
window.onload = function(){
<%
String id = request.getParameter("id");
int mnum = Integer.parseInt(request.getParameter("maketeam_num"));
int num = Integer.parseInt(request.getParameter("gmboard_num"));

GongmoTeamApplyDTO adto = new GongmoTeamApplyDTO();
GongmoDAO dao = new GongmoDAO();
List list = dao.applyIdCheck(mnum);
if(list==null){%>

	window.opener.document.location="gongmoTeamContent.jsp?gmboard_num="+<%=num%>+"&maketeam_num="+<%=mnum%>;
	self.close();

<%}else{

for(int i=0;i<list.size();i++){
	adto=(GongmoTeamApplyDTO)list.get(i);
	if(adto.getApplyteam_id().equals(id)){%>
	
				alert("이미지원한 지원자 입니다.");
				self.close();
			
	<%}else{%>
			
				window.opener.document.location="gongmoTeamContent.jsp?gmboard_num="+<%=num%>+"&maketeam_num="+<%=mnum%>;
				self.close();
		<%}
	}
}

%>
}
</script>

<body>

</body>
</html>