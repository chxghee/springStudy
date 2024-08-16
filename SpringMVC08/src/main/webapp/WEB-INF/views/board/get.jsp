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
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button").on("click", function(event){
			
			var formData = $("#frm");
			var btn = $(this).data("btn");		// data-btn = "reply"	라서 reply값을 btn에 저장
			
			if (btn == 'reply'){
				formData.attr("action", "${cpath}/board/reply");
			}
			else if (btn == 'modify') {
				formData.attr("action", "${cpath}/board/modify");
			}
			else if (btn == 'list') {
				
				formData.find("#idx").remove();	// list의 경우에는 idx데이터가 컨트롤러에 필요 없으므로 input 태그를 무효화 
				formData.attr("action", "${cpath}/board/list");
			} 
			
			formData.submit();
			
		});
		
	});
	
	
	
	</script>

</head>
<body>
 
<div class="container">
  <h2>Spring MVC</h2>
  <div class="panel panel-default">
    <div class="panel-heading">게시판</div>
    <div class="panel-body">

		<table class = "table table-bordered">
			<tr>
				<td>번호</td>
				<td><input type= "text" class= "form-control" name= "idx" value="${vo.idx}" readonly="readonly"/></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type= "text" class= "form-control" name= "title" value="<c:out value='${vo.title}'/>" readonly="readonly"/></td>
			</tr>
			<tr>
				<td>내용</td>
		          <td><textarea rows="10" class="form-control" name="content" readonly="readonly"><c:out value='${vo.content}'/></textarea> </td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type= "text" class= "form-control" name= "writer" value= "${vo.writer}" readonly= "readonly"/></td>
			</tr>
			
			<tr>
				<td colspan= "2" style= "text-align: center">
				
				<!--  로그인 했을 때  -->
				<c:if test="${!empty mvo}">
					<button data-btn= "reply" class = "btn btn-sm btn-primary" >답글</button>
					<button data-btn= "modify" class = "btn btn-sm btn-success" >수정</button>
				</c:if>
				
				<!--  로그인 안 했을 때  -->
				<c:if test="${empty mvo}">
					<button disabled= "disabled" class = "btn btn-sm btn-primary">답글</button>
					<button disabled= "disabled" class = "btn btn-sm btn-success" onclick = "location.href='${cpath}/board/modify?idx=${vo.idx}'">수정</button>
				</c:if>
					<button data-btn= "list" class = "btn btn-sm btn-info" >목록</button>
				</td>
			</tr>
		
		</table>
		
		<!-- reply / modify는 idx 값을 get 방식으로 가져가야 하므로 -->
		<form id= "frm" method= "get">
			<input type="hidden" id="idx" name= "idx" value="<c:out value='${vo.idx}'/>"/>
			
			
			
			<!-- 게시글 상세보고 목록버튼 눌러 돌아 갈때 다시 그 페이지로 가도록 get방식으로 페이지 정보를 넘겨줌  -->
			<input type="hidden"  name= "page" value="<c:out value='${cri.page}'/>"/>
			<input type="hidden"  name= "perPageNum" value="<c:out value='${cri.perPageNum}'/>"/>
			
			
		
		</form>

	</div>
        <div class="panel-footer">답변기능 게시판 만들기</div>
    
  </div>
</div>

</body>
</html>
