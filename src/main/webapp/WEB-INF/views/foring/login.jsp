<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<meta charset="UTF-8">
	<title>로그인</title>
	<link rel="stylesheet" href="../resources/css/login.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
	
		
		$(document).ready(function(e){
			
		let code = ""; 
		
			/* 버튼 호버 효과 */
			$(".btn").hover(function(e){
				$(this).addClass("hoverEffect");
// 				$("#"+e.target.id).addClass("hoverEffect");
			}, function(e){
				$(this).removeClass("hoverEffect");
// 				$("#"+e.target.id).removeClass("hoverEffect");
			});
			
			/*//////////////////////////////////////유효성 검사//////////////////////////////// */
			
			
			
			/* ///////////////////////////////////////////////////////////////////////////// */
			
			/* 로그인 정보 전송 */
			$("#loginbtn").on("click", function(e){
				
				alert(termsstr);
				alert("ok");
				
				e.preventDefault();
				
				$("#meminfoinput").serialize();
// 			    $("#meminfoinput").attr('method', 'POST');
			    $("#meminfoinput").attr('action', '${ctx}/foring/main');
				$("#meminfoinput").submit();
			});
			
			/* 회원가입 버튼 클릭 */
			$("#joinbtn").on("click", function(){
				location.href = "/foring/join";
			});
			
		});
		
	</script>
	</head>
	<body>
		<div class="joinback">
			<img class="joinbackimg" alt="../resources/images/no_img.png" src="../resources/images/loginjoinbackimg.png">
			<img class="joinforinglogo" alt="../resources/images/no_img.png" src="../resources/images/foringlogo.png">
			<div class="joinwhiteboard">
				<div class="jointext">
					<h1><strong>로그인</strong></h1>
				</div>
			</div>
			<div class="partition"></div>
			<div id="membersearch">
				<form id="meminfoinput" role="form" action="${ctx}/foring/main" method="post">
					<input type="email" id="email" name="email" maxlength="30" placeholder="이메일을 입력해주세요.">
					<div id="emailguide"></div>
					<input type="password" id="userpw" name="userpw" maxlength="30" placeholder="비밀번호를 입력해주세요.">
					<div id="userpwguide"></div>
					
					<div id="userpwcheckguide"></div>
				</form>
			</div>
			<div id="snsfuncbtn">
				<button type="button" class="btn" id="emailsearch">
					<span>계정 찾기</span>
				</button>
				<button type="button" class="btn" id="pwchg">
					<span>비밀번호 변경</span>
				</button>
				<button type="button" class="btn" id="joinbtn">
					<span>회원가입</span>
				</button>
				<img alt="../resources/images/no_img.png" src="../resources/images/kakaologinbtn.png" class="btn" id="kakaologinbtn">
				<img alt="../resources/images/no_img.png" src="../resources/images/naverloginbtn.png" class="btn" id="naverloginbtn">
				<img alt="../resources/images/no_img.png" src="../resources/images/googleloginbtn.png" class="btn" id="googleloginbtn">
			</div>
			<button type="button" class="btn" id="loginbtn" disabled="disabled">
				<span>로그인</span>
			</button>
		</div>
	</body>
</html>