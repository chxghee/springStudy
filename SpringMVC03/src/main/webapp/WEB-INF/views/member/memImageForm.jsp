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
  $(document).ready(function(){		// 이 join 페이지가 실행될 떄 msgType 값이 있는지 없는지를 항상 체크함 
	  
	  if (${!empty msgType}) {		// 비어있지 않으면 실패했다는 뜻이니까 실페 모달을 보여주기 
		   
		$("#messageType").attr("class", "modal-content panel-warning");
		   
		$("#myMessage").modal("show");
	  }
	  
	  
  });
  
  </script>
  
  
  
  
</head>




<body>
 
<div class="container">

 <jsp:include page="../common/header.jsp"/>	<!-- 네비게이션 바 ../로 상위디렉토리로 가야  -->

  <h2>회원 사진 등록</h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원 사진 등록</div>
    <div class="panel-body">
															<!--  사진 넘길 땐 enctype= "multipart-form-data"from에 적어줘애 -->
	<form action= "${contextPath}/memImageUpdate.do" method= "post"  enctype= "multipart/form-data">
    	
    	<!--  이미지 파일 이름을 DB에 저장할 때 누구의 이미지 인지 알기 위해 우선 히든으로 ID 값을 넘겨받아 놓는 -->
    	<input type= "hidden" name= "memID" value= "${mvo.memID}"}/>
    	
    		<table class = "table table-bordered" style= "text-align: center; border: 1px solid #dddddd;">
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">아이디</td>
    				<td>${mvo.memID}</td>
    			
    			</tr>
    			
    			<tr>
    			
    				<td style= "width: 110px; vartical-align: middle; ">사진 업로드</td>
    				<td colspan="2">
						<span class= "btn btn-default">
							이미지를 업로드 하세요. <input type= "file" name ="memProfile"/>
						</span>
					</td>
    			
    			</tr>
    			
    			
    			<tr>
    				<td colspan="3" style= "text-align: left;">
    					<input type= "submit" class= "btn btn-primary btn-sm pull-right" value="등록" />
    				</td>			<!--  나이 부분을 정상적으로 썼는지 확인하기 위해서 타입을 submit으로 하지 않고 클릭했을 goInsert() 함수를 실앻해서 서브밋을 하도록  -->
    			</tr>
    			
    			
    		</table>
    	
    	
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
