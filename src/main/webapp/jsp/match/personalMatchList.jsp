<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 찾기 (personalMatchList.jsp) - 담당: 변재언
  피그마: Home / Guest · Member · Admin / Desktop, Home / * / Map Search (Typing · Moved · Pin Selected)
  ─ 하나의 JSP 로 처리 ─
   role  : guest(인기 기준 추천, 로그인 버튼) / member·admin(맞춤 추천 탭 추가)
   state : list(일반 검색) | map(지도 검색) | mapTyping(지도 검색어 입력 중) | mapPin(지도 핀 선택)
--%>
<c:set var="pageTitle" value="경기 찾기" />
<c:set var="pageCss" value="home,match" />
<c:set var="pageJs" value="home" />
<c:set var="activeNav" value="match" />
<c:set var="showFooter" value="true" />
<%@ include file="/jsp/common/header.jsp" %>
<style>
	.is-hidden { display: none !important; }
	
	.map-title-row {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 8px;
	}
	.map-title-row strong {
		flex: 1;
		min-width: 0;
	}
	.map-title-row .fav-btn {
		position: static !important;
		flex-shrink: 0;
		margin: 0;
	}
</style>
<script src="${ctx}/js/common.format.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<script>
	const locationReady = getUserLocation().catch(() => null);
	let userLat = null, userLng = null;

	
	let page =1;

	const PAGE_SIZE = 4;

	const SPORT_TYPE = {
		'축구/풋살': 'football',
		'축구': 'football',
		'농구': 'basketball',
		'배드민턴': 'badminton',
		'테니스': 'tennis'
	};
	function getSportType(sport) {
		return SPORT_TYPE[sport] || '';
	}

	const SEARCH_TYPE_TEXT = {
		RECOMAND: '지역 · 실력 일치',
		POPULAR: '인기 경기',
		NEW: '최신 경기',
		END: '마감임박 경기'
	};

	const STATUS_PILL = {
		'모집중': 'pill-success',
		'모집 마감': 'pill-info',
		'경기 종료': 'pill-info',
		'경기 취소': 'pill-danger'
	};

	function esc(value) {
		if (value === null || value === undefined) return "";
		return String(value)
			.replace(/&/g, "&amp;")
			.replace(/</g, "&lt;")
			.replace(/>/g, "&gt;")
			.replace(/"/g, "&quot;")
			.replace(/'/g, "&#39;");
	}
	
	function favBtn(item, extraClass){
	    return `<button type="button" class="fav-btn `+(extraClass||"")+(item.favorite ? " is-on" : "")+`"
	    data-fav2 data-auth data-match-type="Personal" data-match-id="`+item.personalMatchId+`" aria-label="관심 경기">${heart}</button>`;
	}

	$(function(){

		function NowList(searchType){
			$.ajax({
				url:"${ctx}/match/list/now",
				type:"post",
			    dataType: "json",
			    data: {
			    	requestType: "ajax",
			    	searchType:searchType,
			    	userLat: userLat,
			    	userLng: userLng
		    	},
				success:function(result){
					let html = "";
					let searchtypeText = SEARCH_TYPE_TEXT[searchType] || "";
					result.forEach(function(item) {
						
					    let sportsType = getSportType(item.sport);

					    html += `
					    	<a class="match-card `+sportsType+`" href="${ctx}/match/detail/view?personalMatchId=`+item.personalMatchId+`">
						    <img class="art" src="${ctx}/img/art-`+sportsType+`.png" alt="">
						    <span class="sport-tag `+sportsType+`">
						    `+esc(item.sport)+`
						    </span>
						    `+favBtn(item, "bare")+`
						    <span class="signal"><img src="${ctx}/img/icon-pin-14.svg" alt="">`+searchtypeText+`</span>
						    <div class="body">
						      <p class="title">
						      	`+esc(item.title)+`
						      </p>
						      <p class="when"><img src="${ctx}/img/icon-calendar-14.svg" alt="">
						      <span class="txt">`+FormatDate(item.matchDate, item.startTime)+`
						      `+esc(item.region)+`
						      </p>
						    </div>
						    <p class="count">
						    	`+item.currentPeople+`명
						    <small>/ 정원 
						    `+item.maxPeople+`
						    명</small></p>
						    <p class="price">
					      	`+Number(item.participationFee).toLocaleString('ko-KR')+`원
					        </p>
						    <div class="bar"><i style="width:`+(item.currentPeople*100/item.maxPeople)+`%"></i></div>
						  </a>
			            `;
					});
					 $("#nowMatchListDiv").html(html);		
				},
				error:function(err){
					console.log(err);
				}
			});
		}
		function NormalList(page,target){
			
	        var data = $('#normalMatchSearchForm').serializeArray();
	        data.push({
	            name: 'page',
	            value: page
	        });
	        data.push({
	            name: 'requestType',
	            value: 'ajax'
	        });	     
	        data.push({
	            name: 'userLat',
	            value: userLat
	        });
	        data.push({
	            name: 'userLng',
	            value: userLng  
	        });
			$.ajax({
				url:"${ctx}/match/list/normal",
				type:"post",
			    dataType: "json",
			    data: data,
				success:function(result){
					let html = "";
					
					if(result.length < PAGE_SIZE){
						$("#moreBtn").addClass("is-hidden");
					}
					result.forEach(function(item) {
						let sportsType = getSportType(item.sport);
					    				    
						/* 개인경기 리스트 */

						html+=`
							<a class="match-row" href="${ctx}/match/detail/view?personalMatchId=`+item.personalMatchId+`">
				            <div class="left"><span class="pill `+(STATUS_PILL[item.status] || 'pill-neutral')+` bd">`+esc(item.status)+`</span><img src="${ctx}/img/sport-icon-`+sportsType+`.png" alt="`+esc(item.sport)+`"></div>
				            <div class="main">
				              <p class="title">
				              `+esc(item.title)+`
				              </p>
				              <div class="meta">
				                <span class="it people">
				                	<img src="${ctx}/img/icon-person.svg" alt="">`+item.currentPeople+`/`+item.maxPeople+` &nbsp; 최소 `+item.minPeople+`명 
				                	<span class="cap">
				                		<i style="width:`+(item.currentPeople*100/item.maxPeople)+`%"></i>
			                		</span>
			                	</span>
				                <span class="it"><img src="${ctx}/img/icon-calendar-16.svg" alt="">`+FormatDate(item.matchDate, item.startTime)+`</span>
				                <span class="it"><img src="${ctx}/img/icon-pin-16.svg" alt="">`+esc(item.region)+`</span>
				                <span class="price">`+Number(item.participationFee).toLocaleString('ko-KR')+`원</span>
				                `+favBtn(item)+`
				              </div>
				            </div>
				          </a>
						`;
					});
					if(target == null || target.id === "normalMatchSearchForm")
						$("#normalMatchListDiv").html(html);
					else if (target.id === "moreBtn")
				    	$("#normalMatchListDiv").append(html);	
				    else 
				    	$("#normalMatchListDiv").html(html);	
				},
				error:function(err){
					console.log(err);
				}
				
			});
		}
		

		//초기 리스트
		locationReady.then(function (loc) {
			
			userLat = loc ? loc.lat : null;
			userLng = loc ? loc.lng : null;
			NowList("${sessionScope.user == null ? 'POPULAR' : 'RECOMAND'}");
			NormalList(page);

		});
		
		$(".btnGroup1").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			NowList($(this).data("type"));
		});
		
		
		
		//일반검색 버튼
		$("#normalBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
		  	$(".normalGroup").removeClass("is-hidden");
		  	$(".mapGroup").addClass("is-hidden");
			//NormalList(page, this);
		});
		$("#mapBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			$(".normalGroup").addClass("is-hidden");
		  	$(".mapGroup").removeClass("is-hidden");
		  	map.relayout();
		  	map.setCenter(mapCenter); 
			searchMapMatch();
			
		});
		$("#moreBtn").on("click", function(e) {
			NormalList(++page,this);
		});

	    $('#normalMatchSearchForm').on('submit', function(e) {
	    	page=1;
			$("#moreBtn").removeClass("is-hidden");
	        e.preventDefault();
		    NormalList(page, this);
	    });
	    $('#mapMatchSearchForm').on('submit', function(e) {
	        e.preventDefault();
			searchPlaces();
	    });
		
	     
		

	});
</script>


<main class="page">
  <div class="container">

    <%-- ===== 지금 볼 만한 경기 ===== --%>
    <section>
      <h2 class="section-title">지금 볼 만한 경기</h2>
      <p class="section-desc">
        <c:choose>
          <c:when test="${sessionScope.user == null}">인기 경기, 마감 임박, 신규 모집을 빠르게 확인해보세요.</c:when>
          <c:otherwise>내 조건에 맞는 경기와 서비스에서 인기 있는 경기를 함께 보여드려요.</c:otherwise>
        </c:choose>
      </p>
      <div class="feature-tabs">
        <c:if test="${sessionScope.user != null}"><a id="nowRecomandBtn" class="btnGroup1 is-active" data-type="RECOMAND">추천 경기</a></c:if>
        <a id="nowPopularBtn" class="btnGroup1 ${sessionScope.user == null ? 'is-active' : ''}" data-type="POPULAR">인기 경기</a>
        <a id="nowEndBtn" class="btnGroup1" data-type="END">마감 임박</a>
        <a id="nowNewBtn" class="btnGroup1" data-type="NEW">신규 모집</a>
      </div>
		<div id="nowMatchListDiv" class="feature-row">
		</div>
    </section>


    <%-- ===== 검색 ===== --%>
    <section class="search-intro">
      <h2>경기를 검색해보세요!</h2>
      <p>종목, 지역, 날짜, 실력과 키워드로 원하는 경기를 찾아보세요.</p>
      <div class="search-mode">
		<a id="normalBtn" class="btnGroup2 is-active">일반 검색</a>
		<a id="mapBtn" class="btnGroup2">지도기반 검색</a>
      </div>





      <form class="normalGroup search-shell" id="normalMatchSearchForm" method="post">
        <div class="filter-row">
          <div class="filter-cluster">
            <div class="chip-group" data-select="multi" data-name="sports">
              <span class="chip-label">종목</span>
              <button type="button" class="chip" data-value="축구/풋살">축구/풋살</button>
              <button type="button" class="chip" data-value="농구">농구</button>
              <button type="button" class="chip" data-value="테니스">테니스</button>
              <button type="button" class="chip" data-value="배드민턴">배드민턴</button>
            </div>
            <div class="filter-more">
              <button type="button" class="btn btn-outline btn-sm" data-filter-toggle>필터 더보기 +</button>
              <div class="filter-panel">
                <div class="chip-group" data-select="single" data-name="gender">
                  <span class="chip-label">성별</span>
                  <button type="button" class="chip" data-value="혼성">성별무관</button>
                  <button type="button" class="chip" data-value="남성">남성</button>
                  <button type="button" class="chip" data-value="여성">여성</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="ages">
                  <span class="chip-label">연령대</span>
                  <button type="button" class="chip">20대</button><button type="button" class="chip">30대</button>
                  <button type="button" class="chip">40대</button><button type="button" class="chip">50대</button>
                  <button type="button" class="chip" data-value="60대">연령무관</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="skills">
                  <span class="chip-label">실력</span>
                  <button type="button" class="chip">입문</button><button type="button" class="chip">초급</button>
                  <button type="button" class="chip">중급</button><button type="button" class="chip">상급</button>
                </div>
              </div>
            </div>
          </div>
          <button type="button" class="btn-reset" data-filter-reset>필터 초기화</button>
        </div>


		<div class="input-row">
		  <div id="normalInputs" class="normalDivGroup" style="display:contents">
		    <select class="select" id="sido" name="sido" style="width: 140px"
				aria-label="시·도">
				<option value="">시 · 도</option>
				<option value="서울시">서울시</option>
				<option value="경기도">경기도</option>
			</select>
			 <select class="select" id="sigungu" name="sigungu" style="width: 140px" aria-label="시군구" disabled>
					<option value="">시군구</option>
			</select>
		    <input type="text"
		           id="periodPicker"
		           class="input periodPicker" 
		           placeholder="날짜 선택 "  
		           style="width:220px;">
		    <input type="hidden" id="startDate" name="startDate">
		    <input type="hidden" id="endDate" name="endDate">
			<input class="input keyword" name="keyword" placeholder="제목 또는 내용 키워드 검색">			
		  </div>
 		  
		  
		  <button type="submit" class="btn btn-primary btn-lg">검색</button>
		</div>
		<div class="normalDivGroup">
			<p id="maxRegion" class="region-max" style="display: none">최대 3개까지 선택 가능합니다.</p>
		    <div class="picked" id="pickedRegions"></div>
		    <div id="regionInputs"></div>
		</div>
        <div class="filter-more" style="padding-top:5px;">
			<span class="count">
             </span>
		</div>
      </form>
      
      
 
      
      <form class="mapGroup search-shell is-hidden" id="mapMatchSearchForm" method="post">
        <div class="filter-row">
          <div class="filter-cluster">
            <div class="chip-group" data-select="multi" data-name="sports">
              <span class="chip-label">종목</span>
              <button type="button" class="chip" data-value="축구/풋살">축구/풋살</button>
              <button type="button" class="chip" data-value="농구">농구</button>
              <button type="button" class="chip" data-value="테니스">테니스</button>
              <button type="button" class="chip" data-value="배드민턴">배드민턴</button>
            </div>
            <div class="filter-more">
              <button type="button" class="btn btn-outline btn-sm" data-filter-toggle>필터 더보기 +</button>
              <div class="filter-panel">
                <div class="chip-group" data-select="single" data-name="gender">
                  <span class="chip-label">성별</span>
                  <button type="button" class="chip" data-value="남성">남성</button>
                  <button type="button" class="chip" data-value="여성">여성</button>
                  <button type="button" class="chip" data-value="혼성">성별무관</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="ages">
                  <span class="chip-label">연령대</span>
                  <button type="button" class="chip">20대</button><button type="button" class="chip">30대</button>
                  <button type="button" class="chip">40대</button><button type="button" class="chip">50대</button>
                  <button type="button" class="chip" data-value="60대">연령무관</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="skills">
                  <span class="chip-label">실력</span>
                  <button type="button" class="chip">입문</button><button type="button" class="chip">초급</button>
                  <button type="button" class="chip">중급</button><button type="button" class="chip">상급</button>
                </div>
              </div>
            </div>
          </div>
          <button type="button" class="btn-reset" data-filter-reset>필터 초기화</button>
        </div>


		<div class="input-row">
		  <div id="mapInputs" style="display:contents">
	          <div class="map-query">
	            <input id="keyword" type="text" name="keyword" placeholder="지역을 검색해 주세요" aria-label="키워드" data-value="서울시청">
			  </div>
			    <input type="text"
				       id="mapPeriodPicker"
				       class="input periodPicker"
				       placeholder="날짜 선택 "
				       style="width:220px;">
				<input type="hidden" id="mapStartDate" name="startDate">
				<input type="hidden" id="mapEndDate" name="endDate">
		  	</div>
		  
		  
		  <button type="submit" class="btn btn-primary btn-lg">검색</button>
		</div>
		<div class="filter-more" style="padding-top:5px;">
			<span class="count">
             </span>
		</div>
      </form>
    </section>



	      <%-- ===== 일반 검색 결과 : 경기 리스트 ===== --%>
	      <div id="normalDiv" class="normalGroup" style="display:contents">
	        <section class="list-head">
	          <h2 class="section-title">경기 리스트</h2>
	          <p class="section-desc">검색 조건에 맞는 경기를 한 줄씩 빠르게 비교해보세요.</p>
	        </section>
	        <div id="normalMatchListDiv" class="match-rows">
	        </div>
	        <div class="more-wrap">
	        	<button id="moreBtn" type="button" class="btn-more">↓ &nbsp;더보기</button>
	       	</div>
	   	</div>



      	<div id="mapDiv" class="mapGroup is-hidden" style="display:contents">
	        <section class="list-head">
	          <h2 class="section-title">지도 기반 경기 찾기</h2>
	          <p class="section-desc">검색한 지역 주변 경기를 지도에서 확인하세요.</p>
	        </section>
	        
	        
	        <div class="map-result">
   	          <div class="map-canvas" id="map">
   	          </div>
	          <div id="mapMatchListDiv" class="map-list" style="max-height:420px;overflow-y: auto;">
	           </div>
	        </div>
		</div>
  </div>
</main>

	<a id="matchMakeButton" class="fab" href="${ctx}/match/write/form" data-auth 
		data-account="${not empty sessionScope.user.bankName
	    and not empty sessionScope.user.accountNumber
	    and not empty sessionScope.user.accountHolder}">
	  <span class="fab-label">경기 만들기</span><span class="fab-btn" aria-hidden="true"></span>
	</a>

<%@ include file="/jsp/common/footer.jsp" %>

<script>
	const DEFAULT_MAP_LAT = 37.5700;
	const DEFAULT_MAP_LNG = 126.979;
	const DEFAULT_MAP_LEVEL = 7;

	let markers = [];
	let overlays = []; 
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
	    center: new kakao.maps.LatLng(DEFAULT_MAP_LAT, DEFAULT_MAP_LNG), // 지도의 중심좌표
	    level: DEFAULT_MAP_LEVEL // 지도의 확대 레벨
	};
	var map = new kakao.maps.Map(mapContainer, mapOption);
	let mapCenter = map.getCenter();                         // 현재 기준 중심 저장
	locationReady.then(function (loc) {
		if (!loc) return;                                    // 위치 실패 → 서울시청 유지
		mapCenter = new kakao.maps.LatLng(loc.lat, loc.lng);
		map.setCenter(mapCenter);
	});
	
	var ps = new kakao.maps.services.Places();  
	
	kakao.maps.event.addListener(map, 'dragend', function() {
		searchMapMatch();
	});
	kakao.maps.event.addListener(map, 'zoom_changed', function() {
		searchMapMatch();
	});
	
	
	function searchPlaces() {

	    var keyword = document.getElementById('keyword').value;
	    //if (!keyword) 
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	    	searchMapMatch();
	        return false;
	    }
	    ps.keywordSearch( keyword, placesSearchCB); 
	}
	//콜백함수
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	        movePlace(data);
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	    } else if (status === kakao.maps.services.Status.ERROR) {
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	    }
	}
	function movePlace(places) {
	    var moveLatLon = new kakao.maps.LatLng(places[0].y, places[0].x);
	    map.setCenter(moveLatLon);
	    searchMapMatch();
	}
	
	function createMarker(item) {
    	 
	    let sportsType = getSportType(item.sport);
		 const position = new kakao.maps.LatLng(
		 	item.latitude,
		 	item.longitude
	    );

		var imageSrc = "${ctx}/img/art-"+sportsType+".png"; // 마커이미지의 주소입니다  
	    var imageSize = new kakao.maps.Size(64, 69); // 마커이미지의 크기입니다
	    var imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

	    const marker = new kakao.maps.Marker({
	        map: map,
	        position: position
	       //image: markerImage
	    });


	    const content = `
	        <div class="map-list">
	            <a href="${ctx}/match/detail/view?personalMatchId=`+item.personalMatchId+`"
	               class="`+sportsType+` is-active"
	               data-pin="`+item.personalMatchId+`">
	                <small>`+esc(item.sport)+`</small>
	                <strong>`+esc(item.title)+`</strong>
	                <span>`+FormatDate(item.matchDate, item.startTime)+`</span>

	            </a>
	        </div>
	    `;
	    const overlay = new kakao.maps.CustomOverlay({
	        content: content,
	        position: position,
	        yAnchor: 1.35
	    });
	    overlays.push(overlay);
	    kakao.maps.event.addListener(marker, "mouseover", function() {
	        overlay.setMap(map);
	    });

	    kakao.maps.event.addListener(marker, "mouseout", function() {
	        overlay.setMap(null);
	    });
	    kakao.maps.event.addListener(marker, "click", function() {
	        location.href =
	            "${ctx}/match/detail/view?personalMatchId="
	            + item.personalMatchId;
	    });

	    return marker;
	}
	

	
	function removeMarkers() {
	    markers.forEach(function(marker) {
	        marker.setMap(null);
	    });
	    markers = [];
	    overlays.forEach(function(overlay) {
	        overlay.setMap(null);
	    });
	    overlays = [];
	}

	function searchMapMatch() {
		overlays.forEach(function(overlay) {
	        overlay.setMap(null);
	    });
	    const bounds = map.getBounds();
	    const sw = bounds.getSouthWest();
	    const ne = bounds.getNorthEast();
        var data = $('#mapMatchSearchForm').serializeArray();
        data.push({
            name: 'minLat',
            value: sw.getLat()
        });
        data.push({
            name: 'maxLat',
            value: ne.getLat()
        });
        data.push({
            name: 'minLng',
            value: sw.getLng()
        });
        data.push({
            name: 'maxLng',
            value: ne.getLng()
        });
        data.push({
            name: 'requestType',
            value: "ajax"
        });

	     $.ajax({
	        url: "${ctx}/match/list/map",
	        type: "POST",
		    dataType: "json",
	        data:data,
	        success: function(data) {
	            removeMarkers();
				let html = "<h3>지도 주변 경기</h3>";
	            data.forEach(function(item) {	
	            	html += `
	            		<a href="${ctx}/match/detail/view?personalMatchId=`+item.personalMatchId+`"
	            		   class="`+getSportType(item.sport)+` is-active" data-pin="`+item.personalMatchId+`">
	            			<small>`+esc(item.sport)+`</small>
	            			<div class="map-title-row">
	            				<strong>`+esc(item.title)+`</strong>
	            				`+favBtn(item, "bare")+`
	            			</div>
	            			<span>`+FormatDate(item.matchDate, item.startTime)+`</span>
	            			<span>`+Number(item.participationFee + item.fee).toLocaleString('ko-KR')+`원</span>
	            			
	            		</a>
	            	`;
	            	//마커찍기
	                const marker = createMarker(item);
	                markers.push(marker);

	            });
			 	$("#mapMatchListDiv").html(html);		

	        }
	    }); 
	    
	}
	


</script>
<script src="${ctx}/js/address.js"></script>
<script src="${ctx}/js/common.match.js"></script>

<script>
	function initPeriodPicker(pickerId, startId, endId, onPicked) {
		const el = document.getElementById(pickerId);
		if (!el) return;
		flatpickr(el, {
			mode: 'range',
			locale: 'ko',
			dateFormat: 'Y-m-d',
			disableMobile: true,
			onClose: function (selectedDates, dateStr, instance) {
				if (selectedDates.length === 2) {
					document.getElementById(startId).value = instance.formatDate(selectedDates[0], 'Y-m-d');
					document.getElementById(endId).value = instance.formatDate(selectedDates[1], 'Y-m-d');
					if (onPicked) onPicked();
				}
			}
		});
	}

	// 일반 검색
	initPeriodPicker('periodPicker', 'startDate', 'endDate');

	// 지도 검색: 날짜 고르면 바로 지도 재검색
	initPeriodPicker('mapPeriodPicker', 'mapStartDate', 'mapEndDate', function () {
	});
</script>
