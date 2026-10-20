<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 작성글 (teamInfoPosts.jsp) - 담당: 하준수
  피그마: Club / Team Info / Match Posts / Desktop (팀원 전용 조회)
  TODO: <c:forEach var="p" items="${teamMatchPostList}">
--%>
<c:set var="infoMode" value="true" />
<c:set var="manageTab" value="posts" />
<c:set var="pageTitle" value="팀 작성글" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="team" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container">
		<%--
  팀 관리 공통 상단 (가입 신청 / 팀원 관리 / 팀 작성글 관리 탭)
   - manageTab : application | members | posts
   - infoMode  : true 면 팀원용 조회 화면(팀원 보기 / 팀 작성글 보기) 탭으로 표시
--%>
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><a
				href="${ctx}/team/detail/veiw?teamId=${teamId}">${team.teamName }</a><span
				class="sep">›</span><span>팀 정보</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">서울 풋살 크루</h1>
			<p class="page-desc">팀원과 팀 작성글을 확인할 수 있어요.</p>
		</div>
		<nav class="tabs">
			<a class="tab ${manageTab eq 'members' ? 'is-active' : ''}"
				href="${ctx}/team/info/members?teamId=${teamId}">팀원</a> <a
				class="tab ${manageTab eq 'posts' ? 'is-active' : ''}"
				href="${ctx}/team/info/posts?teamId=${teamId}">팀 작성글</a>
		</nav>
		<h2 class="sub-title">작성한 팀 매칭 글</h2>
		<p class="section-desc">우리 팀이 작성한 상대 팀
			모집 글이에요.</p>
		<div class="post-grid">
			<c:forEach var="tm" items="${teamMatchList}">
				<div class="post-card"
					data-href="${ctx}/team-match/detail/view?teamMatchId=${tm.teamMatchId}">
					<p class="ttl">
						${tm.title}
						<c:choose>
							<c:when test="${tm.status eq '모집중' }">
								<span class="pill pill-success">${tm.status}</span>
							</c:when>
							<c:when test="${tm.status eq '모집 마감' or tm.status eq '경기 종료' }">
								<span class="pill pill-info">${tm.status}</span>
							</c:when>
							<c:when
								test="${tm.status eq '경기 취소'}">
								<span class="pill pill-danger">경기 취소</span>
							</c:when>
						</c:choose>
					</p>
					<p>${tm.matchDate} (${tm.dayOfWeekKorean}) ${tm.startTime} ~ ${tm.endTime} ·
						${tm.region }</p>
				</div>
			</c:forEach>
		</div>
		<c:if test="${pageInfo.allPage > 1}">
			<nav class="pagination">
				<c:if test="${pageInfo.curPage > 1}">
					<a href="${ctx}/team/manage/posts?teamId=${teamId}&page=${pageInfo.curPage - 1}">‹</a>
				</c:if>
		
				<c:forEach var="p" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
					<a href="${ctx}/team/manage/posts?teamId=${teamId}&page=${p}"
						class="${pageInfo.curPage eq p ? 'is-active' : ''}">${p}</a>
				</c:forEach>
		
				<c:if test="${pageInfo.curPage < pageInfo.allPage}">
					<a href="${ctx}/team/manage/posts?teamId=${teamId}&page=${pageInfo.curPage + 1}">›</a>
				</c:if>
			</nav>
		</c:if>
	</div>
</main>
<%@ include file="/jsp/common/footer.jsp"%>
