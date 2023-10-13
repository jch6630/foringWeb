<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
console.clear();
	/* let box = $('.con')
	let boxHeight = box.height();
	let boxOffsetTop = box.offset().top; */
	let quickMenu = $('.fly');
	let quickMenuHeight = quickMenu.height();
	const DURATION = 1000;

	$(window).resize(function(){
	    boxHeight = box.height();
	    boxOffsetTop = box.offset().top;
	    quickMenuHeight = quickMenu.height();
	    // console.log('resize!');
	})
	
	$(window).scroll(function() {
	    let scrollTop = $(this).scrollTop();
	    let point;
	    let endPoint = boxHeight - quickMenuHeight;
	    if ( scrollTop < boxOffsetTop ) {
	        point = 0;
	    } else if ( scrollTop > endPoint ) {
	        point = endPoint;
	    } else {
	        point = scrollTop - boxOffsetTop; // 따라다니는 영역에서 우측 최상단에 위치
	    }
	    quickMenu.stop().animate({top: point}, DURATION);
	});
</script>
<section class="body">
	<div id="boardCategory">
		
	</div>
</section>
<%@ include file="../includes/footer.jsp" %>