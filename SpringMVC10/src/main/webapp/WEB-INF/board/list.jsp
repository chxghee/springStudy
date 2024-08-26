<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>    


<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript">
  
  
  $(document).ready(function(){
	 
	  var regForm = $("#regForm");
	  
	  $("button").on("click", function(e){		// 버튼에서 
		 
		  var oper = $(this).data("oper");		// oper의 값에 따라 if~~
		  if (oper == 'register') {
			  regForm.submit();		// 등록 버튼 누르면 form 을 submit 
		  }
		  else if (oper == 'reset') {
			  regForm[0].reset();
		  }
		  else if (oper == 'list') {	
			  location.href = "${cpath}/list";	// 리스트 요청 보내기
		  }
		  else if (oper == 'remove') {		// 삭제 눌리면 서버로 인덱스 값을  넘김 -> 처리 후 list 로 back 
			  var idx = regForm.find("#idx").val();
			  location.href= "${cpath}/remove?idx="+idx;	// 요청 get 방식으러 넘기기 
		  }
		  else if (oper == 'updateForm') {
			  regForm.find("#title").attr("readonly", false);
			  regForm.find("#content").attr("readonly", false);
			  
			  var updateBtn = "<button type= 'button' onclick='goUpdate()' data-oper= 'update' class= 'btn btn-sm btn-info'>수정하기</button>"
			  
			  $("#update").html(updateBtn);
			  
		  }
		 
		 
	  });
	  
	  // a tag 클릭 시 상세보기 구현 (a tag 클릭 시 href 경로로 넘어가지 않도록 해야함 기능막기 ))
	  $("a").on("click", function(e){
		 
		  e.preventDefault();	//  넘어온 이벤터 막기 
		  var idx = $(this).attr("href");
		  $.ajax({
			 
			  url : "${cpath}/get",
			  type : "get",
			  data : {"idx":idx},	// controller 에 전달하는 파라미터 
			  dataType : "json",	// 전달받는 data type ( json 으로 데이터를 받아 옴 ->  객체 바인딩을 해서 가져온것이아님 )
			  success : printBoard,
			  error : function(){ alert("error"); }
			  
			  
		  });
		  
	  });
	  
	  
  });
  
  function printBoard(vo) {
	
	  var regForm = $("#regForm");
	  
	  regForm.find("#idx").val(vo.idx);
	  regForm.find("#title").val(vo.title);
	  regForm.find("#content").val(vo.content);
	  regForm.find("#writer").val(vo.writer);
	  regForm.find("input").attr("readonly", true);
	  regForm.find("textarea").attr("readonly", true);
	  

	  $("#regDiv").css("display", "none");
	  $("#updateDiv").css("display", "block");

	
  }
  
  function goUpdate() {
	  regForm = $("#regForm");
	  
	  regForm.attr("action", "${cpath}/modify");
	  regForm.submit();
  }
  
  
  </script>
</head>
<body>
 
  <div class="card">
    <div class="card-header">
    
		<div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring WEB MVC</h1>
		    <p>Spring Boot로 게시판 만들어 보기</p>
		  </div>
		</div>

	</div>
    <div class="card-body">

		<h4 class= "card-title">Spring Boot</h4>
		
		<div class= "row">
			<div class="col-lg-2">
			
				<div class= "card" style= "min-height:500px; max-height: 1000px">
					<div class= "card-body">
						<h4 class= "card-title">GUEST</h4>
						<p class= "card-text">환영합니다!</p>
						
						<form action="">
						
							<div class= "form-group">
								<lable for= "title">아이디</lable>
								<input type= "text" class= "form-control" id ="memId"/>
							</div>
							
							<div class= "form-group">
								<lable for= "title">비밀번호</lable>
								<input type= "text" class= "form-control" id ="memId"/>
							</div>
							
							<button type= "button" class= "btn btn-sm btn-primary form-control">로그인</button>
						
						</form>
					</div>
				</div>
			
			</div>
			
			<div class="col-lg-5">
			
				<div class= "card" style= "min-height:500px; max-height: 1000px">
					<div class= "card-body">
						<table class = "table table-hover">
							<thead>
								<th>번호</th>
								<th>제목</th>
								<th>작성일</th>
							</thead>
							<tbody>
							
								<c:forEach var= "vo" items= "${list}">
								
									<tr>
										<td>${vo.idx}</td>
										<td><a href="${vo.idx}">${vo.title}</a></td>
										<td><fmt:formatDate pattern= "yyyy-MM-dd" value= "${vo.indate}"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			
			</div>
			
			<div class="col-lg-5">
			
				<div class= "card" style= "min-height:500px; max-height: 1000px">
				
					<div class="card-body">
		                <form id="regForm" action="${cpath}/register" method="post">
		                
		                <!--  상세보기를 했을 때 데이터를 json으로 받아왔음 그래서 객체 바인딩이 vo로 안되어 있는데, 그렇기 때문에 이렇게 히든으러 인덱스 값을 가져옹 -->
		                 <input type="hidden" id="idx" name="idx" value="${vo.idx}"/>
		                
		                 <div class="form-group">
		                    <label for="memId">제목:</label>
		                    <input type="text" class="form-control" id="title" name="title" placeholder="Enter title"/>                    
		                 </div>
		                 <div class="form-group">
		                    <label for="content">내용:</label>
		                    <textarea rows="9" class="form-control" id="content" name="content"></textarea>                    
		                 </div>
		                 <div class="form-group">
		                    <label for="writer">작성자:</label>
		                    <input type="text" class="form-control" id="writer" name="writer" placeholder="Enter writer"/>                    
		                 </div>     
		                 <div id="regDiv">            
		                  <button type="button" data-oper="register" class="btn btn-sm btn-primary">등록</button>
		                  <button type="button" data-oper="reset" class="btn btn-sm btn-warning">취소</button>                           
		                 </div>
		                 
		                 <div id="updateDiv" style="display: none">            
		                  <button type="button" data-oper="list" class="btn btn-sm btn-primary">목록</button>
                  			<span id="update"><button type="button" data-oper="updateForm" class="btn btn-sm btn-success">수정</button></span>
		                  <button type="button" data-oper="remove" class="btn btn-sm btn-warning">삭제</button>                           
		                 </div>
		                 
		                 
		               </form>            
		             </div>
				</div>
			
			</div>
		
		</div>



	</div> 
    <div class="card-footer">스프링 부트 공부하기</div>
  </div>


</body>
</html>
