<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  신고 접수 (reportWrite.jsp) - 담당: 박우리
  피그마: Report / Form / Desktop, Report / Post / Desktop
  ─ 하나의 JSP 로 처리 ─
   state : member(일반/회원 신고 - 유형 직접 선택) | post(게시글 신고 - 대상 게시글 정보 자동 입력)
  게시글 신고는 경기/후기 상세의 [신고] 버튼에서 ?state=post&targetNo= 로 들어옵니다.
  레이아웃: 문의 작성·상세, 신고 상세와 같은 .mp-body + .form-card 틀 사용
--%>
<c:set var="targetType" value="${param.targetType}" />
<c:set var="targetNo" value="${param.targetNo}" />

<c:set var="hasTarget" value="${not empty targetType and not empty targetNo}" />
<c:set var="isUser" value="${hasTarget and targetType eq 'user'}" />
<c:set var="isTeam" value="${hasTarget and targetType eq 'team'}" />
<c:set var="isPost" value="${hasTarget and (targetType eq 'personalMatch' or targetType eq 'teamMatch' or targetType eq 'review')}" />

<c:choose>
  <c:when test="${isPost}">
    <c:set var="reportTitle" value="게시글 신고 접수" />
    <c:set var="reportDesc"  value="신고 대상 게시글 정보는 자동으로 입력됩니다." />
    <c:set var="bodyHolder"  value="신고 대상 게시글에 관한 신고입니다." />
  </c:when>
  <c:when test="${isUser}">
    <c:set var="reportTitle" value="회원 신고 접수" />
    <c:set var="reportDesc"  value="신고 대상 회원 정보는 자동으로 입력됩니다." />
    <c:set var="bodyHolder"  value="신고 상황을 자세히 입력해주세요.&#10;확인이 필요한 상황과 내용을 구체적으로 적어주세요." />
  </c:when>
  <c:when test="${isTeam}">
    <c:set var="reportTitle" value="팀 신고 접수" />
    <c:set var="reportDesc"  value="신고 대상 팀 정보는 자동으로 입력됩니다." />
    <c:set var="bodyHolder"  value="신고 상황을 자세히 입력해주세요.&#10;확인이 필요한 상황과 내용을 구체적으로 적어주세요." />
  </c:when>
  <c:otherwise>
    <c:set var="reportTitle" value="신고 접수" />
    <c:set var="reportDesc"  value="신고할 내용을 작성해주세요. 확인 후 처리해드릴게요." />
    <c:set var="bodyHolder"  value="신고 상황을 자세히 입력해주세요.&#10;확인이 필요한 상황과 내용을 구체적으로 적어주세요." />
  </c:otherwise>
</c:choose>

<c:set var="pageTitle" value="${reportTitle}" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="support" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="member:일반 신고|post:게시글 신고" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<%-- TODO: action 을 신고 등록 서블릿으로 교체 --%>
<form class="work-inner mp-body inq-page" action="${ctx}/support/report/create" method="post">
  <h1 class="section-title">${reportTitle}</h1>
  <p class="section-desc">${reportDesc}</p>

  <c:if test="${hasTarget}">
    <input type="hidden" name="targetType" value="${targetType}">
    <input type="hidden" name="targetNo" value="${targetNo}">
  </c:if>

  <div class="form-card inq-card">
    <c:if test="${hasTarget}">
      <div class="field">
        <c:choose>
          <c:when test="${targetType eq 'user'}"><label class="field-label danger" for="rTarget">신고 대상 닉네임</label></c:when>
          <c:when test="${targetType eq 'team'}"><label class="field-label danger" for="rTarget">신고 대상 팀명</label></c:when>
          <c:when test="${targetType eq 'personalMatch'}"><label class="field-label danger" for="rTarget">신고 대상 개인경기 게시글 제목</label></c:when>
          <c:when test="${targetType eq 'teamMatch'}"><label class="field-label danger" for="rTarget">신고 대상 팀경기 게시글 제목</label></c:when>
          <c:otherwise><label class="field-label danger" for="rTarget">신고 대상 후기 게시글 제목</label></c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${targetType eq 'user'}"><input class="input" id="rTarget" name="target" placeholder="${reportTarget.userNickname}" readonly></c:when>
          <c:when test="${targetType eq 'team'}"><input class="input" id="rTarget" name="target" placeholder="${reportTarget.teamName}" readonly></c:when>
          <c:when test="${targetType eq 'personalMatch'}"><input class="input" id="rTarget" name="target" placeholder="${reportTarget.personalMatchTitle}" readonly></c:when>
          <c:when test="${targetType eq 'teamMatch'}"><input class="input" id="rTarget" name="target" placeholder="${reportTarget.teamMatchTitle}" readonly></c:when>
          <c:otherwise><input class="input" id="rTarget" name="target" placeholder="${reportTarget.reviewTitle}" readonly></c:otherwise>
        </c:choose>
      </div>
    </c:if>

    <div class="field">
      <label class="field-label" for="rType">신고 유형</label>
      <c:choose>
        <c:when test="${isPost}"><input class="input" id="rType" name="reportType" value="부적절한 글 신고" readonly></c:when>
        <c:otherwise>
          <select class="select" id="rType" name="reportType">
            <option>비매너 행동</option>
            <option>노쇼(불참)</option>
            <option>욕설·비방</option>
            <option>사기·금전 문제</option>
            <option>기타</option>
          </select>
        </c:otherwise>
      </c:choose>
    </div>
    <div class="field">
      <label class="field-label" for="rTitle">신고 제목</label>
      <input class="input" id="rTitle" name="title" placeholder="신고 제목을 입력해주세요." required>
    </div>
    <div class="field">
      <label class="field-label" for="rBody">신고 내용</label>
      <textarea class="textarea" id="rBody" name="content" rows="8" placeholder="${bodyHolder}" required></textarea>
    </div>
    <p class="notice-box">카테고리에 맞는 항목이 없으면 기타를 선택하고 상황을 구체적으로 적어주세요.</p>
  </div>

  <div class="form-actions">
    <a class="btn btn-outline" href="${ctx}/support/report/list">취소</a>
    <button type="submit" class="btn btn-primary">신고 접수</button>
  </div>
</form>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
