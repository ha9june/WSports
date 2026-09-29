<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 수정 (personalMatchEdit.jsp) - 담당: 김도윤
  피그마: Match / Write Form / Desktop (수정 - 값이 채워진 상태)
--%>
<c:set var="pageTitle" value="경기 수정" />
<c:set var="pageCss" value="match" />
<c:set var="activeNav" value="match" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
<form class="form-rail" action="${ctx}/jsp/match/personalMatchDetail.jsp" method="post" enctype="multipart/form-data">
  <nav class="breadcrumb"><a href="${ctx}/jsp/match/personalMatchList.jsp">경기 찾기</a><span class="sep">›</span><span>경기 수정</span></nav>
  <div class="page-head"><h1 class="page-title">경기 수정</h1>
    <p class="page-desc">수정 내용은 참가자에게 알림으로 전송돼요.</p></div>

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
      <input class="input" id="title" name="title" placeholder="예: 토요일 저녁 풋살 한 판!" value="토요일 저녁 풋살 한 판!" required>
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
      <input class="input" id="place" name="place" placeholder="장소를 검색하세요" value="서울 마포구 망원 풋살장">
      <input type="hidden" name="lat"><input type="hidden" name="lng">
    </div>
  </section>

  <section class="form-section">
    <h2 class="sub-title">모집 설정</h2>
    <div class="grid-3">
      <div class="field"><label class="field-label" for="fee">참가비</label><input class="input" id="fee" name="fee" inputmode="numeric" placeholder="10,000원" value="10,000"></div>
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
      <textarea class="textarea soft" id="content" name="content" rows="6" placeholder="준비물, 경기 방식, 주차 정보 등을 적어주세요.">경기 시작 10분 전까지 도착 부탁드립니다. 실내화와 개인 음료를 준비해주세요.</textarea>
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
    <a class="btn btn-outline" href="${ctx}/jsp/match/personalMatchDetail.jsp?state=host">취소</a>
        <button type="submit" class="btn btn-primary" data-toast="경기 정보를 수정했어요.">수정 완료</button>
  </div>
</form>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
