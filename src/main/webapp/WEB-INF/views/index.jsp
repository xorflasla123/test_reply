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
	function rep(){
		let form={}; let arr=$("#frm").serializeArray();
		for(i=0; i<arr.length; i++){
			form[arr[i].name] = arr[i].value
		}
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
	function replyData(){
		$.ajax({
			url : "replyData"/* +${personalData.writeNo} */, type : "GET",
			dataType : "json",
			success : function(rep){
				let html = `<tr> //멋져!
								<td>내용</td> <td>시간</td>
							</tr>`
							
				rep.forEach(function(data){
					let date = new Date(data.date)
					let writeDate = date.getFullYear()+"년"+(date.getMonth()+1)+"월"
					writeDate += date.getDate()+"일"+date.getHours()+"시"
					writeDate += date.getMinutes()+"분"+date.getSeconds()+"초"
					
					//html += "<div align='left'>" /* "<b>아이디 : </b>"+data.id+"님 / " */
					//html += "<b>작성일</b> : "+writeDate+"<br>"
					//html += "<b>내용</b> : "+data.content+"<hr></div>"
					
					html +=	"<tr>"
					html += "<td>"+data.content+"</td>"
					html +=	"<td>"+writeDate+"</td>"
					html += "</tr>"
				})
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