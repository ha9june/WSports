<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  내 팀 (myPageMyTeam.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Clubs, MyPage / Activity / Club Applications,
          Overlay / My Club Card Menu (Member · Manager), Club / Leave Confirm / Modal
  ─ 하나의 JSP 로 처리 ─
   state : joined(가입한 팀) | applications(가입 신청 현황) | leave(탈퇴 확인 모달)
   카드 ⋮ 메뉴는 팀 내 역할(팀원 / 팀장·부팀장)에 따라 '팀 관리' 항목이 추가됩니다.
--%>
<c:set var="state" value="${empty param.state ? 'joined' : param.state}" />
<c:set var="pageTitle" value="내 팀" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="myTeam" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates"
	value="joined:가입한 팀|applications:가입 신청|leave:탈퇴 모달" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<div class="work-inner" style="width: 100%; max-width: 1000px;">
	<h1 class="section-title">내 팀</h1>
	<p class="section-desc">${state eq 'applications' ? '가입 신청 현황을 확인하고 대기 중인 신청을 취소할 수 있어요.' : '가입한 팀을 확인하고 팀별 역할에 따라 관리하세요.'}</p>
	<!-- 상단 탭 버튼 영역 -->
	<div class="seg"
		style="margin-bottom: 20px; display: flex; justify-content: flex-start; gap: 12px; width: max-content; padding-left: 0 !important; margin-left: 0 !important;">
		<a class="seg-item ${state ne 'applications' ? 'is-active' : ''}"
			href="?state=joined">가입한 팀</a> <a
			class="seg-item ${state eq 'applications' ? 'is-active' : ''}"
			href="?state=applications">가입 신청</a>
	</div>
	<c:choose>
		<c:when test="${state eq 'applications'}">
			<div class="myteam-grid"
				style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; width: 100%;">
				<c:if test="${empty match}">
					<p
						style="grid-column: span 2; text-align: center; color: #9ca3af; padding: 40px 0;">신청
						중인 팀이 없습니다.</p>
				</c:if>
				<c:forEach var="m" items="${match}">
					<div class="myteam-card"
						style="display: flex; align-items: center; padding: 16px; border: 1px solid #e5e7eb; border-radius: 16px; background-color: #fff; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02); position: relative; height: 110px; box-sizing: border-box;">

						<div class="team-logo-wrap"
							style="width: 56px; height: 56px; border-radius: 50%; background-color: #e0e0ff; display: flex; align-items: center; justify-content: center; margin-left: 6px; margin-right: 20px; flex-shrink: 0;">
							<img
								src="${ctx}/img/sport-icon-${m.sport eq '축구/풋살' ? 'football' : (m.sport eq '농구' ? 'basketball' : (m.sport eq '테니스' ? 'tennis' : 'badminton'))}.png"
								alt=""
								style="width: 34px; height: 34px; object-fit: contain; display: block;">
						</div>
						<div class="main-info"
							style="flex: 1; min-width: 0; padding-right: 12px;">
							<strong
								style="display: block; font-size: 16px; font-weight: 700; color: #111827; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${m.teamName}</strong>
							<p class="meta"
								style="font-size: 13px; color: #6b7280; margin: 0 0 6px 0; font-weight: 500; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${m.sport}
								· 가입 신청</p>
							<p class="sub"
								style="display: flex; gap: 6px; margin: 0; font-size: 12px; color: #9ca3af; align-items: center; font-weight: 500; white-space: nowrap;">
								<img src="${ctx}/img/icon-calendar-14.svg" alt=""
									style="width: 12px; height: 12px; opacity: 0.4;"> <span>${m.appliedAt}</span>
							</p>
						</div>
						<div class="aside-info"
							style="display: flex; flex-direction: column; align-items: flex-end; justify-content: center; gap: 6px; flex-shrink: 0; width: 80px;">
							<span class="status-txt"
								style="font-size: 12px; color: #6b7280; font-weight: 500; margin-right: 4px; white-space: nowrap;">${m.status}</span>
							<button type="button" class="btn-cancel"
								data-id="${m.applicationId}"
								style="width: 100%; background-color: #fff; border: 1px solid #d1d5db; color: #1f2937; font-size: 12px; font-weight: 600; padding: 6px 0; text-align: center; border-radius: 8px; cursor: pointer; white-space: nowrap;">신청
								취소</button>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:when>
		<c:otherwise>
			<div class="myteam-grid"
				style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; width: 100%;">
				<!-- 마포 풋살 크루 카드 -->
				<div class="myteam-card"
					data-href="${ctx}/jsp/team/teamDetail.jsp?state=member"
					style="display: flex; align-items: center; padding: 20px; border: 1px solid #e5e7eb; border-radius: 12px; background: #fff;">
					<img src="${ctx}/img/team-football.png" alt=""
						style="width: 50px; height: 50px; margin-right: 16px;">
					<div class="main" style="flex: 1;">
						<strong
							style="display: block; font-size: 16px; margin-bottom: 4px;">마포
							풋살 크루</strong>
						<p class="meta"
							style="font-size: 13px; color: #666; margin-bottom: 6px;">풋살
							· 서울 마포</p>
						<p class="sub"
							style="display: flex; gap: 12px; margin: 0; font-size: 12px; color: #888;">
							<span
								style="display: inline-flex; align-items: center; gap: 4px;"><img
								src="${ctx}/img/icon-user-12.svg" alt=""
								style="width: 12px; height: 12px;">24명</span> <span
								style="display: inline-flex; align-items: center; gap: 4px;"><img
								src="${ctx}/img/icon-pin-12.svg" alt=""
								style="width: 12px; height: 12px;">마포구</span>
						</p>
					</div>
					<div class="aside"
						style="display: flex; flex-direction: column; align-items: flex-end; justify-content: space-between; height: 48px;">
						<span class="pill pill-neutral">팀원</span>
						<div class="dropdown">
							<button type="button" class="icon-btn" data-dropdown-toggle
								aria-label="팀 메뉴">⋮</button>
							<div class="dropdown-menu">
								<a href="${ctx}/jsp/team/teamInfoMembers.jsp">팀원 보기</a> <a
									href="${ctx}/jsp/team/teamInfoPosts.jsp">팀 작성글 보기</a>
								<hr>
								<button type="button" class="danger"
									data-modal-open="leaveModal">탈퇴하기</button>
							</div>
						</div>
					</div>
				</div>

				<!-- 성동 농구 모임 카드 -->
				<div class="myteam-card"
					data-href="${ctx}/jsp/team/teamDetail.jsp?state=manager"
					style="display: flex; align-items: center; padding: 20px; border: 1px solid #e5e7eb; border-radius: 12px; background: #fff;">
					<img src="${ctx}/img/team-basketball.png" alt=""
						style="width: 48px; height: 48px; margin-right: 16px;">
					<div class="main" style="flex: 1;">
						<strong
							style="display: block; font-size: 16px; margin-bottom: 4px;">성동
							농구 모임</strong>
						<p class="meta"
							style="font-size: 13px; color: #666; margin-bottom: 6px;">농구
							· 서울 성동</p>
						<p class="sub"
							style="display: flex; gap: 12px; margin: 0; font-size: 12px; color: #888;">
							<span
								style="display: inline-flex; align-items: center; gap: 4px;"><img
								src="${ctx}/img/icon-user-12.svg" alt=""
								style="width: 12px; height: 12px;">18명</span> <span
								style="display: inline-flex; align-items: center; gap: 4px;"><img
								src="${ctx}/img/icon-pin-12.svg" alt=""
								style="width: 12px; height: 12px;">성동구</span>
						</p>
					</div>
					<div class="aside"
						style="display: flex; flex-direction: column; align-items: flex-end; justify-content: space-between; height: 48px;">
						<span class="pill pill-neutral">부팀장</span>
						<div class="dropdown">
							<button type="button" class="icon-btn" data-dropdown-toggle
								aria-label="팀 메뉴">⋮</button>
							<div class="dropdown-menu">
								<a href="${ctx}/jsp/team/teamInfoMembers.jsp">팀원 보기</a> <a
									href="${ctx}/jsp/team/teamInfoPosts.jsp">팀 작성글 보기</a> <a
									href="${ctx}/jsp/team/teamManageApplication.jsp">팀 관리</a>
								<hr>
								<button type="button" class="danger"
									data-modal-open="leaveModal">탈퇴하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<%@ include file="/jsp/common/footer.jsp"%>