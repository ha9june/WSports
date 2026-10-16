<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 만들기 (personalMatchWriteForm.jsp) - 담당: 변재언
  피그마: Match / Write Form / Desktop
--%>
<c:set var="pageTitle" value="경기 만들기" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="match" />

<c:set var="minPeopleStart" value="2" />
<c:set var="minPeopleEnd" value="20" />
<c:set var="maxPeopleStart" value="2" />
<c:set var="maxPeopleEnd" value="30" />
<c:set var="defaultMinPeople" value="8" />
<c:set var="defaultMaxPeople" value="10" />
<%@ include file="/jsp/common/header.jsp" %>
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>


<main class="page">
<form id="writeForm" class="form-rail" novalidate action="${ctx}/match/write/form" method="post" enctype="multipart/form-data">
  <nav class="breadcrumb"><a href="${ctx}/match/list">경기 찾기</a><span class="sep">›</span><span>경기 만들기</span></nav>
  <div class="page-head"><h1 class="page-title">경기 만들기</h1></div>

  <div class="team-form-inner">
    <section class="form-section">
      <h2 class="sub-title">경기 정보</h2>
		<div class="form-row c-2">
		  <div class="field">
		    <label class="field-label strong" for="title">제목</label>
		    <input class="input" id="title" name="title"
		      autocomplete="off" placeholder="예: 토요일 저녁 풋살 한 판!" value="" required>
		  </div>
		  <div class="field">
		    <span class="field-label strong">종목</span>
		    <div class="chip-group" data-select="single" data-name="sport">
		      <button type="button" class="chip is-selected" data-value="축구/풋살">축구/풋살</button>
		      <button type="button" class="chip" data-value="농구">농구</button>
		      <button type="button" class="chip" data-value="테니스">테니스</button>
		      <button type="button" class="chip" data-value="배드민턴">배드민턴</button>
		    </div>
		  </div>
		</div>
    </section>

    <section class="form-section">
      <h2 class="sub-title">일정 및 장소</h2>
      <div class="form-row c-2">
        <div class="field">
          <label class="field-label strong" for="matchDate">경기일자</label>
          <input class="input" type="date" id="matchDate" name="matchDate" required>
        </div>
        <div class="field">
          <span class="field-label strong">시간</span>
          <div class="time-range">
            <select class="select" name="startTime" required>
              <option value="" disabled selected>시간 선택</option>
              <c:forEach var="h" begin="0" end="23">
                <c:set var="hh" value="${h<10 ? '0' :  ''}${h}"></c:set>
                <option value="${hh}:00">${hh}:00</option>
                <option value="${hh}:30">${hh}:30</option>
              </c:forEach>
            </select>
            <span>~</span>
            <select class="select" name="endTime" required>
              <option value="" disabled selected>시간 선택</option>
              <c:forEach var="h" begin="0" end="23">
                <c:set var="hh" value="${h < 10 ? '0' : ''}${h}" />
                <c:if test="${h > 0}">
                  <option value="${hh}:00">${hh}:00</option>
                </c:if>
                <option value="${hh}:30">${hh}:30</option>
              </c:forEach>
              <option value="24:00">24:00</option>
            </select>
          </div>
        </div>
      </div>
		<div class="form-row c-2">
		  <div class="field">
		    <label class="field-label strong" for="address">장소</label>
		    <div class="field-row" style="display:flex; gap:8px;">
		      <input class="input" id="address" name="address" style="flex:1; min-width:0;"
		        placeholder="주소를 검색하세요" value="" readonly required>
		      <button type="button" id="postSearch" class="btn btn-primary btn-lg">검색</button>
		    </div>
		    <input type="hidden" id="lat" name="lat" required>
		    <input type="hidden" id="lng" name="lng" required>
		  </div>
		  <div class="field">
		    <label class="field-label strong" for="addressDetail">상세주소</label>
		    <input class="input" id="addressDetail" name="addressDetail"
		      placeholder="상세주소 (예: 마포 풋살장)" value="" required>
		  </div>
		</div>
    </section>

    <section class="form-section">
      <h2 class="sub-title">모집 설정</h2>
      <div class="form-row c-2">
        <div class="field">
          <label class="field-label strong" for="fee">참가비</label>
          <input class="input" id="fee" name="fee" inputmode="numeric" placeholder="10,000원" value="" required>
        </div>
        <div class="field">
          <span class="field-label strong">참가 인원</span>
          <div class="time-range">
            <select class="select" name="minPeople" aria-label="최소 인원" required><c:forEach var="n" begin="${minPeopleStart}" end="${minPeopleEnd}"><option value="${n}" ${n eq defaultMinPeople ? 'selected' : ''}>최소 ${n}명</option></c:forEach></select>
            <span>~</span>
            <select class="select" name="maxPeople" aria-label="최대 인원" required><c:forEach var="n" begin="${maxPeopleStart}" end="${maxPeopleEnd}"><option value="${n}" ${n eq defaultMaxPeople ? 'selected' : ''}>최대 ${n}명</option></c:forEach></select>
          </div>
        </div>
      </div>
      <div class="form-row c-2">
        <div class="field">
          <label class="field-label strong" for="deadline">모집 마감</label>
          <input class="input" type="datetime-local" id="deadline" name="deadline" value="" required>
        </div>
      </div>
    </section>

    <section class="form-section">
      <h2 class="sub-title">모집 조건</h2>
      <p class="section-desc">연령대와 실력은 여러 항목을 선택할 수 있습니다.</p>
      <div class="field">
        <span class="field-label strong">모집 성별</span>
        <div class="chip-group" data-select="single" data-name="gender">
          <button type="button" class="chip" data-value="혼성">성별무관</button>
          <button type="button" class="chip" data-value="남성">남성</button>
          <button type="button" class="chip" data-value="여성">여성</button>
        </div>
      </div>
      <div class="field">
        <span class="field-label strong">연령대 <span class="hint-gray">복수 선택 가능</span></span>
        <div class="chip-group" data-select="multi" data-name="ages">
          <button type="button" class="chip">20대</button>
          <button type="button" class="chip">30대</button>
          <button type="button" class="chip">40대</button>
          <button type="button" class="chip">50대</button>
          <button type="button" class="chip" data-value="60대">연령 무관</button>
        </div>
      </div>
      <div class="field">
        <span class="field-label strong">실력 <span class="hint-gray">복수 선택 가능</span></span>
        <div class="chip-group" data-select="multi" data-name="levels">
          <button type="button" class="chip">입문</button>
          <button type="button" class="chip">초급</button>
          <button type="button" class="chip">중급</button>
          <button type="button" class="chip">상급</button>
        </div>
      </div>
    </section>

    <section class="form-section">
      <h2 class="sub-title">상세 내용</h2>
      <div class="field">
        <label class="field-label strong" for="content">상세 설명</label>
        <textarea class="textarea soft" id="content" name="content" rows="6" placeholder="준비물, 경기 방식, 주차 정보 등을 적어주세요." required></textarea>
      </div>
      <div class="field">
        <span class="field-label strong">사진 <span class="hint-gray">선택 · 최대 5장</span></span>
        <div class="photo-upload">
          <label class="photo-add"><span class="plus">+</span>사진 추가
            <input type="file" name="photos" accept="image/png,image/jpeg" multiple data-max="5">
          </label>
          <div class="photo-preview">미리보기</div><div class="photo-preview">미리보기</div>
        </div>
        <p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p>
      </div>
    </section>

    <div class="form-actions">
      <button type="submit" class="btn btn-primary">등록하기</button>
    </div>
  </div>
</form>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
<script src="${ctx}/js/common.match.js"></script>
<script src="${ctx}/js/common.postAddress.js"></script>
<script>
	$(function(){
		$('#postSearch').on("click", function(e) {
			e.preventDefault();
			searchPostAddress();
		});

		function pad2(n) { return (n < 10 ? '0' : '') + n; }
		var now = new Date();
		var todayStr = now.getFullYear() + '-' + pad2(now.getMonth() + 1) + '-' + pad2(now.getDate());
		var todayStr2 = todayStr + 'T'+ pad2(now.getHours()) + ':'+ pad2(now.getMinutes());
		
		$('#matchDate').attr('min', todayStr);
		$('#deadline').attr('min', todayStr2);
		
		var submitting = false;

		// 뒤로가기로 돌아왔을 때 버튼이 잠겨 있지 않도록 복구
		$(window).on('pageshow', function () {
			submitting = false;
			$('#writeForm .form-actions button[type="submit"]').prop('disabled', false);
		});

		function fail(e, msg, el) {
			e.preventDefault();
			showToast(msg);
			if (el) {
				el.scrollIntoView({ behavior: 'smooth', block: 'center' });
				if (typeof el.focus === 'function') el.focus();
			}
		}
		
		$('#writeForm').on('submit', function (e) {

			if (submitting) {
				e.preventDefault();
				return;
			}

			var checks = [
				{ type: 'input', sel: '#title',                msg: '제목을 입력해주세요.' },
				{ type: 'input', sel: '#matchDate',            msg: '경기일자를 선택해주세요.' },
				{ type: 'input', sel: '[name="startTime"]',    msg: '시작 시간을 선택해주세요.' },
				{ type: 'input', sel: '[name="endTime"]',      msg: '종료 시간을 선택해주세요.' },
				{ type: 'input', sel: '#address',              msg: '장소를 검색해주세요.' },
				{ type: 'input', sel: '#lat',                  msg: '주소를 다시 검색해주세요. (좌표를 가져오지 못했어요)' },
				{ type: 'input', sel: '#lng',                  msg: '주소를 다시 검색해주세요. (좌표를 가져오지 못했어요)' },
				{ type: 'input', sel: '#addressDetail',        msg: '상세주소를 입력해주세요.' },
				{ type: 'input', sel: '#fee',                  msg: '참가비를 입력해주세요.' },
				{ type: 'input', sel: '#deadline',             msg: '모집 마감을 선택해주세요.' },
				{ type: 'chip',  sel: '[data-name="gender"]',  msg: '모집 성별을 선택해주세요.' },
				{ type: 'chip',  sel: '[data-name="ages"]',    msg: '연령대를 선택해주세요.' },
				{ type: 'chip',  sel: '[data-name="levels"]',  msg: '실력을 선택해주세요.' },
				{ type: 'input', sel: '#content',              msg: '상세 설명을 입력해주세요.' }
			];

			for (var i = 0; i < checks.length; i++) {
				var c = checks[i];
				var el = document.querySelector(c.sel);
				var empty = (c.type === 'input')
					? !el.value.trim()
					: !el.querySelector('.chip.is-selected');

				if (empty) {
					fail(e, c.msg, el);
					return;
				}
			}

			var feeRaw = $('#fee').val().replace(/,/g, '').trim();
			if (!/^\d+$/.test(feeRaw)) {
				fail(e, '참가비는 숫자만 입력해주세요.', document.getElementById('fee'));
				return;
			}

			var minP = parseInt($('[name="minPeople"]').val(), 10);
			var maxP = parseInt($('[name="maxPeople"]').val(), 10);
			if (minP > maxP) {
				fail(e, '최소 인원은 최대 인원보다 클 수 없어요.', document.querySelector('[name="minPeople"]'));
				return;
			}

			var st = $('[name="startTime"]').val();
			var et = $('[name="endTime"]').val();
			if (st >= et) {
				fail(e, '종료 시간은 시작 시간보다 늦어야 해요.', document.querySelector('[name="endTime"]'));
				return;
			}

			var matchDate = $('#matchDate').val();
			var startAt = new Date(matchDate + 'T' + st);   // 예: 2026-10-20T19:30
			var deadlineAt = new Date($('#deadline').val());
			var nowAt = new Date();

			if (startAt < nowAt) {
				fail(e, '이미 지난 시간에는 경기를 만들 수 없어요.', document.getElementById('matchDate'));
				return;
			}
			if (deadlineAt < nowAt) {
				fail(e, '모집 마감은 현재 시각 이후여야 해요.', document.getElementById('deadline'));
				return;
			}
			if (deadlineAt > startAt) {
				fail(e, '모집 마감은 경기 시작 전이어야 해요.', document.getElementById('deadline'));
				return;
			}

			submitting = true;
			$(this).find('button[type="submit"]').prop('disabled', true);
		});
		
		
		
	})
</script>
