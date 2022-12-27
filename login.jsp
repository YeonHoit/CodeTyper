<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String login_id=request.getParameter("id");
	String login_pw=request.getParameter("password");
	String url="jdbc:mysql://localhost:3306/keyboard_practice";
	String id="root";
	String pw="tjguswls100";
	String sql="select * from member where id='"+login_id+"'and password='"+login_pw+"'";
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection(url,id,pw);
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(sql);
		if(rs.next()) //조회 결과가 있으면 넘겨준다
		{
			session.setAttribute("login_id",login_id);
			response.sendRedirect("main.jsp");
		}
		%>
		<script>
			alert("등록되지 않은 계정입니다! 아이디와 비밀번호를 확인해주세요.");
			location.href="index.html";
		</script>
		<%
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>