<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String database=request.getParameter("database");
	String url="jdbc:mysql://localhost:3306/keyboard_practice";
	String id="root";
	String pw="tjguswls100";
	String sql1="select count(*) from "+database;
	String sql2="select * from "+database;
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection(url,id,pw);
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(sql1);
		rs.next();
		int size=rs.getInt(1);
		Random r=new Random();
		int ran=r.nextInt(size);
		rs=stmt.executeQuery(sql2);
		rs.next();
		for(int i=0;i<ran;i++)	//랜덤한 코드 하나를 뽑는 for
		{
			rs.next();
		}
		out.write(rs.getString("code"));
		//out.write("{\"code\":"+rs.getString("code")+"}");
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>