<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/read.css">
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	var url_href = window.location.href;

	var url = new URL(url_href);
	var bno = url.searchParams.get("bno");
	
	function replyCallIn(){
		$("#replies").empty();
		$("#paginationReply").empty();
		
		
	  	let nowPageNum = $("#replyPageNum").val();
		
		$.ajax({
	        type:"POST",
	        url:"reply",
	        data: {
	        	"bno" : bno,
	        	"nowPageNum" : nowPageNum
	        },
	        success:function(data){
	        	console.log(data);
	        	let replyList = data.reply;
	        	
	        	for (var i = 0; i < replyList.length; i++) {
	        		console.log(replyList[i]);
	        		let replyRow = "";
	        		replyRow += "<tr id='reply'>";
	        		replyRow += "<td id='replyUsernick'>" + replyList[i].usernick + "</td>";
	        		replyRow += "<td id='replyContent'>" + replyList[i].replycontent + "</td>";
	        		const replyregdate = new Date(replyList[i].replyregdate);
	        		const nowTime = new Date();
	        		let showingTime = "";
	        		
	        		if (replyregdate.getDate() < nowTime.getDate()) {
	        			showingTime = replyregdate.getFullYear() + "-" + (replyregdate.getMonth()+1) + "-" + replyregdate.getDate();
					}
	        		else{
	        			if(replyregdate.getHours()==nowTime.getHours()){
	        				if (replyregdate.getMinutes()==nowTime.getMinutes()) {
	        					showingTime = "방금 전";
							} 
	        				else{
	        					showingTime = String(nowTime.getMinutes() - replyregdate.getMinutes()) + "분 전";
							}
	        			}
	        			else{
	        				showingTime = (nowTime.getHours() - replyregdate.getHours()) + "시간 전";
	        			}
	        		}
	        		
	        		replyRow += "<td id='replyRegdate'>" + showingTime + "</td>";
	        		replyRow += "</tr>";
	        		$("#replies").append(replyRow);
				}
	        	
	        	var pageDto = data.listMaker;
	        	
	        	var prevHtml ="";
	        	if (pageDto.prev) {
	        		prevHtml = "<li id='replyPrevBtn'><div class='pagingReplyBtn'><</div></li>"
	        		$("#paginationReply").append(prevHtml);
				}
	        	else {
	        		prevHtml = "<li id='replyNextBtn'><div class='pagingReplyBtn' style='color:gray; outline: 1px solid gray; cursor: default; pointer-events: none;'><</div></li>"
	        		$("#paginationReply").append(prevHtml);
				}
	        	var nowPageNum = 0;
	        	var nowPageNumHtml = "";
	        	
	        	startPage = pageDto.startPage;
	        	endPage = pageDto.endPage;
	        	$("#replyStartPageNum").val(pageDto.startPage);
	        	$("#replyEndPageNum").val(pageDto.endPage);
	        	
	        	for (var i = startPage; i <= endPage; i++) {
	        		nowPageNum = i
	        		nowPageNumHtml = "<li id='paginationReplyBtn'><div class='pagingReplyBtn' id='pagingReplyBtn" + nowPageNum + "'>" + nowPageNum + "</div></li>"
	        		$("#paginationReply").append(nowPageNumHtml);
				}
	        	
	        	var nextHtml ="";
	        	if (pageDto.next) {
	        		nextHtml = "<li id='replyNextBtn'><div class='pagingReplyBtn'>></div></li>"
	        		$("#paginationReply").append(nextHtml);
				}
	        	else {
					nextHtml = "<li id='replyNextBtn'><div class='pagingReplyBtn' style='color:gray; outline: 1px solid gray; cursor: default; pointer-events: none;'>></div></li>"
	        		$("#paginationReply").append(nextHtml);
				}
	        	
					$("#pagingReply").css("top",((replyList.length+1)*30)-50+"px");
					
					$(document).off().on("click", ".pagingReplyBtn", function(){
// 						alert("ok");
						let prevPageNum = nowPageNum;
						if ($(this).text() == "<") {
				  			nowPageNum = startPage - 1;
						}
				  		else if ($(this).text() == ">") {
				  			nowPageNum = endPage + 1;
						}
				  		else{
				  			nowPageNum = parseInt($(this).text());
				  		}
				  		
				  		$("#replyPageNum").val(nowPageNum);
// 				  		if(prevPageNum == nowPageNum){
// 				  			return;
// 				  		}
// 				  		else{
					  		$(replyCallIn()).one();
// 				  		}
				  	});
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	           if(textStatus=="timeout") {
	            alert("시간이 초과되어 데이터를 수신하지 못하였습니다.");
	           } else {
	            alert("데이터 전송에 실패했습니다. 다시 시도해 주세요");
	           } 
	        }
	    });
	}
	
	function pagingBtnClick(){
		alert("startPage : " + startPage + ", endPage : " + endPage);
	}
	
	$(document).ready(function(e){
		
		/* 좌측 플로팅 네비 */
	  	var currentPosition = parseInt($("#category").css("top"));
	  	$(window).scroll(function() {
	    	var position = $(window).scrollTop(); 
	    	if (position+currentPosition > 440) { 
				return false;
			} else {
		    	$("#category").stop().animate({"top":position+currentPosition+"px"},700);
			}
	  	});
	  	
	  	$(".detailMenuBtn").on("click", function(e){
	  		var actionForm = $("#actionForm");
	  		var categorymenu = $(this).attr('data-value')
// 	  		alert(categorymenu);
	  		e.preventDefault();
			actionForm.append("<input type='hidden' id='categorymenu' name='categorymenu' value=" + categorymenu + ">");
			actionForm.attr("action", "${ctx}/foring/board");
			actionForm.submit();
	  	});
	  	

		let startPage = $("#replyStartPageNum").val();
	  	let endPage = $("#replyEndPageNum").val();
	  	
	  	$(replyCallIn()).one();
	  	
	  	$("#replyRegText").keypress(function(e){
	  		if(e.keyCode == 13){
	  			var memInfo = $("#meminfo").val();
// 		  		alert(memInfo);
	  			
	  			var data = {
		  			replycontent : $(this).val(),
		  			boardid : parseInt(bno),
		  			usernick : memInfo,
		  			disclosure : "y"
	  			};
	  			
	  			$.ajax({
	  		        type:"POST",
	  		        url:"replyRegister",
	  		        data: data,
	  		        success:function(data){
	  		        	if(data==1){
	  		        		replyCallIn();
	  		        		$("#replyRegText").val("");
	  		        	}
	  		        },
	  		        error: function(jqXHR, textStatus, errorThrown) {
	  		           if(textStatus=="timeout") {
	  		            alert("시간이 초과되어 데이터를 수신하지 못하였습니다.");
	  		           } else {
	  		            alert("데이터 전송에 실패했습니다. 다시 시도해 주세요");
	  		           } 
	  		        }
	  		    });
	  			
	  		}
	  	})
	  	
	});
</script>
<section class="body">
	<div id="category">
		<ul id="categoryMenu">
			<li id="categoryBoard" class="categoryMenuMain"><strong>게시판</strong></li>
			<li class="categoryMenuDetail"><button class="detailMenuBtn" id="notice" data-value="notice"> 공지사항</button></li>
			<li class="categoryMenuDetail"><button class="detailMenuBtn" id="free" data-value="free"> 자유게시판</button></li>
			<li class="categoryMenuDetail"><button class="detailMenuBtn" id="infor" data-value="infor"> 정보게시판</button></li>
			<li class="categoryMenuDetail"><button class="detailMenuBtn" id="study" data-value="study"> 스터디모임게시판</button></li>
			<li id="categoryResume" class="categoryMenuMain"><strong>이력서</strong></li>
			<li class="categoryMenuDetail"><a href="resume"> 이력서</a></li>
			<li class="categoryMenuDetail"><a href="selfIntro"> 자기소개서</a></li>
			<li id="categoryMypage" class="categoryMenuMain"><strong>Mypage</strong></li>
			<li class="categoryMenuDetail"><a href="chgMyImfor"> 개인정보수정</a></li>
			<li class="categoryMenuDetail"><a href="resumeWrite"> 이력서 작성</a></li>
			<li class="categoryMenuDetail"><a href="selfIntroWrite">- 자기소개서 작성</a></li>
		</ul>
		<form action="" id="actionForm" method="get">
			<input type="hidden" id="replyPageNum" value="1">
			<input type="hidden" id="replyStartPageNum" value="0">
			<input type="hidden" id="replyEndPageNum" value="0">
			<input type="hidden" id="meminfo" value="${memInfo.usernick}">
		</form>
	</div>
	<div id="readContainer">
		<div id="boardTitle">게시글 제목 : ${read.boardtitle}</div>
		<div id="boardCategory">카테고리 : ${read.categorymenu}</div>
		<div id="boardDate">작성일 : 2023-11-11</div>
		<div id="boardViewCnt">조회수 : ${read.viewCnt}</div>
		<div id="boardWriter">작성자 : ${read.usernick}</div>
		<div id="boardDisclosure">공개여부 : ${read.disclosure}</div>
		<div id="boardAttachment">첨부파일 : attach.jpg</div>
		<div id="boardContent">
			게시글 내용 <br/> 
			<div id="boardContentText">${read.boardcontent}</div>
		</div>
	</div>
	
	<div id="replyContainer">
		<table id="replies">
		</table>
		<div id="pagingReply">
			<ul id="paginationReply">
			</ul>
		</div>
		<form id="replyReg">
			<textarea id="replyRegText" placeholder="댓글은 입력하세요." ></textarea>
		</form>
	</div>
	
</section>
<%@ include file="../includes/footer.jsp" %>