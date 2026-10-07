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
<c:set var="pageCss" value="home" />
<c:set var="pageJs" value="home" />
<c:set var="activeNav" value="match" />
<c:set var="showFooter" value="true" />
<c:set var="demoStates" value="list:일반 검색|map:지도 검색|mapTyping:지도-입력 중|mapPin:지도-핀 선택" />
<%@ include file="/jsp/common/header.jsp" %>
<style>
	.is-hidden { display: none !important; }
</style>
<script src="${ctx}/js/common_header.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<script>
	let page =1;

	$(function(){
		let data = {"userId":"test1","grade":"User"};
		
		function NowList(searchType){
			$.ajax({
				url:"${ctx}/match/list/now",
				type:"post",
			    dataType: "json",
			    data: {
			    	requestType: "ajax",
			    	searchType:searchType,
			    	data:JSON.stringify(data),
			    	},
				success:function(result){
					let html = "";
					
					result.forEach(function(item) {
						
					    let sportsType = "";
					    if(item.sport == "축구/풋살" || item.sport == "축구"){
					    	sportsType="football";
					    }else if(item.sport == "농구"){
					    	sportsType="basketball";
					    }else if(item.sport == "배드민턴"){
					    	sportsType="badminton";
					    }else if(item.sport == "테니스"){
					    	sportsType="tennis";
					    }
					    

					    html += `
					    	<a class="match-card `+sportsType+`" href="${ctx}/match/detail/view?personalMatchId=`+item.personalMatchId+`">
						    <img class="art" src="${ctx}/img/art-`+sportsType+`.png" alt="">
						    <span class="sport-tag football">
						    `+item.sport+`
						    </span>
						    <button type="button" class="fav-btn bare" data-fav data-auth aria-label="관심 경기">${heart}</button>
						    <span class="signal"><img src="${ctx}/img/icon-pin-14.svg" alt="">${role eq 'guest' ? '인기 경기' : '지역 · 실력 일치'}</span>
						    <div class="body">
						      <p class="title">
						      	`+item.title+`
						      </p>
						      <p class="when"><img src="${ctx}/img/icon-calendar-14.svg" alt="">
				                `+formatDate(item.matchDate, item.startTime)+`
						      `+item.region+`
						      </p>
						      <p class="price">
						      	`+item.participationFee+`원
						      </p>
						    </div>
						    <p class="count">
						    	`+item.currentPeople+`명
						    <small>/ 정원 
						    `+item.maxPeople+`
						    명</small></p>
						    <div class="bar"><i style="width:`+(item.currentPeople*100/item.maxPeople)+`%"></i></div>
						  </a>
			            `;
					});
					 $("#nowMatchListDiv").html(html);		
				},
				error:function(err){
					console.log("err");
					console.log(err);
				}
			});
		}
		function NormalList(page,target){
			
	        var data = $('#matchSearchForm').serializeArray();
	        data.push({
	            name: 'page',
	            value: page
	        });

	        data.push({
	            name: 'requestType',
	            value: 'ajax'
	        });
	        
	        console.log(data);
			
			$.ajax({
				url:"${ctx}/match/list/normal",
				type:"post",
			    dataType: "json",
			    data: data,
				success:function(result){
					console.log(result);
					let html = "";
					result.forEach(function(item) {
						let sportsType = "";
					    if(item.sport == "축구/풋살" || item.sport == "축구"){
					    	sportsType="football";
					    }else if(item.sport == "농구"){
					    	sportsType="basketball";
					    }else if(item.sport == "배드민턴"){
					    	sportsType="badminton";
					    }else if(item.sport == "테니스"){
					    	sportsType="tennis";
					    }
						
						html+=`
							<a class="match-row" href="${ctx}/match/detail/view?personalMatchId=`+item.personalMatchId+`">
				            <div class="left"><span class="pill pill-success bd">모집중</span><img src="${ctx}/img/sport-icon-`+sportsType+`.png" alt="축구/풋살"></div>
				            <div class="main">
				              <p class="title">
				              `+item.title+`
				              </p>
				              <div class="meta">
				                <span class="it people"><img src="${ctx}/img/icon-person.svg" alt="">8/10 &nbsp; 최소 8명 <span class="cap"><i style="width:80%"></i></span></span>
				                <span class="it"><img src="${ctx}/img/icon-calendar-16.svg" alt="">9/19 (토)</span>
				                <span class="it"><img src="${ctx}/img/icon-clock-16.svg" alt="">19:00</span>
				                <span class="it"><img src="${ctx}/img/icon-pin-16.svg" alt="">서울 마포구</span>
				                <span class="price">10,000원</span>
				                <button type="button" class="fav-btn" data-fav data-auth aria-label="관심 경기">${heart}</button>
				              </div>
				            </div>
				          </a>
						`;
					});
					if(target == null || target.id === "matchSearchForm")
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
		function MapList(page){
			$.ajax({
				url:"${ctx}/match/list/map",
				type:"post",
			    dataType: "json",
			    data: {
			    	requestType: "ajax",
			    	page:page,
			    	data:data,
			    	},
				success:function(result){
					console.log(result);

				},
				error:function(err){
					console.log("err");
					console.log(err);
				}
				
			});
		}
		NowList("RECOMAND");
		NormalList(page);

		$("#nowRecomandBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			NowList("RECOMAND");
		});
		$("#nowPopularBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			NowList("POPULAR");
		});
		$("#nowEndBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			NowList("END");
		});
		$("#nowNewBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			NowList("NEW");
		});
		
		//일반검색 버튼
		$("#normalBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			$(".normalDivGroup").removeClass("is-hidden");
		  	$(".mapDivGroup").addClass("is-hidden");
			page=1;
			NormalList(page, this);
		});
		$("#mapBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			$(".normalDivGroup").addClass("is-hidden");
		  	$(".mapDivGroup").removeClass("is-hidden");
			map.relayout();
			searchMatch(); 

		});
		$("#moreBtn").on("click", function(e) {
			NormalList(++page,this);
		})//전송 이벤트	//전송 이벤트
	    $('#matchSearchForm').on('submit', function(e) {
	        e.preventDefault();
	        if ($("#mapInputs").hasClass("is-hidden")) {
	        	
			    NormalList(page, this);
			} else {
				searchPlaces();
			    searchMatch();   
			}
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
        <c:if test="${sessionScope.user != null}"><a id="nowRecomandBtn" class="btnGroup1 is-active">추천 경기</a></c:if>
        <a id="nowPopularBtn" class="btnGroup1 ${sessionScope.user == null ? 'is-active' : ''}">인기 경기</a>
        <a id="nowEndBtn" class="btnGroup1">마감 임박</a>
        <a id="nowNewBtn" class="btnGroup1">신규 모집</a>
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


      <%-- TODO: action 을 검색 서블릿 URL 로 교체 (예: ${ctx}/match/list) --%>
      <form class="search-shell" id="matchSearchForm" method="post">
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
              <span class="count">0</span>
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
                  <button type="button" class="chip" data-value="60대">60대+</button>
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
		           class="input"
		           placeholder="날짜 선택"
		           style="width:220px">
		    <input type="hidden" id="startDate" name="startDate">
		    <input type="hidden" id="endDate" name="endDate">
			<input class="input keyword" name="keyword" placeholder="제목 또는 내용 키워드 검색">			
		  </div>
 		  
		  
		  
		  <div id="mapInputs" class="mapDivGroup is-hidden" style="display:contents">
	          <div class="map-query">
	            <input id="keyword" type="text" name="keyword" placeholder="지역을 검색해 주세요" aria-label="키워드" data-value="서울시청">
			  </div>
		  </div>
		  
		  
		  <button type="submit" class="btn btn-primary btn-lg">검색</button>
		</div>
		<div class="normalDivGroup">
			<p id="maxRegion" class="region-max" style="display: none">최대 3개까지 선택 가능합니다.</p>
		    <div class="picked" id="pickedRegions"></div>
		    <div id="regionInputs"></div>
		</div>
      </form>
    </section>



	      <%-- ===== 일반 검색 결과 : 경기 리스트 ===== --%>
	      <div id="normalDiv" class="normalDivGroup" style="display:contents">
	        <section class="list-head">
	          <h2 class="section-title">경기 리스트</h2>
	          <p class="section-desc">검색 조건에 맞는 경기를 한 줄씩 빠르게 비교해보세요.</p>
	        </section>
	        <%-- TODO: <c:forEach var="m" items="${matchList}"> 로 아래 행 하나를 반복 --%>
	        <div id="normalMatchListDiv" class="match-rows">

	        </div>
	        <div class="more-wrap">
	        	<button id="moreBtn" type="button" class="btn-more">↓ &nbsp;더보기</button>
	       	</div>
	   	</div>



      	<div id="mapDiv" class="mapDivGroup is-hidden" style="display:contents">
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

<a class="fab" href="${ctx}/match/write/form" data-auth>
  <span class="fab-label">경기 만들기</span><span class="fab-btn" aria-hidden="true"></span>
</a>

<%@ include file="/jsp/common/footer.jsp" %>

<script>
	let markers = [];
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
	    center: new kakao.maps.LatLng(37.5675000, 126.9790000), // 지도의 중심좌표
	    level: 5 // 지도의 확대 레벨
	};
	var map = new kakao.maps.Map(mapContainer, mapOption);

	var ps = new kakao.maps.services.Places();  
	
	kakao.maps.event.addListener(map, 'dragend', function() {
	    searchMatch();
	});
	kakao.maps.event.addListener(map, 'zoom_changed', function() {
	    searchMatch();
	});
	
	
	function searchPlaces() {

	    var keyword = document.getElementById('keyword').value;
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
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
	    searchMatch();
	    
	}
	


	function createMarker(item) {
    	 
	    let sportsType = "";
	    if(item.sport == "축구/풋살" || item.sport == "축구"){
	    	sportsType="football";
	    }else if(item.sport == "농구"){
	    	sportsType="basketball";
	    }else if(item.sport == "배드민턴"){
	    	sportsType="badminton";
	    }else if(item.sport == "테니스"){
	    	sportsType="tennis";
	    }
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
	            <a href="${ctx}/match/detail/view?personalMatchId="`+item.personalMatchId+`
	               class="football ${state eq 'mapPin' ? '' : 'is-active'}"
	               data-pin="m1">
	                <small>`+item.sport+`</small>
	                <strong>`+item.title+`</strong>
	                <span>`+formatDate(item.matchDate, item.startTime)+`</span>

	            </a>
	        </div>
	    `;
	    const overlay = new kakao.maps.CustomOverlay({
	        content: content,
	        position: position,
	        yAnchor: 1.35
	    });

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
	}
	

	function searchMatch() {
	    const bounds = map.getBounds();
	    const sw = bounds.getSouthWest();
	    const ne = bounds.getNorthEast();
	    const minLat = sw.getLat();
	    const maxLat = ne.getLat();
	    const minLng = sw.getLng();
	    const maxLng = ne.getLng();
        var data = $('#matchSearchForm').serializeArray();
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
				let html = "<h3>지도 주변 경기 4개</h3>";
	            data.forEach(function(item) {	
					html+= `
			            <a href="${ctx}/match/detail/view?="`+item.personalMatchId+` 
			            class="football ${state eq 'mapPin' ? '' : 'is-active'}" data-pin="m1">
			            <small>`+item.sport+`</small>
			            <strong>`+item.title+`</strong>
		                <span>`+formatDate(item.matchDate, item.startTime)+`</span>
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

<script>
	const periodPicker = document.getElementById('periodPicker');
	if (periodPicker) {
		flatpickr(periodPicker, {
			mode: 'range',                    // 기간 선택
			locale: 'ko',
			dateFormat: 'Y-m-d',
			disableMobile: true,
			defaultDate: ['${startDate}', '${endDate}'],   // 현재 조회 중인 기간 표시
			onClose: function (selectedDates, dateStr, instance) {
				// 시작일, 종료일 둘 다 골랐을 때만 조회
				if (selectedDates.length === 2) {
					document.getElementById('startDate').value = instance.formatDate(selectedDates[0], 'Y-m-d');
					document.getElementById('endDate').value = instance.formatDate(selectedDates[1], 'Y-m-d');
				}
			}
		});
	}
</script>
	



