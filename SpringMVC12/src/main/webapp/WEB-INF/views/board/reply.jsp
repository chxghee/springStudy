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
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"> 
  <script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button").on("click", function(event){
			
			var formData = $("#frm");
			var btn = $(this).data("btn");		// data-btn = "reply"	라서 reply값을 btn에 저장
			
			if (btn == 'reply'){
				formData.attr("action", "${cpath}/board/reply");
			}
			
			else if (btn == 'list') {
				
				var formDataList = $("#frmList");

				formDataList.attr("action", "${cpath}/board/list");
				formDataList.submit();
				return;
				
			} 
			else if (btn == 'reset'){
				
				formData[0].reset();
				return;
			}
			
			formData.submit();
			
		});
		
	});
	
	
	
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
		  	<form id= "frm" method = "post">
	
				<input type="hidden"  name= "page" value="<c:out value='${cri.page}'/>"/>
				<input type="hidden"  name= "perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>
					
				<input type="hidden"  name= "type" value="<c:out value='${cri.type}'/>"/>
				<input type="hidden"  name= "keyword" value="<c:out value='${cri.keyword}'/>"/>
				
			
				<input type= "hidden" id="idx" name= "idx" value= "${vo.idx}" />			<!-- 부모글의 idx -->
			
				<input type= "hidden" id="memID"  name= "memID" value ="${mvo.memID}" />	<!-- 히든으로 아이디 받아 놓기  -->
				
				<div class= "form-group">
					<label>제목</label>
					<input type= "text" id="title" name= "title" class = "form-control" value= "<c:out value='${vo.title}'/>"/>
				</div>
				
				<div class= "form-group">
					<label>답글</label>
					<textarea rows= "10" type= "text" id="content" name= "content" class = "form-control"></textarea>
				</div>
				
				<div class= "form-group">
					<label>작성자</label>
					<input type= "text" readonly= "readonly" id="writer" name= "writer" class = "form-control" value = "${mvo.memName}"/>
				</div>
				
				<button type= "button" data-btn= "reply" class = "btn btn-primary btn-sm">저장</button>
				<button type= "button" data-btn= "reset" class = "btn btn-secondary btn-sm">취소</button>
				<button type= "button" data-btn= "list" class = "btn btn-secondary btn-sm">목록</button>
			
			
			</form>
			
			<form id= "frmList" method="get">
				<input type="hidden"  name= "page" value="<c:out value='${cri.page}'/>"/>
				<input type="hidden"  name= "perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>
					
				<input type="hidden"  name= "type" value="<c:out value='${cri.type}'/>"/>
				<input type="hidden"  name= "keyword" value="<c:out value='${cri.keyword}'/>"/>
				
			</form>
		
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
