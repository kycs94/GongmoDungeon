<%@page import="team04.project.community.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CommunityDAO dao = new CommunityDAO();
	String msg = request.getParameter("msg");
	int num = Integer.parseInt(request.getParameter("num"));
	
	dao.commModify(msg, num);
	out.print(1);
%>
