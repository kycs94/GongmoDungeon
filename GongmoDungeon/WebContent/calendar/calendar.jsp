<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="team04.project.calendar.CalendarDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 외부CSS링크 네이밍 변경 필요 -->
<link href="style.css" type="text/css" rel="stylesheet">

<!-- 스타일 적용시켜주기 -->
<style type="text/css">
/* 기본스타일  */   
   table{ background-color: "white";}
   
   #tr1{height: 60px;}
   td.sunday{width: 100px; text-align: right; font-size: 15pt; font-family: D2coding;}
   td.saturday{width: 100px; text-align: right; font-size: 15pt; font-family: D2coding;}
   td.etcday{width: 100px; text-align: right; font-size: 15pt; font-family: D2coding;}
   td.sun{width: 100px; text-align: right; font-size: 15pt; font-family: D2coding;}
   td.sat{width: 100px; text-align: right; font-size: 15pt; font-family: D2coding;}
   td.etc{width: 100px; text-align: right; font-size: 15pt; font-family: D2coding;}
   td.redbefore{width: 100px; text-align: right; font-size: 15pt; font-family: D2coding;}
   td.before{width: 100px; text-align: right; font-size: 15pt; font-family: D2coding;}
   
/* 타이틀 스타일 */
   th#title {font-size: 20pt; font-weight: bold; color: #FFBF00; font-family: D2coding; }

/* 요일 스타일 */
   td.sunday{ text-align: center; font-weight: bold; color: red; font-family: D2coding; }
   td.saturday{ text-align: center; font-weight: bold; color: blue; font-family: D2coding; }
   td.etcday{ text-align: center; font-weight: bold; color: black; font-family: D2coding; }

/* 날짜 스타일 */
   td.sun{ text-align: right; font-size: 10pt; color: red; font-family: D2coding; vertical-align: top;}
   td.sat{ text-align: right; font-size: 10pt; color: blue; font-family: D2coding; vertical-align: top;}
   td.etc{ text-align: right; font-size: 10pt; color: black; font-family: D2coding; vertical-align: top;}
   
   td.redbefore{ text-align: right; font-size: 8pt; color: red; font-family: D2coding; vertical-align: top;}
   td.before{ text-align: right; font-size: 8pt; color: gray; font-family: D2coding; vertical-align: top;}

</style>

</head>
<body>

  <!-- 전체 -->
	<div class="wrap">

		<!-- 헤더블럭 -->
		<%@ include file="../common/header.jsp" %>

	<!-- 컨텐츠블럭 -->
		<div class="container" align="center">
<%
// 컴퓨터 시스템의 년, 월 받아오기
   Date date = new Date();
   int year = date.getYear() +1900;
   int month = date.getMonth() +1;

   //   오류사항 걸러주기   
   try{
      year = Integer.parseInt(request.getParameter("year"));
      month = Integer.parseInt(request.getParameter("month"));
      
      if(month>=13){
         year++;
         month =1;
      }else if(month <=0){
         year--;
         month =12;
      }
   }catch(Exception e){
      
   }

%>
<div style="display: inline-flex;">
<div align="center">
<!-- 달력 만들기 -->
<table width ="700" align ="center" border ="1" cellpadding="5" cellspacing="0">
   <tr id="tr1">

<!-- 제목 만들기 -->
      <th>
      <select name="sel" onchang="return false">
      	<option id="aabb" selected="selected">공모</option>
      	<option value="etc" style='pointer-events: none;'>대외(준비중)</option>
      </select>
      </th>
      <th id = "title" colspan = "6">      
      <%=year%>년 <br /> 
      <!-- 이전달로 이동 -->
      <a onclick="location.href='?year=<%=year%>&month=<%=month-1%>'" style="cursor:pointer">&lt;</a>
      
      &nbsp; <%=month%>월 &nbsp;
      
      <!-- 다음달로 이동 -->
      <a onclick="location.href='?year=<%=year%>&month=<%=month+1%>'" style="cursor:pointer">&gt;</a>
      </th>
      

   </tr>
<!-- 요일 표시칸 만들어주기(단, 토,일요일은 색을 다르게 하기위해 구분해주기) -->
   <tr id="tr1">
      <td class = "sunday">일</td>
      <td class = "etcday">월</td>
      <td class = "etcday">화</td>
      <td class = "etcday">수</td>
      <td class = "etcday">목</td>
      <td class = "etcday">금</td>
      <td class = "saturday">토</td>
   </tr>
   
<!-- 날짜 집어 넣기 -->
   <tr id="tr1">
   <%
//   1일의 요일을 계산한다(자주 쓰이기 때문에 변수로 선언해두기)
      int first = CalendarDAO.weekDay(year, month, 1);
   
//   1일이 출력될 위치 전에 전달의 마지막 날짜들을 넣어주기위해 전 달날짜의 시작일을 계산한다.
      int start = 0 ;
      start = month ==1? CalendarDAO.lastDay(year-1, 12)- first : CalendarDAO.lastDay(year, month-1)- first;

//   1일이 출력될 위치를 맞추기 위해 1일의 요일만큼 반복하여 전달의날짜를 출력한다.
      for(int i= 1; i<= first; i++){
         if(i==1){
/* 일요일(빨간색)과 다른날들의 색을 구별주기  */
            out.println("<td class = 'redbefore'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
         }else{
            out.println("<td class = 'before'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
            
         }
      }   

	// 월의 시작 날짜
	String s_day = year+"-";
	// 월의 마지막 날짜
	String e_day = year+"-";
	
	if((int)(Math.log10(month)+1) == 1){
		s_day += "0"+month+"-00";
		e_day += "0"+month+"-31";
	}else{
		s_day += month+"-00";
		e_day += month+"-31";
	}
	
	GongmoDAO dao = new GongmoDAO();
	GongmoWriteDTO gmdto = null;
	List articleList = dao.getArticles(s_day, e_day);
/* 1일부터 달력을 출력한 달의 마지막 날짜까지 반복하며 날짜를 출력 */
      for(int i = 1; i <= CalendarDAO.lastDay(year, month); i++){
         /* 요일별로 색깔 다르게 해주기위해 td에 class 태그걸어주기 */
         switch(CalendarDAO.weekDay(year, month, i)){
            case 0 : %>
            <td class='sun'>
               <div class="print<%=i%>">
                  <%=i %>
               </div>
            </td>
               
            <%   break;
            case 6 : %>
            <td class='sat'>
	            <div class="print<%=i%>">
	               <%=i %>
	            </div>
            </td>
         
            <%break;
            default : %>
            <td class='etc'>
	            <div class="print<%=i%>">
	               <%=i %>
	            </div>
            </td>
         
            <%break;
         }
/* 출력한 날짜(i)가 토요일이고 그달의 마지막 날짜이면 줄을 바꿔주기 */
         if(CalendarDAO.weekDay(year, month, i) == 6 && i != CalendarDAO.lastDay(year, month)){
            out.println("</tr><tr id='tr1'>");         
         }
      }
      if(CalendarDAO.weekDay(year, month, CalendarDAO.lastDay(year, month)) !=6){
         for(int i = CalendarDAO.weekDay(year, month, CalendarDAO.lastDay(year, month))+1; i < 7; i++){
            out.println("<td></td>");   
         }
      }
   %>
   </tr>
</table>

</div>
<div id="gongmoDiv" style="margin-left: 100px; margin-top: 100px; width: 200px">
	
</div>
</div>
<script>
<%
	if(articleList != null){
		for(int i=0; i<articleList.size(); i++){
			gmdto = (GongmoWriteDTO)articleList.get(i);
			int num = gmdto.getGmboard_num();
			String gongmo_s_day = gmdto.getGmboard_sday();
			String title = gmdto.getGmboard_title();
			String day = "";
			if('0' == (gongmo_s_day.charAt(8))){
				day = gongmo_s_day.substring(9);
			}else{
				day = gongmo_s_day.substring(8);
			}
			System.out.println(day);
			%>
			var html = "";
			html += "<p class='gongmo' data-gmboardnum='<%=num%>' style='cursor: pointer'><%=title%></p>";
			html += "<input type='hidden' name='num' value='<%=num%>'/>";
			$(".print<%=day%>").append(html);
<%
		}
	}%> 
</script>
<script>
	$(document).ready(function(){
		$("#gongmoDiv").hide();
		
	})
	$(".gongmo").click(function() {
		console.log(this);
		var gmboardnum = $(this).data('gmboardnum');
		console.log(gmboardnum);
		// ajax 로 공모 번호주고 데이터 가져와서 뿌려주기 
		$.ajax({
			url : "gongmoCalDetailAjax.jsp",
			type : "POST",
			data : "gmboardnum=" + gmboardnum,
			dataType: "json",
			success : function(data){
				var url = "../gongmo/gongmoContent.jsp?gmboard_num="+data.num;
				var gmDetail = "<table  border ='1' rules='none'>"+
									"<tr>"+
										"<td align='rigth'><img src='../common/imgs/cancel.png' height='12' style='cursor: pointer' onclick='cancel()'/></td>"+
									"</tr>"+
									"<tr>"+
										"<td><img src='../gongmoFile/"+data.poster+"' width='200' height='250'/></td>"+
									"</tr>"+
									"<tr>"+
										"<td style='text-align:center;'>제목 : "+data.title+"</td>"+
									"</tr>"+
									"<tr>"+
										"<td style='text-align:center;'><button onclick='goaway("+data.num+")'>자세히보기</button></td>"+
									"</tr>"+
								"</table>";
				$("#gongmoDiv").empty();
				// gongmoDiv 에 gmDetail 추가하기...
				$("#gongmoDiv").append(gmDetail);
				$("#gongmoDiv").show();	
			},
			error : function(e){
				console.log(e);
			}
		});
	});

	function cancel(){
		$("#gongmoDiv").hide();
	};
	function goaway(data){
		window.location = "../gongmo/gongmoContent.jsp?gmboard_num="+data;
	};
</script>
  </div>
		<!-- 풋터블럭 -->
			<%@ include file="../common/footer.jsp"%>
		</div>

</body>
</html>