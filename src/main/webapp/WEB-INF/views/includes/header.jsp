<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Main Page</title>
	<link href="https://fonts.googleapis.com/css?family=Montserrat"
		rel="stylesheet">
	<link rel="stylesheet" href="../resources/css/foringCss.css">
	<link rel="stylesheet" href="../resources/css/footer.css">
	<style type="text/css">
	@-ms-viewport {
		width: device-width;
	}
	
	@-o-viewport {
		width: device-width;
	}
	
	@viewport {
		width: device-width;
	}
	</style>
	<script type="text/javascript"
		src="https://use.fontawesome.com/926fe18a63.js"></script>
	<script src="../resources/js/jquery-3.7.0.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(function() {
				$(".main_hamButton").click(function() {
					$(".mainmenu").slideToggle();
				});
			});
			$(".loginbutton").on("click", function(e){
				location.href = "/foring/main";
			});
		});
	</script>
	</head>
	<body>
		<header>
			<section class="hbody">
				<article class="mainbar">
					<div class="logo">
						<a href="/foring/main"><img class="logoimg" src="../resources/images/foringWebLogo.png" /></a>
					</div>
					<div class="mainbarspace"></div>
					<button type="button" class="main_hamButton">
						<span class="fa fa-bars" title=""></span>
					</button>
					<div class="mainmenu">
						<ul class="menu">
							<li class="mainmenucon"><a href="#">게시판</a></li>
							<div id="heightline"></div>
							<li class="mainmenucon"><a href="#">이력서</a></li>
							<div id="heightline"></div>
							<li class="mainmenucon"><a href="#">MyPage</a></li>
						</ul>
					</div>
					<div class="login">
						<button type="button" class="loginbutton">
							<span class="logintext" title="LOGIN">LOGIN</span>
						</button>
					</div>
					<div class="join">
						<button type="button" class="joinbutton">
							<span class="jointext" title="JOIN">JOIN</span>
						</button>
					</div>
				</article>
			</section>
		</header>

