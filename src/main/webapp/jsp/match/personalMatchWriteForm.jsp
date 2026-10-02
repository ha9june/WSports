<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 만들기 (personalMatchWriteForm.jsp) - 담당: 김도윤
  피그마: Match / Write Form / Desktop
--%>
<c:set var="pageTitle" value="경기 만들기" />
<c:set var="pageCss" value="match" />
<c:set var="activeNav" value="match" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>

<main class="page">
<form class="form-rail" action="${ctx}/jsp/match/personalMatchDetail.jsp" method="post" enctype="multipart/form-data">
  <nav class="breadcrumb"><a href="${ctx}/jsp/match/personalMatchList.jsp">경기 찾기</a><span class="sep">›</span><span>경기 만들기</span></nav>
  <div class="page-head"><h1 class="page-title">경기 만들기</h1></div>

	<input type="text" id="sample5_address" placeholder="주소">
	<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
	<div id="map" style="width:300px;height:300px;margin-top:10px;"></div>

  <section class="form-section">
    <div class="field">
      <span class="field-label">종목</span>
      <div class="chip-group" data-select="single" data-name="sportCode">
        <button type="button" class="chip is-selected" data-value="FOOTBALL">축구/풋살</button>
        <button type="button" class="chip" data-value="BASKETBALL">농구</button>
        <button type="button" class="chip" data-value="TENNIS">테니스</button>
        <button type="button" class="chip" data-value="BADMINTON">배드민턴</button>
      </div>
    </div>
    <div class="field">
      <label class="field-label" for="title">제목</label>
      <input class="input" id="title" name="title" placeholder="예: 토요일 저녁 풋살 한 판!" value="" required>
    </div>
  </section>

  <section class="form-section">
    <h2 class="sub-title">일정 및 장소</h2>
    <div class="grid-3">
      <div class="field"><label class="field-label" for="matchDate">경기일자</label><input class="input" type="date" id="matchDate" name="matchDate" value="2026-09-19"></div>
      <div class="field"><span class="field-label">시간</span>
        <div class="time-range">
          <select class="select" name="startTime" aria-label="시작 시간"><option>18:00</option><option selected>19:00</option><option>20:00</option></select>
          <span>~</span>
          <select class="select" name="endTime" aria-label="종료 시간"><option>20:00</option><option selected>21:00</option><option>22:00</option></select>
        </div>
      </div>
    </div>
    <div class="field">
      <label class="field-label" for="place">장소</label>
      <%-- TODO: 지도 API 장소 검색 연동 (선택 시 위경도 hidden 저장) --%>
      <input class="input" id="place" name="place" placeholder="장소를 검색하세요" value="">
      <input type="hidden" name="lat"><input type="hidden" name="lng">
    </div>
  </section>

  <section class="form-section">
    <h2 class="sub-title">모집 설정</h2>
    <div class="grid-3">
      <div class="field"><label class="field-label" for="fee">참가비</label><input class="input" id="fee" name="fee" inputmode="numeric" placeholder="10,000원" value=""></div>
      <div class="field"><span class="field-label">참가 인원</span>
        <div class="time-range">
          <select class="select" name="minPeople" aria-label="최소 인원"><c:forEach var="n" begin="2" end="20"><option value="${n}" ${n eq 8 ? 'selected' : ''}>최소 ${n}명</option></c:forEach></select>
          <span>~</span>
          <select class="select" name="maxPeople" aria-label="최대 인원"><c:forEach var="n" begin="2" end="30"><option value="${n}" ${n eq 10 ? 'selected' : ''}>최대 ${n}명</option></c:forEach></select>
        </div>
      </div>
    </div>
    <div class="field w-300">
      <label class="field-label danger" for="deadline">모집 마감</label>
      <input class="input" type="datetime-local" id="deadline" name="deadline" value="2026-09-19T17:00">
    </div>
  </section>

  <section class="form-section">
    <div class="section-head" style="justify-content:flex-start;align-items:baseline;gap:14px">
      <h2 class="sub-title">모집 조건</h2><span class="t-11 t-2">연령대와 실력은 여러 항목을 선택할 수 있습니다.</span>
    </div>
    <div class="field"><span class="field-label">모집 성별</span>
      <div class="chip-group" data-select="single" data-name="gender">
        <button type="button" class="chip is-selected" data-value="ANY">무관</button><button type="button" class="chip" data-value="M">남</button><button type="button" class="chip" data-value="F">여</button>
      </div>
    </div>
    <div class="field"><span class="field-label">연령대 <span class="hint">복수 선택 가능</span></span>
      <div class="chip-group" data-select="multi" data-name="ages">
        <button type="button" class="chip is-selected">20대</button><button type="button" class="chip is-selected">30대</button>
        <button type="button" class="chip">40대</button><button type="button" class="chip">50대 이상</button><button type="button" class="chip">연령무관</button>
      </div>
    </div>
    <div class="field"><span class="field-label">실력 <span class="hint">복수 선택 가능</span></span>
      <div class="chip-group" data-select="multi" data-name="levels">
        <button type="button" class="chip">입문</button><button type="button" class="chip is-selected">초급</button>
        <button type="button" class="chip is-selected">중급</button><button type="button" class="chip">상급</button>
      </div>
    </div>
  </section>

  <section class="form-section">
    <h2 class="sub-title">상세 내용</h2>
    <div class="field"><label class="field-label" for="content">상세 설명</label>
      <textarea class="textarea soft" id="content" name="content" rows="6" placeholder="준비물, 경기 방식, 주차 정보 등을 적어주세요."></textarea>
    </div>
    <div class="field"><span class="field-label t-bold" style="color:var(--ds-text)">사진 <span class="t-11 t-2" style="font-weight:400">선택 · 최대 5장</span></span>
      <div class="photo-upload">
        <label class="photo-add"><span class="plus">+</span>사진 추가<input type="file" name="photos" accept="image/png,image/jpeg" multiple data-preview data-max="5"></label>
        <div class="photo-preview">미리보기</div><div class="photo-preview">미리보기</div>
      </div>
      <p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p>
    </div>
  </section>

  <div class="form-actions">
    <button type="submit" class="btn btn-primary" data-toast="경기를 등록했어요.">등록하기</button>
  </div>
</form>
</main>
<script>

	//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(); 
	
	// 키워드로 장소를 검색합니다
	ps.keywordSearch('망원동 축구장', placesSearchCB); 
	
	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();
	
	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	    } 
	}
	
	// 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {
	    
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });
	
	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
	        infowindow.open(map, marker);
	    });
	}
	
	
		
		


</script>


<%@ include file="/jsp/common/footer.jsp" %>
