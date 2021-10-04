<%@page import="team04.project.gongmo.GongmoTeamMakeDTO"%>
<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		String id =(String)session.getAttribute("cid");
		String userc_pw=request.getParameter("userc_pw");
		int num = Integer.parseInt(request.getParameter("gmboard_num"));
		System.out.println("gmboard_num ="+num);
		
		GongmoDAO dao = new GongmoDAO();
		// 삭제
		GongmoWriteDTO gmdto = dao.getPoster(id);
		String path=request.getRealPath("gongmoFile"); // 실제 파일 저장되는 save 폴더의 경로 찾고
		String path1=request.getRealPath("gongmoFile"); // 실제 파일 저장되는 save 폴더의 경로 찾고
		path+="\\"+gmdto.getGmboard_poster(); // 거기에 \ 파일 확장자 추가해서 실제 파일 파일 경로 준비!!!
		path1+="\\"+gmdto.getGmboard_file(); // 거기에 \ 파일 확장자 추가해서 실제 파일 파일 경로 준비!!!
		System.out.println(path);
		System.out.println(path1);
		
		int gresult =0;
		int mresult =0;
		int aresult =0;
		
		// 값이 있는지 없는지 
		boolean YorN = dao.TFmaketeamNum(num);
		System.out.println("maketeam_num 값이 있냐 ? "+YorN);
		if(YorN){
		GongmoTeamMakeDTO dto = dao.getMaketeamNum(num);
		System.out.println(dto.getMaketeam_num());
		int acount= dao.countApplyteam(dto.getMaketeam_num());
		System.out.println("applyteam_count = "+acount);
		if(acount > 0){
			aresult = dao.deleteApplyteam(dto.getMaketeam_num());
			if(!(aresult == -1)){
				int mcount = dao.countMaketeam(num);
				System.out.println("maketeam_count = "+mcount);
				if(mcount>0){
					mresult = dao.deleteMaketeam(num);
					if(mresult == 1){
						gresult = dao.deleteGongmo(id, userc_pw, num);
						if(gresult == 1){
						File f = new File(path); // 포스터 객체생성 및 경로
						File f1 = new File(path1); // 파일 객체생성 및 경로
						f.delete(); // 포스터 삭제
						f1.delete(); // 파일 삭제%>
							<script>
							alert("공모전, maketeam, apply 삭제완료!");
							self.close();
							opener.document.location="gongmoList.jsp";
							</script>
						<%}
					}
				}
			}
		}else{	// applyteam가 없는경우, maketeam은 있을 수 있다
			int mcount = dao.countMaketeam(num);
			System.out.println("maketeam_count = "+mcount);
			if(mcount>0){
				mresult = dao.deleteMaketeam(num);
				if(mresult == 1){
					gresult = dao.deleteGongmo(id, userc_pw, num);
					if(gresult == 1){
						File f = new File(path); // 포스터 객체생성 및 경로
						File f1 = new File(path1); // 파일 객체생성 및 경로
						f.delete(); // 포스터 삭제
						f1.delete(); // 파일 삭제%>
						<script>
						alert("(applyteam 없음) 공모전, maketeam 삭제완료!");
						self.close();
						opener.document.location="gongmoList.jsp";
						</script>
					<%}
				}
			}else{ // maketeam 도 없을 경우
				gresult = dao.deleteGongmo(id, userc_pw, num);
				if(gresult == 1){
					File f = new File(path); // 포스터 객체생성 및 경로
					File f1 = new File(path1); // 파일 객체생성 및 경로
					f.delete(); // 포스터 삭제
					f1.delete(); // 파일 삭제%>
					<script>
					alert("(applyteam, maketeam 없음) 공모전 삭제완료!");
					self.close();
					opener.document.location="gongmoList.jsp";
					</script>
				<%}
			}
		}
		}else { // maketeam_num이 없다는건 공모전만 있다는거니까...
			gresult = dao.deleteGongmo(id, userc_pw, num);
			if(gresult == 1){
			File f = new File(path); // 포스터 객체생성 및 경로
			File f1 = new File(path1); // 파일 객체생성 및 경로
			f.delete(); // 포스터 삭제
			f1.delete(); // 파일 삭제%>
				<script>
				alert("(applyteam, maketeam 없음) 공모전 삭제완료!");
				self.close();
				opener.document.location="gongmoList.jsp";
				</script>
			<%}
		}
%>	
<body>

</body>
</html>