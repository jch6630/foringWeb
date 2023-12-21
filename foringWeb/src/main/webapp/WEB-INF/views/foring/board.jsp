<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/board.css">
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var startPage = 0;
	    var endPage = 0;
	    var nowPageNum = $("#nowPageNum").val();
	    var category = $("#category").val();
	    var content = $("#content").val();
	
	    function loadBoardList() {
	        // Ajax 통신
	        $.ajax({
	            type: "POST",
	            url: "boardlist",
	            dataType: "json",
	            data: {
	                "category": category,
	                "nowPageNum": nowPageNum,
	                "content": content
	            },
	            success: function(responseData) {
	                var list = responseData.list;
	                var pageDto = responseData.listMaker;

	                console.log(list);
	                
	                // 게시판 목록 출력
	                if (Array.isArray(list)) {
	                    list.forEach(function(item) {
	                        var html = "<tr><td>" + item.boardid + "</td><td><a class='move' href='" + item.boardid + "'>" + item.boardtitle + "</a></td><td>" + item.usernick + "</td><td>" + item.viewCnt + "</td></tr>";
	                        $("#boardList").append(html);
	                    });
	                }

	                // 페이징 버튼 생성
	                renderPagingButtons(pageDto);

	                // 기타 UI 업데이트
	                $("#paging").css("top", ((list.length + 1) * 30) + 120 + "px");
	                $("#write").css("top", ((list.length + 1) * 30) + 120 + "px");
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
	
	    function getDetailNametext(category) {
	        switch (category) {
	            case "notice":
	                return "공지사항";
	            case "free":
	                return "자유게시판";
	            case "infor":
	                return "정보게시판";
	            case "study":
	                return "스터디모임게시판";
	            default:
	                return "";
	        }
	    }
	 // 페이징 버튼을 렌더링하는 함수
	    function renderPagingButtons(pageDto) {
	        // 기존 페이징 버튼 제거
	        $("#pagination").empty();

	        var prevHtml = pageDto.prev ? "<li id='prevBtn'><div class='pagingBtn'><</div></li>" : "<li id='nextBtn'><div class='pagingBtn' style='color:gray; outline: 1px solid gray; cursor: default; pointer-events: none;'><</div></li>";
	        $("#pagination").append(prevHtml);

	        var nowPageNum = 0;
	        var nowPageNumHtml = "";

	        startPage = pageDto.startPage;
	        endPage = pageDto.endPage;

	        for (var i = startPage; i <= endPage; i++) {
	            nowPageNum = i
	            nowPageNumHtml = "<li id='paginationBtn'><div class='pagingBtn' id='pagingBtn" + nowPageNum + "'>" + nowPageNum + "</div></li>"
	            $("#pagination").append(nowPageNumHtml);
	        }

	        var nextHtml = pageDto.next ? "<li id='nextBtn'><div class='pagingBtn'>></div></li>" : "<li id='nextBtn'><div class='pagingBtn' style='color:gray; outline: 1px solid gray; cursor: default; pointer-events: none;'>></div></li>";
	        $("#pagination").append(nextHtml);

	        $("#pagination").css("width", pageDto.next ? "360px" : (30 * (endPage - startPage + 3)) + "px");
	    }
	
	 	// 나머지 이벤트 핸들러 및 함수 등록
	    // 게시판 하위 메뉴 클릭시 페이지 변화
		$(".detailMenuBtn").on("click", function() {
		    if ($("#appendList")) {
		        $("#boardList").html("<tr><th>글 번호</th><th>제목</th><th>작성자</th><th>조회수</th></tr>");
		        $("#pagination").html("");
		    }
		
		    category = $(this).attr('data-value');
		
		    $("#detailNametext").text($(this).text())
		
		    $("#category").val(category);
		
		    loadBoardList();
		});
		
		// 페이징 버튼 클릭시 페이지 변화
		$(document).on("click", ".pagingBtn", function pagingBtnClick() {
		    if ($("#appendList")) {
		        $("#boardList").html("<tr><th>글 번호</th><th>제목</th><th>작성자</th><th>조회수</th></tr>");
		        $("#pagination").html("");
		    }
		
		    if ($(this).text() == "<") {
		        nowPageNum = startPage - 1;
		    } else if ($(this).text() == ">") {
		        nowPageNum = endPage + 1;
		    } else {
		        nowPageNum = parseInt($(this).text());
		    }
		
		    $("#nowPageNum").val(nowPageNum);
		
		    loadBoardList();
		});
		
		// 게시판 검색시 페이지 변화
		$(document).on("keyup", "#contentInput", function(key) {
		    if (key.keyCode == 13) {
		        if ($("#appendList")) {
		            $("#boardList").html("<tr><th>글 번호</th><th>제목</th><th>작성자</th><th>조회수</th></tr>");
		            $("#pagination").html("");
		        }
		
		        content = $("#contentInput").val();
		        nowPageNum = 1;
		
		        $("#nowPageNum").val(nowPageNum);
		        $("#content").val(content);
		
		        loadBoardList();
		    }
		});
		
		// 게시판 글 클릭 시 이동 처리
		$(document).on("click", ".move", function(e) {
			e.preventDefault();
	 		var actionForm = $("#boardActionForm");
// 			alert($(this).attr("href"));
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action", "${ctx}/foring/read");
			actionForm.submit();
		});
		
		// 글쓰기 버튼 클릭 시 처리
		$(document).on("click", "#writeBtn", function(e) {
		    e.preventDefault();
		    location.href = "board/write";
		});

    // 초기 로딩
    loadBoardList();
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
                <th>조회수</th>
            </tr>
        </table>
    </div>
    <div id="boardLastLine">
        <div style="width: 10%; height: 30px;"></div>
        <div id="paging">
            <ul id="pagination"></ul>
        </div>
        <div id="write">
            <button type="button" id="writeBtn">
                <span id="writeBtnText" title="WRITE">글쓰기</span>
            </button>
        </div>
    </div>

    <form action="" id="boardActionForm" method="get">
        <input type="hidden" id="nowPageNum" value="1">
        <input type="hidden" id="amount">
        <input type="hidden" id="category" value="notice">
        <input type="hidden" id="content">
        <input type="hidden" name="category" value="${category}">
    </form>
</section>

<%@ include file="../includes/footer.jsp" %>