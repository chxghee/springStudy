<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<div class="card" style= "min-height: 500p; max-height: 1000px";>

	<div class ="row">
		<div class ="col-lg-12">
			<div class= "card-body">
				
				<!--  로그인 X -->
				<c:if test="${empty mvo}">
				
				<h4 class= "card-title">GUEST</h4>
				<p class="card-text">회원님 환영합니다!</p>
				
				<form action= "${cpath}/login/loginProcess" method= "post">
				
					<div class="form-group">
					    <label for="memID">ID:</label>
					    <input type="text" class="form-control" name="memID">
					  </div>
					  
					  <div class="form-group">
					    <label for="memPwd">Password:</label>
					    <input type="password" class="form-control" name="memPwd">
					  </div>
			  
			  		<button type="submit" class="btn btn-primary form-control">로그인</button>
				
				</form>
				</c:if>
				
				<!--  로그인 O -->
				<c:if test="${!empty mvo}">
				<h4 class= "card-title">${mvo.memName}</h4>
				<p class= "card-text">님 환영합니다!</p>	
				    <form class="form-inline" action="${cpath}/login/logoutProcess">
					  
					  
					  <button type="submit" class="btn btn-primary form-control">로그아웃</button>
					</form>
		    	</c:if>
				
			</div>
		</div>
	
	</div>



	<div class ="row">
		<div class ="col-lg-12">
			<div class= "card-body">
				
				<p class="card-text">MAP View</p>
				<div class ="input-group mb-3">
					<input type= "text" class= "form-control" placeholder="Search" id= "address"/>
					<div class= "input-group-append">
						<button type= "button" class= "btn btn-secondary" id= "mapBtn">검색</button>
					</div>
				</div>
				
				<div id="map" style="width:100%;height:200px;"></div>
				
			</div>
		</div>
	
	</div>

</div>