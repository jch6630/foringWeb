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
	<title>회원가입</title>
	<link rel="stylesheet" href="../resources/css/join.css">
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
			
			
			/* 회원가입 버튼 활성화 */ 
			
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
			
			/* 회원가입 정보 전송 */
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
				
				e.preventDefault();
				
				$("#meminfoinput").serialize();
// 			    $("#meminfoinput").attr('method', 'POST');
			    $("#meminfoinput").attr('action', '${ctx}/foring/login');
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
					<h1><strong>회원가입</strong></h1>
				</div>
			</div>
			<div class="terms">
				<table class="termstable">
					<tr>
						<td><strong>필수동의 항목 및 개인정보 수집 및 이용 동의(선택),<br>
						 광고성 정보 수신(선택)에 모두 동의합니다.</strong></td>
						<td><input type="checkbox" name="termsstr" class="allcheck"></td>
					</tr>
					<tr>
						<td><span>[필수]</span> 만 15세 이상입니다.</td>
						<td><input type="checkbox" id="t1" name="termsstr" value="t1"></td>
					</tr>
					<tr>
						<td>
							<span>[필수]</span> 이용약관 동의 
							<button type="button" class="popupBtn" id="popupBtn2">
								<div class="btnWrap" id="btnWrap2">
									》 내용보기
								</div>
							</button>
						</td>
						<td><input type="checkbox" id="t2" name="termsstr" value="t2"></td>
					</tr>
					<tr>
						<td>
							<span>[필수]</span> 개인정보 수집 및 이용동의
							<button type="button"class="popupBtn" id="popupBtn3">
								<div class="btnWrap" id="btnWrap3">
									》 내용보기
								</div>
							</button>
						</td>
						<td><input type="checkbox" id="t3" name="termsstr" value="t3"></td>
					</tr>
					<tr>
						<td>
							[선택] 광고성 정보 이메일 수신 동의
							<button type="button"class="popupBtn" id="popupBtn4">
								<div class="btnWrap" id="btnWrap4">
									》 내용보기
								</div>
							</button>
						</td>
						<td><input type="checkbox" id="t4" name="termsstr" value="t4"></td>
					</tr>
					<tr>
						<td>
							[선택] 광고성 정보 SMS수신 동의
							<button type="button"class="popupBtn" id="popupBtn5">
								<div class="btnWrap" id="btnWrap5">
									》 내용보기
								</div>
							</button>
						</td>
						<td><input type="checkbox" id="t5" name="termsstr" value="t5"></td>
					</tr>
				</table>
			</div>
			<div class="partition"></div>
			<div id="memberinfo">
				<form id="meminfoinput" role="form" action="${ctx}/foring/login" method="post">
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
				<span>회원가입</span>
			</button>
			<div id="t2modal">
			<button type="button" class="closeBtn" id="closeBtn2">&times;</button>
<textarea rows="100" cols="10" readonly="readonly">
서비스 이용약관 （상품，서비스 등 이용 일반 회원용）
제1조 （목적）
1.	본 약관은 포링가 운영하는 온라인 쇼핑몰 '포림 □http'/foring.com□'에서 제공하는 서비스 （이하 '서비
스'라 합니다） 를 이용함에 있어 당사자의 권리 의무 및 책임사항을 규정하는 것을 목적으로 합니다.
2.	PC통신，무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 본 약관을 준용합니다.
제2조 （정의）
1.	'회사'라 함은，'포링’가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하
여 재화등을 거래할 수 있도록 설정한 가상의 영업장을 운영하는 사업자를 말하며，아울러 ’포링
  http://foring.com  '을 통해 제공되는 전자상거 래 관련 서 비스의 의미로도 사용합니 다.
2.	'이용자’라 함은，'사이트’에 접속하여 본 약관에 따라 '회사’가 제공하는 서비스를 받는 회원 및 비회원을
말합니다.
3.	'회원'이라 함은，’회사’에 개인정보를 제공하고 회원으로 등록한 자로서，'회사’의 서비스를 계속하여 이용
할 수 있는 자를 말합니 다.
4.	'비회원’이라 함은，회원으로 등록하지 않고，'회사'가 제공하는 서비스를 이용하는 자를 말합니다.
5.	'상품'이라 함은 '사이트'를 통하여 제공되는 재화 또는 용역을 말합니다.
6.	'구매자’라 함은 '회사가 제공하는 '상품’에 대한 구매서비스의 이용을 청약한 '회원’ 및 '비회원’을 말합니
다.
제3조 （약관 외 준칙）
본 약관에서 정하지 아니한 사항은 법령 또는 회사가 정한 서비스의 개별 약관，운영정책 및 규칙 （이하
'세부지침'이라 합니다） 의 규정에 따릅니다. 또한 본 약관과 세부지침이 충돌할 경우에는 세부지침이 우
선합니다.
제4조 （약관의 명시 및 개정）
1.	'회사'는 이 약관의 내용과 상호 및 대표자 성명，영업소 소재지，전화번호，모사전송번호（FAX）, 전자우편
주소，사업자등록번호，통신판매업신고번호 등을 이용자가 쉽게 알 수 있도록 ’회사’ 홈페이지의 초기 서
비스화면에 게시합니다. 다만 본 약관의 내용은 '이용자’가 연결화면을 통하여 확인할 수 있도록 할 수 있
습니다.
2.	'회사'는 '이용자가 약관에 동의하기에 앞서 약관에 정해진 내용 중 청약철회，배송책임，환불조건 등과 같
은 내용을 ’이용자'가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 통하여 '이용자’의 확인을 구
합니다.
3.	'회사'는 '전자상거래 등에서의 소비자보호에 관한 법률'，’약관의 규제에 관한 법률’，’전자거래기본법'，'정
보통신망 이용촉진등에 관한 법률’，'소비자보호법' 등 관련법령 （이하 '관계법령'이라 합니다） 에 위배되지
않는 범위내에서 본 약관을 개정할 수 있습니다.
4.	'회사’가 본 약관을 개정하고자 할 경우, 적용일자 및 개정사유를 명시하여 현행약관과 함께 온라인 쇼핑
몰의 초기화면에 그 적용일자 7일전부터 적용일자 전날까지 공지합니다. 다만, '이용자'에게 불리한 내용
으로 약관을 변경하는 경우 최소 30일 이상 유예기간을 두고 공지합니다.
5.	'회사'가 본 약관을 개정한 경우, 개정약관은 적용일자 이후 체결되는 계약에만 적용되며 적용일자 이전
체결된 계약에 대해서는 개정 전 약관이 적용됩니다. 다만, 이미 계약을 체결한 '이용자|가 개정약관의 내
용을 적용받고자하는뜻을 '회사'에 전달하고 ’회사'가 여기에 동의한 경우 개정약관을 적용합니다.
6.	본 약관에서 정하지 아니한 사항 및 본 약관의 해석에 관하여는 관계법령 및 건전한 상관례에 따릅니다.
제5조（제공하는 서비스）
'회사'는 다음의 서 비스를 제공합니 다.
1.	결제대금 보호서비스, 이용자 문의서비스, 상품 구매평 등 기타 정보 제공
2.	직접 또는 제휴사와 공동으로 제공하는 이 벤트 등
3.	기타 '회사'가 정하는업무
제6조（서 비스의 중단 등）
1.	'회사|가 제공하는 서비스는 연중무휴, 1일 24시간 제공을 원칙으로 합니다. 다만 '회사| 시스템의 유지 •
보수를 위한 점검, 통신장비의 교체 등 특별한 사유가 있는 경우 서비스의 전부 또는 일부에 대하여 일시
적 인 제공 중단이 발생할 수 있습니다.
2.	|회사'는 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우, 전
기통신사업법에 의한 기간통신사업자가 전기통신서비스를 중지하는 등 부득이한 사유가 발생한 경우 서
비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다.
3.	'쇼핑몰'은 재화 또는 용역이 품절되거나 상세 내용이 변경되는 경우 장차 체결되는 계약에 따라 제공할 재
화나 용역의 내용을 변경할 수 있습니다. 이 경우 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여
즉시 공지합니다.
4.	'회사가 서비스를 정지하거나 이용을 제한하는 경우 그 사유 및 기간, 복구 예정 일시 등을 지체 없이 '이
용자'에게 알립니다.
제 7조 （회원가입）
1.	'회사'가 정한 양식에 따라 '이용자'가 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로써
회원가입을 신청합니다.
2.	|회사'는 전항에 따라 회원가입을 신청한 |이용자' 중 다음 각호의 사유가 없는 한 '회원'으로 등록합니다.
가. 가입신청자가 본 약관에 따라 회원자격을 상실한 적이 있는 경우. 다만, '회사'의 재가입 승낙을 얻은
경우에는 예외로 합니다.
나. 회원정보에 허위, 기재누락, 오기 등 불완전한 부분이 있는 경우
다. 기타 회원으로 등록하는 것이 '회사'의 운영에 현저한 지장을 초래하는 것으로 인정되는 경우
3.	회원가입 시기는 |회사'의 가입승낙 안내가 |회원'에게 도달한 시점으로 합니다.
제8조（회원탈퇴 및 자격상실 등）
1.	|회원'은 '회사'에 언제든지 탈퇴를 요청할 수 있으며, |회사’는 지체없이 회원탈퇴 요청을 처리합니다. 다만
이미 체결된 거래계약을 이행할 필요가 있는 경우에는 본약관이 계속 적용됩니다.
2.	'쇼핑몰'은 다음 각호의 사유가 발생한 경우 |회사’의 자격을 제한 또는 정지시킬 수 있습니다.
가. 회원가입 시 허위정보를 기재한 경우
나. 다른 이용자의 정상적인 이용을 방해하는 경우
다. 관계법령 또는 본 약관에서 금지하는 행위를 한 경우
라. 공서 양속에어긋나는 행위를 한 경우
마. 기타 '회원'으로 등록하는 것이 적절하지 않은 것으로 판단되는 경우
3.	'회사’의 서비스를 1년 동안 이용하지 않는 '회원'의 경우 휴면계정으로 전환하고 서비스 이용을 제한할 수
있습니다.
4.	휴면계정 전환 시 계정 활성을 위해 필요한 아이디（ID）, 비밀번호, 이름, 중복가입 방지를 위한 본인 인증
값（DI）, 휴대전화 번호를 제외한 나머지 정보는 삭제됩니다. 다만, 관계법령에 의해 보존할 필요가 있는
경우 '회사'는 정해진 기간 동안 회원정보를 보관합니다.
제9조（회원에 대한 통지）
1.	'회사'는 '회원’ 회원가입 시 기재한 전자우편, 이동전화번호, 주소 등을 이용하여 '회원|에게 통지 할 수 있
습니다.
2.	'회사'가 불특정 다수 '회원'에게 통지하고자 하는 경우 1주일 이상 '사이트’의 게시판에 게시함으로써 개별
통지에 갈음할 수 있습니다. 다만 _회원'이 서비스를 이용함에 있어 중요한 사항에 대하여는 개별 통지합
니다.
제 10조 （구매신청）
'이용자|는 온라인 쇼핑몰 상에서 다음 방법 또는 이와 유사한 방법에 따라 구매를 신청할 수 있으며, |회
사'는 '이용자'를 위하여 다음 각호의 내용을 알기 쉽게 제공하여야 합니다.
1.	재화 또는 용역의검색및선택
2.	성명，주소, 연락처, 전자우편주소 등 구매자 정보 입력
3.	약관내용, 청약철회가 제한되는 서비스, 배송료 등 비용부담과 관련된 내용에 대한 확인 및 동의 표시
4.	재화 또는 용역 등에 대한 구매신청 및 확인
5.	결제방법선택및결제
6.	|회사'의최종 확인
제11조（계약의 성립）
1.	'회사’는 다음 각호의 사유가 있는 경우 본 약관의 '구매신청' 조항에 따른 구매신청을 승낙하지 않을 수 있
습니다.
가. 신청 내용에 허위, 누락, 오기가 있는 경우
나. 회원자격이 제한 또는 정지된 고객이 구매를 신청한 경우
다. 재판매, 기타 부정한 방법이나 목적으로 구매를 신청하였음이 인정되는 경우
라. 기타 구매신청을 승낙하는 것이 '회사'의 기술상 현저한 지장을 초래하는 것으로 인정되는 경우
2.	'회사’의 승낙이 본 약관의 '수신확인통지' 형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니
다.
3.	'회사|가 승낙의 의사표시를 하는 경우 이용자의 구매신청에 대한 확인 및 판매가능여부, 구매신청의 정정
및 취소 등에 관한 정보가 포함되어야 합니다.
제12조（결제방법 및 일반회원의 이용 수수료）
1.	'회사’의 '사이트'에서 구매한 상품에 대한 대금은 다음 각호의 방법으로 결제할 수 있습니다.
가. 폰뱅킹, 인터넷뱅킹 등각종 계좌이체
2.	|회사|는 '구매자가 결제수단에 대한 정당한 사용권한을 가지고 있는지 여부를 확인할 수 있으며, 이에 대
한 확인이 완료될 때까지 거래 진행을 중지하거나, 확인이 불가능한 거래를 취소할 수 있습니다.
3.	'회사'의 정책 및 결제업체（이동통신사, 카드회사 등） 또는 결제대행업체어여의 기준에 따라 이용자 당 월
누적 결제액 및 충전한도정당한사용권한을 가지고 있는지 여부를확인할수 있으며, 이에 대한 확인이 완
료될 때까지 거래 진행을 중지하거 나, 확인이 불가능한 거래를 취소할 수 있습니 다.
4.	'회사'의 정책 및 결제업체（이동통신사, 카드회사 등） 또는 결제대행업체어어의 기준에 따라 '구매자' 당
월 누적 결제액 및 충전한도가 제한될 수 있습니다.
5.	대금의 지급 또는 결제를 위하여 입력한 정보에 대한 책임은 '구매자|가 전적으로 부담합니다.
6.	일반회원은 회사의 서비스 이용대가로 수수료, 회원료 등 각 상품의 구매시 또는 별도로 회사가 정한 회사
가 정한 요율이 나 기준에 따라 서 비스 이용료를 지급해 야 합니 다.
제13조（수신확인통지，구매신청 변경 및 취소）
1.	'회사’는 |구매자가 구매신청을 한 경우 '구매자'에게 수신확인통지를 합니다.
2.	수신확인통지를 받은 '구매자'는 의사표시의 불일치가 있는 경우 수신확인통지를 받은 후 즉시 구매신청
내용의 변경 또는 취소를 요청할 수 있고, '회사'는 배송 준비 전 |구매자'의 요청이 있는 경우 지체없이 그
요청에 따라 변경 또는 취소처리 하여야합니다. 다만 이미 대금을 지불한 경우 본 약관의 '청약철회 등'에
서 정한 바에 따릅니다.
제14조（재화 등의 공급）
1.	'회사'는 별도의 약정이 없는 이상, '구매자가 청약을 한 날부터 7일 이내에 재화등을 배송할 수 있도록 주
문제작, 포장 등 기타 필요한 조치를 취합니다. 다만 '회사'가 이미 대금의 전부 또는 일부를 받은 경우에는
대금을 받은 날부터 3 영 업 일 이 내 에 필요한 조치 를 취합니 다.
2.	전항의 경우 '회사'는 '구매자가 상품 등의 공급 절차 및 진행 상황을 확인할 수 있도록 적절한 조치를 취해
야합니다.
제 15조 （환급）
'회사’는 '구매자’가 신청한 |상품'이 품절, 생산중단 등의 사유로 인도 또는 제공할 수 없게된 경우 지체
없이 그 사유를 '구매자'에게 통지합니다. 이 때 '구매자'가 재화 등의 대금을 지불한 경우 대금을 받은
날 부터 3 영업일 이내에 환급하거나 이에 필요한 조치를 취합니다.
제 16조（청약철회）
1.	|회사'와 재화 등의 구매에 관한 계약을 체결한 '구매자|는 수신확인의 통지를 받은 날부터 7일 이내에 청
약을 철회할 수 있습니다.
2.	다음 각호의 사유에 해당하는 경우, 배송받은 재화의 반품 또는 교환이 제한됩니다.
가. '구매자'에게 책임있는 사유로 재화 등이 멸실 또는 훼손된 경우（다만, 재화를 확인하기 위하여 포장
등을 훼손한 경우는 예외로 합니다）
나. '구매자1의 사용 또는 소비에 의하여 재화의 가치가현저히 감소한 경우
다. 시간의 경과로 재판매가 곤란할 정도로 재화의 가치가 현저히 감소한 경우
라. 같은 성능을 지 닌 재화 등으로 복제가 가능한 경우 그 원본이 되는 재화의 포장을 훼손한 경우
마. '구매자'의 주문에 의하여 개별적으로 생산한 상품으로서 청약철회 및 교환의 제한에 대하여 사전에
고지한 경우
3.	|회사’가 전항의 청약철회 제한 사유를 '구매자가 알기 쉽게 명시하거나, 시용상품을 제공하는 등의 조치
를 취하지 않은 경우 '구매자'의 청약철회가 제한되지 않습니다.
4.	'구매자'는 본조의 규정에도 불구하고 재화등의 내용이 표시, 광고내용과 다르거나 계약내용과 다르게 이
행된 때에는 당해 재화를 공급받은 날로부터 3월 이내, 그 사실을 안날 또는 알 수 있었던 날부터 30일 이
내에 청약철회 등을 할수 있습니다.
제17조（청약철회의 효과）
1.	'회사'는 ’구매자'로부터 재화 등을 반환 받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합
니다. 이때 '회사'가 '구매자'에게 재화등의 환급을 지연한 때에는 그 지연기간에 대하여 전자상거래법 시
행령 제21조의3 소정의 이율（연 15%）을곱하여 산정한 지연이자를 지급합니다.
2.	|회사|는 위 재화를 환급함에 있어서 |구매자'가 신용카드 또는 전자화폐 등의 결제수단을 사용한 경우에는
지체없이 당해 결제수단을 제공한 사업자로 하여금 재화등의 대금 청구를 정지 또는 취소하도록 요청합
니다.
3.	청약철회의 경우 공급받은 재화등의 반환에 필요한 비용은 '구매자|가부담합니다. 다만, 재화등의 내용이
표시 • 광고내용과 다르거나 계약내용과 다르게 이행되어 청약철회를 하는 경우 재화 등의 반환에 필요한
비용은'회사가 부담합니다.
4.	|회사|는 청약철회시 배송비 등 제반 비용을 누가 부담하는지 _구매자'가 알기 쉽도록 명확하게 표시합니
다.
제 18조（개인정보보호）
1.	'회사'는 '구매자|의 정보수집시 다음의 필수사항 등 구매계약 이행에 필요한 최소한의 정보만을 수집합니
성명
주민등록번호 또는 외 국인등록번호
주소
전화번호（또는 이 동전화번호）
아이디 （ID）
비밀번호
전자우편 （e-mail） 주소
2.	'회사'가 개인정보보호법 상의 고유식별정보 및 민감정보를 수집하는 때에는 반드시 대상자의 동의를 받
습니다.
3.	|회사'는 제공된 개인정보를 '구매자'의 동의 없이 목적외 이용, 또는 제3자 제공할 수 없으며 이에 대한 모
든 책임은 '회사가 부담합니다. 다만 다음의 경우에는 예외로 합니다.
가. 배송업무상 배송업체에게 배송에 필요한 최소한의 정보（성명, 주소, 전화번호）를 제공하는 경우
나. 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로
다가나 다라 마 바사
제공하는 경우
다. 재화 등의 거래에 따른 대금정산을 위하여 필요한 경우
라. 도용방지를 위하여 본인 확인이 필요한 경우
마. 관계법령의 규정에 따른 경우
제19조（'회사'의 의무）
1.	|회사'는 관계법령, 본 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 약관이 정하는 바에 따
라 지속적 • 안정적으로 재화 및 용역을 제공하는데 최선을 다하여야 합니다.
2.	|회사’는 '이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 개인정보（신용정보 포함）보호를 위한 보
안 시스템을 갖추어 야 합니 다.
3.	|회사가 상품에 대하여 |표시 • 광고의 공정화에 관한 법률' 제3조 소정의 부당한 표시 • 광고행위를 하여
|이용자'가손해를 입은 때에는 이를 배상할 책임을 집니다.
4.	|회사'는 ’이용자1익 수신동의 없이 영 리목적으로 광고성 전자우편, 휴대전화 메시지, 전화, 우편 등을 발송
하지 않습니다.
제20조（이용자 및 회원의 의무）
1.	'이용자'는 회원가입 신청 시 사실에 근거하여 신청서를 작성해야 합니다. 허위, 또는 타인의 정보를 등록
한 경우 '회사'에 대하여 일체의 권리를 주장할수 없으며, '회사'는 이로 인하여 발생한손해에 대하여 책임
을 부담하지 않습니다.
2.	|이용자'는 본 약관에서 규정하는 사항과 기타 *회사'가 정한 제반 규정 및 공지사항을 준수하여야 합니다.
또한 '이용자'는 '회사*의 업무를 방해하는 행위 및 ’회사'의 명예를훼손하는 행위를하여서는 안 됩니다.
3.	'이용자'는 주소, 연락처, 전자우편 주소 등 회원정보가 변경된 경우 즉시 이를 수정해야 합니다. 변경된 정
보를 수정하지 않거나 수정을 게을리하여 발생하는 책임은 '이용자'가 부담합니다.
4.	|이용자'는 다음의 행위를 하여서는 안됩니다.
가. '회사'에 게시된 정보의 변경
나. '회사'가 정한 정보 외의 다른 정보의 송신 또는 게시
다. '회사'및제3자의저작권등 지식재산권에대한 침해
라. ’회사’ 및 저13자의 명예를 훼손하거나 업무를 방해하는 행위
마. 외설 또는 폭력적인 메시지, 화상, 음성 기타 관계법령 및 공서양속에 반하는 정보를 '회사'의 '사이
트'에 공개 또는 게시하는 행위
5.	|회원|은 부여된 아이디（ID）와 비밀번호를 직접 관리해야합니다.
6.	|회원'이 자신의 아이디（ID） 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로
'회사'에 통보하고 안내에 따라야 합니다.
제21조（저작권의 귀속 및 이용）
1.	'쇼핑몰'이 제공하는 서비스 및 이와 관련된 모든 지식재산권은 '회사'에 귀속됩니다
2.	'이용자'는 '쇼핑몰'에게 지식재산권이 있는 정보를 사전 승낙없이 복제, 송신, 출판, 배포, 방송 기타 방법
에 의하여 영리목적으로 이용하거나, 저13자가 이용하게 하여서는 안됩니다.
3.	|이용자가 서비스 내에 게시한 게시물, 이용후기 등 콘텐츠（이하 '콘텐츠'）의 저작권은 해당 '콘텐츠'의 저
작자에게 귀속됩니다.
제22조（분쟁의 해결）
1.	'회사’는 '이용자'가 제기하는 불만사항 및 의견을 지체없이 처리하기 위하여 노력합니다. 다만 신속한 처
리가 곤란한 경우 '이용자'에게 그 사유와 처리일정을 즉시 통보해 드립니다.
2.	'회사|와 |이용자'간 전자상거래에 관한 분쟁이 발생한 경우, '이용자'는 한국소비자원, 전자문서 • 전자거래
분쟁조정위원회 등 분쟁조정기관에 조정을 신청할 수 있습니다.
3.	'회사'와 '이용자'간 발생한 분쟁에 관한 소송은 |회사' 소재지를 관할하는 법원을 저11심 관할법원으로 하
며, 준거법은 대한민국의 법령을 적용합니다.
부칙
제 1조（시행일）
본 약관은 2023.10.31부터 적용합니다.
</textarea>
</div>
			<div id="t3modal">
			<button type="button" class="closeBtn" id="closeBtn3">&times;</button>
<textarea rows="100" cols="10" readonly="readonly">
1. 개인정보의 수집항목 및 수집방법 
  포링사이트에서는 기본적인 회원 서비스 제공을 위한 
  필수정보로 실명인증정보와 가입정보로 구분하여 다음의 
  정보를 수집하고 있습니다. 
  필수정보를 입력해주셔야 회원 서비스 이용이 가능합니다.

  가. 수집하는 개인정보의 항목 
    * 수집하는 필수항목
      - 실명인증정보 : 이름, 휴대전화번호, 본인 인증 
      또는 I-PIN(개인식별번호), GPKI
      - 가입정보 : 아이디, 비밀번호, 성명, 이메일, 
      전화번호, 휴대전화번호, 기관명
    * 선택항목
      - 주소, 기관의 부서명
	
   [컴퓨터에 의해 자동으로 수집되는 정보]
   인터넷 서비스 이용과정에서 아래 개인정보 항목이 
   자동으로 생성되어 수집될 수 있습니다. 
    - IP주소, 서비스 이용기록, 방문기록 등
	
  나. 개인정보 수집방법
      홈페이지 회원가입을 통한 수집 

2. 개인정보의 수집/이용 목적 및 보유/이용 기간
  포링사이트에서는 정보주체의 회원 가입일로부터 서비스를 
  제공하는 기간 동안에 한하여 포링사이트 서비스를 
  이용하기 위한 최소한의 개인정보를 보유 및 이용 하게 
  됩니다. 
  회원가입 등을 통해 개인정보의 수집·이용, 제공 등에 
  대해 동의하신 내용은 언제든지 철회하실 수 있습니다. 
  회원 탈퇴를 요청하거나 수집/이용목적을 달성하거나 
  보유/이용기간이 종료한 경우, 사업 폐지 등의 사유발생시 
  개인 정보를 지체 없이 파기합니다.

  * 실명인증정보
    - 개인정보 수집항목 : 이름, 휴대폰 본인 인증 또는 
    I-PIN(개인식별번호), GPKI
    - 개인정보의 수집·이용목적   : 홈페이지 이용에 따른 
    본인 식별/인증절차에 이용
    - 개인정보의 보유 및 이용기간 : I-PIN / GPKI는 
    별도로 저장하지 않으며 실명인증용으로만 이용

  * 가입정보
    - 개인정보 수집항목 : 아이디, 비밀번호, 성명, 
    이메일, 전화번호, 휴대전환번호, 기관명
    - 개인정보의 수집·이용목적 : 홈페이지 서비스 이용 
    및 회원관리, 불량회원의 부정 이용방지, 민원신청 
    및 처리 등
    - 개인정보의 보유 및 이용기간 : 2년 또는 회원탈퇴시

  정보주체는 개인정보의 수집·이용목적에 대한 동의를 
  거부할 수 있으며, 동의 거부시 포링사이트에 회원가입이 
  되지 않으며, 포링사이트에서 제공하는 서비스를 
  이용할 수 없습니다.

3. 수집한 개인정보 제3자 제공
  포링사이트에서는 정보주체의 동의, 법률의 특별한 규정 등 
  개인정보 보호법 제17조 및 제18조에 해당하는 경우에만 
  개인정보를 제3자에게 제공합니다.
		
4. 개인정보 처리업무 안내
  포링사이트에서는 개인정보의 취급위탁은 하지 않고 있으며, 
  원활한 서비스 제공을 위해 아래의 기관을 통한 실명인증 
  및 공공 I-PIN, GPKI 인증을 하고 있습니다.
</textarea>
			</div>
			<div id="t4modal">
			<button type="button" class="closeBtn" id="closeBtn4">&times;</button>
<textarea rows="100" cols="10" readonly="readonly">
1. 광고성 정보의 이용목적
헤이버니가 제공하는 이용자 맞춤형 서비스, 뉴스레터 발송, 새로운 기능의 안내, 각종 경품 행사, 이벤트 등의 광고성 정보를 전자우편이나 서신우편, 문자(SMS), 푸시 등을 통해 이용자에게 제공합니다. 이메일 및 SMS 수신거부와 관계없이 광고나 영리성 목적 외의 약관안내 및 서비스내용, 회사의 주요 정책 관련 변경에 따른 안내 등 의무적으로 안내되어야 하는 메일은 정상적으로 발송됩니다.

마케팅 수신 동의는 거부하실 수 있으며 동의 이후에라도 고객의 의사에 따라 동의를 철회할 수 있습니다. 동의를 거부하시더라도 헤이버니가 제공하는 서비스의 이용에 제한이 되지 않습니다. 단, 이벤트 및 이용자 맞춤형 상품 추천 등의 마케팅 정보 안내 서비스가 제한됩니다.

이메일 수신동의를 하셨음에도 이메일을 받지 못하고 계신다면, 아래 내용을 확인해 주세요.

- 이메일 주소가 잘못 등록되어 있을 경우
- 해당 사이트 이메일이 스팸메일로 설정되어 있을 경우
- 위 사항을 점검했음에도 문제 해결이 안 되신 경우, 고객센터로 연락 주세요.

‘수신거부'로 변경하여도 수정 전에 예약발송 메일 또는 SMS가 설정되어 있어 약 일주일 동안은 메일 또는 SMS가 발송될 수 있습니다. 이 점 양해 부탁드립니다.

2. 미동의 시 불이익 사항
개인정보보호법 제22조 제5항에 의해 선택정보 사항에 대해서는 동의 거부하시더라도 서비스 이용에 제한되지 않습니다. 단, 이벤트 및 이용자 맞춤형 상품 추천 등의 마케팅 정보 안내 서비스가 제한됩니다.

‍3. 서비스 정보 수신 동의 철회
포링에서 제공하는 마케팅 정보를 원하지 않을 경우 jch6630@naver.com으로 철회를 요청할 수 있습니다.
</textarea>
			</div>
			<div id="t5modal">
			<button type="button" class="closeBtn" id="closeBtn5">&times;</button>
<textarea rows="100" cols="10" readonly="readonly">
1. 광고성 정보의 이용목적
헤이버니가 제공하는 이용자 맞춤형 서비스, 뉴스레터 발송, 새로운 기능의 안내, 각종 경품 행사, 이벤트 등의 광고성 정보를 전자우편이나 서신우편, 문자(SMS), 푸시 등을 통해 이용자에게 제공합니다. 이메일 및 SMS 수신거부와 관계없이 광고나 영리성 목적 외의 약관안내 및 서비스내용, 회사의 주요 정책 관련 변경에 따른 안내 등 의무적으로 안내되어야 하는 메일은 정상적으로 발송됩니다.

마케팅 수신 동의는 거부하실 수 있으며 동의 이후에라도 고객의 의사에 따라 동의를 철회할 수 있습니다. 동의를 거부하시더라도 헤이버니가 제공하는 서비스의 이용에 제한이 되지 않습니다. 단, 이벤트 및 이용자 맞춤형 상품 추천 등의 마케팅 정보 안내 서비스가 제한됩니다.

이메일 수신동의를 하셨음에도 이메일을 받지 못하고 계신다면, 아래 내용을 확인해 주세요.

- 이메일 주소가 잘못 등록되어 있을 경우
- 해당 사이트 이메일이 스팸메일로 설정되어 있을 경우
- 위 사항을 점검했음에도 문제 해결이 안 되신 경우, 고객센터로 연락 주세요.

‘수신거부'로 변경하여도 수정 전에 예약발송 메일 또는 SMS가 설정되어 있어 약 일주일 동안은 메일 또는 SMS가 발송될 수 있습니다. 이 점 양해 부탁드립니다.

2. 미동의 시 불이익 사항
개인정보보호법 제22조 제5항에 의해 선택정보 사항에 대해서는 동의 거부하시더라도 서비스 이용에 제한되지 않습니다. 단, 이벤트 및 이용자 맞춤형 상품 추천 등의 마케팅 정보 안내 서비스가 제한됩니다.

‍3. 서비스 정보 수신 동의 철회
포링에서 제공하는 마케팅 정보를 원하지 않을 경우 jch6630@naver.com으로 철회를 요청할 수 있습니다.
</textarea>
			</div>
		</div>
	</body>
</html>