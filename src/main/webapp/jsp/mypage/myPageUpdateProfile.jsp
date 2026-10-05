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

//선택한 지역을 태그로 표시합니다. 태그의 ✕ 를 누르면 선택이 해제됩니다.
//(태그는 기존 칩과 같은 클래스를 써서 디자인이 그대로 적용됩니다)
function renderRegionTags() {
	var box = document.getElementById('regionTags');
	if (!box) return;
	box.innerHTML = '';
	document.querySelectorAll('.chip-group[data-name="regions"] .chip.is-selected').forEach(function (c) {
		var name = c.textContent.trim();
		var tag = document.createElement('button');
		tag.type = 'button';
		tag.className = 'chip chip-sm is-selected';
		tag.setAttribute('data-tag', name);
		tag.appendChild(document.createTextNode(name));
		var x = document.createElement('span');
		x.textContent = '✕';
		x.setAttribute('aria-label', name + ' 삭제');
		x.style.marginLeft = '6px';
		box.appendChild(tag).appendChild(x);
	});
}

document.addEventListener('click', function (e) {
	var tag = e.target.closest('#regionTags [data-tag]');
	if (tag) {
		// 드롭다운 안의 같은 지역 칩을 눌러서 해제 (common.js 가 선택 해제와 hidden 값 갱신을 처리)
		var name = tag.getAttribute('data-tag');
		document.querySelectorAll('.chip-group[data-name="regions"] .chip.is-selected').forEach(function (c) {
			if (c.textContent.trim() === name) c.click();
		});
	}
	// 지역 칩을 누르거나 태그를 누르면 태그 목록을 다시 그림 (common.js 처리 후 실행되도록 한 박자 늦춤)
	if (tag || e.target.closest('.chip-group[data-name="regions"] .chip')) setTimeout(renderRegionTags, 0);
});

function resetToDefault() {
	document.getElementById('preview').src = '${ctx}/img/profile-default.png';
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
	renderRegionTags();
	// 제출 시 관심 종목 / 주 활동 지역을 1~3번 칸으로 나눠서 전송
	document.getElementById('edit-wrap').addEventListener('submit', function () {
		splitValues('sports', 'preferredSport');
		splitValues('regions', 'preferredRegion');
	});
});
</script>
<form class="work-inner" id="edit-wrap" action="${ctx}/member/profile/edit" method="post" enctype="multipart/form-data" style="padding-left:24px">
  <h1 class="sub-title">프로필 사진</h1>
  <p class="section-desc">프로필에 표시될 사진을 등록할 수 있습니다.</p>
  <div class="profile-photo">
    <span class="avatar lg">
      <c:choose>
  	  <c:when test="${not empty loginUser.profileImage }">
  		  <img class="avatar lg"
  		  	   id="preview"
  			   src="${ctx}${profilePath}/${loginUser.profileImage}"
  			   alt="프로필 사진">
	  </c:when>
	  <c:otherwise>
		  <img class="avatar lg"
		       id="preview"
			   src="${ctx }/img/profile-default.png"
			   alt="기본 프로필 사진">
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

  <div class="field mt-32"><span class="field-label" style="font-size:14px;color:var(--ds-text)">관심 종목 <span class="hint">복수 선택 가능 · 최대 3개</span></span>
    <div class="chip-group" data-select="multi" data-max="3" data-name="sports">
    	<c:forTokens var="sp" items="축구/풋살,농구,테니스,배드민턴" delims=",">
            <button type="button" class="chip ${loginUser.preferredSport1 == sp or loginUser.preferredSport2 == sp or loginUser.preferredSport3 == sp ? 'is-selected' : ''}">${sp}</button>
        </c:forTokens>
    </div>
  </div>  
  <div class="field mt-24" style="width:360px"><span class="field-label" style="font-size:14px;color:var(--ds-text)">주 활동 지역 <span class="hint">복수 선택 가능 · 최대 3개</span></span>
    <div class="chip-group mt-8" id="regionTags"></div>
    <div class="dropdown" style="display:block">
      <button type="button" class="select" data-dropdown-toggle style="text-align:left">지역을 검색하거나 선택하세요</button>
      <div class="dropdown-menu" style="left:0;right:auto;width:360px;padding:14px">
        <input class="input sm" placeholder="예: 마포구, 성남시">
        <div class="chip-group mt-16" data-select="multi" data-max="3" data-name="regions">
          <c:forTokens var="rg" items="서울 마포구,서울 영등포구,서울 강남구,서울 송파구,경기 성남시,경기 고양시" delims=",">
            <button type="button" class="chip chip-sm ${loginUser.preferredRegion1 == rg or loginUser.preferredRegion2 == rg or loginUser.preferredRegion3 == rg ? 'is-selected' : ''}">${rg}</button>
          </c:forTokens>
        </div>
      </div>
    </div>
  </div>

  <h2 class="sub-title mt-48">종목별 프로필 <span class="t-11 t-2" style="font-weight:400;margin-left:8px">종목을 선택해 실력을 설정하세요. 종목을 다시 누르면 선택이 취소돼요.</span></h2>
  <%-- 종목 칩: 복수 선택(토글). 강조된 종목의 실력 블록이 보이고, 강조를 풀면 그 종목의 실력이 지워집니다.
       서버로 전송하지 않음(data-name 없음). 저장된 실력이 있는 종목은 처음부터 강조됩니다. --%>
  <div class="chip-group mt-16" id="sportGroup" data-select="multi">
    <button type="button" class="chip ${not empty loginUser.soccerSkill ? 'is-selected' : ''}">축구/풋살</button>
    <button type="button" class="chip ${not empty loginUser.basketballSkill ? 'is-selected' : ''}">농구</button>
    <button type="button" class="chip ${not empty loginUser.tennisSkill ? 'is-selected' : ''}">테니스</button>
    <button type="button" class="chip ${not empty loginUser.badmintonSkill ? 'is-selected' : ''}">배드민턴</button>
  </div>

  <%-- 실력 칩: data-name 이 곧 전송 파라미터 이름입니다. data-deselect 로 다시 누르면 해제(미설정)됩니다. --%>

  <div class="level-block" data-sport="축구/풋살" style="display:none">
    <p class="t-11 t-bold mt-16">축구/풋살 실력</p>
    <div class="chip-group mt-8" data-select="single" data-deselect data-name="soccerSkill">
      <c:forTokens var="lv" items="입문,초급,중급,상급" delims=",">
        <button type="button" class="chip ${loginUser.soccerSkill == lv ? 'is-selected' : ''}">${lv}</button>
      </c:forTokens>
    </div>
  </div>

  <div class="level-block" data-sport="농구" style="display:none">
    <p class="t-11 t-bold mt-16">농구 실력</p>
    <div class="chip-group mt-8" data-select="single" data-deselect data-name="basketballSkill">
      <c:forTokens var="lv" items="입문,초급,중급,상급" delims=",">
        <button type="button" class="chip ${loginUser.basketballSkill == lv ? 'is-selected' : ''}">${lv}</button>
      </c:forTokens>
    </div>
  </div>

  <div class="level-block" data-sport="테니스" style="display:none">
    <p class="t-11 t-bold mt-16">테니스 실력</p>
    <div class="chip-group mt-8" data-select="single" data-deselect data-name="tennisSkill">
      <c:forTokens var="lv" items="입문,초급,중급,상급" delims=",">
        <button type="button" class="chip ${loginUser.tennisSkill == lv ? 'is-selected' : ''}">${lv}</button>
      </c:forTokens>
    </div>
  </div>

  <div class="level-block" data-sport="배드민턴" style="display:none">
    <p class="t-11 t-bold mt-16">배드민턴 실력</p>
    <div class="chip-group mt-8" data-select="single" data-deselect data-name="badmintonSkill">
      <c:forTokens var="lv" items="입문,초급,중급,상급" delims=",">
        <button type="button" class="chip ${loginUser.badmintonSkill == lv ? 'is-selected' : ''}">${lv}</button>
      </c:forTokens>
    </div>
  </div>

  <h2 class="sub-title mt-32">한 줄 소개</h2>
  <p class="section-desc">프로필에 표시할 짧은 소개를 입력해주세요.</p>
  <input class="input mt-8" name="intro" maxlength="50" value="${loginUser.bio}">
  <div class="form-actions"><a class="btn btn-outline" href="${ctx}/member/profile/view">취소</a><button type="submit" class="btn btn-primary" style="width:92px">저장</button></div>
</form>
<%@ include file="/jsp/common/footer.jsp" %>
