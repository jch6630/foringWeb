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
		<div id="boardContent">게시글 내용 : ${read.boardcontent}</div>
	</div>
	
</section>
<%@ include file="../includes/footer.jsp" %>