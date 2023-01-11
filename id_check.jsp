<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String register_id=request.getParameter("id");
	if(register_id=="")
	{
		%>
		<script>
			alert("ID는 필수 항목입니다. 다시 입력해주세요.");
			location.href="register.html";
		</script>
		<%
	}
	String register_pw=request.getParameter("password");
	String name=request.getParameter("name");
	String gender=request.getParameter("gender");
	int age=Integer.parseInt(request.getParameter("age"));
	String email=request.getParameter("email");
	String url="jdbc:mysql://localhost:3306/keyboard_practice";
	String id="";
	String pw="";
	String sql="select * from member where id='"+register_id+"'";
	String sql2="insert into member values('"+register_id+"','"+register_pw+"','"+name+"','"+gender+"',"+age+",'"+email+"')";
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection(url,id,pw);
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(sql);
		if(!rs.next())
		{
			stmt.executeUpdate(sql2);
			%>
			<script>
				alert("회원가입에 성공하셨습니다!. 로그인 화면으로 돌아갑니다.");
				location.href="index.html";
			</script>
			<%
		}
		else
		{
			%>
			<script>
				alert("이미 사용중인 아이디입니다.");
				location.href="register.html";
			</script>
			<%
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
