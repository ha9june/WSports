<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  후기 작성 (reviewWrite.jsp) - 담당: 강신우
  피그마: Review / Form / Desktop, Review / Form / From Past Match, Review / Form / From Club Match
   state : select(참여 경기 직접 선택) | pastMatch(개인 경기에서 진입 - 경기 고정) | clubMatch(팀 경기에서 진입 - 경기 고정)
--%>

<c:set var="state" value="${empty param.state ? 'select' : param.state}" />
<c:if test="${state eq 'pastMatch'}"><c:set var="fixedMatch" value="9/19 토요일 저녁 풋살 한 판!" /></c:if>
<c:if test="${state eq 'clubMatch'}"><c:set var="fixedMatch" value="9/13 서울 풋살 크루 vs 망원 FC" /></c:if>
<c:set var="pageTitle" value="후기 작성" />
<c:set var="pageCss" value="review" />
<c:set var="activeNav" value="review" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="select:경기 선택|pastMatch:개인 경기에서|clubMatch:팀 경기에서" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
<form class="rail" action="${ctx}/jsp/review/reviewDetail.jsp?state=mine" method="post" enctype="multipart/form-data">
  <nav class="breadcrumb"><a href="${ctx}/jsp/review/reviewList.jsp">후기</a><span class="sep">›</span><span>작성</span></nav>
  <div class="page-head"><h1 class="page-title">후기 작성</h1><p class="page-desc">경기 후기를 작성하고 경험을 공유해보세요.</p></div>
  <div style="width:744px;max-width:100%">
    <div class="field"><label class="field-label" for="matchNo">참여 경기</label>
      <c:choose>
        <c:when test="${not empty fixedMatch}"><input class="input" value="${fixedMatch}" readonly style="width:420px"><input type="hidden" name="matchNo" value="${param.matchNo}"></c:when>
        <c:otherwise>
          <%-- TODO: 내가 참가 완료한 경기 목록으로 option 채우기 --%>
          <select class="select" id="matchNo" name="matchNo" style="width:420px"><option value="">참여한 경기를 선택하세요</option><option>9/19 토요일 저녁 풋살 한 판!</option><option>9/13 망원 배드민턴 번개</option><option>9/13 서울 풋살 크루 vs 망원 FC (팀 경기)</option></select>
        </c:otherwise>
      </c:choose></div>
    <div class="field mt-24"><label class="field-label" for="rvTitle">제목</label><input class="input" id="rvTitle" name="title" style="width:420px" placeholder="후기 제목을 입력하세요" value="" required></div>
    <div class="field mt-24"><label class="field-label" for="rvBody">내용</label>
      <textarea class="textarea soft" id="rvBody" name="content" rows="7" placeholder="경기에서 좋았던 점이나 참고할 내용을 적어주세요." required></textarea></div>
    <div class="field mt-24"><span class="field-label" style="color:var(--ds-text)">사진 <span class="t-11 t-2">선택 · 최대 5장</span></span>
      <div class="photo-upload">
        <label class="photo-add"><span class="plus">+</span>사진 추가<input type="file" name="photos" accept="image/png,image/jpeg" multiple data-preview data-max="5"></label>
        <div class="photo-preview">미리보기</div><div class="photo-preview">미리보기</div>
      </div>
      <p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p></div>
    <div class="form-actions">
      <a class="btn btn-outline" href="${ctx}/jsp/review/reviewList.jsp">취소</a>
      <button type="submit" class="btn btn-primary">등록</button>
    </div>
  </div>
</form>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
