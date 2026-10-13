<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀원 보기 (teamInfoMembers.jsp) - 담당: 하준수
  팀원 전용 조회 화면 (관리 메뉴 없음)
  서블릿에서 넘기는 값: team, userList
--%>
<c:set var="infoMode" value="true" />
<c:set var="manageTab" value="members" />
<c:set var="pageTitle" value="팀원" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="team" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container">
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><a
				href="${ctx}/team/detail/view?teamId=${team.teamId}"><c:out value="${team.teamName}" /></a><span
				class="sep">›</span><span>팀 정보</span>
		</nav>
		<div class="page-head" style="margin-bottom: 24px">
			<h1 class="page-title"><c:out value="${team.teamName}" /></h1>
			<p class="page-desc">팀원과 팀 작성글을 확인할 수 있어요.</p>
		</div>
		<nav class="tabs">
			<a class="tab ${manageTab eq 'members' ? 'is-active' : ''}"
				href="${ctx}/team/info/members?teamId=${team.teamId}">팀원</a>
			<a class="tab ${manageTab eq 'posts' ? 'is-active' : ''}"
				href="${ctx}/team/info/posts?teamId=${teamId}">팀 작성글</a>
		</nav>

		<h2 class="sub-title">팀원 ${team.currentPeople}명</h2>
		<p class="section-desc" style="margin-bottom: 24px">함께 활동 중인 팀원의 역할과 프로필을 확인할 수 있어요.</p>

		<div class="member-grid">
			<c:forEach var="m" items="${userList}">
				<div class="member-card">
					<c:choose>
						<c:when test="${not empty m.profileImage}">
							<span class="avatar"><img src="${ctx}/profiles/${m.profileImage}" alt=""></span>
						</c:when>
						<c:otherwise>
							<span class="avatar"><img src="${ctx}/img/default-profile.svg" alt=""></span>
						</c:otherwise>
					</c:choose>
					<div class="info">
						<strong><c:out value="${m.nickname}" /></strong>
						<c:if test="${m.teamRole eq 'CAPTAIN'}"><span class="pill pill-brand role">주장</span></c:if>
						<c:if test="${m.teamRole eq 'VICE_CAPTAIN'}"><span class="pill pill-brand role">부주장</span></c:if>
						<p class="meta">
							<c:out value="${empty m.preferredRegion1 ? '지역 미설정' : m.preferredRegion1}" />
							·
							<c:choose>
								<c:when test="${team.sport eq '축구/풋살'}"><c:out value="${empty m.soccerSkill ? '실력 미설정' : m.soccerSkill}" /></c:when>
								<c:when test="${team.sport eq '농구'}"><c:out value="${empty m.basketballSkill ? '실력 미설정' : m.basketballSkill}" /></c:when>
								<c:when test="${team.sport eq '테니스'}"><c:out value="${empty m.tennisSkill ? '실력 미설정' : m.tennisSkill}" /></c:when>
								<c:when test="${team.sport eq '배드민턴'}"><c:out value="${empty m.badmintonSkill ? '실력 미설정' : m.badmintonSkill}" /></c:when>
								<c:otherwise>실력 미설정</c:otherwise>
							</c:choose>
						</p>
						<c:if test="${not empty m.joinedAt}">
							<p class="meta" style="margin-top:2px;">
								${fn:substring(m.joinedAt, 0, 10)} 가입
							</p>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>
			<c:if test="${fn:length(userList) > 12}">
				<div class="more-wrap">
					<button type="button" class="btn-more">↓ &nbsp;더보기</button>
				</div>
			</c:if>
	</div>
</main>
<script>
$(function () {
	var SHOW = 12;
	var $cards = $('.member-grid .member-card');
	$cards.slice(SHOW).hide();

	$('.btn-more').on('click', function () {
		$('.member-grid .member-card:hidden').slice(0, SHOW).show();
		if ($('.member-grid .member-card:hidden').length === 0) {
			$('.more-wrap').hide();
		}
	});
});
</script>
<%@ include file="/jsp/common/footer.jsp"%>