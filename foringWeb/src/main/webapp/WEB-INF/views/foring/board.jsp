<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">


	$(document).ready(function(e){

	  	var startPage = 0;
	  	var endPage = 0;
	  	let nowPageNum = $("#nowPageNum").val();
	  	
	  	let content = $("#content").val();
	  	let responseCategorymenu = $('input[name=categorymenu]').val();
	  	let categorymenu = ""
	  	if (responseCategorymenu == "") {
// 	  		alert(responseCategorymenu);
		  	categorymenu = $("#categorymenu").val();
		}
	  	else {
// 	  		alert(responseCategorymenu);
	  		categorymenu = responseCategorymenu;
	  		
	  		let detailNametext = ""
	  		if (categorymenu =="notice") {
	  			detailNametext= "공지사항"
			}
	  		else if (categorymenu =="free") {
	  			detailNametext= "자유게시판"
			}
			else if (categorymenu =="infor") {
				detailNametext= "정보게시판"	
			}
			else if (categorymenu =="study") {
				detailNametext= "스터디모임게시판"
			}
	  		
	  		$("#detailNametext").text(detailNametext)
	  	
			$(function(){
		  		$.ajax({
			        type:"POST",
			        url:"boardlist",
			        dataType: "text",
			        data:{
			        		"categorymenu" : categorymenu,
			        		"nowPageNum" : nowPageNum,
			        		"content" : content
			        	},
			        success:function(data){
			        	var responseData = JSON.parse(data)
// 			        	console.log(responseData["list"]);
// 			        	console.log(responseData["listMaker"]);
			        	
			        	var list = JSON.parse(responseData["list"]);
			        	var pageDto = JSON.parse(responseData["listMaker"]);
			        	for (var i = 0; i < list.length; i++) {
				        	var html = ""; 
				        	html += '<tr id="appendList">';
				        	html += '<td>'+list[i].boardid+'</td>';
				        	html += '<td><a class="move" href=' + list[i].boardid + '>'+list[i].boardtitle+'</td>';
				        	html += '<td>'+list[i].usernick+'</td>';
				        	html += '<td>'+list[i].viewCnt+'</td>';
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
			        	
		  				$("#paging").css("top",((list.length+1)*30)+120+"px");
		  				$("#write").css("top",((list.length+1)*30)+120+"px");
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
	  	}
		
	  	/* 게시판 하위 메뉴 클릭시 페이지 변화 */
	  	$(".detailMenuBtn").on("click",function(){
	  		
	  		if ($("#appendList")) {
	  			$("#boardList").html("<tr><th>글 번호</th><th>제목</th><th>작성자</th><th>조회수</th></tr>");
	  			$("#pagination").html("");
			}
	  		
	  		categorymenu = $(this).attr('data-value');
	  		
	  		$("#detailNametext").text($(this).text())
	  		
	  		$("#categorymenu").val(categorymenu);
	  		
	  		$.ajax({
		        type:"POST",
		        url:"boardlist",
		        dataType: "text",
		        data:{
		        		"categorymenu" : categorymenu,
		        		"nowPageNum" : nowPageNum,
		        		"content" : content
		        	},
		        success:function(data){
		        	var responseData = JSON.parse(data)
// 		        	console.log(responseData["list"]);
// 		        	console.log(responseData["listMaker"]);
		        	
		        	var list = JSON.parse(responseData["list"]);
		        	var pageDto = JSON.parse(responseData["listMaker"]);
		        	for (var i = 0; i < list.length; i++) {
			        	var html = ""; 
			        	html += '<tr id="appendList">';
			        	html += '<td>'+list[i].boardid+'</td>';
			        	html += '<td><a class="move" href=' + list[i].boardid + '>'+list[i].boardtitle+'</td>';
			        	html += '<td>'+list[i].usernick+'</td>';
			        	html += '<td>'+list[i].viewCnt+'</td>';
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
		        	
	  				$("#paging").css("top",((list.length+1)*30)+120+"px");
	  				$("#write").css("top",((list.length+1)*30)+120+"px");
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
	  	
	  	/* 페이징 버튼 클릭시 페이지 변화 */
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
	  		
	  		$("#nowPageNum").val(nowPageNum);
	  		
	  		$.ajax({
		        type:"POST",
		        url:"boardlist",
		        dataType: "text",
		        data:{
		        	"categorymenu" : categorymenu,
	        		"nowPageNum" : nowPageNum,
	        		"content" : content
		        	},
		        success:function(data){
	        	
		        	var responseData = JSON.parse(data)
	// 	        	console.log(responseData["list"]);
	// 	        	console.log(responseData["listMaker"]);
		        	
		        	var list = JSON.parse(responseData["list"]);
		        	var pageDto = JSON.parse(responseData["listMaker"]);
		        	for (var i = 0; i < list.length; i++) {
			        	var html = ""; 
			        	html += '<tr id="appendList">';
			        	html += '<td>'+list[i].boardid+'</td>';
			        	html += '<td><a class="move" href=' + list[i].boardid + '>'+list[i].boardtitle+'</td>';
			        	html += '<td>'+list[i].usernick+'</td>';
			        	html += '<td>'+list[i].viewCnt+'</td>';
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
	// 	        	var nowPageNumHtml = "";
		        	
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
		        	
	  				$("#paging").css("top",((list.length+1)*30)+120+"px");
	  				$("#write").css("top",((list.length+1)*30)+120+"px");
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
	 	
	 	/* 게시판 검색시 페이지 변화 */
	  	$(document).on("keyup", "#contentInput", function pagingBtnClick(key){
	  		if (key.keyCode==13) {
	  			
// 	  			alert("OK");
	  			
	  			content = $("#contentInput").val();
	  			$("#content").val(content)
	  			
		 		if ($("#appendList")) {
		 			$("#boardList").html("<tr><th>글 번호</th><th>제목</th><th>작성자</th><th>조회수</th></tr>");
		 			$("#pagination").html("");
				}
		 		
		 		nowPageNum = 1;
		  		
		  		$("#nowPageNum").val(nowPageNum)
		  		
// 		  		alert("categorymenu" + categorymenu);
// 		  		alert("nowPageNum" + nowPageNum);

		  		$.ajax({
			        type:"POST",
			        url:"boardlist",
			        dataType: "text",
			        data:{
			        	"categorymenu" : categorymenu,
		        		"nowPageNum" : nowPageNum,
		        		"content" : content
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
				        	html += '<td>'+list[i].viewCnt+'</td>';
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
		  				$("#paging").css("top",((list.length+1)*30)+120+"px");
		  				$("#write").css("top",((list.length+1)*30)+120+"px");
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
	 	
	 	$(document).on("click", ".move", function(e) {
	 		var actionForm = $("#actionForm");
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action", "${ctx}/foring/read");
			actionForm.submit();
		});
	  	
	  	$(document).on("click", "#writeBtn", function(e) {
	 		location.href ="./write";
		});
	 	
	});
</script>
<section class="body">
	<!-- 사이드 바 -->
	<%@ include file="../includes/sideMenuBar.jsp" %>
	<div id="boardFirstLine">
		<div id="detailName">
			<h2 id="detailNametext">공지사항</h2>
		</div>
		<div id="contentInputBox">
			<input type="text" id="contentInput" placeholder="관심 있는 내용을 입력해 주세요!" maxlength="30"/>
		</div>
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
	<div id="boardLastLine">
		<div style="width: 10%;height: 30px;"></div>
		<div id="paging">
			<ul id="pagination">
			</ul>
		</div>
		<div id="write">
			<button type="button" id="writeBtn">
				<span id="writeBtnText" title="WRITE">글쓰기</span>
			</button>
		</div>
	</div>
	
	<form action="" id="actionForm" method="get">
		<input type="hidden" id="nowPageNum" value="1">
		<input type="hidden" id="amount">
		<input type="hidden" id="categorymenu" value="notice">
		<input type="hidden" id="content">
		<input type="hidden" name="categorymenu" value="${categorymenu}">
	</form>
	
</section>
<%@ include file="../includes/footer.jsp" %>