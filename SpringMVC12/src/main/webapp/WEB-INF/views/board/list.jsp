<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html lang="en">
<head>
  <title>스프링 게시판 만들기</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"> 
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3d9c2b2eb69317bc722bc708c398732c"></script>
  
  <script type="text/javascript">
	
		$(document).ready(function(){
			
			var result = '${result}';		// RedirectAttributes rttr로 받은  게시물 인덱스를 변수에 저장
			checkModal(result);
			
	    	 
	    	$("#regBtn").click(function(){
	    		location.href="${cpath}/board/register";
	    	});   
	    	
	    	// 페이지 번호 클릭 시 이동 구현
	    	var pageFrm = $("#pageFrm");
	    	$(".paginate_button a").on("click", function(e){	// paginate_button 클래스의 하위 a 태그가 클릭되면 이벤트 e를 받아와서 함수 실행
	    	
	    		e.preventDefault();	// a tag의 기능을 막는 것 (a tag눌렀을 때 우선 서버로 전송 막기)
	    		
	    		var page=$(this).attr("href");		// a 태그의 href값 가져오기(페이지 번호 가져오기)
	    		pageFrm.find("#page").val(page);	// 히든으로 만들어 둔 form에 페이지 번호 넣어주기
	    		pageFrm.submit();					// sp08/board/list 로 get방식ㅇㄹ 넘김 
	    		
	    	});
	    	
	    	
	    	// 게시글 상세보기 클릿 시 리스트로 다시 이동 구현
	    	$(".move").on("click", function(e){
	    		
	    		e.preventDefault();
	    		
	    		var idx = $(this).attr("href");
	    		var tag = "<input type='hidden' name='idx' value='"+idx+"' />"
	    		
	    		pageFrm.append(tag);		// 히든 인퓻에 위의 태그 추가 
	    		pageFrm.attr("action", "${cpath}/board/get");	// 인풋의 액션을 get으러 넘어가도록 수정
	    		pageFrm.attr("method", "get");
	    		pageFrm.submit();
	    		
	    		
	    	});
	    	
	    	// 책 검색 버튼 클릭 
  			$("#search").click(function(){
	    		
	    		var bookname=$("#bookname").val();
	      		
	    		if (bookname==""){
	      			alert("책 제목을 입력하세요");
	      			return false;
	      		}

	    		
	    		// kakao 책 검색 opne API 연동 (키 발급)
	    		// app key: 96d1e7e5e978a280348387bfe620d7df
	    		// URL: "https://dapi.kakao.com/v3/search/book?target=title"
	    		// header: "Authorization: KakaoAK 96d1e7e5e978a280348387bfe620d7df"
	    		
	    		$.ajax({
	    			url : "https://dapi.kakao.com/v3/search/book?target=title",
	    			headers : {"Authorization" : "KakaoAK 96d1e7e5e978a280348387bfe620d7df"},
	    			type : "get",
	      			data : {"query" : bookname},
	      			dataType : "json",
	      			success : bookPrint,
	      			error : function(){ alert("error");}	
	    		});
	    		
	    		// ajax 실행시 start / stop -> 로딩 창 보여주기 
	    		$(document).ajaxStart(function(){ $(".loading-progress").show(); });
	      		$(document).ajaxStop(function(){ $(".loading-progress").hide(); });
	    	});
	    	
	    	
	    	// input box에 실시간 책 제목 검색
	    	$("#bookname").autocomplete({
	    		
	    		source : function(){
	    			
		    		var bookname=$("#bookname").val();
		    		
		    		$.ajax({
		    			url : "https://dapi.kakao.com/v3/search/book?target=title",
		    			headers : {"Authorization" : "KakaoAK 96d1e7e5e978a280348387bfe620d7df"},
		    			type : "get",
		      			data : {"query" : bookname},
		      			dataType : "json",
		      			success : bookPrint,
		      			error : function(){ alert("error");}	
		    		});
 
	    		},
	    		minLength : 1					// 최소 한 자 입력해야 실행
	    	});
	    	// 지도 검색 버튼 클릭스 지도 opne
	    	$("#mapBtn").click(function(){
	    		
	    		var address= $("#address").val();
	    		
	    		if (address=="") {
	    			alert("주소를 입력하세요.")
	    			return false
	    		}
	    		
	    		$.ajax({
	    			url : "https://dapi.kakao.com/v2/local/search/address.json",
	    			headers : { "Authorization" : "KakaoAK 96d1e7e5e978a280348387bfe620d7df"},
	    			type : "get",
	    			data : {"query" : address},
	    			dataType : "json",
	    			success : mapView,
	    			error : function() { alert("error"); }
	    		});
	    		
	    	});
			
		});
	
		
		function checkModal(result) {
			
			if (result== '') {
				return; 	// 여기서 리턴을 해 주어야 result 값이 없을 때 checkModal 함수가 끝남 
			}
			if (parseInt(result) > 0) {	// 새로운 글 등록 시 모달 창 띄우기 (parseInt = 숫자를 문자열로 ) 
				
				// modal body에 글 뿌려주기
				$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.")
			}
			$("#myModal").modal("show");
		}
		
		
		
		function goDeleteMsg() {
			
			alert("삭제된 게시물 입니다.")
		}
	
		function bookPrint(data) {
			var bList= "<table class= 'table table-hover'>";
			
			bList += "<thead>";
			bList += "<tr>";
			bList += "<th>책 표지</th>";
			bList += "<th>책 제목</th>";
			bList += "<th>책 가격</th>";
			bList += "</tr>";
			bList += "</thead>"
			
			bList += "<tbody>";
			$.each(data.documents, function(index, obj){
				
				var image = obj.thumbnail;
				var price = obj.price;
				var url = obj.url;
				var title = obj.title;
				
				bList += "<tr>";
				bList += "<td><a href= '"+url+"'><img src= '"+image+"' width='50px' height= '60px' /></a></td>";
				bList += "<td>"+title+"</td>";
				bList += "<td>"+price+"</td>";
				bList += "</tr>";
				
			});
			
			bList += "</body>"
			bList += "</table>"
			
			$("#bookList").html(bList);
		}
		
		function mapView(data) {
			
			var x = data.documents[0].x;	// 경도 받아오기 
			var y = data.documents[0].y;	// 위도 
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };

			// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(y, x); 

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
			var iwContent = '<div style="padding:5px;">${mvo.memName}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    content : iwContent,
			    removable : iwRemoveable
			});

			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function() {
			      // 마커 위에 인포윈도우를 표시합니다
			      infowindow.open(map, marker);  
			});

		}
	</script>


</head>
<body>
 

  <div class="card">
    <div class="card-header">
		<div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring MVC</h1>
		    <p>스프링 게시판으로 연습하기</p>
		  </div>
		</div>

	</div>
    
    <div class="card-body">

		<div class="row">
		  <div class="col-lg-2">
			<jsp:include page="left.jsp"/>

		</div>
		  <div class="col-lg-7">
		  	

		<table class= "table table-hover">
		
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			
			</thead>
			
			<c:forEach var= "vo" items= "${list}">
				<tr>
					<td>${vo.idx}</td>
					<td>
					
					<!--  답글 들여쓰기 -->
					<c:if test="${vo.boardLevel>0}">
						<c:forEach begin= "1" end= "${vo.boardLevel}">
							<span style= "padding-left: 15px"></span>
						
						</c:forEach>
            		  <i class="bi bi-arrow-return-right"></i>           	
					</c:if>
					
					<!--  답글이면 RE  -->
					<c:if test= "${vo.boardLevel>0}">
					
						<c:if test= "${vo.boardAvailable==1}">
							<a class ="move" href = "${vo.idx}"><c:out value="[RE]: ${vo.title}"/></a>
						</c:if>
						
						<c:if test= "${vo.boardAvailable==0}">
							<a href = "javascript:goDeleteMsg()">[RE]: 삭제된 게시물 입니다.</a>
						</c:if>
						
					</c:if>
					
					<!--  원글  -->
					<c:if test= "${vo.boardLevel == 0}">
						<c:if test= "${vo.boardAvailable==1}">
							<a class ="move" href = "${vo.idx}"><c:out value="${vo.title}"/></a>	<!-- get 방식으로 컨트롤러에 넘김  -->
						</c:if>
						
						<c:if test= "${vo.boardAvailable==0}">
							<a href = "javascript:goDeleteMsg()">삭제된 게시물 입니다.</a>	<!-- 삭제된 게시물일 경우 모달창   -->
						</c:if>
					</c:if>
					</td>
					<td>${vo.writer}</td>
					<td><fmt:formatDate pattern= "yyyy-MM-dd" value="${vo.indate}"/></td>
					<td>${vo.count}</td>
				</tr>
			</c:forEach>
			
			<c:if test="${!empty mvo}">
				<tr>
					<td colspan="5">
						<button id= "regBtn" class = "btn btn-sm btn-primary pull-right">글쓰기</button>
					</td>
				</tr>
			</c:if>
			
		</table>
		
		<!--  검색 -->
		<form class="form-inline" action="${cpath}/board/list" method= "post">
			
			<div class= "container">
			<div class="input-group mb-3 pagenation justify-content-center">
			
				<div class="input-group-append">
			    	<select name= "type" class= "form-control">
				    	<option value= "writer" ${pageMaker.cri.type=='writer' ? 'selected' : ''} >이름</option>
				    	<option value= "title" ${pageMaker.cri.type=='title' ? 'selected' : ''}>제목</option>
				    	<option value= "content" ${pageMaker.cri.type=='content' ? 'selected' : ''}>내용</option>
				    </select>
			  	</div>
			
		   	 <input type="text" class="form-control" name="keyword" value= "${pageMaker.cri.keyword}">
			  	<div class="input-group-append">
			   		<button class="btn btn-success" type="submit">Search</button>
			  	</div>
			</div>
			</div>
		</form>
		
		
		<!-- 페이징 처리 부분 추가 -->
		
		<ul class="pagination justify-content-center">
		  
		
		
		<!--  이전페이지 처리 -->
			<c:if test= "${pageMaker.prev}">
				<li class= "paginate_button previous page-item">
					<a class= "page-link" href="${pageMaker.startPage - 1}">이전</a>
				</li>
			
			</c:if>
		
		
		<!--  페이지 번호 처리 -->
			<c:forEach var= "pageNum" begin= "${pageMaker.startPage}" end= "${pageMaker.endPage}">
				
					<li class= "paginate_button ${pageMaker.cri.page == pageNum ? 'active' : ''} page-item" ><a class= "page-link" href="${pageNum}">${pageNum}</a></li>
				
			 		
				
			 	
			</c:forEach>
		<!--  다음페이지 처리 -->
			<c:if test= "${pageMaker.next}">
				<li class= "paginate_button next page-item">
					<a class= "page-link" href="${pageMaker.endPage + 1}">다음</a>
				</li>
			
			</c:if>
		
		</ul>
		
		
		<form id = "pageFrm" action= "${cpath}/board/list" method= "post">
		
		<!--  게시물 번허 (idx) 추기 -->
		
			<input type= "hidden" id= "page" name= "page" value= "${pageMaker.cri.page}"/>
			<input type= "hidden" name= "perPageNum" value= "${pageMaker.cri.perPageNum}"/>
			
			<input type= "hidden" name= "type" value= "${pageMaker.cri.type}"/>
			<input type= "hidden" name= "keyword" value= "${pageMaker.cri.keyword}"/>
			
		
		</form>
		

	<!--  modal  -->
		<div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title">알림</h4>
		      
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      <div class="modal-body">

		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
		<!--  modal  -->
		
	

		  </div>
		  <div class="col-lg-3">
			<jsp:include page="right.jsp"/>
		</div>
		</div>


	</div> 
    
    <div class="card-footer">답변기능 게시판 만들기</div>
  </div>


</body>
</html>
