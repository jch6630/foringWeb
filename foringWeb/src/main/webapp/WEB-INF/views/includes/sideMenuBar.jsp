<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="../resources/css/categoryFloatingBar.css">
<script src="../resources/jquery/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var currentPosition = parseInt($("#category").css("top"));
	  	$(window).scroll(function() {
	    	var position = $(window).scrollTop(); 
	    	if (position+currentPosition > parseInt($(".body").css("height"))-300) { 
				return false;
			} else {
		    	$("#category").stop().animate({"top":position+currentPosition+"px"},500);
			}
	  	});
	  	
	  	$(".detailMenuBtn").hover(function(){
	  		$(this).css({"font-size":"18px"});
	  	}, function(){
	  		$(this).css({"font-size":"15px"});
	  	});
	});
</script>
<div id="category">
	<ul id="categoryMenu">
		<li id="categoryBoard" class="categoryMenuMain"><strong>게시판</strong></li>
		<li class="categoryMenuDetail"><button class="detailMenuBtn" id="notice" data-value="notice"> 공지사항</button></li>
		<li class="categoryMenuDetail"><button class="detailMenuBtn" id="free" data-value="free"> 자유게시판</button></li>
		<li class="categoryMenuDetail"><button class="detailMenuBtn" id="infor" data-value="infor"> 정보게시판</button></li>
		<li class="categoryMenuDetail"><button class="detailMenuBtn" id="study" data-value="study"> 스터디모임게시판</button></li>
		<li id="categoryResume" class="categoryMenuMain"><strong>이력서</strong></li>
		<li class="categoryMenuDetail"><a class="detailMenuBtn" href="resume"> 이력서</a></li>
		<li class="categoryMenuDetail"><a class="detailMenuBtn" href="selfIntro"> 자기소개서</a></li>
		<li id="categoryMypage" class="categoryMenuMain"><strong>Mypage</strong></li>
		<li class="categoryMenuDetail"><a class="detailMenuBtn" href="chgMyImfor"> 개인정보수정</a></li>
		<li class="categoryMenuDetail"><a class="detailMenuBtn" href="resumeWrite"> 이력서 작성</a></li>
		<li class="categoryMenuDetail"><a class="detailMenuBtn" href="selfIntroWrite"> 자기소개서 작성</a></li>
	</ul>
</div>