<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  상대 팀 모집 수정 (teamMatchEdit.jsp) - 담당: 하준수
  피그마: Club Match / Form / Desktop (수정 - 값이 채워진 상태)
--%>
<c:set var="pageTitle" value="상대 팀 모집 수정" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="teamMatch" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
<form class="form-rail" action="${ctx}/jsp/team/teamMatchDetail.jsp?state=hostRecruiting" method="post" enctype="multipart/form-data">
  <nav class="breadcrumb"><a href="${ctx}/jsp/team/teamList.jsp">팀</a><span class="sep">›</span><a href="${ctx}/jsp/team/teamMatchList.jsp">팀 매칭</a><span class="sep">›</span><span>경기 수정</span></nav>
  <div class="page-head"><h1 class="page-title">상대 팀 모집 수정</h1><p class="page-desc">작성과 수정은 같은 화면을 사용합니다.</p></div>
  <div style="width:744px;max-width:100%">
    <section class="form-section">
      <h2 class="sub-title">경기 정보</h2>
      <div class="grid-3" style="grid-template-columns:200px 1fr">
        <div class="field"><label class="field-label" for="team">팀</label>
          <%-- TODO: 내가 팀장/부팀장인 팀만 선택 가능 --%>
          <select class="select" id="team" name="teamNo" disabled><option>서울 풋살 크루</option><option>성동 농구 모임</option></select></div>
        <div class="field"><span class="field-label">종목</span>
          <div class="chip-group" data-select="single" data-name="sportCode"><button type="button" class="chip is-selected">축구/풋살</button><button type="button" class="chip">농구</button><button type="button" class="chip">테니스</button><button type="button" class="chip">배드민턴</button></div></div>
      </div>
      <div class="field"><label class="field-label" for="tmTitle">제목</label><input class="input" id="tmTitle" name="title" value="서울 풋살 크루 연습경기 상대 팀 모집" placeholder="예: 서울 풋살 크루 연습경기 상대 팀 모집" required></div>
    </section>
    <section class="form-section">
      <h2 class="sub-title">일정 및 장소</h2>
      <div class="grid-3" style="grid-template-columns:200px 1fr">
        <div class="field"><label class="field-label" for="tmDate">경기일자</label><input class="input" type="date" id="tmDate" name="matchDate" value="2026-09-27"></div>
        <div class="field"><span class="field-label">시간</span><div class="time-range">
          <select class="select" name="startTime" style="width:140px"><option selected>17:00</option><option>18:00</option></select><span>~</span>
          <select class="select" name="endTime" style="width:140px"><option selected>19:00</option><option>20:00</option></select></div></div>
      </div>
      <div class="field"><label class="field-label" for="tmPlace">장소</label><input class="input" id="tmPlace" name="place" value="난지 풋살장" placeholder="장소를 검색하세요"></div>
    </section>
    <section class="form-section">
      <h2 class="sub-title">경기 설정</h2>
      <div class="grid-3" style="grid-template-columns:200px 200px">
        <div class="field"><label class="field-label" for="tmFee">참가비</label><input class="input" id="tmFee" name="fee" value="50,000원" placeholder="50,000원"></div>
        <div class="field"><label class="field-label" for="tmSize">경기 인원</label><select class="select" id="tmSize" name="teamSize"><option>5 vs 5</option><option selected>6 vs 6</option><option>11 vs 11</option></select></div>
      </div>
      <div class="field" style="width:200px"><label class="field-label" for="tmDeadline">모집 마감</label><input class="input" type="datetime-local" id="tmDeadline" name="deadline" value="2026-09-25T18:00"></div>
    </section>
    <section class="form-section">
      <h2 class="sub-title">모집 조건</h2><p class="section-desc" style="margin:-8px 0 16px">신청 가능한 팀의 연령대, 성별, 팀 레벨을 설정하세요.</p>
      <div class="field"><span class="field-label t-bold" style="color:var(--ds-text)">연령대 <span class="t-11 t-2" style="font-weight:400">복수 선택 가능</span></span>
        <div class="chip-group" data-select="multi" data-name="ages"><button type="button" class="chip is-selected">20대</button><button type="button" class="chip is-selected">30대</button><button type="button" class="chip">40대</button><button type="button" class="chip">50대 이상</button><button type="button" class="chip">연령 무관</button></div></div>
      <div class="grid-3" style="grid-template-columns:240px 1fr;margin-top:20px">
        <div class="field"><span class="field-label t-bold" style="color:var(--ds-text)">성별</span><div class="chip-group" data-select="single" data-name="gender"><button type="button" class="chip">남자</button><button type="button" class="chip">여자</button><button type="button" class="chip is-selected">성별 무관</button></div></div>
        <div class="field"><span class="field-label t-bold" style="color:var(--ds-text)">팀 레벨</span><div class="chip-group" data-select="multi" data-name="levels"><button type="button" class="chip">입문</button><button type="button" class="chip is-selected">초급</button><button type="button" class="chip">중급</button><button type="button" class="chip">상급</button></div></div>
      </div>
    </section>
    <section class="form-section">
      <h2 class="sub-title">상세 내용</h2>
      <div class="field"><label class="field-label" for="tmDesc">상세 설명</label><textarea class="textarea soft" id="tmDesc" name="content" rows="5" placeholder="경기 방식, 준비물, 팀 유니폼 색상 등을 적어주세요.">6 vs 6 풋살 경기입니다. 경기 시작 10분 전까지 도착해주세요.</textarea></div>
      <div class="field"><span class="field-label">사진 <span class="t-11 t-2">선택 · 최대 5장</span></span>
        <div class="photo-upload"><label class="photo-add"><span class="plus">+</span>사진 추가<input type="file" name="photos" accept="image/png,image/jpeg" multiple data-preview data-max="5"></label><div class="photo-preview">미리보기</div><div class="photo-preview">미리보기</div></div>
        <p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p></div>
    </section>
    <div class="form-actions"><a class="btn btn-outline" href="${ctx}/jsp/team/teamMatchList.jsp">취소</a><button type="submit" class="btn btn-primary">수정 완료</button></div>
  </div>
</form>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
