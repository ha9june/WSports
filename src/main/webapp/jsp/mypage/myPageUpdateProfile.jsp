<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  내 프로필 수정 (myPageUpdateProfile.jsp) - 담당: 박우리
  피그마: MyPage / Profile / Edit
  종목별 프로필: 위쪽 종목 칩은 "어느 종목의 실력을 입력할지" 고르는 용도(탭)입니다.
  DB에는 종목이 아니라 실력만 저장합니다. (soccer_skill / basketball_skill / tennis_skill / badminton_skill)
  전송 파라미터: soccerSkill, basketballSkill, tennisSkill, badmintonSkill (선택 안 하면 빈 문자열)
--%>
<c:set var="pageTitle" value="내 프로필 수정" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="profile" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
// 실력 블록의 선택값을 지움 (칩 강조 해제 + 전송용 hidden 값 비움)
function clearLevel(block) {
	block.querySelectorAll('.chip.is-selected').forEach(function (c) { c.classList.remove('is-selected'); });
	block.querySelectorAll('input[type=hidden]').forEach(function (h) { h.value = ''; });
}

// 강조된 종목의 실력 블록만 보여주고, 강조가 풀린 종목의 블록은 숨기면서 입력값을 지웁니다.
function updateLevels() {
	var selectedSports = [];
	document.querySelectorAll('#sportGroup .chip.is-selected').forEach(function (c) {
		selectedSports.push(c.textContent.trim());
	});

	var hint = document.getElementById('levelHint');
	if (hint) hint.style.display = selectedSports.length ? 'none' : '';

	document.querySelectorAll('.level-block').forEach(function (block) {
		var on = selectedSports.indexOf(block.getAttribute('data-sport')) !== -1;
		block.style.display = on ? '' : 'none';
		if (!on) clearLevel(block);
	});
}

// 종목 칩을 누른 뒤 실행 (common.js 가 선택 상태를 바꾼 다음에 읽도록 한 박자 늦춤)
document.addEventListener('click', function (e) {
	if (e.target.closest('#sportGroup .chip')) setTimeout(updateLevels, 0);
});

function splitValues(groupName, prefix) {
	var values = [];
	$('.chip-group[data-name="' + groupName + '"] .chip.is-selected').each(function() {
		values.push($(this).attr('data-value') || $.trim($(this).text()));
	});
	
	for (var i=0; i<3; i++) {
		$('input[name="' + prefix + (i+1) + '"]').remove();
		if (values[i]) {
			$('<input type="hidden">').attr('name', prefix + (i+1)).val(values[i]).appendTo('#edit-wrap');
		}
	}
	<%-- common.js가 만든 콤마 방식 hidden input은 전송 제외 --%>
	$('input[type=hidden][name="' + groupName + '"]').prop('disabled', true);
}

<%-- address.js가 만든 regions hidden input → preferredRegion1~3 으로 분리 저장 --%>
function splitRegions() {
	var values = [];
	$('#regionInputs input[name="regions"]').each(function() {
		values.push($(this).val());
	});
	
	for (var i=0; i<3; i++) {
		$('input[name="preferredRegion' + (i+1) + '"]').remove();
		if (values[i]) {
			$('<input type="hidden">').attr('name', 'preferredRegion' + (i+1)).val(values[i]).appendTo('#edit-wrap');
		}
	}
	<%-- 중복 전송 방지 --%>
	$('#regionInputs input[name="regions"]').prop('disabled', true);
}

function resetToDefault() {
	document.getElementById('preview').src = '${ctx}/img/default-profile.svg';
	document.getElementById('profile').value = '';       // 선택해 둔 새 파일 취소
	document.getElementById('deleteImg').value = 'true';
}

function readURL(input) {
	if(input.files && input.files[0]) {
		document.getElementById('deleteImg').value = 'false';
		var reader = new FileReader();
		reader.onload = function(e) {
			document.getElementById("preview").src = e.target.result;
		}
		reader.readAsDataURL(input.files[0]);
	}
}

// 페이지를 처음 열 때 (form 이 그려진 뒤에 실행)
document.addEventListener('DOMContentLoaded', function () {
	updateLevels();
	var intro = document.getElementById('introInput'), cnt = document.getElementById('introCnt');
	function syncCnt() { cnt.textContent = intro.value.length; }
	intro.addEventListener('input', syncCnt); syncCnt();
	// 제출 시 관심 종목 / 주 활동 지역을 1~3번 칸으로 나눠서 전송
	document.getElementById('edit-wrap').addEventListener('submit', function () {
		splitValues('sports', 'preferredSport');
		splitRegions();
	});
});
</script>
<form class="work-inner full pf-page" id="edit-wrap" action="${ctx}/member/profile/edit" method="post" enctype="multipart/form-data">

  <div class="pf-head">
    <h1 class="section-title">내 프로필 수정</h1>
    <p class="section-desc">변경할 항목을 수정한 뒤 저장해주세요.</p>
  </div>

  <%-- 프로필 사진 + 한 줄 소개 --%>
  <section class="pf-card">
    <h2 class="sub-title">프로필</h2>
    <p class="section-desc">프로필에 표시될 사진과 한 줄 소개를 등록할 수 있습니다.</p>
    <div class="pf-edit-top">
      <div class="profile-photo">
        <span class="avatar lg">
          <c:choose>
            <c:when test="${not empty loginUser.profileImage}">
              <img class="avatar lg" id="preview" src="${ctx}${profilePath}/${loginUser.profileImage}" alt="프로필 사진">
            </c:when>
            <c:otherwise>
              <img class="avatar lg" id="preview" src="${ctx}/img/default-profile.svg" alt="기본 프로필 사진">
            </c:otherwise>
          </c:choose>
        </span>
        <div>
          <div class="btn-group">
            <label class="btn btn-primary btn-sm">사진 추가 / 변경<input type="file" id="profile" name="profileImg" accept="image/*" hidden onchange="readURL(this);"></label>
            <input type="hidden" name="deleteImg" id="deleteImg" value="false">
            <button type="button" class="btn btn-outline btn-sm" onclick="resetToDefault();">기본 이미지</button>
          </div>
          <p class="field-help mt-8">사진을 등록하지 않으면 기본 이미지가 사용됩니다.</p>
        </div>
      </div>
      <div class="pf-intro-edit">
        <span class="field-label strong">한 줄 소개 <span class="hint">최대 50자</span></span>
        <input class="input" id="introInput" name="intro" maxlength="50" value="${loginUser.bio}" placeholder="예) 주말마다 같이 뛸 팀원을 찾고 있어요!">
        <p class="pf-count"><span id="introCnt">0</span> / 50</p>
      </div>
    </div>
  </section>

  <%-- 관심 종목 / 주 활동 지역 --%>
  <section class="pf-card">
    <h2 class="sub-title">활동 정보</h2>
    <div class="field pf-field-box">
      <span class="field-label strong">관심 종목 <span class="hint">복수 선택 가능 · 최대 3개</span></span>
      <div class="chip-group" data-select="multi" data-max="3" data-name="sports">
        <c:forTokens var="sp" items="축구/풋살,농구,테니스,배드민턴" delims=",">
          <button type="button" class="chip ${loginUser.preferredSport1 == sp or loginUser.preferredSport2 == sp or loginUser.preferredSport3 == sp ? 'is-selected' : ''}">${sp}</button>
        </c:forTokens>
      </div>
    </div>
    <div class="field pf-region">
      <span class="field-label strong">주 활동 지역 <span class="hint">복수 선택 가능 · 최대 3개</span></span>
      <div class="field-row">
        <select class="select" id="sido" aria-label="시·도">
          <option value="">시 · 도</option>
          <option value="서울시">서울시</option>
          <option value="경기도">경기도</option>
        </select>
        <select class="select" id="sigungu" aria-label="시군구" disabled>
          <option value="">시군구</option>
        </select>
      </div>
      <p id="maxRegion" class="region-max" style="display:none">최대 3개까지 선택 가능합니다.</p>
      <div class="picked" id="pickedRegions"></div>
      <div id="regionInputs"></div>
    </div>
  </section>

  <%-- 종목별 프로필
       종목 칩: 복수 선택(토글). 강조된 종목의 실력 블록이 보이고, 강조를 풀면 그 종목의 실력이 지워집니다.
       서버로 전송하지 않음(data-name 없음). 저장된 실력이 있는 종목은 처음부터 강조됩니다.
       실력 칩: data-name 이 곧 전송 파라미터 이름입니다. data-deselect 로 다시 누르면 해제(미설정)됩니다. --%>
  <section class="pf-card">
    <h2 class="sub-title">종목별 프로필</h2>
    <p class="section-desc">종목을 선택해 실력을 설정하세요. 종목을 다시 누르면 선택이 취소돼요.</p>
    <div class="chip-group mt-16" id="sportGroup" data-select="multi">
      <button type="button" class="chip ${not empty loginUser.soccerSkill ? 'is-selected' : ''}">축구/풋살</button>
      <button type="button" class="chip ${not empty loginUser.basketballSkill ? 'is-selected' : ''}">농구</button>
      <button type="button" class="chip ${not empty loginUser.tennisSkill ? 'is-selected' : ''}">테니스</button>
      <button type="button" class="chip ${not empty loginUser.badmintonSkill ? 'is-selected' : ''}">배드민턴</button>
    </div>
    <p class="pf-level-hint" id="levelHint">종목을 선택하면 실력을 설정할 수 있어요.</p>
    <div class="pf-levels">
      <div class="level-block" data-sport="축구/풋살" style="display:none">
        <p class="t-11 t-bold">축구/풋살 실력</p>
        <div class="chip-group" data-select="single" data-deselect data-name="soccerSkill">
          <c:forTokens var="lv" items="입문,초급,중급,상급" delims=",">
            <button type="button" class="chip ${loginUser.soccerSkill == lv ? 'is-selected' : ''}">${lv}</button>
          </c:forTokens>
        </div>
      </div>
      <div class="level-block" data-sport="농구" style="display:none">
        <p class="t-11 t-bold">농구 실력</p>
        <div class="chip-group" data-select="single" data-deselect data-name="basketballSkill">
          <c:forTokens var="lv" items="입문,초급,중급,상급" delims=",">
            <button type="button" class="chip ${loginUser.basketballSkill == lv ? 'is-selected' : ''}">${lv}</button>
          </c:forTokens>
        </div>
      </div>
      <div class="level-block" data-sport="테니스" style="display:none">
        <p class="t-11 t-bold">테니스 실력</p>
        <div class="chip-group" data-select="single" data-deselect data-name="tennisSkill">
          <c:forTokens var="lv" items="입문,초급,중급,상급" delims=",">
            <button type="button" class="chip ${loginUser.tennisSkill == lv ? 'is-selected' : ''}">${lv}</button>
          </c:forTokens>
        </div>
      </div>
      <div class="level-block" data-sport="배드민턴" style="display:none">
        <p class="t-11 t-bold">배드민턴 실력</p>
        <div class="chip-group" data-select="single" data-deselect data-name="badmintonSkill">
          <c:forTokens var="lv" items="입문,초급,중급,상급" delims=",">
            <button type="button" class="chip ${loginUser.badmintonSkill == lv ? 'is-selected' : ''}">${lv}</button>
          </c:forTokens>
        </div>
      </div>
    </div>
  </section>

  <div class="form-actions">
    <a class="btn btn-outline" href="${ctx}/member/profile/view">취소</a>
    <button type="submit" class="btn btn-primary">저장</button>
  </div>
</form>
<script src="${ctx}/js/address.js"></script>
<script>
// 저장된 주 활동 지역을 칩으로 복원 (address.js 수정 없이 select 의 change 이벤트를 발생시켜 선택)
(function () {
	var saved = [];
	<c:if test="${not empty loginUser.preferredRegion1}">saved.push('${loginUser.preferredRegion1}');</c:if>
	<c:if test="${not empty loginUser.preferredRegion2}">saved.push('${loginUser.preferredRegion2}');</c:if>
	<c:if test="${not empty loginUser.preferredRegion3}">saved.push('${loginUser.preferredRegion3}');</c:if>

	var sido = document.getElementById('sido');
	var sigungu = document.getElementById('sigungu');

	function fire(el) { el.dispatchEvent(new Event('change')); }

	// 예전 방식으로 저장된 "서울 마포구" 도 "서울시 마포구" 로 맞춰서 읽음
	function normalizeSido(s) {
		if (s.indexOf('서울') === 0) return '서울시';
		if (s.indexOf('경기') === 0) return '경기도';
		return s;
	}

	saved.forEach(function (region) {
		var idx = region.indexOf(' ');
		if (idx < 0) return;
		var sd = normalizeSido(region.substring(0, idx));
		var sg = region.substring(idx + 1).trim();

		sido.value = sd;
		if (sido.value !== sd) return;        // 목록에 없는 시·도
		fire(sido);                           // 시군구 목록 채움
		sigungu.value = sg;
		if (sigungu.value !== sg) return;     // 목록에 없는 시군구
		fire(sigungu);                        // 칩 추가
	});

	// 선택 상태 초기화 (처음 화면처럼 비워둠)
	sido.value = '';
	fire(sido);
})();
</script>
<%@ include file="/jsp/common/footer.jsp" %>
