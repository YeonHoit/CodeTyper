<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    String language=request.getParameter("language");
%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Code Typer</title>
</head>
<style type="text/css">
    .titlefont {
        font-size: 20px;
        font-family: 'consolas';
        font-weight: bold;
        color: #ff285d;
        text-shadow: 1px 1px #500018;
        border-radius: 5px 5px 5px 5px;
        margin: 1rem 0 0.5rem 1rem;
    }

    .codearea {
        background-color: white;
        border: 0.5px solid rgb(167, 167, 167);
        border-radius: 10px 10px 10px 10px;
        padding: 1rem 1rem 1rem 1rem;
        width: 30rem;
        height: 1rem;
        font-family: 'consolas';
        vertical-align: middle;
        font-size: 17.5px;
    }

    .codearea:focus {
        border-color: dodgerblue;
        box-shadow: 0 0 8px 0 dodgerblue;
    }

    #testfont {
        font-size: 40px;
        font-family: 'consolas';
        font-weight: bold;
        color: rgb(247, 189, 81);
        text-shadow: 1.5px 1.5px #D55757;
        border-radius: 5px 5px 5px 5px;
        margin: 0.5rem 0 0.5rem 0;
    }

    #realtimefont {
        font-size: 25px;
        font-family: 'consolas';
        font-weight: bold;
        color: rgb(255, 126, 148);
        text-shadow: 1px 1px rgb(0, 0, 0);
        background-color: rgb(187, 239, 255);
        border-radius: 5px;
        width: fit-content;
        margin: 2.5rem 0 0 1rem;
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

    #stopfont {
        text-decoration: none;
        border: none;
        background-color: unset;
        font-size: 25px;
        font-weight: bold;
        font-family: 'Consolas';
        color: rgb(50, 50, 50);
        text-shadow: 1.5px 1.5px rgb(187, 187, 187);
        cursor: pointer;
    }

    #stopfont:hover {
        color: rgb(0, 255, 200);
    }
</style>
<script src="./js/jquery-3.3.1.min.js"></script>
<script src="./js/typing_cal.js"></script>
<script type="text/javascript">
    var language;
    Start();    //초기화
    function Start()
    {
        $(function()
        {
            language='<%=language %>';
            var database=language;
            $("#language").text(database);
            if(database=='C++')
            {
                database='c_plus';
            }
            $.ajax(
            {
                url: './DB_Connection.jsp',
                type: 'post',
                data: {"database":database},
                datatype: 'text',
                success: whenSuccess,
                error: whenError
            });
        });
    }
    function whenSuccess(data)
    {
        data=data.replace(/\n/g, "");
        //data=String(data);
        console.log(data);
        $(function(){
            $("#practice_string").text(data);
            //$("#input_string").css("width",$("#practice_string").text().length*8+"px");
        });
    }
    function whenError(request,status,error)
    {
        console.log("error");
        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    }
    function insert(wpm,accuracy)
    {
        console.log(language);
        console.log(wpm);
        console.log(accuracy);
        $(function()
        {
            $.ajax(
            {
                url:'./DB_Insert.jsp',
                type:'post',
                data:{language:language,wpm:wpm,accuracy:accuracy},
                datatype:'text',
                error: whenError,
            });
        });
    }
</script>

<body>
    <div align="center" style="padding:1rem 0 1rem 0;">
        <img src="./img/Code_Typer.png" width="222px" height="171.75px" />
    </div>
    <div align="center"
        style="background-color:rgb(247, 255, 247); border-top:0.5px solid rgb(100, 100, 100); border-bottom:0.5px solid rgb(100, 100, 100); padding:0 0 10px 0;">
        <p id="testfont">TEST</p>
        <table style="width:60rem">
            <tr>
                <td style="width: 30rem">
                    <p class="titlefont">ANSWER CODE</p>
                    <!-- DB에서 가져오는 코드 -->
                    <div class="codearea" id="practice_string">
                        Hello World!
                    </div>
                    <p class="titlefont">YOUR CODE</p>
                    <p>
                        <!-- 사용자가 입력하는 필드 -->
                        <input class="codearea" type="text" placeholder="Enter The Code" id="input_string" onkeydown="f1()" />
                    </p>
                    <div align="right"><img src="./img/Enter_Key.png" height="49.875px" width="128.625px"></div>
                </td>
                <td style="width: 5rem">
                </td>
                <td style="width: 25rem">
                    <div
                        style="height:15rem; background-color:white; border: 0.5px solid rgb(167, 167, 167); vertical-align: middle">
                        <p id="realtimefont">REAL-TIME</p>
                        <p style="margin: 20px 0 20px 40px;">
                            <font class="infofont">&nbsp;LANGUAGE&nbsp;</font>
                            <!-- 현재 언어 가져오기 -->
                            <font class="defaultfont" id="language">C</font>
                        </p>
                        <p style="margin: 20px 0 20px 40px;">
                            <font class="infofont">&nbsp;WPM&nbsp;</font>
                            <!-- 현재 타수 가져오기 -->
                            <font class="defaultfont" id="wpm">0</font>
                        </p>
                        <p style="margin: 20px 0 20px 40px;">
                            <font class="infofont">&nbsp;ACCURACY&nbsp;</font>
                            <!-- 현재 정확도 가져오기 -->
                            <font class="defaultfont" id="accuracy">0%</font>
                        </p>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div align="center" style="margin-top: 3rem;">
        <div align="center"
            style="background-color:rgb(255, 238, 238); border-top:0.5px solid rgb(100, 100, 100); border-bottom:0.5px solid rgb(100, 100, 100); padding:1rem 0 1rem 0; width: 30rem">
            <!-- 메인 화면으로 -->
            <a id="stopfont" href="main.jsp">STOP</a>
        </div>
    </div>

</body>

</html>