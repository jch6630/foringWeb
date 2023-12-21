<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/main.css">
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<script src="../resources/jquery/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		loadHotBoardList();
	})
	function loadHotBoardList() {
	    // Ajax 통신
	    $.ajax({
	        type: "POST",
	        url: "hotBoardList",
	        dataType: "json",
	        data: {
	            "amount": 10
	        },
	        success: function(responseData) {
	            var list = responseData.list;
// 	            var pageDto = responseData.listMaker;
	
	            console.log(list);
	            // 게시판 목록 출력
	            if (Array.isArray(list)) {
	                list.forEach(function(item) {
	                    var html = "<tr><td><span class='category'>" + item.category + "</span></td><td><a class='hotboardname' href='" + item.boardid + "'>" + item.boardtitle + "</a></td><td><span id='hotBoardLikeImg'><img class='likeimg' src='../resources/images/like.png' /></span><span>"+item.likeCnt+"</span></td><td><span id='hotBoardReplyImg'><img class='commentimg' src='../resources/images/comment.png' /></span><span>"+item.replyCnt+"</span></td></tr>";
	                    $("#hotboardtable").append(html);
	                });
	            }
	            
	            if (list.length!=10) {
	            	for (var i = 0; i < 10-list.length; i++) {
	            		var html = "<tr><td><span class='category'>-</span></td><td><a class='hotboardname'>-</a></td><td><span id='hotBoardLikeImg'><img class='likeimg' src='../resources/images/like.png' /></span></td><td><span id='hotBoardReplyImg'><img class='commentimg' src='../resources/images/comment.png' /></span><span></span></td></tr>";
	                    $("#hotboardtable").append(html);
					}
				}
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            if (textStatus == "timeout") {
	                alert("시간이 초과되어 데이터를 수신하지 못하였습니다.");
	            } else {
	                alert("데이터 전송에 실패했습니다. 다시 시도해 주세요");
	            }
	        }
	    });
	}
	// 게시판 글 클릭 시 이동 처리
	$(document).on("click", ".hotboardname", function(e) {
		e.preventDefault();
 		var actionForm = $("#hotBoardActionForm");
//			alert($(this).attr("href"));
		actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		actionForm.attr("action", "${ctx}/foring/read");
		actionForm.submit();
	});
</script>
<section class="body">

		<div class="searchbox">
			<input type="text" id="searchbox"
				placeholder="&nbsp&nbsp&nbsp관심있는 내용을 입력해주세요.">
		</div>
		<div class="succresume">
			<ul class="succresumelist">
				<li class="succresumelisttitle">합격자소서</li>
				<li>
					<hr class="succresumelistline">
					<div>
						<a href="#" class="succresumelink">
							<ul class="succresumelistkind">
								<li>자소서 제목</li>
								<hr>
								<li>합격 및 지원 회사</li>
								<hr>
								<li>연봉정보</li>
								<hr>
								<li>판매여부/판매가격</li>
								<hr>
								<li>판매자 닉네임</li>
							</ul>
						</a>
					</div>
				</li>
				<li>
					<hr class="succresumelistline">
					<div>
						<a href="#" class="succresumelink">
							<ul class="succresumelistkind">
								<li>자소서 제목</li>
								<hr>
								<li>합격 및 지원 회사</li>
								<hr>
								<li>연봉정보</li>
								<hr>
								<li>판매여부/판매가격</li>
								<hr>
								<li>판매자 닉네임</li>
							</ul>
						</a>
					</div>
				</li>
			</ul>
		</div>
		<div class="hotboard">
			<table border="1" id="hotboardtable">
				<tr>
					<td colspan="4"><img src="../resources/images/hoticon.png" class="hoticon"
						style="vertical-align: middle;" /> <span class="hotboardtitle"
						style="vertical-align: middle;"><strong>핫 게시판</strong></span>
					</td>
				</tr>
			</table>
			<form id="hotBoardActionForm">
			</form>
		</div>
		<div class="mainchat">
			<div class="mainchatbox">
				<!-- 웹 채팅 구현 -->
				<div class="chat_wrap">
				    <div class="chat">
				        <ul>
				            <!-- 동적 생성 -->
				        </ul>
				    </div>
				<input type="text" id="chattingbox" placeholder="&nbsp&nbsp&nbsp;다른 회원님들과 정보를 공유해봐요!">
				    <!-- format -->
				 
				    <div class="chat format">
				        <ul>
				            <li>
				                <div class="sender">
				                    <span></span>
				                </div>
				                <div class="message">
				                    <span></span>
				                </div>
				                <div class="senddate">
				                    <span></span>
				                </div>
				            </li>
				        </ul>
				    </div>
				</div>
				<!-- 웹 채팅 구현 -->
			</div>
		</div>
	<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
	<script type="text/javascript">
	
		$('#chattingbox').one("focus",function(e){
			const login = "${login}";
			$.ajax({
				type:"GET",
		        url:"/foring/mainchat",
		        data: login,
		        success:function(){
		        	if (login == "") {
						alert("로그인 후 이용바랍니다.");
						location.href = "/foring/login"
		        	}
				}
			})
			
		})
	    const usernick = "${login.usernick}";
	    
        let sock = new SockJS("/mc");
		sock.onclose = onClose;
		sock.onmessage = onMessage;
			
	        // enter 키 이벤트
	        $('#chattingbox').on('keydown', function(e){
		            if(e.keyCode == 13 && !e.shiftKey) {
			        	if($(this).val() == ""){
			        		alert("메세지를 입력해주세요.");
			        		return false;
			        	}
			        	else{
		                e.preventDefault();
		                
		 
		                // 메시지 전송
// 		                sendMessage($("#chattingbox").val());
		                sendMessage($("#chattingbox").val());
		                // 입력창 clear
		                clearText();
			        	}
		            }
	    	});
	
		    // 메세지 전송
		    function sendMessage(message) {
// 		 		alert("sendMessage");
		        const data = {
		            senderNick : usernick,
		            message : message
		        };
		        sock.send(JSON.stringify(data));
		        // 서버로부터 메세지를 받기
// 	            onMessage();
		    }
		    
		 	// 서버로부터 메세지를 받았을 때
			function onMessage(msg) {
// 				alert("onMessage");
// 		 		alert(msg);
// 		 		alert(JSON.stringify(msg));
		 		
// 		 	    var data = msg.data;
// 		 		alert(data);
// 		 		alert(JSON.stringify(data));
		 		// Json 데이터 파싱
		 	    var obj = msg.data;
// 		 		alert(obj);
// 		 		alert(JSON.stringify(obj));
		 		
				var data = JSON.parse(obj);
// 		 		alert(data);
// 		 		alert(JSON.stringify(data));
// 				$("#messageArea").append(data + "<br/>");
		        resive(data);
			}
	        	
		    // 메세지 수신
		    function resive(data) {
// 				alert("resive");
// 				alert(data.senderNick);
// 				alert(data.message);
		        const LR = (data.senderNick != "${login.usernick}")? "left" : "right";
		        appendMessageTag(LR, data.senderNick, data.message);
		    }
		    
		    // 메세지 태그 append
		    function appendMessageTag(LR_className, senderNick, message) {
// 				alert("appendMessageTag");
// 				alert("senderNick : " + senderNick);
// 				alert("message : " + message);
		        const chatLi = createMessageTag(LR_className, senderNick, message);
		 
		        $('div.chat:not(.format) ul').append(chatLi);
		 
		        // 스크롤바 아래 고정
		        $('div.chat').scrollTop($('div.chat').prop('scrollHeight'));
		    }
		    
		    // 메세지 태그 생성
		    function createMessageTag(LR_className, senderNick, message) {
// 				alert("createMessageTag");
		        // 형식 가져오기
		        let chatLi = $('div.chat.format ul li').clone();
		        
		        let now = new Date();
		        
		 		let year = now.getFullYear();
		 		let month = now.getMonth()+1;
		 		let date = now.getDate();
		 		
		 		let hr = now.getHours();
		 		let min = now.getMinutes();
		 		let sec = now.getSeconds();
		        
		        // 값 채우기
		        chatLi.addClass(LR_className);
		        
		        chatLi.find('.sender span').html("<strong>" + senderNick + "</strong>");
		        chatLi.find('.message span').html(message);
		        chatLi.find('.senddate span').html("(" + year + "-" + month + "-" + date + "&nbsp"
						  							+ hr + ":" + min + ")");
		 
		        return chatLi;
		    }
		 
		    // 메세지 입력박스 내용 지우기
		    function clearText() {
// 				alert("clearText");
		        $('#chattingbox').val('');
		    }
		 
		    
		 	// 서버와 연결을 끊었을 때
			function onClose() {
				$("#chattingbox").attr("placeholder", "연결 끊김");
			}
	 
	</script>
	</section>
<%@ include file="../includes/footer.jsp" %>