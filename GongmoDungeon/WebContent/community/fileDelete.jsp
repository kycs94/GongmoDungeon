<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String file = request.getParameter("fileName");
		String path = request.getRealPath("gongmoFile");
		System.out.println("서버저장주소 : "+path);
		path += "//" + file;
		File f = new File(path);
		f.delete();
    %>
