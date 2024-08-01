
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>   


<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/> 


<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC06</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type= "text/javascript">

//토큰 값 변수에 저장하기 
  var csrfHeaderName= "${_csrf.headerName}";
  var csrfTokenValue= "${_csrf.token}";
  
  
  	$(document).ready(function(){
  		loadList();
  	})
  	// 서버와 통신: 게시판 목록 기져오기 
  	function loadList(){
  		$.ajax({
  			url : "board/all",
  			type: "get",
  			dataType : "json",
  			success : makeView,
  			error : function(){alert("error"); }
  		});
  	}
  	// json data로 뷰 만들기 
  	function makeView(data){	// [{}. {}. {}....] 
  		
  		var listHtml = "<table class = 'table table-bordered'>";
  		
  		listHtml += "<tr>";
  		listHtml += "<td>번호</td>";
  		listHtml += "<td>제목 </td>";
  		listHtml += "<td>작성자 </td>";
  		listHtml += "<td>작성일 </td>";
  		listHtml += "<td>조회수 </td>";
  		listHtml += "</tr>";
  		
  		$.each(data, function(index, obj){		//obj = { "idx":5, title: asd ....}
  			
  			listHtml += "<tr>";
  	  		listHtml += "<td>"+obj.idx+"</td>";
  	  		listHtml += "<td id='t"+obj.idx+"' ><a href= 'javascript: goContent("+obj.idx+")'>"+obj.title+"</a></td>";	//이때 인덱스도 전달 
  	  		listHtml += "<td>"+obj.writer+"</td>";
  	  		listHtml += "<td>"+obj.indate.split(" ")[0]+"</td>";
  	  		listHtml += "<td id= 'cnt"+obj.idx+"'>"+obj.count+"</td>";
  	  		listHtml += "</tr>";
  	  		
  	  		// 클릭시에만 보여야 하므로 식별하기위해 id를 idx로 고유하게 구별해서 붙여
  	  		listHtml += "<tr id='c"+obj.idx+"' style = 'display:none'>";
	  		listHtml += "<td>내용 </td>";
	  		listHtml += "<td colspan = '4'>";
	  		listHtml += "<textarea readonly id='ta"+obj.idx+"' rows= '7' class= 'form-control'></textarea>";
	  		
	  		
	  		// 자기글만 수정 삭제 가능하도록 
	  		if ("${mvo.member.memID}" == obj.memID) { 		// ${mov.memID} 에는 따옴표 필요 문자열로 설정하고 obj.memID랑 비교해야해서
	  		
	  			listHtml += "<br/>";
		  		listHtml += "<span id= 'ub"+obj.idx+"'><button class='btn btn-success btn-sm' onclick ='goUpdateForm("+obj.idx+")'>수정 </button></span>&nbsp"; 
	  			listHtml += "<button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";    	  		
	  			
	  		}else {
	  			listHtml += "<br/>";
		  		listHtml += "<span id= 'ub"+obj.idx+"'><button disabled class='btn btn-success btn-sm' onclick ='goUpdateForm("+obj.idx+")'>수정 </button></span>&nbsp"; 
	  			listHtml += "<button disabled class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";    	  		
	  			
	  		}
	  		
	  		
  			
  			
  			listHtml += "</td>";
	  		listHtml += "</tr>";
  		});
  		
  		
  		// 로그인을 해야 보이는 부분 
  		if (${!empty mvo.member}) {
  			
  			listHtml += "<tr>";
  	  		
  	  		
  	  		// 글쓰기 버튼 구현 
  	  		listHtml += "<td colspan= '5'>";
  	  		listHtml += "<button class = 'btn btn-primary btn-small' onclick= 'goForm()'>글쓰기 </button>";
  	  		listHtml +=	 "</td>";
  	  		listHtml += "</tr>";
  	  		
  			
  		}
  		
  		listHtml += "</table>";
  		$("#view").html(listHtml); 		// id = "view"인 곳에 만든 테이블 html넣기 
  		
  		
  		$("#wform").css("display", "none");		// from라는 아이디를 안 보이게 
  		$("#view").css("display", "block");		// view라는 아이디를 보이게 
  		
  	}
  	function goForm(){
  		
  		$("#view").css("display", "none");		// view라는 아이디를 안보이게 
  		$("#wform").css("display", "block");		// form라는 아이디를 보이게 
  	}
	function goList(){
  		
		$("#wform").css("display", "none");		// from라는 아이디를 안 보이게 
  		$("#view").css("display", "block");		// view라는 아이디를 보이게 
  		
  	}
	// 글쓰기 위한 
	function goInsert(){
		// 개별로 한개씩 가져오는 방법 
		// var title =$("#title").val;
		// var content =$("#content").val;
		// var writer =$("#writer").val;
		
		// form 안에 파라미터들을 직렬화 시켜서 한번에 값을 가져오기 
		var fData=$("#frm").serialize();	// title=a&content=a&writer=a 이런 형식으로 저장됨 
		
		$.ajax({
  			url : "board/new",		// post방식 + /new
  			type: "post",
  			data : fData,
  			
  			 // post 방식으로 보낼 때 토큰값도 같이 보내줌
  			beforeSend : function(xhr) {
  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
  			},
  			success : loadList,		// 다시 첫 화면으로 돌아가기
  			error : function(){alert("error"); }
  		});
		
		// 다시 빈칸으로 만들기 (폼 초기화 )
		//$("#title").val("");
		//$("#content").val("");
		//$("#writer").val("");
		
		// trigger를 통해 fclear 버튼을 강제로 클릭 
		$("#fclear").trigger("click");		
	}
	// 내용 보여주기 
	function goContent(idx){
		
		if ( $("#c"+idx).css("display") == "none" ) {		// 현재 내용칸이 닫혀있는상태라면 
			
			$.ajax({						// 검색을 하면 데이터를 가져와 내용칸에 보여주기 위함 
	  			url : "board/" + idx,
	  			type: "get",
	  			data : {"idx": idx},
	  			dataType : "json",
	  			success : function(data){
	  				
	  				$("#ta"+idx).val(data.content);
	  				
	  				
	  			},	
	  			error : function(){alert("error"); }
	  		});
			
			$("#c"+idx).css("display", "table-row");		// idx 번째 c를 보여주기 
			$("#ta"+idx).attr("readonly", true);			// 수정 눌렀을 때 

		}
		else{
			$("#c"+idx).css("display","none" );				// 열려있다면 닫기 (감추기) 
			
			// 조회수 구현하기 
			// 닫을때 조회수가 올라가도록 
			$.ajax({
				
				url: "board/count/" + idx,
				type: "put",
				dataType: "json",
				beforeSend : function(xhr) {
	  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
	  			},
				success : function (data){
					$("#cnt"+idx).text(data.count);
				},
	  			error : function(){alert("error"); }

			});
			
			
		}
	}
	// 삭제 
	function goDelete(idx) {
		
		// 서버에 삭제요청 
		$.ajax({
  			url : "board/" + idx,
  			type: "delete",
  			beforeSend : function(xhr) {
  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
  			},
  			success : loadList,		// 다시 첫 화면으로 돌아가기
  			error : function(){alert("error"); }
  		});
	}
	
  function goUpdateForm(idx) {
	  
	  $("#ta"+idx).attr("readonly", false);		// 내용부분 readonly 풀어주기 
	  
	  var title =  $("#t"+idx).text()		// 현재 제묵을 가져옴 
	  var newInput = "<input type='text' id= 'nt"+idx+"' class= 'form-control' value= '"+title+"'/>";	// 제목 고칠수있게 input
	  $("#t"+idx).html(newInput);
	  
	  var newButton = "<button class='btn btn-primary btn-sm' onclick= 'goUpdate("+idx+")'>적용 </button>";
	  $("#ub"+idx).html(newButton);
  }
  
  function goUpdate(idx) {
	  
	  var title = $("#nt"+idx).val();
	  var content = $("#nt"+idx).val();
	  
	  // 수정할 값들을 서버로 보냄
	  $.ajax({
			url : "board/update",
			type: "put",
			
			// REST방식에서 data를 넘길땐 JSON형식으로 변환해줘애 한다. 
			
			contentType: 'application/json;charset=utf-8',		// 또한 전달하는 데이터의 타입도 적어야한다, 
			data : JSON.stringify({"idx": idx, "title": title, "content": content}),		// 변수를 넘길 땐 {"idx": idx},
			beforeSend : function(xhr) {
  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
  			},
			success : loadList,		// 다시 첫 화면으로 돌아가기
			error : function(){alert("error"); }
		});
	  
  }
  
  </script> 
</head>
<body>
 
 
<div class="container">
 <jsp:include page="../common/header.jsp"/>	<!-- 네비게이션 바 ../로 상위디렉토리로 가야  -->


  <h3>화원 게시판</h3>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD</div>
    <div class="panel-body" id = "view">Panel Content</div>
    <div class="panel-body" id = "wform" style = "display: none">
    
	    <form id ="frm">
	    
	    <input type="hidden" name = "memID" id ="memID" value = "${mvo.member.memID}"/>
	      <table class="table">
	         <tr>
	           <td>제목</td>
	           <td><input type="text" id ="title" name="title" class="form-control"/></td>
	         </tr>
	         <tr>
	           <td>내용</td>
	           <td><textarea rows="7"  class="form-control" id ="content" name="content"></textarea> </td>
	         </tr>
	         <tr>
	           <td>작성자</td>
	           <td><input type="text" id ="writer" name="writer" class="form-control" value = "${mvo.member.memName}" readonly = "readonly"/></td>
	         </tr>
	         <tr>
	           <td colspan="2" align="right">
              		<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
	               <button type="reset" class="btn btn-warning btn-sm" id = "fclear">취소</button>
	               <button type="button" class="btn btn-info btn-sm" onclick="goList()">리스트 </button>
	               
	           </td>
	         </tr>
	      </table>
	     </form>


	</div>
    <div class="panel-footer">스프링 실습</div>
  </div>
</div>

</body>
</html>
    
    