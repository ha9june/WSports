<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 작성글 관리 (teamManagePosts.jsp) - 담당: 하준수
  피그마: Club / Manage / Match Posts / Desktop
  TODO: <c:forEach var="p" items="${teamMatchPostList}">
--%>
<c:set var="infoMode" value="false" />
<c:set var="manageTab" value="posts" />
<c:set var="pageTitle" value="팀 작성글 관리" />
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
				href="${ctx}/team/detail/view?teamId=${teamId}">서울
				풋살 크루</a><span class="sep">›</span><span>관리</span>
		</nav>
		<div class="page-head" style="margin-bottom: 24px">
			<h1 class="page-title">${infoMode ? '서울 풋살 크루' : '팀 관리'}</h1>
			<p class="page-desc">${infoMode ? '팀원과 팀 작성글을 확인할 수 있어요.' : '가입 신청, 팀원, 팀 작성글 관리를 한 화면에서 전환합니다.'}</p>
		</div> 
		<nav class="tabs">
					<a class="tab ${manageTab eq 'application' ? 'is-active' : ''}"
						href="${ctx}/team/manage/applications">가입 신청</a>
					<a class="tab ${manageTab eq 'members' ? 'is-active' : ''}"
						href="${ctx}/team/manage/members">팀원 관리</a>
					<a class="tab ${manageTab eq 'posts' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamManagePosts.jsp">팀 작성글 관리</a>
		</nav>
		<h2 class="sub-title">작성한 팀 매칭 글</h2>
		<p class="section-desc" style="margin-bottom: 24px">내 팀이 작성한 상대 팀
			경기를 수정하거나 관리할 수 있어요.</p>
		<div class="post-grid">
			<c:forEach var="tm" items="${teamMatchList}">
				<div class="post-card"
					data-href="${ctx}/team-match/detail/view?teamMatchId?${tm.teamMatchId}">
					<p class="ttl" style="margin: 0">
						${tm.title} 
						<c:choose>
							<c:when test="${tm.status eq '모집중' }">
								<span class="pill pill-success">${tm.status}</span>
							</c:when>
							<c:when test="${tm.status eq '모집 마감' or tm.status eq '경기 종료' }">
								<span class="pill pill-info">${tm.status}</span>
							</c:when>
							<c:when test="${tm.status eq '인원 미달 경기 취소' or status eq '작성자 경기 취소'}">
								<span class="pill pill-danger">경기 취소</span>
							</c:when>
						</c:choose>
					</p>
					<p>${tm.matchDate} (요일 가공해야됨) ${tm.startTime} ~ ${tm.endTime} · ${tm.placeName }</p>
					<div class="acts">
						<a class="btn btn-outline btn-xs"
							href="${ctx}/jsp/team/teamMatchEdit.jsp">수정</a><a
							class="btn btn-primary btn-xs"
							href="${ctx}/team-match/detail/view?teamMatchId=${tm.teamMatchId}">경기
							상세</a>
					</div>
				</div>
			</c:forEach>
				
		</div>
	</div>
</main>
<%@ include file="/jsp/common/footer.jsp"%>
