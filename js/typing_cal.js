
var sum = 0;
var startTime;
var endTime;
var check = 0;
var aa; 
var qw;
var cnt;
var t;
var acc;
var w;
var check2=false;

$(function() {
	$("#input_string").focus();
});

$(document).keydown(function(event) { // 엔터 눌리면 결과 나옴
  if (event.keyCode == '13' && check2==false) {
	  f2();
	  Start();
	  insert(w,acc);
  }
  return;
});

function f1(){
	if($("#input_string").val().length >= $("#practice_string").text().length - 3){ check2=true; f2(); Start(); insert(w,acc); return; }// 길이 넘어가면 자동으로 종료
	if(check == 1) return; // 시작은 한번 해야하니까 밑에꺼 한번만 실행하게 해줌
	check = 1;
	check2=false;
	startTime = new Date().getTime(); //타자입력 시작
	console.log(startTime);
	
	return;
}

function f2(){// 타자 끝
	console.log("f2");
	aa = $("#input_string").val(); // 사용자가 입력한 텍스트
	qw = $("#practice_string").text(); // 서버에서 제공하는 텍스트
	console.log('aa:'+aa);
	//$("#practice_string").append("<br>",aa,"<br>");  // 사용자가 입력한거 출력
	//document.write(aa,"<br>");
	endTime = new Date().getTime();
	cnt = 0;
	for(var i = 0; i < qw.length-3; i++){ //사용자가 입력한거 맞춘 수
		if(aa[i] == qw[i+3])cnt++;  
	}
	acc=Math.floor(cnt / (qw.length-3)*100);
	$("#accuracy").text(acc+"%"); //정확도
	//document.write("Accuracy : ",cnt / qw.length*100,"%<br>");
	t = (endTime - startTime) / 1000;
	w=Math.floor(60 * (cnt / t));
	$("#wpm").text(w); // 타자속도
	//document.write("time : ",Math.floor(60 * (cnt / t)) + " speed");
	//console.log(endTime);
	//$("#input_string").remove();
	$("#input_string").val("");
	check=0;
	return;
}