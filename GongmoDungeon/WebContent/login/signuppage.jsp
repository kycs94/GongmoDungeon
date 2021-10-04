<%@page import="team04.project.login.signupDTO"%>
<%@page import="java.util.List"%>
<%@page import="team04.project.login.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일반/기관 회원가입</title>
<%
 String strReferer = request.getHeader("referer");
 
 if(strReferer == null){
%>
 <script>
  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다. 정상적인 경로를 통해 다시 접근해 주십시오.");
  document.location.href="../main/main.jsp";
 </script>
<%
  return;
 }
%>
	<script>
		//일반회원 이메일 직접입력
		function checkemailaddy(){
			if (email_select.value == '' || email_select.value == null) {
	            email2.readOnly = false;
	            email2.value = null;
	            email2.focus();
	        }
	        else {
	            email2.readOnly = true;
	            email2.value = email_select.value;
	        }
	    }
		
		//기업회원 이메일 직접입력
		function checkemailaddyy(){
			if (email_selectt.value == '' || email_selectt.value == null) {
	            email4.readOnly = false;
	            email4.value = '';
	            email4.focus();
	        }
	        else {
	            email4.readOnly = true;
	            email4.value = email_selectt.value;
	        }
	    }
		
		//아이디중복체크 초기화
		function chgDuplCheck(){
			if(document.getElementById('duplCheck').getAttribute('value')=="true"){
				document.getElementById('duplCheck').setAttribute('value', "false");
			}
		}
		
		//일반회원 유효성검사
		function nCheck(){
	    	
			var inputs = document.inputFormN;
			
			var usern_pw = inputs.usern_pw.value;
			var usern_pw_num = usern_pw.search(/[0-9]/g);
			var usern_pw_eng = usern_pw.search(/[a-z]/ig);
			var usern_pw_spe = usern_pw.search(/[`~!@@#$%^&*-|₩₩₩'₩";:₩/?]/gi);
			
			if(!inputs.user_id.value){
				alert("아이디를 입력하세요.");
				return false;
			}
			if(!inputs.usern_pw.value){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(usern_pw.length < 8 || usern_pw.length > 16){
				alert("비밀번호는 8자리 ~ 16자리 이내로 입력해주세요.");
				return false;
			}
			if(usern_pw.search(/\s/) != -1){
				alert("비밀번호는 공백 없이 입력해주세요.");
				return false;
			}
			if(usern_pw_num < 0 || usern_pw_eng < 0 || usern_pw_spe < 0 ){
				alert("비밀번호는 영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
				return false;
			}
			if(!inputs.usern_pwCh.value){
				alert("비밀번호 확인란을 입력하세요.");
				return false;
			}
			if(!inputs.usern_name.value){
				alert("이름을 입력하세요.");
				return false;
			}
			if(inputs.usern_pw.value != inputs.usern_pwCh.value){
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			}

			if(inputs.email1.value != null){
				if(inputs.email2.value == null){
					//이메일 앞에 것이 있으면서 이메일 뒤에가 없을 경우
					alert("이메일작성을 완료해주세요.");
					return false;				
				}else{// 이메일1, 이메일2 다있는경우(이메일 작성완료한경우)
					var email = inputs.email1.value+"@"+inputs.email2.value;
					if(email == '@'){
						email = "0";
					}
					document.getElementById('usern_email').setAttribute('value', email);
				}
			}
			
			if(inputs.usern_phone.value != null){
				var nphone = inputs.usern_phone.value;
				if(nphone == ""){
					nphone = "0";
				}
					document.getElementById('usern_phone').setAttribute('value', nphone);
			}
			
			if(inputs.usern_award.value != null){
				var naward = inputs.usern_award.value;
				if(naward == ""){
					naward = "0";
				}
					document.getElementById('usern_award').setAttribute('value', naward);
			}
			
			if(inputs.usern_popul.value != null){
				var npopul = inputs.usern_popul.value;
				if(npopul == ""){
					npopul = "0";
				}
					document.getElementById('usern_popul').setAttribute('value', npopul);
			}
						
			if(inputs.usern_active.value != null){
				var nactive = inputs.usern_active.value;
				if(nactive == ""){
					nactive = "0";
				}
					document.getElementById('usern_active').setAttribute('value', nactive);
			}
			
			if(inputs.usern_history.value != null){
				var nhistory = inputs.usern_history.value;
				if(nhistory == ""){
					nhistory = "0";
				}
					document.getElementById('usern_history').setAttribute('value', nhistory);
			}
						
			if(inputs.usern_dropmsg.value != null){
				var ndropmsg = inputs.usern_dropmsg.value;
				if(ndropmsg == ""){
					ndropmsg = "0";
				}
					document.getElementById('usern_dropmsg').setAttribute('value', ndropmsg);
			}
			
			//관심분야 ,
			var checkbox = document.getElementsByName('usern_favor');
			
	        if(checkbox.length>0){
				var checked = "";

		        for(var i=0; i<checkbox.length; i++){
		            if(checkbox[i].checked){
		                checked += checkbox[i].value+",";
		            }
		        }
		        document.getElementById('user_favor').setAttribute('value', checked);
	        }
			
	        //아이디 중복체크
	        if(document.getElementById('duplCheck').getAttribute('value')=="false"){
	        	alert("아이디중복체크를 해주세요.");
	        	return false;
	        }
	    }
	    
		//일반회원 아이디 중복확인
		function confirmNid(inputFormN){
			if(inputFormN.user_id.value == "" || !inputFormN.user_id.value){
				alert("아이디를 입력하세요");
				return;
			}
			
			var url = "confirmId.jsp?user_id=" + inputFormN.user_id.value;
			open(url, "confirmId", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
		}
		
		//기업회원 유효성검사
		function cCheck(){
			var inputs = document.inputFormC;
			
			var userc_pw = inputs.userc_pw.value;
			var userc_pw_num = userc_pw.search(/[0-9]/g);
			var userc_pw_eng = userc_pw.search(/[a-z]/ig);
			var userc_pw_spe = userc_pw.search(/[`~!@@#$%^&*-|₩₩₩'₩";:₩/?]/gi);
			
			if(!inputs.user_id.value){
				alert("아이디를 입력하세요.");
				return false;
			}
			if(!inputs.userc_pw.value){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(userc_pw.length < 8 || userc_pw.length > 16){
				alert("비밀번호는 8자리 ~ 16자리 이내로 입력해주세요.");
				return false;
			}
			if(userc_pw.search(/\s/) != -1){
				alert("비밀번호는 공백 없이 입력해주세요.");
				return false;
			}
			if(userc_pw_num < 0 || userc_pw_eng < 0 || userc_pw_spe < 0 ){
				alert("비밀번호는 영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
				return false;
			}
			if(!inputs.userc_pwCh.value){
				alert("비밀번호 확인란을 입력하세요.");
				return false;
			}
			if(!inputs.userc_name.value){
				alert("기업명을 입력하세요.");
				return false;
			}
			if(!inputs.userc_num.value){
				alert("사업자번호를 입력하세요.");
				return false;
			}
			if(inputs.userc_pw.value != inputs.userc_pwCh.value){
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			}
			if(inputs.email3.value != null){
				if(inputs.email4.value == null){
					//이메일 앞에 것이 있으면서 이메일 뒤에가 없을 경우
					alert("이메일작성을 완료해주세요.");
					return false;				
				}else{// 이메일3, 이메일4 다있는경우(이메일 작성완료한경우)
					var email = inputs.email3.value+"@"+inputs.email4.value;
					if(email == '@'){
						email = "0";
					}
					document.getElementById('userc_email').setAttribute('value', email);
				}
			}
			
			if(inputs.userc_url.value != null){
				var curl = inputs.userc_url.value;
				if(curl == ""){
					curl = "0";
				}
					document.getElementById('userc_url').setAttribute('value', curl);
			}
			
		}
		
		//기업회원 아이디 중복확인
		function confirmCid(inputFormC){
			if(inputFormC.user_id.value == "" || !inputFormC.user_id.value){
				alert("아이디를 입력하세요");
				return;
			}
			
			var url = "confirmId.jsp?user_id=" + inputFormC.user_id.value;
			open(url, "confirmId", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
		}
		
		// div show/hide
		function signup(type){
			const nsign = document.getElementById("n");
			const csign = document.getElementById("c");
			 
			if(type == 'N'){
			   nsign.style.display = "block";
			   csign.style.display = "none";
			}else{
			   nsign.style.display = "none";
			   csign.style.display = "block";
			}		
		}		
	</script>
</head>
<%
	LoginDAO dao = LoginDAO.getInstance();
	List mailList = null;
	mailList = dao.getmailList();
%>
<body>
	<div align="center">
		<input type="button" value="일반 회원가입" onclick="signup('N')" />
		<input type="button" value="기관 회원가입" onclick="signup('C')" />
	</div>
	
	<div class="nsign" id="n" style="display:none" align="center">
	<h2>일반 회원가입</h2>
	<h5><font color="red">*는 필수 기입사항입니다.</font></h5>
		<form action="signupPro.jsp" method="post" name="inputFormN" onsubmit="return nCheck()">
			<input type="hidden" id="duplCheck" value="false"/>
			<input type ="hidden" name="orgType" value ="normal"/>
			<input type ="hidden" name="user_favor" id="user_favor"/>
			<input type="hidden" name="usern_email" id="usern_email"/>
			<input type="hidden" name="usern_award" id="usern_award" />
			<input type="hidden" name="usern_popul" id="usern_popul" />
			<input type="hidden" name="usern_active" id="usern_active" />
			<input type="hidden" name="usern_history" id="usern_history" />
			<input type="hidden" name="usern_dropmsg" id="usern_dropmsg" />
			
			<table>
				<tr>
					<td> <font color="red">*</font> 아이디 </td>
					<td>
						<input type="text" name="user_id" onKeyup="chgDuplCheck(); this.value=this.value.replace(/[^a-zA-Z0-9]/gi,'');" maxlength="10" />
						<input type="button" value="중복확인" onclick="confirmNid(this.form)" />
					</td>
				</tr>
				<tr>
					<td> <font color="red">*</font> 비밀번호 </td>
					<td> <input type="password" name="usern_pw" /> </td>
				</tr>
				<tr>
					<td> <font color="red">*</font> 비밀번호 확인 </td>
					<td> <input type="password" name="usern_pwCh" /> </td>
				</tr>
				<tr>
					<td> <font color="red">*</font> 이름 </td>
					<td> <input type="text" name="usern_name" onKeyup="this.value=this.value.replace(/[^a-zA-Zㄱ-힣]/gi,'');" maxlength="20"/> </td>
				</tr>
				<tr>
					<td> 이메일 </td>
					<td>
						<input name="email1" type="text" id="email1" size="15"> @ <input name="email2" type="text" id="email2" size="20">
						<select name="email_select" id="email_select" onChange="checkemailaddy();">
						    <option value="" selected>직접입력</option>
							<%for(int i = 0; i < mailList.size(); i++){
								signupDTO mail = (signupDTO)mailList.get(i);
							%>
							<option value="<%=mail.getCode()%>"><%=mail.getCode()%></option>
							<%}%>
						</select>
					</td>
				</tr>
				<tr>
					<td> 전화번호 </td>
					<td> <input type="text" name="usern_phone" id="usern_phone" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="11" placeholder="'-'를 제외한 전화번호 입력" /> </td>
				</tr>
				<tr>
					<td> 소속 </td>
					<td>
						<select name="usern_attach">
							<option value="teenager">청소년</option>
							<option value="nolimit">대상 제한 없음</option>
							<option value="student">대학생</option>
							<option value="worker">직장인/일반인</option>
						</select>
					</td>
				</tr>
				<tr>
					<td> 지역 </td>
					<td>
						<select name="usern_local">
							<option value="seoul">서울</option>
							<option value="incheon">인천</option>
							<option value="gyeonggi">경기도</option>
							<option value="gangwon">강원도</option>
							<option value="chungcheong">충청도</option>
							<option value="gyeongsang">경상도</option>
							<option value="jeolla">전라도</option>
							<option value="jeju">제주도</option>
						</select>
					</td>
				</tr>
				<tr>
					<td> 관심분야 </td>
					<td>
						<input type="checkbox" name="usern_favor" id="usern_favor" value="design" checked/> 디자인
						<input type="checkbox" name="usern_favor" id="usern_favor" value="supporters" /> 서포터즈
						<input type="checkbox" name="usern_favor" id="usern_favor" value="science" /> 과학
					</td>
				</tr>
				<tr>
					<td> 직업 </td>
					<td>
						<input type="radio" name="usern_job" id="usern_job" value="warrior" checked/> 전사(발표)
						<input type="radio" name="usern_job" id="usern_job" value="magician" /> 마법사(포토샵)
						<input type="radio" name="usern_job" id="usern_job" value="rogue" /> 도적(기획)
						<input type="radio" name="usern_job" id="usern_job" value="archer" /> 궁수(디자인)
						<input type="radio" name="usern_job" id="usern_job" value="healer" /> 힐러(문서작성)
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="가입" />
						<input type="reset" value="재작성" />
						<input type="button" value="취소" onclick="window.location='../main/main.jsp'" />
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div class="csign" id="c" style="display:none" align="center">
	<h2>기관 회원가입</h2>
	<h5><font color="red">*는 필수 기입사항입니다.</font></h5>
		<form action="signupPro.jsp" method="post" name="inputFormC" onsubmit="return cCheck()">
			<input type ="hidden" name="orgType" value ="org"/>
			<input type="hidden" name="userc_email" id="userc_email"/>
			<table>
				<tr>
					<td> <font color="red">*</font> 아이디 </td>
					<td>
						<input type="text" name="user_id" onKeyup="chgDuplCheck(); this.value=this.value.replace(/[^a-zA-Z0-9]/gi,'');" maxlength="10" />
						<input type="button" value="중복확인" onclick="confirmCid(this.form)" />
					</td>
				</tr>
				<tr>
					<td> <font color="red">*</font> 비밀번호 </td>
					<td> <input type="password" name="userc_pw" /> </td>
				</tr>
				<tr>
					<td> <font color="red">*</font> 비밀번호 확인 </td>
					<td> <input type="password" name="userc_pwCh" /> </td>
				</tr>
				<tr>
					<td> <font color="red">*</font> 기업명 </td>
					<td> <input type="text" name="userc_name" onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9ㄱ-힣]/gi,'');"/> </td>
				</tr>
				<tr>
					<td> <font color="red">*</font> 기업형태 </td>
					<td>
						<select name="userc_type">
							<option value="major">대기업</option>
							<option value="startup">중소기업/스타트업</option>
							<option value="public">공공기관/공기업</option>
							<option value="foreign">외국계기업</option>
							<option value="midsize">중견기업</option>
							<option value="association">비영리단체/협회/교육재단</option>
							<option value="band">동아리/학생자치단체</option>
							<option value="hospital">병원</option>
							<option value="etc">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<td> <font color="red">*</font> 사업자번호 </td>
					<td> <input type="text" name="userc_num" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10" placeholder="'-'를 제외한 사업자번호 입력" /> </td>
				</tr>
				<tr>
					<td> 홈페이지 </td>
					<td> <input type="text" name="userc_url" id="userc_url" /> </td>
				</tr>
				<tr>
					<td> 이메일 </td>
					<td>
						<input name="email3" type="text" class="box" id="email3" size="15"> @ <input name="email4" type="text" class="box" id="email4" size="20">
						<select name="email_selectt" class="box" id="email_selectt" onChange="checkemailaddyy();">
						    <option value="" selected>직접입력</option>
							<%for(int i = 0; i < mailList.size(); i++){
								signupDTO mail = (signupDTO)mailList.get(i);
							%>
							<option value="<%=mail.getCode()%>"><%=mail.getCode()%></option>
							<% }%>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="가입" />
						<input type="reset" value="재작성" />
						<input type="button" value="취소" onclick="window.location='../main/main.jsp'" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>