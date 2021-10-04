<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
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
<body>
<%@ include file="../common/header.jsp" %>
		<!-- 컨텐츠블럭 -->
		<div class="container" align="center">
			<div class="content">
	<h1 align="left">공모전 수정</h1>
	
	<%
	String id = (String)session.getAttribute("cid");
	int num =Integer.parseInt(request.getParameter("gmboard_num"));
	System.out.println("cid = "+id);
	
	GongmoDAO dao = new GongmoDAO();
	GongmoWriteDTO gmdto = dao.getGmBoardList(num);
	String[] favor = gmdto.getGmboard_favor().split(",");
	String[] target = gmdto.getGmboard_target().split(",");
	String[] benefit = gmdto.getGmboard_benefit().split(",");
	%>
	
	<form action="gongmoModifyPro.jsp?gmboard_num=<%=num %>" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td align="left">
					제	목
				</td>
				<td>
					<input type="text" name="gmboard_title" value="<%=gmdto.getGmboard_title() %>" />
				</td>
			</tr>
			<tr>
				<td align="left">
					분	야
				</td>
				<td>
					<input type="checkbox" name="gmboard_favor" <%for(String i : favor){
																	if(i.equals("디자인")){
																	%>checked<%	
																	}
																}%> value="디자인" />디자인 
					<input type="checkbox" name="gmboard_favor" <%for(String i : favor){
																	if(i.equals("서포터즈")){
																	%>checked<%	
																	}
																}%> value="서포터즈" />서포터즈
					<input type="checkbox" name="gmboard_favor" <%for(String i : favor){
																	if(i.equals("과학")){
																	%>checked<%	
																	}
																}%> value="과학" />과학
				</td>
			</tr>
			<tr>
				<td align="left">
					참가대상
				</td>
				<td>
					<input type="checkbox" name="gmboard_target" <%for(String i : target){
																	if(i.equals("청소년")){
																	%>checked<%	
																	}
																}%> value="청소년" />청소년 
					<input type="checkbox" name="gmboard_target" <%for(String i : target){
																	if(i.equals("대학생")){
																	%>checked<%	
																	}
																}%>  value="대학생" />대학생
					<input type="checkbox" name="gmboard_target" <%for(String i : target){
																	if(i.equals("직장인/일반인")){
																	%>checked<%	
																	}
																}%> value="직장인/일반인" />직장인/일반인
					<input type="checkbox" name="gmboard_target" <%for(String i : target){
																	if(i.equals("제한없음")){
																	%>checked<%	
																	}
																}%> value="제한없음" />제한없음
				</td>
			</tr>
			<tr>
				<td align="left">
					수상인원
				</td>
				<td>
					<input type="text" name="gmboard_winner" placeholder="ex) 5" value="<%=gmdto.getGmboard_winner() %>" />
				</td>
			</tr>
			<tr>
				<td align="left">
					수상혜택
				</td>
				<td>
					<input type="checkbox" name="gmboard_benefit" <%for(String i : benefit){
																	if(i.equals("가산점")){
																	%>checked<%	
																	}
																}%> value="가산점" />가산점 
					<input type="checkbox" name="gmboard_benefit" <%for(String i : benefit){
																	if(i.equals("인턴채용")){
																	%>checked<%	
																	}
																}%> value="인턴채용" />인턴 채용
					<input type="checkbox" name="gmboard_benefit" <%for(String i : benefit){
																	if(i.equals("해외연수")){
																	%>checked<%	
																	}
																}%> value="해외연수" />해외연수
					<input type="checkbox" name="gmboard_benefit" <%for(String i : benefit){
																	if(i.equals("상금")){
																	%>checked<%	
																	}
																}%> value="상금" />상금
				</td>
			</tr>
			<tr>
				<td align="left">
					시상규모
				</td>
				<td>
					<select name="gmboard_money" >
						<option value="none" >=== 선택 ===</option>
						<option value="money1" <%
							if(gmdto.getGmboard_money().equals("money1")){%>selected<%}
						%>>5천만원 이상</option>
						<option value="money2"<%
							if(gmdto.getGmboard_money().equals("money2")){%>selected<%}
						%>>3천만원 ~ 5천만원</option>
						<option value="money3" <%
							if(gmdto.getGmboard_money().equals("money3")){%>selected<%}
						%>>1천만원 ~ 3천만원</option>
						<option value="money4" <%
							if(gmdto.getGmboard_money().equals("money4")){%>selected<%}
						%>>1천만원 이하</option>
						<option value="money5" <%
							if(gmdto.getGmboard_money().equals("money5")){%>selected<%}
						%>>없음</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="left">
					접수기간
				</td>
				<td>
					<input type="date" name="gmboard_sday" value="<%=gmdto.getGmboard_sday()%>"/> ~ <input type="date" name="gmboard_eday" value="<%=gmdto.getGmboard_eday()%>"/>
				</td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					모집요강
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea rows="20" cols="50" placeholder="2000자 내외" maxlength="2000" name="gmboard_content" wrap="hard">
						<%
							String Content = gmdto.getGmboard_content().replace("<br/>", "\r");
						%>					
						<%=Content%>
					</textarea>
				</td>
			</tr>
			<tr>
				<td align="left">
					포스터
				</td>
				<td>
				<%System.out.println("포스터이름 = "+gmdto.getGmboard_poster()); %>
				<%
				
					if(gmdto.getGmboard_poster() != null ){%>
						<%=gmdto.getGmboard_poster() %> <br />
					<%}else {%>
						<img src="/project/gongmoFile/defaultimg.png" width="100"/> <br />
					<%}	%>
					<input type="file" name="gmboard_poster"/>
					<input type="hidden" name="exgmboard_poster" value="<%=gmdto.getGmboard_poster() %>"/> <%-- 이전에 저장된 사진 정보 --%>
				</td>
			</tr>
			<tr>
				<td align="left">
					첨부파일
				</td>
				<td>
				<%
					if(gmdto.getGmboard_file() != null ){%>
						<%=gmdto.getGmboard_file() %><br />
					<%}else {%>
						첨부파일 없음. <br />
					<%}	%>
					<input type="file" name="gmboard_file"/>
					<input type="hidden" name="exgmboard_file" value="<%=gmdto.getGmboard_file() %>"/> <%-- 이전에 저장된 사진 정보 --%>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정"/>
					<input type="reset" value="재작성"/>
					<input type="button" value="취소" onclick="window.location='gongmoList.jsp'"/>
				</td>
			</tr>
		</table>
</form>
			</div>
		</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
</body>
</html>