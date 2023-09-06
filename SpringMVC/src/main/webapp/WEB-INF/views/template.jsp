<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="resources/css/style.css">
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
 
  <div class="card">
    <div class="card-header">
    	<div class="jumbotron jumbotron-fluid">
  			<div class="container">
    			<h1>Spring MVC Framework</h1>
    			<p>MVC, Spring, MySQL, jQuery(Ajax, JSON)</p>
  			</div>
		</div>
    </div>
    <div class="card-body">
    	<div class="row">
    	<!-- 컬럼 총합 12 그리드 col-숫자 로 추가해주면 폭 잡아줌-->
    		<div class="col-2">
    			<jsp:include page="left.jsp"/>
    		</div>
    		<div class="col-7">
    			<div class="card-body">
    				<h4 class="card-title">BOARD</h4>
    				<p class="card-text">?????</p>
    				콘텐츠부분
    			</div>
    		</div>
    		<div class="col-3">
				<jsp:include page="right.jsp"/>
			</div>
    	</div>
    </div> 
    <div class="card-footer">
    	스마트인재개발원 빅데이터반__(김주원)
    </div>
  </div>

</body>
</html>
