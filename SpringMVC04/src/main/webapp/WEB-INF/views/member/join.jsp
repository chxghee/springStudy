<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	
	function registerCheck() {	// 중복체크하는 함수
	   var memID=$("#memID").val();
		
		
		$.ajax({
	    	   url : "${contextPath}/memRegisterCheck.do",		// 이 떄는 get방식이라 csrf토큰 검사 하지 않음 
	    	   type : "get",
	    	   data : { "memID" : memID},
	    	   success : function(result){
	    		   // 중복유무 출력(result=1 : 사용할수있는 아이디, 0 : 사용할수없는 아이디)
	    		   if (result == 1) {
	    			   $("#checkMessage").html("사용할 수 있는 아이디입니다.");
	    			   $("#checkType").attr("class","modal-content panel-success");	// 성공 연두 
	    		   }
	    		   else {
	    			   $("#checkMessage").html("사용할 수 없는 아이디입니다.");
	    			   $("#checkType").attr("class","modal-content panel-warning");	// 실패 노랑
	    		   }
	    		   $("#myModal").modal("show");
	    		  
	    	   },    	   
	    	   error : function(){ alert("error"); }    	   
	       });    	
		
	}
	
	// 비밀번호 일치 여부 
	function passwordCheck() {
		
		var memPassword1 = $("#memPassword1").val();
		var memPassword2 = $("#memPassword2").val();
		if (memPassword1 != memPassword2) {
			$("#passMessage").html("비밀번호가 일치하지 않습니다.");
		}
		else {
			$("#passMessage").html("");
			$("#memPassword").val(memPassword1); // memPassword 값에 값 저
		}
		
	}
	
	function goInsert() {
		
		var memAge = $("#memAge").val();
		if (memAge == null || memAge=="" || memAge==0) {
			alert("나이를 입력하세요");
			return false;
		}
		
		document.frm.submit(); 		// name 이 frm인 form을 submit 해서 전송함 
		
	}
	
	</script>


</head>




<body>
 
<div class="container">

 <jsp:include page="../common/header.jsp"/>	<!-- 네비게이션 바 ../로 상위디렉토리로 가야  -->


  <h2>회원가입</h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원가입 </div>
    
    	<!-- 회원가입 폼 만들기  -->
    <div class="panel-body">
    
    	<form name= "frm" action= "${contextPath}/memRegister.do" method= "post">
    	
    	<!-- memPassword를 넘겨야 하는데 변수명이 memPassword1,2이므로 히든으로 memPassword에 값을 저장  -->
    		<input type= "hidden" id= "memPassword" name="memPassword" value=""/>
    	
    		<table class = "table table-bordered" style= "text-align: center; border: 1px solid #dddddd;">
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">아이디</td>
    				<td><input id= "memID" name= "memID" class= "form-control" type = "text" maxlength= "20" placeholder= "아이디를 입력하세요..."/></td>
            		 <td style="width: 110px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck()">중복확인</button></td>
    			
    			</tr>
    			
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">비밀번호</td>
    				<td colspan="2"><input id= "memPassword1" name= "memPassword1" onkeyup="passwordCheck()" class= "form-control" type = "password" maxlength= "20" placeholder= "비밀번호를 입력하세요..."/></td>
    			
    			</tr>
    			
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">비밀번호 확인</td>
    				<td colspan="2"><input id= "memPassword2" name= "memPassword2"  onkeyup="passwordCheck()" class= "form-control" type = "password" maxlength= "20" placeholder= "비밀번호를 확인하세요..."/></td>
    			
    			</tr>
    			
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">사용자 이름</td>
    				<td colspan="2"><input id= "memName" name= "memName"  class= "form-control" type = "text" maxlength= "20" placeholder= "이름을 입력하세요..."/></td>
    			
    			</tr>
    			
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">나이</td>
    				<td colspan="2"><input id= "memAge" name= "memAge"class= "form-control" type = "number" maxlength= "20" placeholder= "나이를 입력하세요..." /></td> <!-- value="0" 인 이유는 age값이 하나도 입력이 없을 떄 를 처리해야 하므로 디트 값을 0 으로 설정함  -->
    			
    			</tr>
    			
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">성별</td>
    				<td colspan="2">
    					<div class= "form-group" style= "text-align: center; margin: 0 auto;">
    						<div class= "btn-group" data-toggle= "buttons">
    							<label class = "btn btn-primary active">
    								<input type= "radio" id= "memGender" name= "memGender" autocomplete= "off" value= "남자" checked/>남자
    							</label>
    							<label class = "btn btn-primary">
    								<input type= "radio" id= "memGender" name= "memGender" autocomplete= "off" value= "여자"/>여자
    							</label>
    						</div>
    					
    					</div>
						
					</td>
    			
    			</tr>
    			
    			<tr>
    			
    				<td style= "width: 110px; vartical-align; ">E-mail</td>
    				<td colspan="2"><input id= "memEmail" name= "memEmail" class= "form-control" type = "text" maxlength= "20" placeholder= "email를 입력하세요..."/></td>
    			
    			</tr>
    			
    			<tr>
    				<td colspan="3" style= "text-align: left;">
    					<span id= "passMessage" style= "color: red"></span><input type= "button" class= "btn btn-primary btn-sm pull-right" value="등록" onclick = "goInsert()"/>
    				</td>			<!--  나이 부분을 정상적으로 썼는지 확인하기 위해서 타입을 submit으로 하지 않고 클릭했을 goInsert() 함수를 실앻해서 서브밋을 하도록  -->
    			</tr>
    			
    			
    		</table>
    	
    		<input type= "hidden" name= "${_csrf.parameterName}" value= "${_csrf.token}"/>
    	
    	</form>

	

	</div>
	
	<!-- 다이얼로그 모달창 만글기  -->
	
		<!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div id= "checkType" class="modal-content">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">메세지 확인</h4>
	      </div>
	      <div class="modal-body">
	        <p id = "checkMessage"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	
	  </div>
	</div>
	
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
