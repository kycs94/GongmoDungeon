<%@page import="team04.project.gongmo.GongmoWriteDTO"%>
<%@page import="team04.project.gongmo.GongmoDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println(request.getParameter("gmboardnum"));
	int num = Integer.parseInt(request.getParameter("gmboardnum"));
	//dao
	GongmoDAO dao = new GongmoDAO();
	GongmoWriteDTO gmdto = dao.getCalendar(num);
	JSONObject obj = new JSONObject();
	obj.put("sday", gmdto.getGmboard_sday());
	obj.put("title", gmdto.getGmboard_title());
	obj.put("eday", gmdto.getGmboard_eday());
	obj.put("poster", gmdto.getGmboard_poster());
	obj.put("num", gmdto.getGmboard_num());
	String result = obj.toJSONString();
	response.setContentType("application/json; charset=UTF-8");
%>
<%=result%>
<%-- 
<%=gmdto.getGmboard_sday()%>,<%=gmdto.getGmboard_title()%>,<%=gmdto.getGmboard_eday()%>,<%=gmdto.getGmboard_poster()%>,<%=gmdto.getGmboard_num()%>
--%>