<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/read.css">
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

	// url주소에서 bno값 받아오기
	var url_href = window.location.href;
	var url = new URL(url_href);
	var bno = url.searchParams.get("bno");
	
	// 댓글 받아오기
	function replyCallIn(){
		
		// 댓글과 댓글 페이징 처리 버튼 초기화
		$("#replies").empty();
		$("#paginationReply").empty();
		
		// 페이징 처리를 위한 현재 페이지 값
	  	let nowPageNum = $("#replyPageNum").val();
		
		// 주소에서 받아온 bno 값과 페이지 값을 받아와 댓글 data를 받아오는 비동기 처리
		$.ajax({
	        type:"POST",
	        url:"reply",
	        data: {
	        	"bno" : bno,
	        	"nowPageNum" : nowPageNum
	        },
	        success:function(data){
	        	// 받아온 데이터 확인
	        	console.log(data);
	        	
	        	// 받아온 댓글 데이터(배열 형식)
	        	let replyList = data.reply;
	        	
	        	// 데이터를 동적으로 포맷 및 DOM으로 만들어 배포 
	        	for (var i = 0; i < replyList.length; i++) {
	        		
	        		// DOM 객체 선언 및 초기화
	        		let replyRow = "";
	        		
	        		// 댓글 날짜 데이터 포맷 시작
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
	        		// 댓글 날짜 데이터 포맷 끝
	        		
	        		// 비공개된 댓글 데이터를 DOM으로 초기화
	        		if(replyList[i].disclosure == "n"){
	        			replyRow += "<tr class='reply' id='reply" + replyList[i].replyid + "'>";
		        		replyRow += "<td id='replyUsernick'>비공개</td>";
		        		replyRow += "<td id='replyContent'>비공개 처리된 댓글입니다.</td>";
		        		replyRow += "<td id='replyRegdate'>" + showingTime + "</td>";
		        		replyRow += "<td id='rereplyBtnBack'><button class='rereplyBtn' id='rereplyBtn_" + replyList[i].replyid + "' style='cursor: default;' disabled>답글▽</button></td>";
		        		replyRow += "</tr>";
	        		}
	        		// 공개된 댓글 데이터를 DOM으로 초기화
	        		else{
		        		replyRow += "<tr class='reply' id='reply" + replyList[i].replyid + "'>";
		        		replyRow += "<td id='replyUsernick'>" + replyList[i].usernick + "</td>";
		        		replyRow += "<td id='replyContent'>" + replyList[i].replycontent + "</td>";
		        		replyRow += "<td id='replyRegdate'>" + showingTime + "</td>";
		        		replyRow += "<td id='rereplyBtnBack'><button class='rereplyBtn' id='rereplyBtn_" + replyList[i].replyid + "'>답글▽</button></td>";
		        		replyRow += "</tr>";
	        		}
	        		$("#replies").append(replyRow); // DOM 배포
				}
	        	
	        	// 페이지네이션 데이터
	        	var pageDto = data.listMaker;
	        	
	        	// 현제 페이지 값을 시작 값 이전으로 바꾸는 페이지네이션 버튼 DOM 선언
	        	var prevHtml ="";
	        	
	        	// 현재 페이지의 값보다 작은 페이지 값이 있을 경우
	        	if (pageDto.prev) {
	        		prevHtml = "<li id='replyPrevBtn'><div class='pagingReplyBtn'><</div></li>"
	        		$("#paginationReply").append(prevHtml);
				}
	        	// 현재 페이지의 값보다 작은 페이지 값이 없을 경우
	        	else {
	        		prevHtml = "<li id='replyNextBtn'><div class='pagingReplyBtn' style='color:gray; outline: 1px solid gray; cursor: default; pointer-events: none;'><</div></li>"
	        		$("#paginationReply").append(prevHtml);
				}
	        	
	        	// 페이지네이션 버튼 선언
	        	var nowPageNumHtml = "";
	        	
	        	// 페이지네이션 버튼 시작 값 초기화
	        	startPage = pageDto.startPage;
	        	
	        	// 페이지네이션 버튼 끝 값 초기화
	        	endPage = pageDto.endPage;
	        	
	        	// 페이지네이션 버튼 시작 및 끝 값을 저장
	        	$("#replyStartPageNum").val(pageDto.startPage);
	        	$("#replyEndPageNum").val(pageDto.endPage);
	        	
	        	// 시작 및 끝 값 사이의 페이지네이션 버튼 DOM 초기화
	        	for (var i = startPage; i <= endPage; i++) {
	        		nowPageNumHtml = "<li id='paginationReplyBtn'><div class='pagingReplyBtn' id='pagingReplyBtn" + i + "'>" + i + "</div></li>"
	        		$("#paginationReply").append(nowPageNumHtml);
				}
	        	
	        	// 현제 페이지 값을 시작 값 이후로 바꾸는 페이지네이션 버튼 DOM 선언
	        	var nextHtml ="";
	        	
	        	// 현재 페이지의 값보다 큰 페이지 값이 있을 경우
	        	if (pageDto.next) {
	        		nextHtml = "<li id='replyNextBtn'><div class='pagingReplyBtn'>></div></li>"
	        		$("#paginationReply").append(nextHtml);
				}
	        	// 현재 페이지의 값보다 큰 페이지 값이 없을 경우
	        	else {
					nextHtml = "<li id='replyNextBtn'><div class='pagingReplyBtn' style='color:gray; outline: 1px solid gray; cursor: default; pointer-events: none;'>></div></li>"
	        		$("#paginationReply").append(nextHtml);
				}
	        	
	        	// 페이지네이션 버튼이 클릭 되었을 때
				$(".pagingReplyBtn").off().on("click",function(){
					
					// prev 버튼이 눌렸을 경우
					if ($(this).text() == "<") {
			  			nowPageNum = startPage - 1;
					}
					// next 버튼이 눌렸을 경우
			  		else if ($(this).text() == ">") {
			  			nowPageNum = endPage + 1;
					}
					// 값을 가진 버튼이 눌렸을 경우
			  		else{
			  			nowPageNum = parseInt($(this).text());
			  		}
			  		
					// 현재 페이지 값 저장
			  		$("#replyPageNum").val(nowPageNum);
					
					// 댓글 다시 불러오기
				  	$(replyCallIn()).one();
			  	});
			  	
	        	// 대댓글 버튼 클릭
			  	$(".rereplyBtn").off().on("click", function(e){
			  		
			  		// 로그인 정보 가져오기
			  		var usernick = $("#usernick").val();
			  		
			  		// 로그인이 되어있지 않을 경우
			  		if(usernick == ""){
			  			alert("로그인 후 이용 바랍니다.");
			  			return false;
			  		}
			  		// 로그인이 되어있을 경우
			  		else{
			  			
			  			// 댓글 코드 선언 및 초기화
						let replyKey = this.id.split("_");

			  			// 대댓글 DOM 비우기
				  		if($("#reReplyContainer"+replyKey[1]).length != 0){
				  			$(".reReplyContainer").remove();
					  		$(".reReplyReg").remove();
					  		return false;
				  		}
				  		
				  		$(".reReplyContainer").remove();
				  		$(".reReplyReg").remove();
				  		
						rereplyBtnClick(replyKey[1]);
						var reReplyContainerDom = "";
						reReplyContainerDom += "<tr class='reReplyContainer' id='reReplyContainer" + replyKey[1] + "'>";
						reReplyContainerDom += "<td class='reReplyContainerBox' colspan='4'><div style='width: 95%; height: auto; max-height: 300px; overflow: auto; float: right;'><table class='reReplies' id='reReplies" + replyKey[1] + "'>";
						reReplyContainerDom += "</table></div></td>";
						reReplyContainerDom += "</tr>";
						reReplyContainerDom += "<tr class='reReplyReg' id='reReplyReg" + replyKey[1] + "'>";
						reReplyContainerDom += "<td class='reReplyRegArea' colspan='4'>";
						reReplyContainerDom += "<textarea class='reReplyTextArea' id='reReplyTextArea" + replyKey[1] + "' placeholder='답글을 작성하세요.'  maxlength='300'></textarea>";
						reReplyContainerDom += "</td>";
						reReplyContainerDom += "</tr>";
						$("#reply"+replyKey[1]).after(reReplyContainerDom);
						
			  		}			  	
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
	
	function rereplyBtnClick(replyid, usernick){
		$.ajax({
	        type:"POST",
	        url:"rereply",
	        data: {
	        	"replyid" : replyid,
	        	"usernick" : usernick
	        },
	        success:function(data){
	        	console.log(data);
	        	var list = data.rereply;
	        	if(list.length == 0){
	        		$("#reReplies" + replyid).append("<tr><td colspan='4'>등록된 답글이 없습니다.</td></tr>")
	        	}
	        	else{
	        		for (var i = 0; i < list.length; i++) {
		        		let reReplyRow = "";
		        		reReplyRow += "<tr class='reReply' id='reReply" + list[i].reReplyid + "'>";
		        		reReplyRow += "<td class='LSymbol'>ㄴ</td>";
		        		reReplyRow += "<td class='reReplyUsernick'>" + list[i].usernick + "</td>";
		        		reReplyRow += "<td class='reReplyContent'>" + list[i].rereplycontent + "</td>";
		        		const reReplyregdate = new Date(list[i].rereplyregdate);
		        		const nowTime = new Date();
		        		let showingTime = "";
		        		
		        		if (reReplyregdate.getDate() < nowTime.getDate()) {
		        			showingTime = reReplyregdate.getFullYear() + "-" + (reReplyregdate.getMonth()+1) + "-" + reReplyregdate.getDate();
						}
		        		else{
		        			if(reReplyregdate.getHours()==nowTime.getHours()){
		        				if (reReplyregdate.getMinutes()==nowTime.getMinutes()) {
		        					showingTime = "방금 전";
								} 
		        				else{
		        					showingTime = String(nowTime.getMinutes() - reReplyregdate.getMinutes()) + "분 전";
								}
		        			}
		        			else{
		        				showingTime = (nowTime.getHours() - reReplyregdate.getHours()) + "시간 전";
		        			}
		        		}
		        		
		        		reReplyRow += "<td class='reReplyRegdate'>" + showingTime + "</td>";
		        		reReplyRow += "</tr>";
		        		$("#reReplies" + replyid).append(reReplyRow);
					}
	        	}
	        	$(document).on("keypress",".reReplyTextArea",function(e){
			  		reReplyRegister(e, replyid);
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
	

  	function reReplyRegister(e, replyid){
		var usernick = $("#usernick").val();
  		if(usernick == ""){
  			alert("로그인 후 이용 바랍니다.");
  			return false;
  		}
  		else{
	  		if(e.keyCode == 13){
// 		  		alert("reReplyRegister 이벤트 발생");
	  			
	  			var data = {
		  			rereplycontent : $("#reReplyTextArea"+replyid).val(),
		  			replyid : parseInt(replyid),
		  			usernick : usernick,
		  			disclosure : "y"
	  			};
		  		alert(data.toString());
	  			
	  			$.ajax({
	  		        type:"POST",
	  		        url:"reReplyRegister",
	  		        data: data,
	  		        success:function(data){
	  		        	if(data==1){
	  		        		$("#rereplyBtn_"+replyid).trigger('click');
	  		        		$("#rereplyBtn_"+replyid).trigger('click');
	  		        		$(".reReplyTextArea").val("");
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
  		}
  	}
	
	$(document).ready(function(e){
	  	
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
  			var usernick = $("#usernick").val();
	  		if(usernick == ""){
	  			alert("로그인 후 이용 바랍니다.");
	  			return false;
	  		}
	  		else{
		  		if(e.keyCode == 13){
		  			
		  			var replyRegDis = $("#replyRegDis").is(":checked") ; 
	 				var disclosure = "y";
// 	 				alert(replyRegDis);
		  			if(replyRegDis){
		  				disclosure = "n";
		  			}
		  			else{
		  				disclosure = "y"
		  			}
// 	 				alert(disclosure);
		  			
		  			var data = {
			  			replycontent : $(this).val(),
			  			boardid : parseInt(bno),
			  			usernick : usernick,
			  			disclosure : disclosure
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
		  			
		  			$("#replyRegDis").prop("checked", false);
		  		}
	  		}
	  	})
	  	
	  	$("#replyRegText").keydown(function(){
	  		var usernick = $("#usernick").val();
	  		if(usernick == ""){
	  			alert("로그인 후 이용 바랍니다.");
	  			return false;
	  		}
	  		else{
	  			var replycontent = $(this).val();
	  			$("#replyRegTextNowCnt").text(replycontent.length);
	  		}
	  	});
	  	
	  	$("#replyRegText").keyup(function(){
 			if ($(this).val().length > $(this).attr('maxlength')) {
 	            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
 	        }
	  	});
	  	
	});
</script>
<section class="body">
	<!-- 사이드 바 -->
	<%@ include file="../includes/sideMenuBar.jsp" %>
	<div id="readContainer">
		<div id="boardTitle">게시글 제목 : ${read.boardtitle}</div>
		<div id="readContainerFirstLine">
			<div id="boardCategory">카테고리 : ${read.categorymenu}</div>
			<div id="boardDate">작성일 : 2023-11-11</div>
			<div id="boardViewCnt">조회수 : ${read.viewCnt}</div>
		</div>
		<div id="readContainerSecondLine">
			<div id="boardWriter">작성자 : ${read.usernick}</div>
			<div id="boardDisclosure">공개여부 : ${read.disclosure}</div>
		</div>
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
			<div id="replyRegOptions">
				<div>
					<span>비공개</span>
					<input type="checkbox" id="replyRegDis" />
				</div>
				<div id="replyRegTextCnt"><span id="replyRegTextNowCnt">0</span><span id="replyRegTextMaxCnt">/300</span></div>
			</div>
			<textarea id="replyRegText" placeholder="댓글은 입력하세요."  maxlength="300"></textarea>
		</form>
		<form action="" id="actionForm" method="get">
			<input type="hidden" id="replyPageNum" value="1">
			<input type="hidden" id="replyStartPageNum" value="0">
			<input type="hidden" id="replyEndPageNum" value="0">
			<input type="hidden" id="usernick" value="${memInfo.usernick}">
		</form>
	</div>
	
</section>
<%@ include file="../includes/footer.jsp" %>