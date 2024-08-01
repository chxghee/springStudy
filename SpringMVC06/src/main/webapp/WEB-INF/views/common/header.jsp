<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>   

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/> 
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/> 

<script> // 로그아웃 post 방식으로 하기위해 ajax 
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	function logout(){
	  	$.ajax({
	  		url : "${contextPath}/logout",
	  		type: "post", // insert    	
	  		beforeSend: function(xhr){
	              xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
	          },
	  		success : function(){
	  			location.href="${contextPath}/";
	  		},
	  		error : function(){ alert("error");}    		
	  	}); 
	}
	


</script>



<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="${contextPath}/">스프링 게시판 실습 </a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="${contextPath}/">Home</a></li>
        
        <li><a href="${contextPath}/boardMain.do">게시판 </a></li>  <!-- 내가 임의로 contextPath  -->
        
        
      </ul>
      
      <security:authorize access= "isAnonymous()">  <!-- isAnonymous() : 인증되지 않은 사용자  -->
      
      <%-- <c:if test="${empty mvo}">  <!-- 로그인 하지 않았을때 시큐리티 인증 전 방법   --> --%>
   
	      <ul class="nav navbar-nav navbar-right">
	        
	            <li><a href="${contextPath}/memLoginForm.do"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
	            <li><a href="${contextPath}/memJoin.do"><span class="glyphicon glyphicon-user"></span> 회원가입</a></li>
	       		
     		</ul>
      </security:authorize>
      
       <%-- </c:if> --%>
          
          <security:authorize access= "isAuthenticated()">	<!-- isAuthenticated() : 인증되지 않은 사용자  -->
           <%-- <c:if test="${!empty mvo}">  <!-- 로그인함   --> --%>
      
		      <ul class="nav navbar-nav navbar-right">
		        
		            
		            <li><a href="${contextPath}/memUpdateForm.do"><span class="glyphicon glyphicon-wrench"></span> 회원정보수정</a></li>
		            <li><a href="${contextPath}/memImageForm.do"><span class="glyphicon glyphicon-picture"></span> 사진 등록</a></li>
		            <%-- <li><a href="${contextPath}/memLogout.do"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li> --%>
		          	<li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
		          			<!--  ${contextPath}/Logout 경로를 바꿔줌  -->
		          			<!-- a 태그는 GET방식으라 post 방식으러 바꾸기 위해 자바스크립트 함수 사용  -->
				
					<c:if test= "${empty mvo.member.memProfile}">   <!--  기본이미지   -->
						
						<li><img class="img-circle" src= "${contextPath}/resources/images/person.png" style = "width: 50px; height: 50px" /> 
						
						
						<%-- <li><img class="img-circle" src= "${contextPath}/resources/images/person.png" style = "width: 50px; height: 50px" /> ${mvo.memName} 님
						( 
						<c:forEach var = "authVO" items= "${mvo.authList}">		<!-- 로그인한 사람의 권한을 표  -->
							<c:if test= "${authVO.auth eq 'ROLE_USER'}">U</c:if>
							<c:if test= "${authVO.auth eq 'ROLE_MANAGER'}">M</c:if>
							<c:if test= "${authVO.auth eq 'ROLE_ADMIN'}">A</c:if>
						</c:forEach>
						
						) 환영합니다.</li> --%>
					</c:if>
				
					<c:if test= "${!empty mvo.member.memProfile}">   <!--  설정 이미지   -->
					
					<li><img class="img-circle" src= "${contextPath}/resources/upload/${mvo.member.memProfile}" style = "width: 50px; height: 50px" /> 
						
						<%-- <li><img class="img-circle" src= "${contextPath}/resources/upload/${mvo.memProfile}" style = "width: 50px; height: 50px" /> ${mvo.memName}님
						(
						<c:forEach var = "authVO" items= "${mvo.authList}">		<!-- 로그인한 사람의 권한을 표  -->
							<c:if test= "${authVO.auth eq 'ROLE_USER'}">U</c:if>
							<c:if test= "${authVO.auth eq 'ROLE_MANAGER'}">M</c:if>
							<c:if test= "${authVO.auth eq 'ROLE_ADMIN'}">A</c:if>
						</c:forEach>
						
						) 환영합니다.</li> --%>
					</c:if>
						${mvo.member.memName} 님 
						(
						<security:authorize access= "hasRole('ROLE_USER')">
						U 
						</security:authorize>
						<security:authorize access= "hasRole('ROLE_MANAGER')">
						M 
						</security:authorize>
						<security:authorize access= "hasRole('ROLE_ADMIN')">
						A
						</security:authorize>
						)
					</li>
				  
	     	 </ul>
	    </security:authorize>
       <%-- </c:if> --%>
         
          
       
    </div>
  </div>
</nav>
