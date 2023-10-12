<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>

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
			<table border="1" class="hotboardtable">
				<tr>
					<td colspan="4"><img src="../resources/images/hoticon.png" class="hoticon"
						style="vertical-align: middle;" /> <span class="hotboardtitle"
						style="vertical-align: middle;"><strong>핫 게시판</strong></span>

						<hr></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
				<tr>
					<td><span class="category">카테고리</span></td>
					<td><a href="#" class="hotboardname">게시물 제목</a></td>
					<td><span><img class="likeimg" src="../resources/images/like.png" /></span></td>
					<td><span><img class="commentimg"
							src="../resources/images/comment.png" /></span></td>
				</tr>
			</table>
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