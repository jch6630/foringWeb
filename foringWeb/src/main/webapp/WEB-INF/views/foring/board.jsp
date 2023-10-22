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
	    	if (position+currentPosition > 536) { 
				return false;
			} else {
		    	$("#category").stop().animate({"top":position+currentPosition+"px"},700);
			}
	  	});
	  	
	  	$(".detailMenuBtn").on("click",function(){
	  		var categorymenu = $(this).attr('data-value');
// 	  		alert($(this).attr('data-value'));
	  		$.ajax({
		        type:"POST",
		        url:"boardlist",
		        dataType: "text",
		        data:{"categorymenu" : categorymenu},
		        success:function(data){
		        	alert("ok");
		        	let resultJson = eval("(" + data + ")");
// 		        	alert(resultJson.list);
// 		        	alert(resultJson.listMaker);
// 		        	alert(JSON.stringify(resultJson.list));
// 		        	alert(JSON.stringify(resultJson.listMaker));
		        	
		            let list = JSON.stringify(resultJson.list).replace(/[\[\]]/g, "");
		            let list2 = list.substring(10, list.length-2);
// 		        	alert(list2);
					let listsplit = new Array();
					listsplit = list2.split("), BoardDTO(");
// 		        	alert(listsplit.length);
					
					let listcontent =  new Array();
					let listdetail =  new Array();
					let boardlistdetailkey = new Array();
					let boardlistdetailvalue = new Array();
					let boardlistdetail = new Array();
					
					let boardliststr = "{";
					
					for(var i=0;i < listsplit.length;i++){
						listcontent[i] = String(listsplit[i]).split(",");
						console.log("listsplit" + [i] + " : " + listsplit[i]);
						console.log("listcontent" + [i] + " : " + listcontent[i]);
						for(var j=0;j<listcontent.length;j++){
							listdetail[j] = String(listcontent[j]).split('=');
							console.log("listdetail" + [j] + " : " + listdetail[j]);
							boardlistdetailkey[j] = listdetail[0];
							boardlistdetailvalue[j] = '"' + listdetail[1] +  '"';
							console.log("boardlistdetailkey" + [j] + " : " + boardlistdetailkey[j]);
							console.log("boardlistdetailvalue" + [j] + " : " + boardlistdetailvalue[j]);
						}
						
						for(var j=0;j < listcontent.length;j++){
							boardlistdetail[j] = boardlistdetailkey[j] + "=" + boardlistdetailvalue[j];
							console.log("boardlistdetailkey" + [j] + " : " + boardlistdetailkey[j]);
							console.log("boardlistdetailvalue" + [j] + " : " + boardlistdetailvalue[j]);
							console.log("boardlistdetail : " + boardlistdetail);
						}
						boardliststr += boardlistdetail[i]
						if (i<listsplit.length) {
							boardliststr += ", ";
						}
						else{
							boardliststr += "}";
						}
					}
					console.log("boardliststr : " + boardliststr);
					
					alert(boardliststr);
					
					
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
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach items="${list }" var="list">
				<tr>
					<td>${list.boardid }</td>
					<td><a class="move" href=${list.boardid }>	
							<span>${list.boardtitle }</span>
							<span class="badge bg-ref">${list.usernick }</span>
						</a>
					</td>
					<td>${board.writer }</td>
					<td><fmt:formatDate value="${board.regdate }" pattern="yy-MM-dd"></fmt:formatDate></td>
					<td><span class="badge bg-ref">${board.viewcnt }</span></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</section>
<%@ include file="../includes/footer.jsp" %>