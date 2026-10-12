<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 후 관리 - 출석 체크 · 참가자 평가 (personalMatchAfterMatchEdit.jsp) - 담당: 변재언
  피그마: Postgame / Rating / Edit / Desktop, Postgame / Rating / From Participating Past Match / Desktop
  ─ 하나의 JSP 로 처리 ─
   state : host(작성자 - 출석 체크 + 평가) | participant(참가자 - 출석은 조회만, 평가만 작성)
--%>
<c:set var="state" value="${empty param.state ? 'host' : param.state}" />
<c:set var="isHost" value="${sessionScope.user.userId eq personalMatch.userId}" />
<c:set var="pageTitle" value="경기 후 관리" />
<c:set var="pageCss" value="match" />
<%@ include file="/jsp/common/header.jsp" %>

<main class="page">
  <div class="container">
    <nav class="breadcrumb"><span>${isHost ? '내 경기' : '참가 경기'}</span><span class="sep">›</span><span>경기 후 관리</span></nav>
    <div class="page-head">
      <h1 class="page-title">경기 후 관리</h1>
      <p class="page-desc">본인을 제외한 참가자의 출석 여부와 평가를 관리합니다.</p>
    </div>
    <div class="tabs dark"><span class="tab is-active">출석 · 참가자 평가</span></div>

    <form class="postgame-card" action="${ctx}/match/after/profile/list/edit" method="post">
    <input type="hidden" name="personalMatchId" value="${personalMatch.personalMatchId}">
      <div class="match-summary">
        <div>
          <p class="tags"><span class="sport-tag neutral" style="background:var(--ds-brand-subtle);color:var(--ds-brand)">${personalMatch.sport }</span>${personalMatch.status }</p>
          <strong>${personalMatch.title }</strong>
          <p class="meta">
          	<span>${personalMatch.matchDate}（${personalMatch.dayOfWeekKorean}）
	            ${personalMatch.startTime} ～ 
	            ${personalMatch.endTime}
            </span>
            <span>${personalMatch.region } · ${personalMatch.placeName }</span>
           </p>
        </div>
        
        <div class="target">평가 대상<b>${userList.size() }명</b></div>
      </div>

      <div class="eval-head">
        <h3>출석 · 참가자 평가</h3>
        <p>${isHost ? '출석은 호스트만 체크할 수 있어요. 참가자의 출석 여부를 체크하고 경기 매너를 평가해주세요.' : '호스트가 체크한 출석 정보를 확인하고, 함께 뛴 참가자의 매너를 평가해주세요.'}</p>
      </div>
      
      
		<c:forEach var="user" items="${userList}" varStatus="st">
		  <div class="eval-row">
		    <div class="who">
		      <span class="avatar sm default"></span>${user.nickname}		      
		    </div>

		
		    <c:choose>
		      <c:when test="${isHost}">
		        <div class="chip-group att-toggle" data-select="single" data-name="attend_${st.index}">
		          <button type="button" class="chip ${user.attendance ? 'is-selected' : ''}" data-value="Y">출석</button>
		          <button type="button" class="chip ${not user.attendance ? 'is-selected' : ''}" data-value="N">미출석</button>
		        </div>
		      </c:when>
		      <c:otherwise>
		        <div><span class="att-badge">${user.attendance ? '출석' : '미출석'}</span></div>
		      </c:otherwise>
		    </c:choose>
		    <div class="rate star-input">
		      <c:forEach var="i" begin="1" end="5">
		      <button type="button" aria-label="${i}점">★</button>
 		      </c:forEach>
		      <span class="score">0</span>
		      <input type="hidden" name="score_${st.index}" value="0">
		    </div>
		
		    <input type="hidden" name="userId_${st.index}" value="${user.userId}">
		  </div>
		</c:forEach>

      <div class="form-actions" style="margin-right:20px">
        <button type="submit" class="btn btn-primary">정보 저장</button>
      </div>
    </form>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
