<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/read.css">
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	
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
	  	
	  	$(function (){
	  		var url_href = window.location.href;

			var url = new URL(url_href);
			var bno = url.searchParams.get("bno");
			
			var startPage = 0;
		  	var endPage = 0;
		  	let nowPageNum = $("#nowPageNum").val();
			
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
		        			showingTime = replyregdate.getFullYear().slice(-2) + "-" + (replyregdate.getMonth()+1) + "-" + replyregdate.getDate();
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
		        		prevHtml = "<li id='prevBtn'><div class='pagingBtn'><</div></li>"
		        		$("#pagination").append(prevHtml);
					}
		        	else {
		        		prevHtml = "<li id='nextBtn'><div class='pagingBtn' style='color:gray; outline: 1px solid gray; cursor: default; pointer-events: none;'><</div></li>"
		        		$("#pagination").append(prevHtml);
					}
		        	var nowPageNum = 0;
		        	var nowPageNumHtml = "";
		        	
		        	startPage = pageDto.startPage;
		        	endPage = pageDto.endPage;
		        	
		        	for (var i = pageDto.startPage; i <= pageDto.endPage; i++) {
		        		nowPageNum = i
		        		nowPageNumHtml = "<li id='paginationBtn'><div class='pagingBtn' id='pagingBtn" + nowPageNum + "'>" + nowPageNum + "</div></li>"
		        		$("#pagination").append(nowPageNumHtml);
					}
		        	
		        	var nextHtml ="";
		        	if (pageDto.next) {
		        		nextHtml = "<li id='nextBtn'><div class='pagingBtn'>></div></li>"
		        		$("#pagination").append(nextHtml);
					}
		        	else {
						nextHtml = "<li id='nextBtn'><div class='pagingBtn' style='color:gray; outline: 1px solid gray; cursor: default; pointer-events: none;'>></div></li>"
		        		$("#pagination").append(nextHtml);
					}
		        	
	  				$("#paging").css("top",((replyList.length+1)*30)+120+"px");
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
	               if(textStatus=="timeout") {
	                alert("시간이 초과되어 데이터를 수신하지 못하였습니다.");
	               } else {
	                alert("데이터 전송에 실패했습니다. 다시 시도해 주세요");
	               } 
	            }
		    });
		}).one();
	  	
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
			<input type="hidden" id="nowPageNum" value="1">
			<input type="hidden" id="amount">
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
		<div id="paging">
			<ul id="pagination">
			</ul>
		</div>
	</div>
	
</section>
<%@ include file="../includes/footer.jsp" %>