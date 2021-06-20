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
	//대댓글 적는 방식 네이버 블로그처럼 수정 예정, 댓글 수정 기능 추가 예정

	let data; //삭제를 돕기 위해 데이터 저장
	let re_id;
	
	//댓글 test용이기 때문에 table에 게시판id, userId가 없음.
	function rep(){ //댓글 저장
		let form={}; let arr=$("#frm").serializeArray();
		for(i=0; i<arr.length; i++){
			form[arr[i].name] = arr[i].value
		}
		$.ajax({
			url: "addReply", type: "POST", //com.reply.root.controller.ReplyController.java에 있는 addReply
			data: JSON.stringify(form),
			contentType: "application/json; charset=utf-8",
			success: function(list){
				alert("성공적으로 댓글이 달렸습니다");
				$('textarea').val(''); //textarea 비우기
				replyData(); //화면에 보여주는 function
			}, error: function(){
				alert("문제 발생!!!");
			}
		})
	}
	
	function rerep(){ //대댓글 저장
		let form={}; let arr=$("#re").serializeArray();
		for(i=0; i<arr.length; i++){
			form[arr[i].name] = arr[i].value
		}
		//console.log(form);
		$.ajax({
			url: "addReply2", type: "POST", //com.reply.root.controller.ReplyController.java에 있는 addReply2
			data: JSON.stringify(form),
			contentType: "application/json; charset=utf-8",
			success: function(list){
				alert("성공적으로 대댓글이 달렸습니다");
				$('textarea').val('');
				slide_hide(); //modal로 해놓은 거 숨기기
				replyData();
			}, error: function(){
				alert("문제 발생!!!");
			}
		})
	}
	
	function remove(i){ //댓글 삭제(댓글 삭제 시 딸려있는 대댓글도 삭제되게 service쪽을 해놓음)
		$.ajax({
			url: "removeReply", type: "POST", 
			data: JSON.stringify(data[i]),
			contentType: "application/json; charset=utf-8",
			success: function(){
				alert("댓글이 삭제되었습니다.");
				replyData();
			}, error: function(){
				alert("문제 발생!!!");
			}
		})
	}
	
	function replyData(){ //댓글 보여주는 부분
		$.ajax({
			url : "replyData", type : "GET",
			dataType : "json",
			success : function(rep){
				let html = '';
				data = rep;
				console.log('reply list : ');
				console.log(data);
				if(rep.length==0){
					html += "<h3>댓글이 없습니다.</h3>"
				} else{
					html += `<tr> //멋져!
								<td>내용</td> <td>작성일자</td> <td></td>
							</tr>`
					for(i=0;i<rep.length;i++){
						let date = new Date(rep[i].date)
						let writeDate = date.getFullYear()+"/"+(date.getMonth()+1)+"/"
						writeDate += date.getDate()+"_"+date.getHours()+":"
						writeDate += date.getMinutes()+":"+date.getSeconds()
					
						if(rep[i].layer==0){ //부모 댓글은 [댓글]버튼 추가
							html +=	"<tr>"
							html += "<td>"+rep[i].content+"</td>"
							html +=	"<td>"+writeDate+"</td>"
							html += "<td>"
							html +=	"<input type='button' id='"+i+"' value='삭제' onclick='remove(this.id)'>"
							html +=	"<input type='button' id='"+rep[i].id+"' value='댓글' onclick='slideClick(this.id)'>"
							html +=	"</td>"
							html += "</tr>"
						}
						if(rep[i].layer==1){
							html +=	"<tr>"
							html += "<td>└>"+rep[i].content+"</td>"
							html +=	"<td>"+writeDate+"</td>"
							html += "<td>"
							html +=	"<input type='button' id='"+i+"' value='삭제' onclick='remove(this.id)'>"
							html +=	"</td>"
							html += "</tr>"
						}
					}
				}
				$("#show").html(html)
			}, error : function(){
				alert('데이터를 가져올 수 없습니다')
			}
		})
	}

	function slideClick(num){
		$("#first").slideDown("slow");
		$("#modal_wrap").show();
		//console.log(num);
		re_id = num.trim() * 1; //빈칸 제거 후 숫자 형변환(만약을 대비)
		//console.log(re_id);
		document.reform.group_id.value = re_id;
	}
	
	function slide_hide(){
		$("#first").slideUp("fast");
		$("#modal_wrap").hide();
	}
	
	window.onload = function (){ //브라우저 시작과 동시에 댓글 보여주기
		replyData();
	}
</script>

<style type="text/css">
	#modal_wrap{
		display: none; position: fixed; z-index: 9;
		margin: 0 auto; top: 0; left: 0; right: 0;
		width: 100%; height: 100%;
		background-color: rgba(0,0,0,0.6);
	}
	#first{
		display: none; position: fixed; z-index: 10; margin: 0 auto;
		top: 30px; left: 0; right: 0; height: 450px; width: 300px;
		background-color: rgba(212,224,250,0.9);
	}
</style>
</head>
<body>
	<div style="margin: 0 auto; width: 250px; padding-top: 20px;">
		<form id="frm">
			<textarea rows="5" cols="30" id="content" name="content"></textarea>
			<button type="button" onclick="rep()">댓글 달기</button>
		</form>
	</div>

	
	<div id="modal_wrap">
		<div id="first">
			<div style="width: 250px; margin: 0 auto; padding-top: 20px;">
				<form id="re" name="reform">
					<input type="hidden" name="group_id" value="">
					<textarea rows="5" cols="30" id="content" name="content"></textarea>
					<button type="button" onclick="rerep()">대댓글 달기</button>
					<button type="button" onclick="slide_hide()">취소</button>
				</form>
			</div>
		</div>
	</div>
	
	<table border="1" id="show" style="margin: auto;"></table>
</body>
</html>