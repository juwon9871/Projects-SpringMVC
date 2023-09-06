<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- jstl에서 줄바꿈 하기 위한 작업 밑에 두줄 -->
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>
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
    				<p class="card-text">상세보기</p>
    				<table class="table table-bordered">
   						<tr>
   							<td style="width: 100px;">제목</td>
   							<td>${vo.title}</td>
   						</tr>
   						<tr>
   							<td>내용</td>
   							<!-- 줄바꿈을 br태그로 바꿔서 출력시켜 줄바꿈을 정상적으로 나오게끔 하기 위함 -->
   							<td>${fn:replace(vo.content, replaceChar, "<br>")}</td>
   						</tr>
   						<tr>
   							<td>작성자</td>
   							<td>${vo.writer}</td>
   						</tr>
   						<tr>
   							<td>작성일</td>
   							<!-- 날짜 포매팅 -->
   							<td><fmt:formatDate value="${vo.indate }" pattern="yyyy-MM-dd" /></td>
   						</tr>
   						<tr>
   							<td colspan="2" style="text-align: center;">
   								<button data-btn="list" class="btn btn-primary btn-sm">목록</button>
   								<c:if test="${mvo.username eq vo.username}">
   								<button data-btn="modify" class="btn btn-primary btn-sm">수정</button>
   								<button data-btn="remove" class="btn btn-warning btn-sm">삭제</button>
   								</c:if>
   								<c:if test="${!empty mvo}">
   								<button data-btn="reply" class="btn btn-primary btn-sm">답글</button>
   								</c:if>
   							</td>
   						</tr>
    				</table>
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
  <form id="frm">
  	<input type="hidden" name="num" value="${vo.num}"/>
  	<input type="hidden" name="page" value="${cri.page}"/>
  	<input type="hidden" name="type" value="${cri.type}">
  	<input type="hidden" name="keyword" value="${cri.keyword}">
  </form>
  
<!-- 스크립트를 헤드부분에 안걸고 바디 아래에 거는 이유는 해석을 하다보면 브라우져 속도가 늦어질 수 있어서? -->
<script type="text/javascript">
	// 분리개발을 위한 목적
	// jQuery(자바스크립트 라이브러리 : API) : ajax, fetch(ajax)
	// 서버에 있는 js파일을 연결해서 사용하는 방법을 CDN : http://jquery.com
	// 바닐라스크립트란 프레임워크 또는 라이브러리가 적용되지 않은 순수한 자바스크립트
				// 익명함수 ↓
	$(document).ready(function(){
		// 버튼이 클릭되면 ~
		$("button").click(function(){
			var frm = $("#frm");
			var data = $(this).data("btn"); //data- ~~에 접근하기 위한 함수
			if (data == "list") {
				// location.href="${cpath}/list.do" // get이동이기 때문에 꼬리표가 붙고 비효율적
				// jquery는 겟과 셋이 구분되어 있지 않고 인자가 1개면 겟동작, 2개면 셋동작이 이루어짐
				frm.attr("action", "${cpath}/list.do");
				frm.attr("method", "post");
			} else if (data == "modify") {
				frm.attr("action", "${cpath}/modify.do");
				frm.attr("method", "get");
			} else if (data == "remove") {
				frm.attr("action", "${cpath}/remove.do");
				frm.attr("method", "get");
			} else if (data == "reply") {
				frm.attr("action", "${cpath}/reply.do");
				frm.attr("method", "get");
			}
			// 폼태그는 전송(submit)이 있어야하니까 마지막에 추가해줌
			frm.submit();
		});
	});
</script>
</body>
</html>
