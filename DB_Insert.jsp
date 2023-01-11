<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String login_id=(String)session.getAttribute("login_id");
	String language=request.getParameter("language");
	int wpm=Integer.parseInt(request.getParameter("wpm"));
	int accuracy=Integer.parseInt(request.getParameter("accuracy"));
	String url="jdbc:mysql://localhost:3306/keyboard_practice";
	String id="";
	String pw="";
	String sql="insert into record values('"+login_id+"','"+language+"',"+wpm+","+accuracy+")";
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection(url,id,pw);
		Statement stmt=conn.createStatement();
		stmt.executeUpdate(sql);
		out.write("");
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
