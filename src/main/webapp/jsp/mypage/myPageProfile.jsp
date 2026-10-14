<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  내 프로필 (myPageProfile.jsp) - 담당: 박우리
  피그마: MyPage / Profile / Desktop
--%>
<c:set var="pageTitle" value="내 프로필" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="profile" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner" style="padding-left:24px">
  <h1 class="sub-title">프로필 사진</h1>
  <p class="section-desc">현재 프로필 사진입니다.</p>
  <div class="profile-photo">
  	<c:choose>
  		<c:when test="${not empty loginUser.profileImage }">
  			<img class="avatar lg"
  				src="${ctx}${profilePath}/${loginUser.profileImage}"
  				alt="프로필 사진">
		</c:when>
		<c:otherwise>
			<img class="avatar lg"
				src="${ctx }/img/default-profile.svg"
				alt="기본 프로필 사진">
		</c:otherwise>
	</c:choose>	
 </div>
  <dl class="pf-list">
    <dt>관심 종목</dt><dd>${loginUser.preferredSport1} · ${loginUser.preferredSport2} · ${loginUser.preferredSport3}</dd>
    <dt>주 활동 지역</dt><dd>${loginUser.preferredRegion1} · ${loginUser.preferredRegion2} · ${loginUser.preferredRegion3}</dd>
  </dl>
  <h2 class="sub-title mt-32">종목별 프로필</h2>
  <dl class="pf-list" style="margin-top:14px">
    <dt>축구/풋살</dt><dd class="brand">${loginUser.soccerSkill}</dd><dt>농구</dt><dd class="brand">${loginUser.basketballSkill}</dd>
    <dt>테니스</dt><dd class="brand">${loginUser.tennisSkill}</dd><dt>배드민턴</dt><dd class="brand">${loginUser.badmintonSkill}</dd>
  </dl>
  <h2 class="sub-title mt-32">한 줄 소개</h2>
  <p class="t-12 mt-8">"${loginUser.bio}"</p>
  <div class="form-actions"><a class="btn btn-primary" href="${ctx}/member/profile/edit" style="width:92px">수정</a></div>
<div class="work-inner full pf-page">

  <div class="pf-head">
    <h1 class="section-title">내 프로필</h1>
    <p class="section-desc">다른 사용자에게 보여지는 나의 프로필입니다.</p>
  </div>

  <%-- 프로필 사진 + 한 줄 소개 --%>
  <section class="pf-card">
    <h2 class="sub-title">프로필</h2>
    <div class="pf-intro">
      <c:choose>
        <c:when test="${not empty loginUser.profileImage}">
          <img class="avatar lg" src="${ctx}${profilePath}/${loginUser.profileImage}" alt="프로필 사진">
        </c:when>
        <c:otherwise>
          <img class="avatar lg" src="${ctx}/img/default-profile.svg" alt="기본 프로필 사진">
        </c:otherwise>
      </c:choose>
      <div class="pf-intro-body">
        <p class="pf-intro-label">한 줄 소개</p>
        <c:choose>
          <c:when test="${not empty loginUser.bio}">
            <p class="pf-bio">"<c:out value="${loginUser.bio}" />"</p>
          </c:when>
          <c:otherwise>
            <p class="pf-bio is-empty">작성한 한 줄 소개가 없습니다.</p>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </section>

  <%-- 관심 종목 / 활동 지역 --%>
  <section class="pf-card">
    <h2 class="sub-title">활동 정보</h2>
    <dl class="pf-rows">
      <div class="pf-row">
        <dt>관심 종목</dt>
        <dd>
          <c:if test="${not empty loginUser.preferredSport1}"><span class="pill pill-brand">${loginUser.preferredSport1}</span></c:if>
          <c:if test="${not empty loginUser.preferredSport2}"><span class="pill pill-brand">${loginUser.preferredSport2}</span></c:if>
          <c:if test="${not empty loginUser.preferredSport3}"><span class="pill pill-brand">${loginUser.preferredSport3}</span></c:if>
          <c:if test="${empty loginUser.preferredSport1 and empty loginUser.preferredSport2 and empty loginUser.preferredSport3}">
            <span class="pf-empty-text">선택한 관심 종목이 없습니다.</span>
          </c:if>
        </dd>
      </div>
      <div class="pf-row">
        <dt>주 활동 지역</dt>
        <dd>
          <c:if test="${not empty loginUser.preferredRegion1}"><span class="pill pill-outline">${loginUser.preferredRegion1}</span></c:if>
          <c:if test="${not empty loginUser.preferredRegion2}"><span class="pill pill-outline">${loginUser.preferredRegion2}</span></c:if>
          <c:if test="${not empty loginUser.preferredRegion3}"><span class="pill pill-outline">${loginUser.preferredRegion3}</span></c:if>
          <c:if test="${empty loginUser.preferredRegion1 and empty loginUser.preferredRegion2 and empty loginUser.preferredRegion3}">
            <span class="pf-empty-text">선택한 활동 지역이 없습니다.</span>
          </c:if>
        </dd>
      </div>
    </dl>
  </section>

  <%-- 종목별 프로필 : 입력된 종목은 파란 카드, 미입력은 점선 카드 --%>
  <section class="pf-card">
    <h2 class="sub-title">종목별 프로필</h2>
    <div class="pf-tiles">
      <div class="pf-tile ${empty loginUser.soccerSkill ? 'is-empty' : ''}">
        <small>축구/풋살</small>
        <b><c:out value="${empty loginUser.soccerSkill ? '미설정' : loginUser.soccerSkill}" /></b>
      </div>
      <div class="pf-tile ${empty loginUser.basketballSkill ? 'is-empty' : ''}">
        <small>농구</small>
        <b><c:out value="${empty loginUser.basketballSkill ? '미설정' : loginUser.basketballSkill}" /></b>
      </div>
      <div class="pf-tile ${empty loginUser.tennisSkill ? 'is-empty' : ''}">
        <small>테니스</small>
        <b><c:out value="${empty loginUser.tennisSkill ? '미설정' : loginUser.tennisSkill}" /></b>
      </div>
      <div class="pf-tile ${empty loginUser.badmintonSkill ? 'is-empty' : ''}">
        <small>배드민턴</small>
        <b><c:out value="${empty loginUser.badmintonSkill ? '미설정' : loginUser.badmintonSkill}" /></b>
      </div>
    </div>
  </section>

  <div class="form-actions">
    <a class="btn btn-primary" href="${ctx}/member/profile/edit">수정</a>
  </div>

</div>
<%@ include file="/jsp/common/footer.jsp" %>
