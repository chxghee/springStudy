<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  
  // j query 
  $(document).ready(function(){		// 이 join 페이지가 실행될 떄 / msgType 값이 있는지 없는지를 항상 체크함 
	  
	  
	  if(${param.error != null}) {		// 에러 파라미터를 받아 오는데 이 값이 존재하먄 
		  
			$("#messageType").attr("class", "modal-content panel-warning");
			$(".modal-body").text("아이디와 비밀번호를 확인해주세요");
			$(".modal-title").text("실패 메세지");
			$("#myMessage").modal("show");

	  }
	  
	 /*  if (${!empty msgType}) {		// 비어있지 않으면 실패했다는 뜻이니까 실페 모달을 보여주기  -> 시큐리티로 인증절차 바꾸었으므로 받아오는 메세지를 주는 컨트롤러가 없으니까 다른 방식으로 처리를 해야함 
		   
		$("#messageType").attr("class", "modal-content panel-warning");
		   
		$("#myMessage").modal("show");
	  } */
	  if (${!empty msgType}) {		// 회원가입 성공 메세지 
		   
			$("#messageType").attr("class", "modal-content panel-success");
			   
			$("#myMessage").modal("show");
		} 
	  
  });
  
  </script>
  
  
  
  
</head>




<body>
 
<div class="container">

 <jsp:include page="../common/header.jsp"/>	<!-- 네비게이션 바 ../로 상위디렉토리로 가야  -->

  <h2>Login</h2>
  <div class="panel panel-default">
    <div class="panel-heading">로그인 화면</div>
    <div class="panel-body">
	
	<form action= "${contextPath}/memLogin.do" method= "post">
    	
    	
    		<table class = "table table-bordered" style= "text-align: center; border: 1px solid #dddddd;">
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">아이디</td>	<!-- name= "username" 스프링 시큐리티에선 아이디는 반드시 username/ 비번은 password 으로 받아야 함  --> 
    				<td><input id= "memID" name= "username" class= "form-control" type = "text" maxlength= "20" placeholder= "아이디를 입력하세요..."/></td>
    			
    			</tr>
    			
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">비밀번호</td>
    				<td colspan="2"><input id= "memPassword" name= "password" class= "form-control" type = "password" maxlength= "20" placeholder= "비밀번호를 입력하세요..."/></td>
    			
    			</tr>
    			
    			
    			<tr>
    				<td colspan="3" style= "text-align: left;">
    					<input type= "submit" class= "btn btn-primary btn-sm pull-right" value="로그인" />
    				</td>			<!--  나이 부분을 정상적으로 썼는지 확인하기 위해서 타입을 submit으로 하지 않고 클릭했을 goInsert() 함수를 실앻해서 서브밋을 하도록  -->
    			</tr>
    			
    			
    		</table>
    	
    	<!--  로그인 토큰 전달  -->
    		<input type= "hidden" name= "${_csrf.parameterName}" value= "${_csrf.token}"/>
    		
    	</form>




	</div>
	
	
	<!-- 다이얼로그 모달창 만글기  -->
	
	<!--  싪패 메세지 출력 뷰뷴  -->
	
	<div id="myMessage" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div id= "messageType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        
	        <h4 class="modal-title">${msgType}</h4>
	      </div>
	      <div class="modal-body">
	        <p>${msg}</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	
	  </div>
	</div>
	
	
    <div class="panel-footer">스프링 게시판 구현</div>
  </div>
</div>

</body>
</html>
