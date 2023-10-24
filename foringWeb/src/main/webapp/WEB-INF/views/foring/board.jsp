<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(e){
	  	var currentPosition = parseInt($("#category").css("top"));
	  	$(window).scroll(function() {
	    	var position = $(window).scrollTop(); 
	    	if (position+currentPosition > 440) { 
				return false;
			} else {
		    	$("#category").stop().animate({"top":position+currentPosition+"px"},700);
			}
	  	});
	  		
	  	var startPage = 0;
	  	var endPage = 0;
	  	let nowPageNum = 1;
	  	let categorymenu = "notice";
	  	
	  	$(".detailMenuBtn").on("click",function(){
	  		
	  		if ($("#appendList")) {
	  			$("#boardList").html("<tr><th>글 번호</th><th>제목</th><th>작성자</th><th>조회수</th></tr>");
	  			$("#pagination").html("");
			}
	  		
	  		categorymenu = $(this).attr('data-value');
	  		$.ajax({
		        type:"POST",
		        url:"boardlist",
		        dataType: "text",
		        data:{
		        		"categorymenu" : categorymenu,
		        		"nowPageNum" : nowPageNum
		        	},
		        success:function(data){
		        	var responseData = JSON.parse(data)
		        	console.log(responseData["list"]);
		        	console.log(responseData["listMaker"]);
		        	
		        	var list = JSON.parse(responseData["list"]);
		        	var pageDto = JSON.parse(responseData["listMaker"]);
		        	for (var i = 0; i < list.length; i++) {
			        	var html = ""; 
			        	html += '<tr id="appendList">';
			        	html += '<td>'+list[i].boardid+'</td>';
			        	html += '<td><a class="move" href=' + list[i].boardid + '>'+list[i].boardtitle+'</td>';
			        	html += '<td>'+list[i].usernick+'</td>';
			        	html += '<td>'+list[i].viewcCnt+'</td>';
			        	html += '</tr>';
			        	$("#boardList").append(html);
					}
		        	
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
		        	
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
	               if(textStatus=="timeout") {
	                alert("시간이 초과되어 데이터를 수신하지 못하였습니다.");
	               } else {
	                alert("데이터 전송에 실패했습니다. 다시 시도해 주세요");
	               } 
	            }
		    });
	  	})
	  	$(document).on("click", ".pagingBtn", function pagingBtnClick(){

	 		if ($("#appendList")) {
	 			$("#boardList").html("<tr><th>글 번호</th><th>제목</th><th>작성자</th><th>조회수</th></tr>");
	 			$("#pagination").html("");
			}
	 		
	  		if ($(this).text() == "<") {
	  			nowPageNum = startPage - 1;
			}
	  		else if ($(this).text() == ">") {
	  			nowPageNum = endPage + 1;
			}
	  		else{
	  			nowPageNum = parseInt($(this).text());
	  		}
	  		$.ajax({
		        type:"POST",
		        url:"boardlist",
		        dataType: "text",
		        data:{
		        	"categorymenu" : categorymenu,
	        		"nowPageNum" : nowPageNum
		        	},
		        success:function(data){
	        	
		        	var responseData = JSON.parse(data)
	        	console.log(responseData["list"]);
	        	console.log(responseData["listMaker"]);
	        	
	        	var list = JSON.parse(responseData["list"]);
	        	var pageDto = JSON.parse(responseData["listMaker"]);
	        	for (var i = 0; i < list.length; i++) {
		        	var html = ""; 
		        	html += '<tr id="appendList">';
		        	html += '<td>'+list[i].boardid+'</td>';
		        	html += '<td><a class="move" href=' + list[i].boardid + '>'+list[i].boardtitle+'</td>';
		        	html += '<td>'+list[i].usernick+'</td>';
		        	html += '<td>'+list[i].viewcCnt+'</td>';
		        	html += '</tr>';
		        	$("#boardList").append(html);
				}
	        	
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
	        	
	        	for (var i = startPage; i <= endPage; i++) {
	        		nowPageNum = i
	        		nowPageNumHtml = "<li id='paginationBtn'><div class='pagingBtn' id='pagingBtn" + nowPageNum + "'>" + nowPageNum + "</div></li>"
	        		$("#pagination").append(nowPageNumHtml);
				}
	        	
	        	var nextHtml ="";
	        	if (pageDto.next) {
	        		nextHtml = "<li id='nextBtn'><div class='pagingBtn'>></div></li>"
	        		$("#pagination").append(nextHtml);
	        		$("#pagination").css("width", "360px");
				}
	        	else {
					nextHtml = "<li id='nextBtn'><div class='pagingBtn' style='color:gray; outline: 1px solid gray; cursor: default; pointer-events: none;'>></div></li>"
	        		$("#pagination").append(nextHtml);
	        		$("#pagination").css("width",(30*(endPage-startPage+3)) + "px");
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
	 	})
	});
</script>
<section class="body">
	<div id="category">
		<ul id="categoryMenu">
			<li id="categoryBoard" class="categoryMenuMain"><strong>게시판</strong></li>
			<li class="categoryMenuDetail"><button class="detailMenuBtn" id="notice" data-value="notice">- 공지사항</button></li>
			<li class="categoryMenuDetail"><button class="detailMenuBtn" id="free" data-value="free">- 자유게시판</button></li>
			<li class="categoryMenuDetail"><button class="detailMenuBtn" id="infor" data-value="infor">- 정보 게시판</button></li>
			<li class="categoryMenuDetail"><button class="detailMenuBtn" id="study" data-value="study">- 스터디모임 게시판</button></li>
			<li id="categoryResume" class="categoryMenuMain"><strong>이력서</strong></li>
			<li class="categoryMenuDetail"><a href="resume">- 이력서</a></li>
			<li class="categoryMenuDetail"><a href="selfIntro">- 자기소개서</a></li>
			<li id="categoryMypage" class="categoryMenuMain"><strong>Mypage</strong></li>
			<li class="categoryMenuDetail"><a href="chgMyImfor">- 개인정보수정</a></li>
			<li class="categoryMenuDetail"><a href="resumeWrite">- 이력서 작성</a></li>
			<li class="categoryMenuDetail"><a href="selfIntroWrite">- 자기소개서 작성</a></li>
		</ul>
	</div>
	<div id="detailName">
		<h2>공지사항</h2>
	</div>
	<div id="contentInputBox">
		<input type="text" id="contentInput" placeholder="&nbsp&nbsp&nbsp관심 있는 내용을 입력해 주세요!">
	</div>
	<div id="board">
		<table id="boardList">
			<tr>
				<th>글 번호</th>
				<th>제목</th>
				<th>작성자</th>
<!-- 				<th>작성일</th> -->
				<th>조회수</th>
			</tr>
		</table>
	</div>
	<div id="paging">
		<ul id="pagination">
		</ul>
	</div>
</section>
<%@ include file="../includes/footer.jsp" %>