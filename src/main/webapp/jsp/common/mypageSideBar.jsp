<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Map, dto.User, service.member.MemberService, service.member.MemberServiceImpl" %>
<%
  // 사이드바 상단 뱃지용 내 평점 (로그인 정보가 없으면 건너뜀)
  User sideUser = (User) session.getAttribute("user");
  if (sideUser != null) {
    Map<String, Object> sideMe = new MemberServiceImpl().publicProfile(sideUser.getUserId());
    if (sideMe != null) {
      pageContext.setAttribute("myScore", sideMe.get("score"));
    }
  }
%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%--
  마이페이지 사이드바 (워크스페이스 시작 태그 포함)
   - sideMenu : user | profile | personalMatch | createdMatch | heartMatch | myTeam | teamMatch
                | review | alarm | support | personalSettlement | teamSettlement | payment
  ※ 이 파일은 <div class="workspace"> ... <main class="work"> 를 열어둡니다.
     페이지 본문 마지막에서 </main></div> 로 닫아주세요.
--%>
<style>
.side .menu a .side-badge {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 22px;
	height: 22px;
	min-width: 22px;
	padding: 0;
	margin-left: 6px;
	box-sizing: border-box;
	border-radius: 50%;
	background: #2563eb;
	color: #fff;
	font-size: 11px;
	font-weight: 700;
	line-height: 1;
	letter-spacing: -0.3px;
	vertical-align: middle;
}
</style>
<div class="workspace">
	<aside class="side" aria-label="마이페이지 메뉴">
		<a class="me" href="${ctx}/member/publicProfile/view?userId=${sessionScope.user.userId}">
			<span class="avatar sm">
				<c:choose>
					<c:when test="${not empty sessionScope.user.profileImage}">
						<img src="${ctx}/profiles/<c:out value='${sessionScope.user.profileImage}' />"
							alt="프로필 사진"
							onerror="this.onerror=null;this.src='${ctx}/img/default-profile.svg';"
							style="width:100%;height:100%;border-radius:50%;object-fit:cover;display:block;">
					</c:when>
					<c:otherwise>
						<img src="${ctx}/img/default-profile.svg" alt="프로필 사진"
							style="width:100%;height:100%;border-radius:50%;object-fit:cover;display:block;">
					</c:otherwise>
				</c:choose>
			</span>
			<span>
				<strong><c:out value="${sessionScope.user.nickname}" /></strong>
				<small>내 평점 ★ <c:out value="${empty myScore ? '-' : myScore}" /></small>
			</span>
		</a>

		<div class="group">
			<p class="group-title">계정</p>
			<nav class="menu">
				<a href="${ctx}/member/mypage/view"
					class="${sideMenu eq 'user' ? 'is-active' : ''}">내 정보</a>
				<a href="${ctx}/member/profile/view"
					class="${sideMenu eq 'profile' ? 'is-active' : ''}">내 프로필</a>
			</nav>
		</div>
		<div class="group">
			<p class="group-title">경기</p>
			<nav class="menu">
				<a href="${ctx}/mypage/matches/participating"
					class="${sideMenu eq 'personalMatch' ? 'is-active' : ''}">참가 경기</a>
				<a href="${ctx}/mypage/matches/created"
					class="${sideMenu eq 'createdMatch' ? 'is-active' : ''}">내가 만든 경기</a>
				<a href="${ctx}/mypage/matches/saved"
					class="${sideMenu eq 'heartMatch' ? 'is-active' : ''}">관심경기</a>
			</nav>
		</div>
		<div class="group">
			<p class="group-title">팀</p>
			<nav class="menu">
				<a href="${ctx}/mypage/clubs"
					class="${sideMenu eq 'myTeam' ? 'is-active' : ''}">내 팀</a>
				<a href="${ctx}/mypage/team-matches"
					class="${sideMenu eq 'teamMatch' ? 'is-active' : ''}">팀 경기</a>
			</nav>
		</div>
		<div class="group">
			<p class="group-title">기타</p>
			<nav class="menu">
				<a href="${ctx}/mypage/reviews"
					class="${sideMenu eq 'review' ? 'is-active' : ''}">내 후기</a>
				<a href="${ctx}/mypage/notifications"
					class="${sideMenu eq 'alarm' ? 'is-active' : ''}">알림
					<span id="sideAlarmBadge" class="side-badge" style="display: none;">0</span>
				</a>
				<a href="${ctx}/support/report/list"
					class="${sideMenu eq 'support' ? 'is-active' : ''}">신고・문의사항</a>
			</nav>
		</div>
		<div class="group">
			<p class="group-title">정산・결제</p>
			<nav class="menu">
				<a href="${ctx}/settlement/personal/list"
					class="${sideMenu eq 'personalSettlement' ? 'is-active' : ''}">개인 경기 정산</a>
				<a href="${ctx}/settlement/team/list"
					class="${sideMenu eq 'teamSettlement' ? 'is-active' : ''}">팀 경기 정산</a>
				<a href="${ctx}/payment/history/list"
					class="${sideMenu eq 'payment' ? 'is-active' : ''}">결제 내역</a>
			</nav>
		</div>

		<div class="bottom">
			<a href="${ctx}/auth/logout/submit">로그아웃</a>
		</div>
	</aside>
	<main class="work">