<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 외부CSS링크 네이밍 변경 필요 -->
<link href="../common/style.css" type="text/css" rel="stylesheet">
<%
String sender1 = (String)session.getAttribute("nid");
if(sender1==null){
	sender1 = (String)session.getAttribute("cid");
}
%>
<body>
	<!-- 풋터블럭 -->
	<div class="footer tb-color-1 bb-color-1">
		<div class="content">
			<div class="info">
				<span class="developers">
					Developers
				</span><br/>
				<span class="member">
					김유찬
				</span>
				<span class="member">
					김하늘
				</span>
				<span class="member">
					박줄기
				</span>
				<span class="member">
					서형석
				</span>
				<span class="member">
					이승재
				</span>
				<span class="member">
					정다연
				</span><br/>
			</div>

			<div class="info">
				<span class="addr">
					서울특별시 관악구 남부순환로 1820, 에그옐로우 14층
				</span><br/>
				<span class="copyright">
					Copyright 공모던전. All Rights Reserved
				</span>
			</div>
			<div>
			<a href="../msg/sendmsgForm.jsp?send=<%=sender1%>&receive=admin"
										onclick="window.open(this.href, '메시지 보내기', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;"
										>관리자에게 문의</a>
			</div>
		</div>
	</div>
</body>
</html>