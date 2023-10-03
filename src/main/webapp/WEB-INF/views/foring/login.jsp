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
		
			/* 유효성 검사 통과유무 변수 */
			let nameCheck = false;            // 이름
			let mailCheck = false;            // 이메일
			let mailnumCheck = false;        // 이메일 인증번호 확인
			let nickCheck = false;            // 아이디
			let pwCheck = false;            // 비번
			let pwckCheck = false;            // 비번 확인
			let pwckcorCheck = false;        // 비번 확인 일치 확인
			
			 /* 입력값 변수 */
	        let name = $('#username').val();            // 이름 입력란
	        let mail = $('#email').val();            // 이메일 입력란
	        let mailnum = $('#emailcheck').val();            // 이메일 인증번호 입력란
	        let nickname = $('#usernick').val();                 // nick 입력란
	        let pw = $('#userpw').val();                // 비밀번호 입력란
	        let pwck = $('#userpwcheck').val();            // 비밀번호 확인 입력란
        
			/* 약관 동의 전체 선택 */
			$(".allcheck").on("change", function(){
				if ($(this).is(":checked")) {
					$(".termstable input[type='checkbox']").prop('checked',true);
				}else {
					$(".termstable input[type='checkbox']").prop('checked',false);
				}
			});
			
			/* 버튼 호버 효과 */
			$(".btn").hover(function(e){
				$(this).addClass("hoverEffect");
// 				$("#"+e.target.id).addClass("hoverEffect");
			}, function(e){
				$(this).removeClass("hoverEffect");
// 				$("#"+e.target.id).removeClass("hoverEffect");
			});
			
			/*//////////////////////////////////////유효성 검사//////////////////////////////// */
			
			
			/* 이름 유효성 검사 */
			$("#username").on("keyup", function(){
				let username = $("#username").val();
				let blank_pattern = /[\s]/g;
				let special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
				
				if (username=="") {
					$("#usernameguide").html("※이름을 입력해주세요.");
					$("#usernameguide").css({
						"color" : "red"
					});
					nameCheck = false;
					return false;
				}
				if (blank_pattern.test(username) == true) {
					$("#usernameguide").html("※공백 없이 이름을 입력해주세요.");
					$("#usernameguide").css({
						"color" : "red"
					});
					nameCheck = false;
					return false;
				}
				if (special_pattern.test(username) == true) {
					$("#usernameguide").html("※이름에 특수문자가 입력되었습니다.");
					$("#usernameguide").css({
						"color" : "red"
					});
					nameCheck = false;
					return false;
				}
				else {
					$("#usernameguide").html("※이름이 입력되었습니다.");
					$("#usernameguide").css({
						"color" : "green"
					});
					nameCheck = true;
				}
			});
			/* 이메일 유효성 검사 */
			$("#emailnum").on("click", function(){
				let email = $("#email").val();
				let exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
				let emailcut = email.split("@");
				let domain = emailcut[1];
				
				//이메일에 @ 중복 입력이 있는지 검사
				if (emailcut.length != 2) {
					$("#emailguide").html("※이메일 형식이 올바르지 않습니다.");
					$("#emailguide").css({
						"color" : "red"
					});
					mailCheck = false;
					return false;
				}
				
				//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
				if(exptext.test(email)==false){
					$("#emailguide").html("※이메일 형식이 올바르지 않습니다.");
					$("#emailguide").css({
						"color" : "red"
					});
					mailCheck = false;
					return false;
				}
				
				//이메일이 공백일 경우
				if (email=="") {
					$("#emailguide").html("※이메일을 입력해 주세요.");
					$("#emailguide").css({
						"color" : "red"
					});
					mailCheck = false;
					return false;
				}
				
				//
				
				$.ajax({
			        
			        type:"GET",
			        url:"mailCheck?email=" + email,
			        success:function(data){
			            
// 			            console.log("data : " + data);
			        	code = data;
			        },
			        error:function(request,status,error){
			        	mailCheck = false;
			        	$("#emailguide").html("※올바른 이메일을 입력해 주세요.");
						$("#emailguide").css({
							"color" : "red"
						});
			        }
			    });
				
				$.ajax({
			        
			        type:"GET",
			        url:"domainCheck?domain=" + domain,
			        success:function(domainCheck){
			            
			            if (domainCheck) {
			            	$("#emailguide").html("※인증번호를 전송하였습니다.");
							$("#emailguide").css({
								"color" : "green"
							});
							mailCheck = true;
						} else {
							$("#emailguide").html("※올바른 이메일을 입력해 주세요.");
							$("#emailguide").css({
								"color" : "red"
							});
							mailCheck = false;
							return false;
						}
			        },
			        error:function(request,status,error){

			        	$("#emailguide").html("※올바른 이메일을 입력해 주세요.");
						$("#emailguide").css({
							"color" : "red"
						});
			        	mailCheck = false;
						return false;

			        }
			    });
				
				/* 재번송 버튼 클릭 */
				$("#emailnum").on("click", function(){
					$.ajax({
				        
				        type:"GET",
				        url:"domainCheck?domain=" + domain,
				        success:function(domainCheck){
				            
				            if (domainCheck) {
				            	$("#emailguide").html("※인증번호를 전송하였습니다.");
								$("#emailguide").css({
									"color" : "green"
								});
								mailCheck = true;
							} else {
								$("#emailguide").html("※올바른 이메일을 입력해 주세요.");
								$("#emailguide").css({
									"color" : "red"
								});
								mailCheck = false;
								return false;
							}
				        },
				        error:function(request,status,error){

				        	$("#emailguide").html("※올바른 이메일을 입력해 주세요.");
							$("#emailguide").css({
								"color" : "red"
							});
				        	mailCheck = false;
							return false;

				        }
				    });
				});
				
			});
			/* 인증번호 비교 */
			$("#emailnumcheck").on("click", function(){
			    
			    var inputCode = $("#emailcheck").val();        // 입력코드    
			    var checkResult = $("#emailcheckguide");    // 비교 결과     
			    
			    
			    if(inputCode == code){                            // 일치할 경우
			        checkResult.html("※인증되었습니다.");
			        checkResult.css({
						"color" : "green"
					});
			        mailnumCheck = true;
			    } else {                                            // 일치하지 않을 경우
			        checkResult.html("※인증번호를 다시 확인해주세요.");
			        checkResult.css({
						"color" : "red"
					});
			        mailnumCheck = false;
					return false;
			    }    
			    
			});
			
			/* 닉네임 유효성 검사 */
			$('#usernickcheck').on("click", function(){
				
				let nickLength = 0;
				let engCheck = /[a-z]/;
				let numCheck = /[0-9]/;
				let specialCheck = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
				//한글, 영문 길이 2,1로 바꾸기
			      for(var i=0; i < $('#usernick').val().length; i++){ //한글은 2, 영문은 1로 치환
	
			         nick = $('#usernick').val().charAt(i);
	
			         if(escape(nick).length >4){
	
			            nickLength += 2;
	
			         }else{
	
			            nickLength += 1;
	
			         }
	
			      }
			            
			      //닉네임 필수 입력
			      if ($('#usernick').val() == null || $('#usernick').val() == "") {
	
			         	$("#nickguide").html("※닉네임 입력은 필수입니다.");
						$("#nickguide").css({
							"color" : "red"
						});
						nickCheck = false;
						return false;
	
			      } 
			      //닉네임 빈칸 포함 안됨
			      else if ($('#usernick').val().search(/\s/) != -1) {
	
			         	$("#nickguide").html("※닉네임은 빈 칸을 포함 할 수 없습니다.");
						$("#nickguide").css({
							"color" : "red"
						});
						nickCheck = false;
						return false;
	
			      }
			      //닉네임 한글 1~10자, 영문 및 숫자 2~20자   
			      else if (nickLength<2 || nickLength>20) {
	
			         	$("#nickguide").html("※닉네임은 한글 1~10자, 영문 및 숫자 2~20자 입니다.");
						$("#nickguide").css({
							"color" : "red"
						});
						nickCheck = false;
						return false;
			         
	
			      } 
			      //닉네임 특수문자 포함 안됨   
			      else if (specialCheck.test(nickname)) {
	
					 	$("#nickguide").html("※닉네임은 특수문자를 포함 할 수 없습니다.");
						$("#nickguide").css({
							"color" : "red"
						});
						nickCheck = false;
						return false;
	
			      } 
			      //닉네임 중복확인
			      else {
						
			    	  let usernick = $('#usernick').val();
			    	    
						$.ajax({
			                type: 'POST',
			                url: 'checkJoinNick',
			                data: {
			                    "usernick" : usernick
			                },
			                success: function(data){
			                    if(data > 0){
			                    	$("#nickguide").html("※이미 등록된 닉네임 입니다.");
									$("#nickguide").css({
										"color" : "red"
									});
									nickCheck = false;
									return false;
			                    }
			                    else{
			                    	$("#nickguide").html("※사용할 수 있는 닉네임 입니다.");
									$("#nickguide").css({
										"color" : "green"
									});
									nickCheck = true;
			                    }
			                },
			                error: function() {
			                    alert("에러 발생");
			                }
			            });  
						
					}
				});
		     	
			/* 비밀번호 유효성 검사 */
			$("#userpw").on("keyup", function(){
				 let num = $("#userpw").val().search(/[0-9]/g);
				 let eng = $("#userpw").val().search(/[a-z]/ig);
				 let spe = $("#userpw").val().search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
				 
				if($("#userpw").val().length < 8 || $("#userpw").val().length > 20){
					$("#userpwguide").html("※8자리 ~ 20자리 이내로 입력해주세요.");
					$("#userpwguide").css({
						"color" : "red"
					});
					pwCheck = false;
				  	return false;
				 }else if($("#userpw").val().search(/\s/) != -1){
					$("#userpwguide").html("※비밀번호는 공백 없이 입력해주세요.");
					$("#userpwguide").css({
						"color" : "red"
					});
					pwCheck = false;
				  	return false;
				 }else if(num < 0 || eng < 0 || spe < 0 ){
					$("#userpwguide").html("※영문,숫자, 특수문자를 혼합하여 입력해주세요.");
					$("#userpwguide").css({
						"color" : "red"
					});
					pwCheck = false;
				  	return false;
				 }else {
					$("#userpwguide").html("※사용할 수 있는 비밀번호입니다.");
					$("#userpwguide").css({
						"color" : "green"
					});
					pwCheck = true;
				    return true;
				 }
			});
			
			/* 비밀번호 확인 유효성 검사 */
			$("#userpwcheck").on("keyup", function(){
				if ($("#userpwcheck").val() != $("#userpw").val()) {
					$("#userpwcheckguide").html("※비밀번호와 일치하지 않습니다.");
					$("#userpwcheckguide").css({
						"color" : "red"
					});
					pwckCheck = false;
					pwckcorCheck = false;
				  	return false;
				} else {
					$("#userpwcheckguide").html("※비밀번호와 일치합니다.");
					$("#userpwcheckguide").css({
						"color" : "green"
					});
					pwckCheck = true;
					pwckcorCheck = true;
				}
			});
			
			
			/* 로그인 버튼 활성화 */ 
			
			$("#usernameguide, #emailguide, #emailcheckguide, #nickguide, #userpwguide, #userpwcheckguide").on("DOMSubtreeModified", function(){
				
				if (nameCheck && mailCheck && mailnumCheck && nickCheck && pwCheck && pwckCheck && pwckcorCheck && $("#t1").is(':checked') && $("#t2").is(':checked') && $("#t3").is(':checked')) {
		            $('#joinbtn').removeAttr("disabled");
		            $('#joinbtn').css({
						"background-color" : "#96aedc"
					});
		            $("#joinbtn").hover(function(e){
		            	$('#joinbtn').addClass("hoverEffect");
		            });
		        }
		        else if (!nameCheck || !mailCheck || !mailnumCheck || !nickCheck || !pwCheck || !pwckCheck || !pwckcorCheck) {
		            $('#joinbtn').attr('disabled', 'disabled');
		            $('#joinbtn').css({
						"background-color" : "gray"
					});
		            $("#joinbtn").hover(function(e){
		            	$('#joinbtn').removeClass("hoverEffect");
		            });
		        }
			});
			
			$("input[name=termsstr]").on("click", function(){
				if (nameCheck && mailCheck && mailnumCheck && nickCheck && pwCheck && pwckCheck && pwckcorCheck && $("#t1").is(':checked') && $("#t2").is(':checked') && $("#t3").is(':checked')) {
		            $('#joinbtn').removeAttr("disabled");
		            $('#joinbtn').css({
						"background-color" : "#96aedc"
					});
		            $("#joinbtn").hover(function(e){
		            	$('#joinbtn').addClass("hoverEffect");
		            });
		        }
		        else if (!nameCheck || !mailCheck || !mailnumCheck || !nickCheck || !pwCheck || !pwckCheck || !pwckcorCheck || $("#t1").not(':checked') || $("#t2").not(':checked') || $("#t3").not(':checked')) {
		            $('#joinbtn').attr('disabled', 'disabled');
		            $('#joinbtn').css({
						"background-color" : "gray"
					});
		            $("#joinbtn").hover(function(e){
		            	$('#joinbtn').removeClass("hoverEffect");
		            });
		        }
			});
				
			/* ///////////////////////////////////////////////////////////////////////////// */
			
			/* 로그인 정보 전송 */
			$("#joinbtn").on("click", function(e){
				
				let termsstr = "";
				
				if ($("#t1").is(':checked')) {
					termsstr = termsstr + $("#t1").val();
				}
				if ($("#t2").is(':checked')) {
					termsstr = termsstr + $("#t2").val();
				}
				if ($("#t3").is(':checked')) {
					termsstr = termsstr + $("#t3").val();
				}
				if ($("#t4").is(':checked')) {
					termsstr = termsstr + $("#t4").val();
				}
				if ($("#t5").is(':checked')) {
					termsstr = termsstr + $("#t5").val();
				}
				$('#meminfoinput').append("<input type='hidden' name='termsstr' value=" + termsstr + ">");
				
				
				alert(termsstr);
				alert("ok");
				
				e.preventDefault();
				
				$("#meminfoinput").serialize();
// 			    $("#meminfoinput").attr('method', 'POST');
// 			    $("#meminfoinput").attr('action', '${ctx}/foring/join');
				$("#meminfoinput").submit();
			});
			
			/* 모달 창 */
			$("#popupBtn2").on("click", function(e){
				$("#t2modal").css("display", "block");
				$("#btnWrap2").css({
					"color" : "black",
				});
				$("#popupBtn2").css({
					"outline" : "1px solid black"
				});
			});
			$("#popupBtn3").on("click", function(e){
				$("#t3modal").css("display", "block");
				$("#btnWrap3").css({
					"color" : "black",
				});
				$("#popupBtn3").css({
					"outline" : "1px solid black"
				});
			});
			$("#popupBtn4").on("click", function(e){
				$("#t4modal").css("display", "block");
				$("#btnWrap4").css({
					"color" : "black",
				});
				$("#popupBtn4").css({
					"outline" : "1px solid black"
				});
			});
			$("#popupBtn5").on("click", function(e){
				$("#t5modal").css("display", "block");
				$("#btnWrap5").css({
					"color" : "black",
				});
				$("#popupBtn5").css({
					"outline" : "1px solid black"
				});
			});
			
			$(".popupBtn").hover(function(e){
				$("#"+e.target.id).addClass("hoverEffect");
			}, function(e){
				$("#"+e.target.id).removeClass("hoverEffect");
			});
			
			$("#closeBtn2").on("click", function(e){
				$("#t2modal").css("display", "none");
				$("#btnWrap2").css({
					"color" : "blue",
				});
				$("#popupBtn2").css({
					"outline" : "1px solid blue"
				});
			});
			$("#closeBtn3").on("click", function(e){
				$("#t3modal").css("display", "none");
				$("#btnWrap3").css({
					"color" : "blue",
				});
				$("#popupBtn3").css({
					"outline" : "1px solid blue"
				});
			});
			$("#closeBtn4").on("click", function(e){
				$("#t4modal").css("display", "none");
				$("#btnWrap4").css({
					"color" : "blue",
				});
				$("#popupBtn4").css({
					"outline" : "1px solid blue"
				});
			});
			$("#closeBtn5").on("click", function(e){
				$("#t5modal").css("display", "none");
				$("#btnWrap5").css({
					"color" : "blue",
				});
				$("#popupBtn5").css({
					"outline" : "1px solid blue"
				});
			});
			
			$(".closeBtn").hover(function(e){
				$("#"+e.target.id).addClass("hoverEffect");
			}, function(e){
				$("#"+e.target.id).removeClass("hoverEffect");
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
			<div id="memberinfo">
				<form id="meminfoinput" role="form" action="${ctx}/foring/main" method="post">
					<input type="text" id="username" name="username" maxlength="10" placeholder="이름(실명)">
					<div id="usernameguide"></div>
					<input type="email" id="email" name="email" maxlength="30" placeholder="이메일">
					<button type="button" class="btn" id="emailnum"><span>인증번호 전송</span></button>
					<div id="emailguide"></div>
					<input type="text" id="emailcheck" maxlength="10" placeholder="인증번호">
					<button type="button" class="btn" id="emailnumcheck"><span>확인</span></button>
					<button type="button" class="btn" id="emailnumre"><span>재전송</span></button>
					<div id="emailcheckguide"></div>
					<input type="text" id="usernick" name="usernick" maxlength="10" placeholder="닉네임">
					<button type="button" class="btn" id="usernickcheck"><span>중복확인</span></button>
					<div id="nickguide"></div>
					<input type="password" id="userpw" name="userpw" maxlength="30" placeholder="비밀번호">
					<div id="userpwguide"></div>
					<input type="password" id="userpwcheck" maxlength="30" placeholder="비밀번호 확인">
					<div id="userpwcheckguide"></div>
				</form>
			</div>
			<button type="button" class="joinbtn" id="joinbtn" disabled="disabled">
				<span>로그인</span>
			</button>
		</div>
	</body>
</html>