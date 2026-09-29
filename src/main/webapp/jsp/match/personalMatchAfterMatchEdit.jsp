<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 후 관리 - 출석 체크 · 참가자 평가 (personalMatchAfterMatchEdit.jsp) - 담당: 변재언
  피그마: Postgame / Rating / Edit / Desktop, Postgame / Rating / From Participating Past Match / Desktop
  ─ 하나의 JSP 로 처리 ─
   state : host(작성자 - 출석 체크 + 평가) | participant(참가자 - 출석은 조회만, 평가만 작성)
--%>
<c:set var="state" value="${empty param.state ? 'host' : param.state}" />
<c:set var="isHost" value="${state eq 'host'}" />
<c:set var="pageTitle" value="경기 후 관리" />
<c:set var="pageCss" value="match" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="host:작성자|participant:참가자" />
<%@ include file="/jsp/common/header.jsp" %>

<main class="page">
  <div class="container">
    <nav class="breadcrumb"><span>${isHost ? '내 경기' : '참가 경기'}</span><span class="sep">›</span><span>경기 후 관리</span></nav>
    <div class="page-head">
      <h1 class="page-title">경기 후 관리</h1>
      <p class="page-desc">본인을 제외한 참가자의 출석 여부와 평가를 관리합니다.</p>
    </div>
    <div class="tabs dark"><span class="tab is-active">출석 · 참가자 평가</span></div>

    <%-- TODO: action 을 평가 저장 서블릿으로 교체 --%>
    <form class="postgame-card" action="${ctx}/jsp/match/personalMatchAfterMatchDetail.jsp" method="post">
      <div class="match-summary">
        <div>
          <p class="tags"><span class="sport-tag neutral" style="background:var(--ds-brand-subtle);color:var(--ds-brand)">풋살</span>경기 종료</p>
          <strong>토요일 저녁 풋살 한 판!</strong>
          <p class="meta"><span>9/19 (토) 19:00 - 21:00</span><span>서울 마포구 · 망원 풋살장</span></p>
        </div>
        <div class="target">평가 대상<b>3명</b></div>
      </div>

      <div class="eval-head">
        <h3>출석 · 참가자 평가</h3>
        <p>${isHost ? '출석은 호스트만 체크할 수 있어요. 참가자의 출석 여부를 체크하고 경기 매너를 평가해주세요.' : '호스트가 체크한 출석 정보를 확인하고, 함께 뛴 참가자의 매너를 평가해주세요.'}</p>
      </div>

      <%-- TODO: <c:forEach var="p" items="${participantList}" varStatus="st"> --%>
      <c:forTokens items="서울킥:attend:0,공차는날:absent:4,운동하자:absent:4" delims="," var="row" varStatus="st">
        <c:set var="parts" value="${fn:split(row, ':')}" />
        <div class="eval-row">
          <div class="who"><span class="avatar sm default"></span>${parts[0]}</div>
          <c:choose>
            <c:when test="${isHost}">
              <div class="chip-group att-toggle" data-select="single" data-name="attend_${st.index}">
                <button type="button" class="chip ${parts[1] eq 'attend' ? 'is-selected' : ''}" data-value="Y">출석</button>
                <button type="button" class="chip ${parts[1] eq 'absent' ? 'is-selected' : ''}" data-value="N">미출석</button>
              </div>
            </c:when>
            <c:otherwise><div><span class="att-badge">${parts[1] eq 'attend' ? '출석' : '미출석'}</span></div></c:otherwise>
          </c:choose>
          <div class="rate star-input">
            <c:forEach var="i" begin="1" end="5"><button type="button" class="${i le parts[2] ? 'is-on' : ''}" aria-label="${i}점">★</button></c:forEach>
            <span class="score">${parts[2] eq '0' ? '-' : parts[2]}.5</span>
            <input type="hidden" name="score_${st.index}" value="${parts[2]}">
          </div>
        </div>
      </c:forTokens>

      <div class="form-actions" style="margin-right:20px">
        <button type="submit" class="btn btn-primary">정보 저장</button>
      </div>
    </form>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
