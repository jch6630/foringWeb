<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	  	var currentPosition = parseInt($("#category").css("top"));
	  	$(window).scroll(function() {
	    	var position = $(window).scrollTop(); 
	    	if (position+currentPosition > 536) { 
				return false;
			} else {
		    	$("#category").stop().animate({"top":position+currentPosition+"px"},1000);
			}
	  	});
	});
</script>
<section class="body">
	<div id="category">
		<ul id="categoryMenu">
			<li id="categoryBoard" class="categoryMenuMain"><strong>게시판</strong></li>
			<li class="categoryMenuDetail">- 공지사항</li>
			<li class="categoryMenuDetail">- 자유게시판</li>
			<li class="categoryMenuDetail">- 정보 게시판</li>
			<li class="categoryMenuDetail">- 스터디모임 게시판</li>
			<li id="categoryResume" class="categoryMenuMain"><strong>이력서</strong></li>
			<li class="categoryMenuDetail">- 이력서</li>
			<li class="categoryMenuDetail">- 자기소개서</li>
			<li id="categoryMypage" class="categoryMenuMain"><strong>Mypage</strong></li>
			<li class="categoryMenuDetail">- 개인정보수정</li>
			<li class="categoryMenuDetail">- 이력서 작성</li>
			<li class="categoryMenuDetail">- 자기소개서 작성</li>
		</ul>
	</div>
	<div id="detailName">
		<h2>공지사항</h3>
	</div>
	<div id="contentInputBox">
		<input type="text" id="contentInput" placeholder="&nbsp&nbsp&nbsp관심 있는 내용을 입력해 주세요!">
	</div>
	<div>
		<table>
<%-- 			<c:forEach items="${list }" var="board"> --%>
<!-- 				<tr> -->
<%-- 					<td>${board.bno }</td> --%>
<%-- 					<td><a class="move" href=${board.bno }>	 --%>
<%-- 							<span>${board.title }</span> --%>
<%-- 							<span class="badge bg-ref">${board.replycnt }</span> --%>
<!-- 						</a> -->
<!-- 					</td> -->
<%-- 					<td>${board.writer }</td> --%>
<%-- 					<td><fmt:formatDate value="${board.regdate }" pattern="yy-MM-dd"></fmt:formatDate></td> --%>
<%-- 					<td><span class="badge bg-ref">${board.viewcnt }</span></td> --%>
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
		</table>
	</div>
</section>
<%@ include file="../includes/footer.jsp" %>