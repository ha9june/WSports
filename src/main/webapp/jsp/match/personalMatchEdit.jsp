<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>

<c:set var="pageTitle" value="경기 수정" />
<c:set var="pageCss" value="match" />
<c:set var="activeNav" value="" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>

<main class="page">
<form id="editForm" class="form-rail" action="${ctx}/match/edit/form" method="post" enctype="multipart/form-data">
  <input type="hidden" name="personalMatchId" value="${personalMatch.personalMatchId}">

  <nav class="breadcrumb"><a href="${ctx}/jsp/mypage/myPageCreatedPersonalMatch.jsp">내 경기</a><span class="sep">›</span><span>만든 경기</span><span class="sep">›</span><span>경기 수정</span></nav>
  <div class="page-head"><h1 class="page-title">경기 수정</h1>
    <p class="page-desc">수정하면 참가자에게 알림이 전송돼요.</p>
  </div>

  <%-- ===== 종목 / 제목 ===== --%>
      <span class="field-label">종목</span>
      <div class="chip-group" data-select="single" data-name="sport">
        <button type="button" class="chip ${personalMatch.sport eq '축구/풋살' ? 'is-selected' : ''}" data-value="축구/풋살">축구/풋살</button>
        <button type="button" class="chip ${personalMatch.sport eq '농구' ? 'is-selected' : ''}" data-value="농구">농구</button>
        <button type="button" class="chip ${personalMatch.sport eq '테니스' ? 'is-selected' : ''}" data-value="테니스">테니스</button>
        <button type="button" class="chip ${personalMatch.sport eq '배드민턴' ? 'is-selected' : ''}" data-value="배드민턴">배드민턴</button>
      </div>
    </div>
    <div class="field">
      <label class="field-label" for="title">제목</label>
      <input class="input" id="title" name="title" placeholder="예: 토요일 저녁 풋살 한 판!" value="<c:out value='${personalMatch.title}'/>" required>
    </div>
  </section>

  <%-- ===== 일정 및 장소 ===== --%>
  <section class="form-section">
    <h2 class="sub-title">일정 및 장소</h2>
    <div class="grid-3">
      <div class="field">
        <label class="field-label" for="matchDate">경기일자</label>
        <input class="input" type="date" id="matchDate" name="matchDate" value="${personalMatch.matchDate}" required>
      </div>
      <div class="field"><span class="field-label">시간</span>
        <div class="time-range">
          <%-- startTime 이 "19:00:00" 형태여도 앞 5자리(HH:mm)로 비교 --%>
          <select class="select" name="startTime" aria-label="시작 시간" required>
            <c:forEach var="h" begin="6" end="23">
              <c:set var="t" value="${h lt 10 ? '0' : ''}${h}:00" />
              <option value="${t}" ${fn:substring(personalMatch.startTime, 0, 5) eq t ? 'selected' : ''}>${t}</option>
            </c:forEach>
          </select>
          <span>~</span>
          <select class="select" name="endTime" aria-label="종료 시간" required>
            <c:forEach var="h" begin="6" end="23">
              <c:set var="t" value="${h lt 10 ? '0' : ''}${h}:00" />
              <option value="${t}" ${fn:substring(personalMatch.endTime, 0, 5) eq t ? 'selected' : ''}>${t}</option>
            </c:forEach>
          </select>
        </div>
      </div>
    </div>
    <div class="field">
      <label class="field-label" for="address">장소</label>
      <div class="field-row">
        <input class="input" id="address" name="address" style="width:50%;" placeholder="주소 검색" value="<c:out value='${personalMatch.address}'/>" readonly required>
        <button type="button" id="postSearch" class="btn btn-primary btn-lg">검색</button>
      </div>
      <label class="field-label" for="address">상세주소</label>
      <div class="field-row">
		<input class="input" id="addressDetail" name="addressDetail" placeholder="장소를 입력하세요" value="<c:out value='${personalMatch.placeName}'/>" required>
	  </div>
      <input type="hidden" id="lat" name="lat" value="${personalMatch.latitude}">
      <input type="hidden" id="lng" name="lng" value="${personalMatch.longitude}">
    </div>
  </section>

  <%-- ===== 모집 설정 ===== --%>
  <section class="form-section">
    <h2 class="sub-title">모집 설정</h2>
    <div class="grid-3">
      <div class="field"><label class="field-label" for="fee">참가비</label>
        <input class="input" id="fee" name="fee" inputmode="numeric" placeholder="10,000원" value="${personalMatch.participationFee}" required>
      </div>
      <div class="field"><span class="field-label">참가 인원</span>
        <div class="time-range">
          <select class="select" name="minPeople" aria-label="최소 인원" required>
            <c:forEach var="n" begin="2" end="20"><option value="${n}" ${n eq personalMatch.minPeople ? 'selected' : ''}>최소 ${n}명</option></c:forEach>
          </select>
          <span>~</span>
          <%-- 이미 신청한 인원보다 작게는 못 줄이도록 시작값을 currentPeople 로 --%>
          <select class="select" name="maxPeople" aria-label="최대 인원" required>
            <c:forEach var="n" begin="${personalMatch.currentPeople gt 2 ? personalMatch.currentPeople : 2}" end="30"><option value="${n}" ${n eq personalMatch.maxPeople ? 'selected' : ''}>최대 ${n}명</option></c:forEach>
          </select>
        </div>
      </div>
    </div>
    <div class="field w-300">
      <label class="field-label" for="deadline">모집 마감</label>
      <%-- LocalDateTime 문자열이 초까지 있어도 yyyy-MM-ddTHH:mm 16자리만 사용 --%>
      <input class="input" type="datetime-local" id="deadline" name="deadline" value="${fn:substring(personalMatch.deadline, 0, 16)}" required>
    </div>
  </section>

  <%-- ===== 모집 조건 ===== --%>
  <section class="form-section">
    <div class="section-head" style="justify-content:flex-start;align-items:baseline;gap:14px">
      <h2 class="sub-title">모집 조건</h2><span class="t-11 t-2">연령대와 실력은 여러 항목을 선택할 수 있습니다.</span>
    </div>
    <div class="field"><span class="field-label">모집 성별</span>
      <div class="chip-group" data-select="single" data-name="gender">
        <button type="button" class="chip ${personalMatch.gender eq '혼성' ? 'is-selected' : ''}" data-value="혼성">성별무관</button>
        <button type="button" class="chip ${personalMatch.gender eq '남성' ? 'is-selected' : ''}" data-value="남성">남성</button>
        <button type="button" class="chip ${personalMatch.gender eq '여성' ? 'is-selected' : ''}" data-value="여성">여성</button>
      </div>
    </div>
    <div class="field"><span class="field-label">연령대 <span class="hint">복수 선택 가능</span></span>
      <div class="chip-group" data-select="multi" data-name="ages">
        <button type="button" class="chip ${personalMatch.age20s ? 'is-selected' : ''}">20대</button>
        <button type="button" class="chip ${personalMatch.age30s ? 'is-selected' : ''}">30대</button>
        <button type="button" class="chip ${personalMatch.age40s ? 'is-selected' : ''}">40대</button>
        <button type="button" class="chip ${personalMatch.age50s ? 'is-selected' : ''}">50대</button>
        <button type="button" class="chip ${personalMatch.age60Plus ? 'is-selected' : ''}" data-value="60대">60대+</button>
      </div>
    </div>
    <div class="field"><span class="field-label">실력 <span class="hint">복수 선택 가능</span></span>
      <div class="chip-group" data-select="multi" data-name="levels">
        <button type="button" class="chip ${personalMatch.skillIntro ? 'is-selected' : ''}">입문</button>
        <button type="button" class="chip ${personalMatch.skillBeginner ? 'is-selected' : ''}">초급</button>
        <button type="button" class="chip ${personalMatch.skillIntermediate ? 'is-selected' : ''}">중급</button>
        <button type="button" class="chip ${personalMatch.skillAdvanced ? 'is-selected' : ''}">상급</button>
      </div>
    </div>
  </section>

  <%-- ===== 상세 내용 / 사진 ===== --%>
  <section class="form-section">
    <h2 class="sub-title">상세 내용</h2>
    <div class="field"><label class="field-label" for="content">상세 설명</label>
      <textarea class="textarea soft" id="content" name="content" rows="6" placeholder="준비물, 경기 방식, 주차 정보 등을 적어주세요." required><c:out value="${personalMatch.content}"/></textarea>
    </div>

    <div class="field"><span class="field-label t-bold" style="color:var(--ds-text)">사진 <span class="t-11 t-2" style="font-weight:400">선택 · 최대 5장</span></span>
      <div class="photo-upload">
        <label class="photo-add"><span class="plus">+</span>사진 추가
          <input type="file" name="photos" accept="image/png,image/jpeg" multiple data-max="5">
        </label>

        <%-- 기존 사진: ✕ 로 지우면 hidden(keepImage)도 같이 사라져서 서버에는 남길 사진만 전달됨 --%>
        <c:forEach var="img" items="${personalMatch.image1},${personalMatch.image2},${personalMatch.image3},${personalMatch.image4},${personalMatch.image5}">
          <c:if test="${not empty img}">
            <div class="photo-preview is-file" data-existing>
              <img src="${ctx}/uploads/${img}" alt="">
              <button type="button" class="remove" aria-label="사진 삭제">✕</button>
              <input type="hidden" name="keepImage" value="${img}">
            </div>
          </c:if>
        </c:forEach>

        <c:if test="${empty personalMatch.image1 and empty personalMatch.image2 and empty personalMatch.image3 and empty personalMatch.image4 and empty personalMatch.image5}">
          <div class="photo-preview">미리보기</div><div class="photo-preview">미리보기</div>
        </c:if>
      </div>
      <p class="field-help">JPG, PNG 이미지 · 기존 사진 포함 최대 5장까지 첨부할 수 있어요.</p>
    </div>
  </section>

  <div class="form-actions">
    <button type="button" class="btn btn-outline" onclick="history.back()">취소</button>
    <button type="submit" class="btn btn-primary">수정하기</button>
  </div>
</form>
</main>

<%@ include file="/jsp/common/footer.jsp" %>
<script src="${ctx}/js/common.postAddress.js"></script>
<script>
	$(function(){
		$('#postSearch').on("click", function(e) {
			e.preventDefault();
			searchPostAddress();
		});
	})
</script>
<script>
$(function () {

	/* ---------- 2. 사진: 기존 사진 + 새 사진 누적 업로드 ---------- */
	var input = document.querySelector('input[name="photos"]');
	var box   = input.closest('.photo-upload');
	var max   = parseInt(input.getAttribute('data-max') || '5', 10);
	var dt    = new DataTransfer();   // 새로 추가한 파일 누적 저장소

	function same(a, b) {
		return a.name === b.name && a.size === b.size && a.lastModified === b.lastModified;
	}
	// 남아 있는 기존 사진 수 (✕ 로 지우면 DOM 에서 빠지므로 항상 최신)
	function existingCount() {
		return box.querySelectorAll('.photo-preview[data-existing]').length;
	}

	input.addEventListener('change', function () {
		var picked = Array.prototype.slice.call(input.files);
		picked.forEach(function (file) {
			var dup = Array.prototype.some.call(dt.files, function (f) { return same(f, file); });
			if (dup) return;
			if (existingCount() + dt.files.length >= max) {
				showToast('사진은 최대 ' + max + '장까지 올릴 수 있어요.');
				return;
			}
			dt.items.add(file);

			var reader = new FileReader();
			reader.onload = function (ev) {
				var placeholder = box.querySelector('.photo-preview:not(.is-file)');
				if (placeholder) placeholder.remove();
				var div = document.createElement('div');
				div.className = 'photo-preview is-file';
				div.innerHTML = '<img alt=""><button type="button" class="remove" aria-label="사진 삭제">✕</button>';
				div.querySelector('img').src = ev.target.result;
				div._file = file;
				box.appendChild(div);
			};
			reader.readAsDataURL(file);
		});
		input.files = dt.files;
	});

	// ✕ 클릭: 새 사진이면 input.files 에서도 제거 (공통 핸들러의 DOM 삭제보다 먼저 실행: capture)
	// 기존 사진은 미리보기 div 안의 hidden(keepImage)이 DOM 과 함께 사라지므로 따로 처리할 게 없음
	document.addEventListener('click', function (e) {
		var rm = e.target.closest('.photo-preview .remove');
		if (!rm || !box.contains(rm)) return;
		var file = rm.closest('.photo-preview')._file;
		if (!file) return;
		var next = new DataTransfer();
		Array.prototype.forEach.call(dt.files, function (f) {
			if (!same(f, file)) next.items.add(f);
		});
		dt = next;
		input.files = dt.files;
	}, true);

	/* ---------- 3. 제출 전 검증 ---------- */
	$('#editForm').on('submit', function (e) {
		if (!$('#address').val().trim() || !$('#lat').val() || !$('#lng').val()) {
			e.preventDefault();
			showToast('장소를 검색해서 선택해 주세요.');
			return;
		}
		var minP = parseInt($('select[name=minPeople]').val(), 10);
		var maxP = parseInt($('select[name=maxPeople]').val(), 10);
		if (minP > maxP) {
			e.preventDefault();
			showToast('최소 인원은 최대 인원보다 클 수 없어요.');
			return;
		}
		var startT = $('select[name=startTime]').val();
		var endT   = $('select[name=endTime]').val();
		if (startT >= endT) {
			e.preventDefault();
			showToast('종료 시간은 시작 시간보다 늦어야 해요.');
		}
	});
});
</script>
