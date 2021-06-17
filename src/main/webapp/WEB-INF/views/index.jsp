<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reply, re-reply test</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	let data;

	function rep(){
		let form={}; let arr=$("#frm").serializeArray();
		/* console.log(arr); */
		for(i=0; i<arr.length; i++){
			form[arr[i].name] = arr[i].value
		}
		/* console.log(form);
		console.log(JSON.stringify(form)); */
		$.ajax({
			url: "addReply", type: "POST",
			data: JSON.stringify(form),
			contentType: "application/json; charset=utf-8",
			success: function(list){
				alert("성공적으로 답글이 달렸습니다");
				replyData();
			}, error: function(){
				alert("문제 발생!!!");
			}
		})
	}

	function remove(i){
		//console.log(i);
		//console.log(data[i]);
		$.ajax({
			url: "removeReply", type: "POST", 
			data: JSON.stringify(data[i]),
			contentType: "application/json; charset=utf-8",
			success: function(){
				//console.log(data[i]);
				alert("성공적으로 삭제되었습니다.");
				replyData();
			}, error: function(){
				alert("문제 발생!!!");
			}
		})
	}
	
	//이자리에 re-reply함수 만들고 그건 service(기능)를 다른걸로 바꾸기
	
	//밑에 함수에 layer값에 따른 버튼 (onclick넣어서)만들어주기
	//그리고 select조건문 바꾸기 
	function replyData(){
		$.ajax({
			url : "replyData"/* +${personalData.} */, type : "GET",
			dataType : "json",
			success : function(rep){
				let html = `<tr> //멋져!
								<td>내용</td> <td>시간</td> <td></td>
							</tr>`
				data = rep;
				console.log('reply list : ');
				console.log(data);
				for(i=0;i<rep.length;i++){
					let date = new Date(rep[i].date)
					let writeDate = date.getFullYear()+"년"+(date.getMonth()+1)+"월"
					writeDate += date.getDate()+"일"+date.getHours()+"시"
					writeDate += date.getMinutes()+"분"+date.getSeconds()+"초"
				
					if(rep[i].layer==0){
						html +=	"<tr>"
						html += "<td>"+rep[i].content+"</td>"
						html +=	"<td>"+writeDate+"</td>"
						html += "<td>"
						html +=	"<input type='button' id='"+i+"' value='삭제' onclick='remove(this.id)'>"
						html +=	"<input type='button' id='rere' value='댓글'>"
						html +=	"</td>"
						html += "</tr>"
					}
					if(rep[i].layer==1){
						html +=	"<tr>"
						html += "<td>└>"+rep[i].content+"</td>"
						html +=	"<td>"+writeDate+"</td>"
						html += "<td>"
						html +=	"<input type='button' id='remove' value='삭제' onclick='remove(this.id)'>"
						html +=	"</td>"
						html += "</tr>"
					}
				}
				$("#show").html(html)
			}, error : function(){
				alert('데이터를 가져올 수 없습니다')
			}
		})
	}
	window.onload = function (){
		replyData();
	}
</script>
</head>
<body>
	<div style="margin: 0 auto; width: 250px; padding-top: 20px;">
		<form id="frm" >
			<textarea rows="5" cols="30" id="content" name="content"></textarea>
			<button type="button" onclick="rep()">댓글 달기</button>
		</form>
	</div>
	<table border="1" id="show" style="margin: auto;"></table>
</body>
</html>