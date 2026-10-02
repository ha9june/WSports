<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 찾기 (personalMatchList.jsp) - 담당: 변재언
  피그마: Home / Guest · Member · Admin / Desktop, Home / * / Map Search (Typing · Moved · Pin Selected)
  ─ 하나의 JSP 로 처리 ─
   role  : guest(인기 기준 추천, 로그인 버튼) / member·admin(맞춤 추천 탭 추가)
   state : list(일반 검색) | map(지도 검색) | mapTyping(지도 검색어 입력 중) | mapPin(지도 핀 선택)
--%>
<c:set var="state" value="${empty param.state ? 'list' : param.state}" />
<c:set var="isMap" value="${fn:startsWith(state, 'map')}" />
<c:set var="pageTitle" value="경기 찾기" />
<c:set var="pageCss" value="home" />
<c:set var="pageJs" value="home" />
<c:set var="activeNav" value="match" />
<c:set var="showFooter" value="true" />
<c:set var="demoStates" value="list:일반 검색|map:지도 검색|mapTyping:지도-입력 중|mapPin:지도-핀 선택" />
<%@ include file="/jsp/common/header.jsp" %>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>
<script src="${ctx}/js/common_header.js"></script>
<script>

	let isMapp = false;
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
					    	<a class="match-card `+sportsType+`" href="${ctx}/match/detail/view?num=`+item.personalMatchId+`">
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
		function NormalList(page){
			$.ajax({
				url:"${ctx}/match/list/normal",
				type:"post",
			    dataType: "json",
			    data: {
			    	requestType: "ajax",
			    	page:page,
			    	data:data,
			    	},
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
							<a class="match-row" href="${ctx}/jsp/match/personalMatchDetail.jsp">
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
					
				 	$("#normalMatchListDiv").append(html);		

				},
				error:function(err){
					console.log("err");
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
		//지도기반검색 버튼
		$("#normalBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			isMapp = false;
			$("#normalDiv").show();
			$("#mapDiv").hide();

		});
		$("#mapBtn").on("click", function() {
			$(this).siblings("a").removeClass("is-active");
			$(this).addClass("is-active");
			isMapp = true;
			$("#normalDiv").hide();
			$("#mapDiv").show();
			map.relayout();

		});
		$("#moreBtn").on("click", function() {
			
			NormalList(++page);
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
          <c:when test="${role eq 'guest'}">인기 경기, 마감 임박, 신규 모집을 빠르게 확인해보세요.</c:when>
          <c:otherwise>내 조건에 맞는 경기와 서비스에서 인기 있는 경기를 함께 보여드려요.</c:otherwise>
        </c:choose>
      </p>
      <div class="feature-tabs">
        <c:if test="${role ne 'guest'}"><a id="nowRecomandBtn" class="btnGroup1 is-active">추천 경기</a></c:if>
        <a id="nowPopularBtn" class="btnGroup1 ${role eq 'guest' ? 'is-active' : ''}">인기 경기</a>
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
        <a id="normalBtn" class="btnGroup2 ${isMap ? '' : 'is-active'}">일반 검색</a>
        <a id="mapBtn" class=" btnGroup2 ${isMap ? 'is-active' : ''}">지도기반 검색</a>
      </div>
      <%--         <a href="?state=list" class="${isMap ? '' : 'is-active'}">일반 검색</a>
        <a href="?state=map" class="${isMap ? 'is-active' : ''}">지도기반 검색</a> --%>
      
      
      
      
      
      
            

      <%-- TODO: action 을 검색 서블릿 URL 로 교체 (예: ${ctx}/match/list) --%>
      <form class="search-shell" action="${ctx}/jsp/match/personalMatchList.jsp" method="get">
        <input type="hidden" name="state" value="${state}">
        <div class="filter-row">
          <div class="filter-cluster">
            <div class="chip-group" data-select="multi" data-name="sport">
              <span class="chip-label">종목</span>
              <button type="button" class="chip" data-value="FOOTBALL">축구/풋살</button>
              <button type="button" class="chip" data-value="BASKETBALL">농구</button>
              <button type="button" class="chip" data-value="TENNIS">테니스</button>
              <button type="button" class="chip" data-value="BADMINTON">배드민턴</button>
            </div>
            <div class="filter-more">
              <button type="button" class="btn btn-outline btn-sm" data-filter-toggle>필터 더보기 +</button>
              <span class="count">0</span>
              <div class="filter-panel">
                <div class="chip-group" data-select="single" data-name="gender">
                  <span class="chip-label">성별</span>
                  <button type="button" class="chip neutral is-selected" data-all data-value="ALL">전체</button>
                  <button type="button" class="chip" data-value="M">남성</button>
                  <button type="button" class="chip" data-value="F">여성</button>
                  <button type="button" class="chip" data-value="MIX">혼성</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="age">
                  <span class="chip-label">연령대</span>
                  <button type="button" class="chip">20대</button><button type="button" class="chip">30대</button>
                  <button type="button" class="chip">40대</button><button type="button" class="chip">50대+</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="level">
                  <span class="chip-label">실력</span>
                  <button type="button" class="chip">입문</button><button type="button" class="chip">초급</button>
                  <button type="button" class="chip">중급</button><button type="button" class="chip">상급</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="time">
                  <span class="chip-label">시간대</span>
                  <button type="button" class="chip">오전</button><button type="button" class="chip">오후</button><button type="button" class="chip">저녁</button>
                </div>
              </div>
            </div>
          </div>
          <button type="button" class="btn-reset" data-filter-reset>필터 초기화</button>
        </div>








        <div class="input-row">
          <c:choose>
          
          
          
          
          
            <c:when test="${isMap}">
              <div class="map-query ${state eq 'mapTyping' ? 'is-focus' : ''}">
                <span class="t-3">⌕</span>
                
                
                <c:choose>
                  <c:when test="${state eq 'mapTyping'}">
                    <input type="text" name="keyword" value="망원" autofocus aria-label="지역 또는 경기명">
                  </c:when>
                  <c:otherwise>
                    <span class="token-chip">📍 마포구 망원동 <button type="button" aria-label="지역 삭제">✕</button></span>
                    <input type="text" name="keyword" placeholder="경기명·팀명도 검색할 수 있어요" aria-label="키워드">
                  </c:otherwise>
                </c:choose>
                
                
                
                
                <div class="search-dropdown" ${state eq 'mapTyping' ? '' : 'hidden'}>
                  <p class="grp-title">지역 · 장소 — 선택하면 지도가 이동해요</p>
                  <a href="?state=map" class="is-hover"><span class="ic">📍</span><span><b>망원</b> 동</span></a>
                  <a href="?state=map"><span class="ic">📍</span><span><b>망원</b> 한강공원</span></a>
                  <a href="?state=map"><span class="ic">📍</span><span><b>망원</b> 시장</span></a>
                  <hr>
                  <p class="grp-title">경기 — 현재 지도 영역에서 찾아요</p>
                  <a href="${ctx}/jsp/match/personalMatchDetail.jsp"><span class="ic" style="background:var(--ds-bg-muted)">⌕</span>토요일 저녁 풋살 한 판!</a>
                  <a href="?state=map" class="all">'망원'이 들어간 경기 모두 보기</a>
                </div>
              </div>
              <select class="select date" name="period" aria-label="기간"><option>기간 선택</option><option>오늘</option><option>이번 주</option><option>이번 달</option></select>
            
            </c:when>
            
            <c:otherwise>
              <select class="select" name="region" aria-label="지역"><option value="">지역 검색</option><option>서울 마포구</option><option>서울 성동구</option><option>서울 송파구</option></select>
              <select class="select date" name="period" aria-label="기간"><option value="">기간 선택</option><option>오늘</option><option>이번 주</option><option>이번 달</option></select>
              <input class="input keyword" type="text" name="keyword" placeholder="키워드 검색" aria-label="키워드">
            </c:otherwise>
            
            
          </c:choose>
          
          
          
          
          <button type="submit" class="btn btn-primary btn-lg">검색</button>
        </div>
      </form>
    </section>



	      <%-- ===== 일반 검색 결과 : 경기 리스트 ===== --%>
	      <div id="normalDiv" class="normalDiv">
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






      	<div id="mapDiv" class="mapDiv" style="display: none;">
	        <section class="list-head">
	          <h2 class="section-title">지도 기반 경기 찾기</h2>
	          <p class="section-desc">검색한 지역 주변 경기를 지도에서 확인하세요.</p>
	        </section>
	        
	        
	        <div class="map-result">
	          <%-- TODO: 카카오/네이버 지도 API 로 교체 (핀 좌표는 경기 장소의 위경도) --%>
	          <%-- <div class="map-canvas" id="map">
	            <a href="#" class="pin ${state eq 'mapPin' ? '' : 'is-active'}" data-pin="m1" style="left:16%;top:26%"><span>풋살 · 1.2km</span></a>
	            <a href="#" class="pin" data-pin="m2" style="left:68%;top:22%"><span>테니스 · 2.4km</span></a>
	            <a href="#" class="pin ${state eq 'mapPin' ? 'is-active' : ''}" data-pin="m3" style="left:54%;top:55%"><span>농구 · 3.1km</span></a>
	            <a href="#" class="pin" data-pin="m4" style="left:37%;top:78%"><span>배드민턴 · 4.0km</span></a>
	            <c:if test="${state eq 'mapPin'}">
	              <div class="map-popup" style="left:39%;top:9%">
	                <span class="sport-tag basketball">농구</span>
	                <strong>주말 실내 농구 같이 하실 분</strong>
	                <p>9/20 14:00 · 성동구 · 3.1km</p>
	                <p class="price">8,000원</p>
	                <a class="btn btn-primary btn-sm btn-block" href="${ctx}/jsp/match/personalMatchDetail.jsp">경기 자세히 보기</a>
	              </div>
	            </c:if>
	            <button type="button" class="ctrl" style="bottom:60px" aria-label="현재 위치">⌖</button>
	            <button type="button" class="ctrl" style="bottom:16px" aria-label="확대">+</button>
	          </div> --%>
	          
   	          <div class="map-canvas" id="map">
   
   	          </div>
          
	          
	          
	          
	          
	          
	          
	          <div id="mapMatchListDiv" class="map-list">
	            <h3>지도 주변 경기 4개</h3>
	            <%-- <a href="${ctx}/jsp/match/personalMatchDetail.jsp" class="football ${state eq 'mapPin' ? '' : 'is-active'}" data-pin="m1"><small>축구/풋살</small><strong>토요일 저녁 풋살 한 판!</strong><span>9/19 19:00 · 망원동 · 1.2km</span></a>
	            <a href="${ctx}/jsp/match/personalMatchDetail.jsp" class="tennis" data-pin="m2"><small>테니스</small><strong>초중급 테니스 복식 모집</strong><span>9/21 18:30 · 송파구 · 2.4km</span></a>
	            <a href="${ctx}/jsp/match/personalMatchDetail.jsp" class="basketball ${state eq 'mapPin' ? 'is-active' : ''}" data-pin="m3"><small>농구</small><strong>주말 실내 농구 같이 하실 분</strong><span>9/20 14:00 · 성동구 · 3.1km</span></a>
	            <a href="${ctx}/jsp/match/personalMatchDetail.jsp" class="badminton" data-pin="m4"><small>배드민턴</small><strong>퇴근 후 배드민턴</strong><span>9/22 20:00 · 영등포구 · 4.0km</span></a>
	           --%></div>
	          
	          
	          

	        </div>
	        
	        
	        
	        
	        
	        
	        
		</div>






    
    
    
    
    
    
    
    
  </div>
</main>

<a class="fab" href="${ctx}/match/create" data-auth>
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
	
	//지도를 미리 생성
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	
	kakao.maps.event.addListener(map, 'dragend', function() {
	    searchMatch();
	});
	kakao.maps.event.addListener(map, 'zoom_changed', function() {
	    searchMatch();
	});
	
	
	
	//<a href="#" class="pin " data-pin="m3" style="left:54%;top:55%"><span>농구 · 3.1km</span></a>
    //<a href="#" class="pin is-active" data-pin="m1" style="left:16%;top:26%"><span>풋살 · 1.2km</span></a>
	
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
		 


		//	 var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    

		var imageSrc = "${ctx}/img/art-"+sportsType+".png"; // 마커이미지의 주소입니다  
	    var imageSize = new kakao.maps.Size(64, 69); // 마커이미지의 크기입니다
	    var imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);


	    const marker = new kakao.maps.Marker({
	        map: map,
	        position: position
	       //image: markerImage

	    });

	    // 커스텀 오버레이
	    const content = `
	        <div class="map-list">
	            <a href="${ctx}/match/detail/view?num="`+item.personalMatchId+`
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

	    // 마우스 오버
	    kakao.maps.event.addListener(marker, "mouseover", function() {
	        overlay.setMap(map);
	    });

	    // 마우스 아웃
	    kakao.maps.event.addListener(marker, "mouseout", function() {
	        overlay.setMap(null);
	    });

	    // 마커 클릭
	    kakao.maps.event.addListener(marker, "click", function() {
	        location.href =
	            "${ctx}/match/detail/view?num="
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

	     $.ajax({
	        url: "${ctx}/match/list/map",
	        type: "POST",
		    dataType: "json",
	        data: {
	        	requestType:"ajax",
	            minLat: sw.getLat(),
	            maxLat: ne.getLat(),
	            minLng: sw.getLng(),
	            maxLng: ne.getLng()
	        },
	        success: function(data) {
	            // 경기 목록 갱신
	            console.log(data);
	            removeMarkers();
	            
	            
				let html = "";
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
	

	//주소-좌표 변환 객체를 생성
	var geocoder = new kakao.maps.services.Geocoder();
	//마커를 미리 생성

	
	

</script>




