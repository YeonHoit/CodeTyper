<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Code Typer</title>
    <script src="./js/jquery-3.3.1.min.js"></script>
    <%
        request.setCharacterEncoding("utf-8");
        String login_id=(String)session.getAttribute("login_id");
        String url="jdbc:mysql://localhost:3306/keyboard_practice";
        String id="";
        String pw="";
        String sql_c_record="select AVG(wpm), AVG(accuracy) from record where id='"+login_id+"' and use_language='C'";
        String sql_c_plus_record="select AVG(wpm), AVG(accuracy) from record where id='"+login_id+"' and use_language='C++'";
        String sql_python_record="select AVG(wpm), AVG(accuracy) from record where id='"+login_id+"' and use_language='Python'";
        String sql_java_record="select AVG(wpm), AVG(accuracy) from record where id='"+login_id+"' and use_language='Java'";
        String sql_member="select * from member where id='"+login_id+"'";
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection(url,id,pw);
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(sql_c_record);
            if(rs.next()) //사용 언어가 C인 평균값 넣기
            {
                %>
                <script>
                    var c_wpm=(<%=rs.getInt(1) %>);
                    var c_accuracy=(<%=rs.getInt(2) %>);
                </script>
                <%
            }
            else
            {
                %>
                <script>
                    var c_wpm=0;
                    var c_accuracy=0;
                </script>
                <%
            }
            rs=stmt.executeQuery(sql_c_plus_record);
            if(rs.next()) //사용 언어가 C++인 평균값 넣기
            {
                %>
                <script>
                    var cpp_wpm=<%=rs.getInt(1) %>;
                    var cpp_accuracy=<%=rs.getInt(2) %>;
                </script>
                <%
            }
            else
            {
                %>
                <script>
                    var cpp_wpm=0;
                    var cpp_accuracy=0;
                </script>
                <%
            }
            rs=stmt.executeQuery(sql_python_record);
            if(rs.next()) //사용 언어가 python인 평균값 넣기
            {
                %>
                <script>
                    var python_wpm=<%=rs.getInt(1) %>;
                    var python_accuracy=<%=rs.getInt(2) %>;
                </script>
                <%
            }
            else
            {
                %>
                <script>
                    var python_wpm=0;
                    var python_accuracy=0;
                </script>
                <%
            }
            rs=stmt.executeQuery(sql_java_record);
            if(rs.next()) //사용 언어가 java인 평균값 넣기
            {
                %>
                <script>
                    var java_wpm=<%=rs.getInt(1) %>;
                    var java_accuracy=<%=rs.getInt(2) %>;
                </script>
                <%
            }
            else
            {
                %>
                <script>
                    var java_wpm=0;
                    var java_accuracy=0;
                </script>
                <%
            }
            rs=stmt.executeQuery(sql_member);
            rs.next();
            %>
            <script>
                $(function(){
                    $("#name").text('<%=rs.getString("name")%>');
                    $("#id").text('<%=login_id%>');
                    $("#gender").text('<%=rs.getString("gender")%>');
                    $("#age").text('<%=rs.getInt("age")%>');
                    $("#email").text('<%=rs.getString("email")%>');
                });
            </script>
            <%
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    %>
    <script type="text/javascript">
        /* 각 언어 타수와 정확도 (DB에서 불러올 것!) */
        $(function () {
            /* 초기화 */
            selectradio();
        })
        // radio 선택했을 때
        function selectradio() {
            var lan = $("input[name='language']:checked").val();
            if (lan == "c") {
                /* 폰트 색상 변경 */
                for (var i = 0; i < 4; i++) {
                    if (i == 0) {
                        $(".radiofont").eq(i).css("color", "red");
                    }
                    else {
                        $(".radiofont").eq(i).css("color", "rgb(70, 70, 70)");
                    }
                }
                /* 언어별 텍스트 설정 */
                $("#wpm").text(c_wpm);
                $("#accuracy").text(c_accuracy+"%");
            }
            else if (lan == "cpp") {
                /* 폰트 색상 변경 */
                for (var i = 0; i < 4; i++) {
                    if (i == 1) {
                        $(".radiofont").eq(i).css("color", "red");
                    }
                    else {
                        $(".radiofont").eq(i).css("color", "rgb(70, 70, 70)");
                    }
                }
                /* 언어별 텍스트 설정 */
                $("#wpm").text(cpp_wpm);
                $("#accuracy").text(cpp_accuracy+"%");
            }
            else if (lan == "python") {
                /* 폰트 색상 변경 */
                for (var i = 0; i < 4; i++) {
                    if (i == 2) {
                        $(".radiofont").eq(i).css("color", "red");
                    }
                    else {
                        $(".radiofont").eq(i).css("color", "rgb(70, 70, 70)");
                    }
                }
                /* 언어별 텍스트 설정 */
                $("#wpm").text(python_wpm);
                $("#accuracy").text(python_accuracy+"%");
            }
            else if (lan == "java") {
                /* 폰트 색상 변경 */
                for (var i = 0; i < 4; i++) {
                    if (i == 3) {
                        $(".radiofont").eq(i).css("color", "red");
                    }
                    else {
                        $(".radiofont").eq(i).css("color", "rgb(70, 70, 70)");
                    }
                }
                /* 언어별 텍스트 설정 */
                $("#wpm").text(java_wpm);
                $("#accuracy").text(java_accuracy+"%");
            }
        }
    </script>
</head>
<style>
    .titlefont {
        font-size: 25px;
        font-family: 'consolas';
        font-weight: bold;
        color: rgb(255, 126, 148);
        text-shadow: 1px 1px rgb(0, 0, 0);
        background-color: rgb(187, 239, 255);
        border-radius: 5px 5px 5px 5px;
        width: fit-content;
        margin: 1rem 0 1rem 0;
    }

    .infofont {
        border: 1.5px solid rgb(0, 92, 92);
        color: rgb(0, 92, 92);
        border-radius: 5px;
        font-size: 20px;
        font-family: "consolas";
    }

    .defaultfont {
        color: rgb(65, 65, 65);
        font-size: 17.5px;
        font-family: "consolas";
    }

    .radiofont {
        font-family: 'consolas';
        font-size: 15px;
        text-decoration-line: underline;
        color: rgb(70, 70, 70);
    }

    #wpm,
    #accuracy {
        color: rgb(65, 65, 65);
        font-size: 17.5px;
        font-family: "consolas";
    }

    #testfont {
        font-size: 25px;
        font-family: 'consolas';
        font-weight: bold;
        color: rgb(247, 189, 81);
        text-shadow: 1px 1px #D55757;
        border-radius: 5px 5px 5px 5px;
        width: fit-content;
        margin: 0.5rem 0 0.5rem 0;
    }

    #testbutton {
        border: none;
        background-color: unset;
        font-size: 20px;
        font-weight: bold;
        font-family: 'Consolas';
        color: rgb(50, 50, 50);
        text-shadow: 1.5px 1.5px rgb(187, 187, 187);
        padding-bottom: 0.5rem;
        cursor: pointer;
    }

    #testbutton:hover {
        color: rgb(0, 255, 200);
    }

    #logoutbutton {
        text-decoration: none;
        font-size: 20px;
        font-family: 'consolas';
        background-color:black;
        color: white;
        border: 1px solid black;
        border-radius: 10px;
        cursor: pointer;
    }

    #logoutbutton:hover {
        background-color:unset;
        color: black;
        font-weight: bold;
        border: 2px solid black;
    }
</style>

<body>
    <div align="center" style="padding:2rem 0 2rem 0;">
        <img src="./img/Code_Typer.png" width="222px" height="171.75px" />
    </div>
    <div align="center"
        style="background-color:rgb(247, 255, 247); border-top:0.5px solid rgb(100, 100, 100); border-bottom:0.5px solid rgb(100, 100, 100); padding:10px 0 10px 0;">
        <a id="logoutbutton" href="logout.jsp">&nbsp;LOGOUT&nbsp;</a>
        <table style="width:50rem;">
            <tr>
                <td style="background-color: white; border:0.5px solid rgb(167, 167, 167); padding-left:1rem;">
                    <p class="titlefont">PROFILE</p>
                    <!-- 이름과 아이디 (DB에서 불러올 것!) -->
                    <p style="margin: 0 0 0 30px;">
                        <font style="font-size:25px; color:rgb(65, 65, 65); font-family:'consolas'; font-weight:bold;" id="name">
                            김기승 </font>
                        <font style="font-size: 15px; font-family: 'consolas'; color: rgb(146, 146, 146);" id="id">
                            giseung30</font>
                    </p>
                    <!-- 성별 (DB에서 불러올 것!) -->
                    <p style="margin: 10px 0 10px 40px;">
                        <font class="infofont">&nbsp;Gender&nbsp;</font>
                        <font class="defaultfont" id="gender">Man</font>
                    </p>
                    <!-- 나이 (DB에서 불러올 것!) -->
                    <p style="margin: 10px 0 10px 40px;">
                        <font class="infofont">&nbsp;Age&nbsp;</font>
                        <font class="defaultfont" id="age">22</font>
                    </p>
                    <!-- 이메일 (DB에서 불러올 것!) -->
                    <p style="margin: 10px 0 10px 40px;">
                        <font class="infofont">&nbsp;Email&nbsp;</font>
                        <font class="defaultfont" id="email">giseung30@naver.com</font>
                    </p>
                </td>
                <td>&nbsp;</td>
                <td style="padding-left:1rem; background-color: white; border:0.5px solid rgb(167, 167, 167);">
                    <p> <font class="titlefont">RECORD</font> <font style="font-size: 15px; font-family: 'consolas'; color: rgb(146, 146, 146);">AVERAGE</font> </p>
                    <!-- 언어에 따른 전적 공간 -->
                    <p class="radiofont" style="margin:0 0 0 0"><input type="radio" name="language" value="c"
                            checked="checked" onchange="javascript:selectradio()"> C</p>
                    <p class="radiofont" style="margin:0 0 0 0"><input type="radio" name="language" value="cpp"
                            onchange="javascript:selectradio()"> C++
                    </p>
                    <p class="radiofont" style="margin:0 0 0 0"><input type="radio" name="language" value="python"
                            onchange="javascript:selectradio()">
                        Python</p>
                    <p class="radiofont" style="margin:0 0 0 0"><input type="radio" name="language" value="java"
                            onchange="javascript:selectradio()"> Java
                    </p>
                    <p>
                        <font class="infofont">&nbsp;WPM&nbsp;</font>
                        <font id="wpm">400</font>
                    </p>
                    <p>
                        <font class="infofont">&nbsp;Accuracy&nbsp;</font>
                        <font id="accuracy">99%</font>
                    </p>
                </td>
            </tr>
            <tr>
                <td style="font-size: 5px">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3" style="background-color: white; border:0.5px solid rgb(167, 167, 167);">
                    <div align="center" style="padding:10px 0 10px 0">
                        <p id="testfont">SELECT LANGUAGE</p>
                        <form method="post" action="test.jsp">
                            <!-- 선택 박스 -->
                            <select style="width:10rem; height:2rem; border-radius: 5px 5px 5px 5px" name="language">
                                <option value="C">C</option>
                                <option value="C++">C++</option>
                                <option value="Python">Python</option>
                                <option value="Java">Java</option>
                            </select>
                            &nbsp;
                            <!-- 확인 버튼 -->
                            <input id="testbutton" type="submit" name="test" value="TEST" />
                        </form>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>

</html>
