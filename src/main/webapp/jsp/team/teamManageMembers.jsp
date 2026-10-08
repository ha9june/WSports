<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 관리 - 팀원 관리 (teamManageMembers.jsp) - 담당: 하준수
  피그마: Club / Manage / Members, Club / Manage / Members — 역할 관리 흐름
          (Vice Captain Grant / Vice Revoked Toast / Member Kick / Member Action Menu / Inline Profile Hover)
   state : default | vice(부팀장 지정 모달) | viceRevoked(해제 완료 토스트) | kick(강퇴 모달)
  닉네임에 마우스를 올리면 프로필 호버 카드, ⋮ 메뉴로 역할 변경·강퇴
--%>
<c:set var="state"
	value="${empty param.state ? 'default' : param.state}" />
<c:set var="manageTab" value="members" />
<c:set var="pageTitle" value="팀원 관리" />
<c:set var="pageCss" value="match,team" />
<c:set var="pageJs" value="team" />
<c:set var="activeNav" value="team" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates"
	value="default:기본|vice:부팀장 지정 모달|viceRevoked:부팀장 해제 토스트|kick:강퇴 모달" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container">
		<%--
  팀 관리 공통 상단 (가입 신청 / 팀원 관리 / 팀 작성글 관리 탭)
   - manageTab : application | members | posts
   - infoMode  : true 면 팀원용 조회 화면(팀원 보기 / 팀 작성글 보기) 탭으로 표시
--%>
		<nav class="breadcrumb">
			<a href="${ctx}/jsp/team/teamList.jsp">팀</a><span class="sep">›</span><a
				href="${ctx}/jsp/team/teamDetail.jsp?state=${infoMode ? 'member' : 'manager'}">서울
				풋살 크루</a><span class="sep">›</span><span>${infoMode ? '팀 정보' : '관리'}</span>
		</nav>
		<div class="page-head" style="margin-bottom: 24px">
			<h1 class="page-title">${infoMode ? '서울 풋살 크루' : '팀 관리'}</h1>
			<p class="page-desc">${infoMode ? '팀원과 팀 작성글을 확인할 수 있어요.' : '가입 신청, 팀원, 팀 작성글 관리를 한 화면에서 전환합니다.'}</p>
		</div>
		<nav class="tabs">
			<c:choose>
				<c:when test="${infoMode}">
					<a class="tab ${manageTab eq 'members' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamInfoMembers.jsp">팀원</a>
					<a class="tab ${manageTab eq 'posts' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamInfoPosts.jsp">팀 작성글</a>
				</c:when>
				<c:otherwise>
					<a class="tab ${manageTab eq 'application' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamManageApplication.jsp">가입 신청</a>
					<a class="tab ${manageTab eq 'members' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamManageMembers.jsp">팀원 관리</a>
					<a class="tab ${manageTab eq 'posts' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamManagePosts.jsp">팀 작성글 관리</a>
				</c:otherwise>
			</c:choose>
		</nav>
		<h2 class="sub-title">팀원 34명</h2>
		<p class="section-desc" style="margin-bottom: 24px">팀원의 역할을 확인하고
			관리할 수 있어요.</p>
		<%-- TODO: <c:forEach var="m" items="${memberList}"> 팀장 본인은 메뉴 없음 --%>
		<div class="member-grid">
			<div class="member-card">
				<span class="avatar"><img src="${ctx}/img/avatar-01.jpg"
					alt=""></span>
				<div class="info">
					<strong>풋살초보</strong>
					<p class="meta">서울 마포구 · 초급</p>
					<div class="hover-card">
						<div class="top">
							<span class="avatar md"><img
								src="${ctx}/img/avatar-01.jpg" alt=""></span>
							<div>
								<strong>풋살초보</strong>
								<p>서울 마포구 · 초급</p>
								<p class="rating">4.8 · 18개 평가</p>
							</div>
						</div>
						<dl>
							<dt>주 활동 지역</dt>
							<dd>서울 마포구</dd>
							<dt>선호 시간</dt>
							<dd>평일 저녁</dd>
						</dl>
					</div>
				</div>
				<div class="dropdown">
					<button type="button" class="icon-btn" data-dropdown-toggle
						aria-label="팀원 메뉴">⋮</button>
					<div class="dropdown-menu">
						<button type="button" data-member-name="풋살초보"
							data-modal-open="viceModal">부팀장으로 지정</button>
						<hr>
						<button type="button" class="danger" data-member-name="풋살초보"
							data-modal-open="kickModal">강퇴하기</button>
					</div>
				</div>
			</div>
			<div class="member-card">
				<span class="avatar"><img src="${ctx}/img/avatar-02.jpg"
					alt=""></span>
				<div class="info">
					<strong>운동하자</strong><span class="pill pill-brand role">부팀장</span>
					<p class="meta">서울 서대문구 · 중급</p>
					<div class="hover-card">
						<div class="top">
							<span class="avatar md"><img
								src="${ctx}/img/avatar-02.jpg" alt=""></span>
							<div>
								<strong>운동하자</strong>
								<p>서울 서대문구 · 중급</p>
								<p class="rating">4.8 · 18개 평가</p>
							</div>
						</div>
						<dl>
							<dt>주 활동 지역</dt>
							<dd>서울 서대문구</dd>
							<dt>선호 시간</dt>
							<dd>평일 저녁</dd>
						</dl>
					</div>
				</div>
				<div class="dropdown">
					<button type="button" class="icon-btn" data-dropdown-toggle
						aria-label="팀원 메뉴">⋮</button>
					<div class="dropdown-menu">
						<button type="button" data-member-name="운동하자"
							data-modal-open="viceRevokeModal">부팀장 해제</button>
						<hr>
						<button type="button" class="danger" data-member-name="운동하자"
							data-modal-open="kickModal">강퇴하기</button>
					</div>
				</div>
			</div>
			<div class="member-card">
				<span class="avatar"><img src="${ctx}/img/avatar-03.jpg"
					alt=""></span>
				<div class="info">
					<strong>공차는날</strong>
					<p class="meta">서울 은평구 · 초중급</p>
					<div class="hover-card">
						<div class="top">
							<span class="avatar md"><img
								src="${ctx}/img/avatar-03.jpg" alt=""></span>
							<div>
								<strong>공차는날</strong>
								<p>서울 은평구 · 초중급</p>
								<p class="rating">4.8 · 18개 평가</p>
							</div>
						</div>
						<dl>
							<dt>주 활동 지역</dt>
							<dd>서울 은평구</dd>
							<dt>선호 시간</dt>
							<dd>평일 저녁</dd>
						</dl>
					</div>
				</div>
				<div class="dropdown">
					<button type="button" class="icon-btn" data-dropdown-toggle
						aria-label="팀원 메뉴">⋮</button>
					<div class="dropdown-menu">
						<button type="button" data-member-name="공차는날"
							data-modal-open="viceModal">부팀장으로 지정</button>
						<hr>
						<button type="button" class="danger" data-member-name="공차는날"
							data-modal-open="kickModal">강퇴하기</button>
					</div>
				</div>
			</div>
			<div class="member-card">
				<span class="avatar"><img src="${ctx}/img/avatar-04.jpg"
					alt=""></span>
				<div class="info">
					<strong>주말풋살러</strong>
					<p class="meta">서울 용산구 · 초급</p>
					<div class="hover-card">
						<div class="top">
							<span class="avatar md"><img
								src="${ctx}/img/avatar-04.jpg" alt=""></span>
							<div>
								<strong>주말풋살러</strong>
								<p>서울 용산구 · 초급</p>
								<p class="rating">4.8 · 18개 평가</p>
							</div>
						</div>
						<dl>
							<dt>주 활동 지역</dt>
							<dd>서울 용산구</dd>
							<dt>선호 시간</dt>
							<dd>평일 저녁</dd>
						</dl>
					</div>
				</div>
				<div class="dropdown">
					<button type="button" class="icon-btn" data-dropdown-toggle
						aria-label="팀원 메뉴">⋮</button>
					<div class="dropdown-menu">
						<button type="button" data-member-name="주말풋살러"
							data-modal-open="viceModal">부팀장으로 지정</button>
						<hr>
						<button type="button" class="danger" data-member-name="주말풋살러"
							data-modal-open="kickModal">강퇴하기</button>
					</div>
				</div>
			</div>
			<div class="member-card">
				<span class="avatar"><img src="${ctx}/img/avatar-05.jpg"
					alt=""></span>
				<div class="info">
					<strong>패스마스터</strong>
					<p class="meta">서울 영등포구 · 중급</p>
					<div class="hover-card">
						<div class="top">
							<span class="avatar md"><img
								src="${ctx}/img/avatar-05.jpg" alt=""></span>
							<div>
								<strong>패스마스터</strong>
								<p>서울 영등포구 · 중급</p>
								<p class="rating">4.8 · 18개 평가</p>
							</div>
						</div>
						<dl>
							<dt>주 활동 지역</dt>
							<dd>서울 영등포구</dd>
							<dt>선호 시간</dt>
							<dd>평일 저녁</dd>
						</dl>
					</div>
				</div>
				<div class="dropdown">
					<button type="button" class="icon-btn" data-dropdown-toggle
						aria-label="팀원 메뉴">⋮</button>
					<div class="dropdown-menu">
						<button type="button" data-member-name="패스마스터"
							data-modal-open="viceModal">부팀장으로 지정</button>
						<hr>
						<button type="button" class="danger" data-member-name="패스마스터"
							data-modal-open="kickModal">강퇴하기</button>
					</div>
				</div>
			</div>
			<div class="member-card">
				<span class="avatar"><img src="${ctx}/img/avatar-06.jpg"
					alt=""></span>
				<div class="info">
					<strong>골때리는날</strong>
					<p class="meta">서울 강서구 · 초중급</p>
					<div class="hover-card">
						<div class="top">
							<span class="avatar md"><img
								src="${ctx}/img/avatar-06.jpg" alt=""></span>
							<div>
								<strong>골때리는날</strong>
								<p>서울 강서구 · 초중급</p>
								<p class="rating">4.8 · 18개 평가</p>
							</div>
						</div>
						<dl>
							<dt>주 활동 지역</dt>
							<dd>서울 강서구</dd>
							<dt>선호 시간</dt>
							<dd>평일 저녁</dd>
						</dl>
					</div>
				</div>
				<div class="dropdown">
					<button type="button" class="icon-btn" data-dropdown-toggle
						aria-label="팀원 메뉴">⋮</button>
					<div class="dropdown-menu">
						<button type="button" data-member-name="골때리는날"
							data-modal-open="viceModal">부팀장으로 지정</button>
						<hr>
						<button type="button" class="danger" data-member-name="골때리는날"
							data-modal-open="kickModal">강퇴하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<div class="modal ${state eq 'vice' ? 'is-open' : ''}" id="viceModal"
	role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">
			<span data-fill-name>풋살초보</span> 님을 부팀장으로 지정할까요?
		</h2>
		<p class="modal-desc">부팀장은 팀장과 함께 팀 운영 권한을 갖게 됩니다. 권한은 팀원 관리에서 언제든
			해제할 수 있습니다.</p>
		<div class="modal-actions">
			<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
			<button type="button" class="btn btn-primary"
				data-toast="부팀장으로 지정했어요.">지정</button>
		</div>
	</div>
</div>
<div class="modal" id="viceRevokeModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">
			<span data-fill-name>운동하자</span> 님의 부팀장 권한을 해제할까요?
		</h2>
		<p class="modal-desc">해제하면 일반 팀원으로 변경되고 팀 관리 메뉴를 사용할 수 없습니다.</p>
		<div class="modal-actions">
			<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
			<button type="button" class="btn btn-primary"
				data-toast="부팀장 권한을 해제했어요.">해제</button>
		</div>
	</div>
</div>
<div class="modal ${state eq 'kick' ? 'is-open' : ''}" id="kickModal"
	role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">
			<span data-fill-name>공차는날</span> 님을 강퇴할까요?
		</h2>
		<p class="modal-desc">강퇴된 팀원은 팀 경기와 팀원 전용 정보에 접근할 수 없습니다. 이 작업은
			되돌릴 수 없어요.</p>
		<div class="modal-actions">
			<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
			<button type="button" class="btn btn-danger" data-toast="팀원을 강퇴했어요.">강퇴</button>
		</div>
	</div>
</div>
<c:if test="${state eq 'viceRevoked'}">
	<script>document.addEventListener('DOMContentLoaded',function(){showToast('운동하자 님의 부팀장 권한을 해제했어요.');});</script>
</c:if>
<%@ include file="/jsp/common/footer.jsp"%>
