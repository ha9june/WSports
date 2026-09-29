<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  내 프로필 수정 (myPageUpdateProfile.jsp) - 담당: 박우리
  피그마: MyPage / Profile / Edit
  종목별 프로필: 위쪽 종목 칩을 고르면 아래 실력 칩이 해당 종목 값으로 바뀝니다. (TODO: 종목별 값 연동)
--%>
<c:set var="pageTitle" value="내 프로필 수정" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="profile" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<form class="work-inner" action="${ctx}/jsp/mypage/myPageProfile.jsp" method="post" enctype="multipart/form-data" style="padding-left:24px">
  <h1 class="sub-title">프로필 사진</h1>
  <p class="section-desc">프로필에 표시될 사진을 등록할 수 있습니다.</p>
  <div class="profile-photo">
    <span class="avatar lg default"></span>
    <div>
      <div class="btn-group">
        <label class="btn btn-primary btn-sm">사진 추가 / 변경<input type="file" name="profileImg" accept="image/*" hidden></label>
        <button type="button" class="btn btn-outline btn-sm">기본 이미지</button>
      </div>
      <p class="field-help mt-8">사진을 등록하지 않으면 기본 이미지가 사용됩니다.</p>
    </div>
  </div>

  <div class="field mt-32"><span class="field-label" style="font-size:14px;color:var(--ds-text)">관심 종목 <span class="hint">복수 선택 가능</span></span>
    <div class="chip-group" data-select="multi" data-name="sports">
      <button type="button" class="chip is-selected">축구/풋살</button><button type="button" class="chip is-selected">농구</button><button type="button" class="chip">테니스</button><button type="button" class="chip">배드민턴</button></div></div>
  <div class="field mt-24" style="width:215px"><span class="field-label" style="font-size:14px;color:var(--ds-text)">주 활동 지역 <span class="hint">복수 선택 가능 · 최대 3개</span></span>
    <select class="select" name="region"><option>지역을 검색하거나 선택하세요</option><option>서울 마포구</option><option>서울 영등포구</option><option>서울 강남구</option></select></div>

  <h2 class="sub-title mt-48">종목별 프로필 <span class="t-11 t-2" style="font-weight:400;margin-left:8px">종목을 선택해 프로필 정보를 설정하세요.</span></h2>
  <div class="chip-group mt-16" data-select="single">
    <button type="button" class="chip is-selected">축구/풋살</button><button type="button" class="chip">농구</button><button type="button" class="chip">테니스</button><button type="button" class="chip">배드민턴</button></div>
  <p class="t-11 t-bold mt-16">축구/풋살 실력</p>
  <div class="chip-group mt-8" data-select="single" data-name="level_FOOTBALL">
    <button type="button" class="chip">입문</button><button type="button" class="chip is-selected">초급</button><button type="button" class="chip">중급</button><button type="button" class="chip">상급</button></div>

  <h2 class="sub-title mt-32">한 줄 소개</h2>
  <p class="section-desc">프로필에 표시할 짧은 소개를 입력해주세요.</p>
  <input class="input mt-8" name="intro" maxlength="50" value="즐겁게 운동하고 좋은 사람들과 꾸준히 함께하고 싶어요.">
  <div class="form-actions"><a class="btn btn-outline" href="${ctx}/jsp/mypage/myPageProfile.jsp">취소</a><button type="submit" class="btn btn-primary" style="width:92px">저장</button></div>
</form>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
