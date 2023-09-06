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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <!-- jquery slim 말고 밑에거를 써야 ajax씀 -->
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e553c06aed72b9caf0570efca955254"></script>
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
    		<div class="col-lg-2">
    			<jsp:include page="left.jsp"/>
    		</div>
    		<div class="col-lg-7">
    			<div class="card-body">
    				<h4 class="card-title"><a href="${cpath}/list.do">BOARD</a></h4>
    				<p class="card-text">게시판 리스트</p>
    				<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${list}">
								<tr>
									<td>${vo.num}</td>
									<!-- ?는 쿼리스트링 -->
									<td>
										<c:if test="${vo.bseq > 0 && vo.bdelete == 0}">
										<c:forEach begin="1" end="${vo.blevel}">
										<span style="padding-left: 15px;"></span>
										</c:forEach>
										<i class="bi bi-arrow-return-right"></i>
										<a class="get" href="${vo.num}">Re : ${vo.title}의 답글</a>
										</c:if>
										<c:if test="${vo.bseq == 0 && vo.bdelete == 0}">
										<a class="get" href="${vo.num}">${vo.title}</a>
										</c:if>
										
										<c:if test="${vo.bseq > 0 && vo.bdelete == 1}">
										<c:forEach begin="1" end="${vo.blevel}">
										<span style="padding-left: 15px;"></span>
										</c:forEach>
										<i class="bi bi-arrow-return-right"></i>
										<a href="javascript:goMsg()">Re : 삭제된 게시물 입니다.</a>
										</c:if>
										<c:if test="${vo.bseq == 0 && vo.bdelete == 1}">
										<a href="javascript:goMsg()">삭제된 게시물 입니다.</a>
										</c:if>
										
									</td>
									<td>${vo.writer}</td>
									<td><fmt:formatDate value="${vo.indate }" pattern="yyyy-MM-dd" /></td>
									<td>${vo.count}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<!-- 검색기능 추가 -->
					
					<form action="${cpath}/list.do" method="post" >
						<div class="container">
							<div class="input-group mb-3">
								<div class="input-group-oppend">
									<select name="type" class="form-control">
										<option value="writer" ${pm.cri.type == 'writer' ? 'selected' : ''}>이름</option>
										<option value="title" ${pm.cri.type == 'title' ? 'selected' : ''}>제목</option>
										<option value="content" ${pm.cri.type == 'content' ? 'selected' : ''}>내용</option>
									</select>
								</div>
								<input type="text" name="keyword" class="form-control" placeholder="검색" value="${pm.cri.keyword}">
								<div class="input-group-append">
								    <button class="btn btn-primary" type="submit">검색</button>
								</div>
							</div>
						</div>
					</form>
					
					<!-- 페이징 처리 -->
					<ul class="pagination justify-content-center">
					<c:if test="${pm.prev}">
					  <li class="page-item"><a class="page-link" href="${pm.cri.page - 1}">Prev</a></li>
					</c:if>
					  
					<c:forEach var="page" begin="${pm.startPage}" end="${pm.endPage}">
					  		<li class="page-item ${pm.cri.page == page ? 'active' : ''}"><a class="page-link" href="${page}">${page}</a></li>
					</c:forEach>

					  <c:if test="${pm.next}">
					  <li class="page-item"><a class="page-link" href="${pm.cri.page + 1}">Next</a></li>
					  </c:if>
					</ul>
					
					<c:if test="${!empty mvo}">
					<button class="btn btn-primary btn-sm" onclick="location.href='${cpath}/register.do'">글쓰기</button>
					</c:if>
    			</div>
    		</div>
    		<div class="col-lg-3">
				<jsp:include page="right.jsp"/>
			</div>
    	</div>
    </div> 
    <div class="card-footer">
    	스마트인재개발원 빅데이터(김주원)
    </div>
  </div>
  
	<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">메세지</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        삭제된 게시글입니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
	<form id="frm" action="${cpath}/list.do" method="post">
		<input id="page" type="hidden" name="page" value="${pm.cri.page}">
		<input type="hidden" name="type" value="${pm.cri.type}">
		<input type="hidden" name="keyword" value="${pm.cri.keyword}">
		<%-- <input type="hidden" name="num" value="${num}"/> --%>
	</form>
	
	<script type="text/javascript">
		// 목록을 눌려 다시 내가 있던 페이지로 넘어가기 위함 (class="page-link")
		$(document).ready(function() {
			$(".page-link").click(function(e){ 
				e.preventDefault();
				var page = $(this).attr("href");
				$("#page").val(page);
				$("#frm").submit();
				// location.href = "${cpath}/list.do?page=" + page; // => <form>
			});
			
			// 게시글 상세보기 <a> (class="get") 클릭시 이동
			var frm = $("#frm");
			$(".get").click(function(e) {
				e.preventDefault();
				var num = $(this).attr("href");
				var tag = "<input type='hidden' name='num' value='"+num+"'/>";
				frm.append(tag); // 얘 때문에 num이 쌓이는 효과가 생기나?
				frm.attr("action", "${cpath}/get.do");
				frm.attr("method", "get");
				frm.submit();
			});
			
			// 책 검색 버튼이 클릭 되었을 때
			$("#booksearch").click(function() {
				var bookname = $("#bookname").val();
				if (bookname == "") {
					alert("책 제목을 입력하세요");
					return false;
				}
				// KaKao 책 검색 openAPI(URL-REST Service) 연동하기
				// URL : 
				// H(헤더) : 	57f10abf797896c44c6707a152257382
				// curl -v -X GET "https://dapi.kakao.com/v3/search/book?target=title"
				// --data-urlencode "query=미움받을 용기"
				// -H "Authorization: KakaoAK ${REST_API_KEY}"
				$.ajax({
					url : "https://dapi.kakao.com/v3/search/book?target=title",
					headers : {"Authorization" : "KakaoAK 57f10abf797896c44c6707a152257382"},
					type : "GET",
					data : {"query" : bookname},
					dataType : "json",
					success : bookPrint, // 콜백(callback)함수
					error : function() {
						alert("error");
					}
				});
				
				
			}); // booksearch
			
			// 주소 검색 버튼이 클릭 되었을 때
			$("#mapsearch").click(function() {
				var address = $("#address").val();
				if (address == "") {
					alert("주소를 입력하세요.");
					return false;
				}
				$.ajax({
					url : "https://dapi.kakao.com/v2/local/search/address.json",
					headers : {"Authorization" : "KakaoAK 57f10abf797896c44c6707a152257382"},
					type : "get",
					data : {"query" : address},
					dataType : "json",
					success : mapView,
					error : function() {
						alert("error");
					}
				});
			}); // #mapsearch
		
		}); // jQuery - End		
		
		function mapView(data) {
			console.log(data);
			var addr = data.documents[0].address_name;
			var x = data.documents[0].x; // 경도
			var y = data.documents[0].y; // 위도
			// 1. 지도를 보여줄 div 갖고옴
			var mapContainer = document.getElementById('map'); // document.getElementById('map') // $("#map")
			// 2. 지도를 보여주기 위한 option(중심좌표, 지도레벨)
			var mapOption = {
				center : new kakao.maps.LatLng(y, x), // Maps OpenAPI
				level : 2
			};
			// 3. 지도생성하기
			var map = new kakao.maps.Map(mapContainer, mapOption);
			var markerPosition  = new kakao.maps.LatLng(y, x); 

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			// 마커위에 보여질 정보 만들기
			var iwContent = '<div style="padding:10px;">'+ addr +'</div>', iwRemoveable = true;
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    content : iwContent,
			    removable : iwRemoveable
			});

			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function() {
			      // 마커 위에 인포윈도우를 표시합니다
			      infowindow.open(map, marker);  
			});
		}
		
		function goMsg() {
			$(".modal").modal("show");
		}
		function bookPrint(data) {
			// alert(data);
			console.log(data);
			var blist = "<table class='table table-hover'";
			blist += "<thead>";
			blist += "<tr>";
			blist += "<th>이미지</th>";
			blist += "<th>제목</th>";
			blist += "<th>가격</th>";
			blist += "<th>출판사</th>";
			blist += "</tr>";
			blist += "</thead>";
			blist+= "<tbody>";
			$.each(data.documents, function(index, obj) {
				var thumbnail = obj.thumbnail;
				var url = obj.url;
				var price = obj.price;
				var title = obj.title;
				var publisher = obj.publisher;
				blist += "<tr>";
				blist += "<td><a href='" + url + "' target='_blank'><img src='" + thumbnail + "' width='50px' height='60px'/></a></td>";
				blist += "<td>" + title + "</td>";
				blist += "<td>" + price + "</td>";
				blist += "<td>" + publisher + "</td>";
				blist += "</tr>";
			});
			blist += "<tr>";
			
			blist+= "</tbody>";
			blist += "</table>";
			
			$("#booklist").html(blist);
		}
	</script>
</body>
</html>
