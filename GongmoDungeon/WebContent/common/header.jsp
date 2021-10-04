<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
   <style>
		#input{
			background-color: #555555; /* Black */
  		 	 border: none;
 	  		 color: white;
 	  		 width: 90px;
   			 padding: 10px 20px;
   			 text-align: center;
   			 text-decoration: none;
   			 display: inline-block;
   			 font-size: 10px;
   			 border-radius: 8px;
   			 
		}  
      .btn{
         display:block; width:200px; height:70px; line-height:40px; border:1px #8977ad solid;; margin:5px auto; background-color:#8977ad; text-align:center; cursor: pointer; color:#333; transition:all 0.9s, color 0.3; font-size:20px; font-weight:bold;
      }
      .btn:hover{
         color:#fff;
      }
      /* button hover effect */
      /* .btn1:hover{ box-shadow: 200px 0 0 0 rgba(0,0,0,0.25) inset, -200px 0 0 0 rgba(0,0,0,0.25) inset; }
      .btn2:hover{ box-shadow: 200px 0 0 0 rgba(0,0,0,0.25) inset, -200px 0 0 0 rgba(0,0,0,0.25) inset; }
      .btn3:hover{ box-shadow: 200px 0 0 0 rgba(0,0,0,0.25) inset, -200px 0 0 0 rgba(0,0,0,0.25) inset; }
      .btn4:hover{ box-shadow: 200px 0 0 0 rgba(0,0,0,0.25) inset, -200px 0 0 0 rgba(0,0,0,0.25) inset; } */
      .button{
         display: flex;
      }
      .glass{
         width: auto; height: auto;
         max-width: 50px;
         max-height: 50px;
      }
      .dungeon{
         width: auto; height: auto;
         max-width: 300px;
         max-height: 300px;
         margin-top: 10px;
      }
   </style>
   <script>
      function showPopup() { window.open("../main/popup.html", "a", "width=400, height=300, left=100, top=50"); }
      
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
<!-- 외부CSS링크 네이밍 변경 필요 -->
<link href="../common/style.css" type="text/css" rel="stylesheet">

<body>
   <!-- 전체 -->
   <div class="wrap">
      <!-- 헤더블럭 -->
      <div class="header tb-color-1">
         <div class="content">
            <div style="float:left; width:33%;">
               <a href="../main/main.jsp">
               <img class="dungeon" src="../common/imgs/logo.png"></a>
            </div>
            <div style="float:left; width:33%;">
               <form action="../main/searchList.jsp">
                  <input type="text" name="search" style="width:250px;height:50px;margin-top:50px;"/>
                  <input type="image" src="../common/imgs/search.png" alt="검색" class="glass">
               </form>
            </div>
         
<%
   if(session.getAttribute("nid") == null && session.getAttribute("cid") == null){ // 세션속성없다 == 비 로그인
      // 세션이 없으면 쿠키는 있는지 확인
      String user_id = null, user_pw = null, auto = null, orgType = null; // 쿠키가 있으면 꺼내서 값 담아놓을 변수 (쿠키유무 판단용 변수)
      Cookie[] coos = request.getCookies(); // 쿠키들 모두 꺼내기
      
      if(coos != null){ // 쿠키가 있다면
         for(Cookie c : coos){ // 쿠키 반복해서 전체 돌린다
            if(c.getName().equals("autoId")) { user_id = c.getValue(); }
            if(c.getName().equals("autoPw")) { user_pw = c.getValue(); }
            if(c.getName().equals("autoCh")) { auto = c.getValue(); }
            if(c.getName().equals("orgTypeCh")) { orgType = c.getValue(); }
         }
      }
      // 세션은 없지만, 쿠키가 있어서 위 코드로 값을 꺼내 담아보고,
      // 만약에 세 변수에 값이 들어있으면 session을 만들어주기 위해 loginPro로 바로 이동시키기
      if(auto != null && user_id != null && user_pw != null && orgType != null){
         response.sendRedirect("../login/loginPro.jsp");
      }
%>
      <div class="div1" id="noLogin" style="float:left; width:33%; margin-top:30px;">
         <form action="../login/loginPro.jsp" method="post">
            <table>
               <tr>
                  <td>
                     <input type="radio" name="orgType" value="normal" checked="checked"/> 일반회원
                  </td>
                  <td>
                     <input type="radio" name="orgType" value="org" /> 기업회원
                  </td>
               </tr>
               <tr>
                  <td> 아이디 </td>
                  <td> <input type="text" name="user_id" required/> </td>
                  <td> <input id="input" type="submit" value="로그인" /> </td>
               </tr>
               <tr>
                  <td> 비밀번호 </td>
                  <td> <input type="password" name="user_pw" required/> </td>
                  <td> <input id="input" type="button" value="회원가입" onclick="window.location='../login/agreement.jsp'" /> </td>
               </tr>
               <tr>
                  <td colspan="3"><input type="checkbox" name="auto" value="1" /> 자동 로그인 </td>
               </tr>
            </table>
         </form>
      </div>
            
<%}else{  // 세션 속성 있다 == 로그인함 %>
            <div class="div2" id="login" style="float:left; width:33%; margin-top:50px;">
            <%if(session.getAttribute("nid") != null && session.getAttribute("nid").equals("admin")){ %>
               <%= session.getAttribute("nid") %> 님, 환영합니다. <br />
               <button id="input" onclick="window.location='../login/logout.jsp'">로그아웃</button>
               <button id="input"  onclick="window.location='../mypage/myUsernInfo.jsp'">마이페이지</button>
            <%}else if(session.getAttribute("cid") !=null){ %>
               <%= session.getAttribute("cid") %> 님, 환영합니다. <br />
               <button id="input" onclick="window.location='../login/logout.jsp'">로그아웃</button>
               <button id="input" onclick="window.location='../mypage/mypageMyinfo.jsp'">마이페이지</button>
            <%}else if(session.getAttribute("nid") !=null){%>
          	  <%= session.getAttribute("nid") %> 님, 환영합니다. <br />
            	<button id="input" onclick="window.location='../login/logout.jsp'">로그아웃</button>
               <button id="input" onclick="window.location='../mypage/mypageMyinfo.jsp'">마이페이지</button>
            <%}%>
              
            </div>
            
<%}%>         
         </div>
       </div>

      <!-- 카테고리블럭 -->
      <div class="category tb-color-1 bb-color-1">
         <div class="content" style="background-color: #8977ad;">
            <!-- 카테고리 코드 작성 -->
            <div class="button">
               <button class="btn btn1" onclick="window.location='../gongmo/gongmoList.jsp'">공모전</button>
               <button class="btn btn2" onclick="window.location='../calendar/calendar.jsp'">공고달력</button>
               <button class="btn btn3" onclick="showPopup()">대외활동</button>
               <button class="btn btn4" onclick="window.location='../community/communityList.jsp'">커뮤니티</button>
            </div>
         </div>
      </div>
</body>
</html>