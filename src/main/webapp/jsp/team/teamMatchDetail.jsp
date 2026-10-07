<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 경기 상세 (teamMatchDetail.jsp) - 담당: 하준수
  서블릿에서 넘기는 값
    t              : 경기 정보 (TeamMatch)
    isHost         : 글쓴이 여부
    applied        : 상대 팀으로 신청한 경기인지
    canCancelApply : 신청 취소 가능(결제 후 30분 안, 마감 전)
    myTeamList     : 내가 팀장/부팀장인 팀 목록
  t.status : 모집중 | 모집 마감 | 경기 종료 | 인원 미달 경기 취소 | 작성자 경기 취소
--%>
<c:set var="status" value="${t.status}" />
<c:set var="isAdmin" value="${sessionScope.user.grade eq 'Admin'}" />
<c:set var="pageTitle" value="팀 경기 상세" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="teamMatch" />
<%@ include file="/jsp/common/header.jsp"%>

<c:choose>
	<c:when test="${status eq '모집중'}">
		<c:set var="pillCls" value="pill-success" /><c:set var="pillText" value="모집중" />
	</c:when>
	<c:when test="${status eq '모집 마감'}">
		<c:set var="pillCls" value="pill-info" /><c:set var="pillText" value="모집 마감" />
	</c:when>
	<c:when test="${status eq '경기 종료'}">
		<c:set var="pillCls" value="pill-neutral" /><c:set var="pillText" value="경기 종료" />
	</c:when>
	<c:when test="${status eq '인원 미달 경기 취소' or status eq '작성자 경기 취소'}">
		<c:set var="pillCls" value="pill-danger" /><c:set var="pillText" value="경기 취소" />
	</c:when>
</c:choose>

<c:if test="${isAdmin}">
	<div class="admin-post-bar">관리자(사이트) 보기 · 운영 정책에 맞지 않는 팀 경기는 삭제할 수 있어요.</div>
</c:if>

<main class="page">
	<div class="container">
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><a href="${ctx}/team-match/list">상대팀 찾기</a>
		</nav>

		<section class="detail-top">
			<div class="title-row" style="margin-top: 0">
				<h1><c:out value="${t.title}" /></h1>
				<span class="pill pill-lg ${pillCls}">${pillText}</span>
				<c:if test="${isAdmin}">
					<button type="button" class="btn btn-danger btn-sm" data-modal-open="adminDeleteModal">팀 경기 삭제</button>
				</c:if>
			</div>
			<p class="mt-16"><span class="sport-chip"><c:out value="${t.sport}" /></span></p>
			<div class="host-inline">
				<span class="avatar default"></span>
				<div>
					<a href="${ctx}/jsp/member/userProfileInfo.jsp"><strong><c:out value="${t.hostNickname}" /></strong></a>
					<small>호스트 · <c:out value="${t.teamName}" /> ${t.hostRole eq 'VICE_CAPTAIN' ? '부주장' : '주장'}</small>
				</div>
			</div>
		</section>

		<div class="detail-grid">
			<div class="detail-main">
				<section class="info-card">
					<h2>경기 정보</h2>
					<dl class="info-list">
						<div class="info-row"><dt>일시</dt><dd>${t.matchDate} ${t.startTime} ~ ${t.endTime} (가공 필요)</dd></div>
						<div class="info-row"><dt>장소</dt><dd><c:out value="${t.placeName}" /></dd></div>
						<div class="info-row">
							<dt>우리 팀</dt>
							<dd>
								<a href="${ctx}/team/detail/view?teamId=${t.teamId}"><c:out value="${t.teamName}" /></a>
								<c:choose>
									<c:when test="${t.teamRating != null}">
										<span class="rating">${t.teamRating}</span>
										<span class="t-11 t-2">(${t.teamRatingCount})</span>
									</c:when>
									<c:otherwise><span class="t-11 t-2">평가 없음</span></c:otherwise>
								</c:choose>
							</dd>
						</div>
						<div class="info-row"><dt>경기 인원</dt><dd>${t.matchPeople} vs ${t.matchPeople}</dd></div>
						<div class="info-row"><dt>참가비</dt><dd><fmt:formatNumber value="${t.participationFee}" />원</dd></div>
						<div class="info-row"><dt>마감</dt><dd>${t.deadline} (가공 필요)</dd></div>
						<div class="info-row"><dt>성별</dt><dd><c:out value="${t.gender}" /></dd></div>
						<div class="info-row"><dt>연령</dt><dd>${ages }</dd></div>
						<div class="info-row"><dt>팀 레벨</dt><dd>${skills }</dd></div>
					</dl>
					<div class="desc">
						<h3>상세 설명</h3>
						<p style="white-space: pre-line"><c:out value="${t.content}" /></p>
					</div>
				</section>

				<section class="map-card">
					<div class="head">
						<strong>경기 위치</strong><span><c:out value="${t.address}" /></span>
					</div>
					<div class="map-box">
						<div class="map-pin">
							<div><strong><c:out value="${t.placeName}" /></strong><small>지도 API로 실제 위치 표시</small></div>
						</div>
					</div>
				</section>

				<div class="detail-actions">
					<button type="button" class="fav-btn sq ${t.favorite ? 'is-on' : ''}"
						data-fav data-auth aria-label="관심 경기"
						data-target-type="TEAM_MATCH" data-target-id="${t.teamMatchId}">${heart}</button>
					<a class="btn btn-outline btn-sm"
						href="${ctx}/jsp/support/reportWrite.jsp?targetType=team&targetNo=${t.teamMatchId}"
						data-auth style="height: 36px">신고</a>
				</div>
			</div>

			<aside class="detail-side">
				<c:choose> 

					<%-- 모집중 --%>
					<c:when test="${status eq '모집중'}">
						<c:choose>
							<c:when test="${isHost}">
								<div class="side-card">
									<h2>내가 작성한 팀 매칭</h2>
									<p style="margin-top: 8px"><span class="pill pill-success">모집중</span></p>
									<div class="actions">
										<a class="btn btn-outline" href="${ctx}/team-match/edit?teamMatchId=${t.teamMatchId}">경기 수정</a>
										<button type="button" class="btn btn-danger" data-modal-open="hostCancelModal">경기 취소</button>
									</div>
									<div class="actions row">
										<button type="button" class="btn btn-outline btn-sm" disabled>출석 체크</button>
										<button type="button" class="btn btn-outline btn-sm" disabled>양 팀 참가자</button>
									</div>
									<p class="note">상대 팀이 신청하기 전까지는 취소하면 전액 환불돼요. 상대 팀이 확정되면 경기 관리 기능을 사용할 수 있어요.</p>
								</div>
							</c:when>
							<c:otherwise>
								<div class="side-card">
									<h2>팀 매칭 신청</h2>
									<div class="field mt-16">
										<label class="field-label" for="myTeam">내 팀 선택</label>
										<%-- TODO: 내가 팀장/부팀장인 팀 목록 (서블릿에서 myTeamList로 전달) --%>
										<select class="select" id="myTeam" name="teamNo">
											<c:forEach var="mt" items="${myTeamList}">
												<option value="${mt.teamId}"><c:out value="${mt.teamName}" /></option>
											</c:forEach>
										</select>
									</div>
									<p class="note">결제하면 바로 확정돼요. 결제 후 30분 안에는 취소할 수 있고, 이후에는 취소와 환불이 어려워요.</p>
									<div class="actions">
										<a class="btn btn-primary" href="${ctx}/payment/team-match?teamMatchId=${t.teamMatchId}" data-auth>신청하기</a>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:when>

					<%-- 모집 마감 --%>
					<c:when test="${status eq '모집 마감'}">
						<c:choose>
							<c:when test="${isHost}">
								<div class="side-card">
									<h2>내가 작성한 팀 매칭</h2>
									<p style="margin-top: 8px"><span class="pill pill-info">모집 마감</span></p>
									<div class="actions">
										<a class="btn btn-primary" href="${ctx}/team-match/result?teamMatchId=${t.teamMatchId}">출석 체크</a>
										<a class="btn btn-outline" href="${ctx}/team-match/participants?teamMatchId=${t.teamMatchId}">양 팀 참가자</a>
										<a class="btn btn-outline" href="${ctx}/team-match/edit?teamMatchId=${t.teamMatchId}">경기 정보 수정</a>
									</div>
									<p class="note">수정 시 상대 팀에 알림이 전송돼요. 상대 팀이 확정되어 취소와 환불은 불가해요.</p>
								</div>
							</c:when>
							<c:when test="${applied}">
								<div class="side-card">
									<h2>신청 완료 <span class="pill pill-info">결제 완료</span></h2>
									<p class="sub">결제가 완료되어 팀 매칭 신청이 접수되었습니다.</p>
									<div class="kv">참가비 <b><fmt:formatNumber value="${t.participationFee}" />원</b></div>
									<div class="kv">결제 금액 <b><fmt:formatNumber value="${t.participationFee + t.fee}" />원</b></div>
									<div class="actions row">
										<a class="btn btn-outline btn-sm" href="${ctx}/team-match/participants?teamMatchId=${t.teamMatchId}">참가 팀 확인</a>
										<c:if test="${canCancelApply}">
											<button type="button" class="btn btn-danger btn-sm" data-modal-open="applyCancelModal">신청 취소</button>
										</c:if>
									</div>
									<c:if test="${not canCancelApply}">
										<p class="note">결제 후 30분이 지나 취소와 환불이 불가해요.</p>
									</c:if>
								</div>
							</c:when>
							<c:otherwise>
								<div class="side-card">
									<h2>상대 팀 모집이 마감되었습니다</h2>
									<p class="sub">상대 팀이 확정되어 더 이상 팀 매칭 신청을 받을 수 없어요.</p>
								</div>
							</c:otherwise>
						</c:choose>
					</c:when>

					<%-- 경기 종료 --%>
					<c:when test="${status eq '경기 종료'}">
						<div class="side-card done">
							<h2>경기가 종료되었습니다</h2>
							<c:if test="${isHost or applied}">
								<p class="sub">우리 팀과 상대 팀의 경기 매너를 팀 단위로 평가해주세요.</p>
								<div class="actions">
									<a class="btn btn-primary" href="${ctx}/jsp/review/reviewWrite.jsp?state=clubMatch">후기 작성</a>
									<a class="btn btn-primary" href="${ctx}/jsp/team/teamMatchResultEdit.jsp">참가 팀 평가</a>
								</div>
							</c:if>
						</div>
					</c:when>

					<%-- 인원 미달 취소 --%>
					<c:when test="${status eq '인원 미달 경기 취소'}">
						<div class="side-card">
							<span class="pill pill-danger bd">매칭 실패</span>
							<p class="status-title">상대 팀을 구하지 못했어요</p>
							<p class="sub">모집 마감까지 신청한 팀이 없어 경기가 자동 취소되었습니다.</p>
							<c:if test="${isHost}"><p class="note">결제하신 금액은 전액 환불돼요.</p></c:if>
						</div>
					</c:when>

					<%-- 작성자 취소 --%>
					<c:when test="${status eq '작성자 경기 취소'}">
						<div class="side-card">
							<span class="pill pill-danger bd">작성자 취소</span>
							<p class="status-title">경기가 취소되었습니다</p>
							<p class="sub">팀 작성자가 경기를 취소했습니다.</p>
						</div>
					</c:when>

				</c:choose>
			</aside>
		</div>
	</div>
</main>

<%-- 상대 팀 신청 취소 --%>
<div class="modal" id="applyCancelModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">팀 매칭 신청을 취소할까요?</h2>
		<p class="modal-desc">결제 후 30분 안이라 전액 환불돼요.</p>
		<form action="${ctx}/team-match/apply/cancel" method="post" class="modal-actions" style="justify-content: flex-start">
			<input type="hidden" name="teamMatchId" value="${t.teamMatchId}">
			<button type="button" class="btn btn-primary" data-modal-close>닫기</button>
			<button type="submit" class="btn btn-danger">신청 취소</button>
		</form>
	</div>
</div>

<%-- 작성자 경기 취소 (모집중) --%>
<div class="modal" id="hostCancelModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">경기를 취소할까요?</h2>
		<p class="modal-desc">상대 팀이 확정되기 전이라 결제하신 금액이 전액 환불돼요.</p>
		<form action="${ctx}/team-match/cancel" method="post" class="modal-actions">
			<input type="hidden" name="teamMatchId" value="${t.teamMatchId}">
			<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
			<button type="submit" class="btn btn-danger">경기 취소</button>
		</form>
	</div>
</div>

<%-- 관리자 삭제 --%>
<c:if test="${isAdmin}">
	<div class="modal" id="adminDeleteModal" role="dialog" aria-modal="true">
		<div class="modal-card sm">
			<h2 class="modal-title">팀 경기를 삭제할까요?</h2>
			<p class="modal-desc">삭제한 경기는 복구할 수 없습니다.</p>
			<form action="${ctx}/admin/team-match/delete" method="post" class="modal-actions">
				<input type="hidden" name="teamMatchId" value="${t.teamMatchId}">
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
				<button type="submit" class="btn btn-danger">삭제</button>
			</form>
		</div>
	</div>
</c:if>
<%@ include file="/jsp/common/footer.jsp"%>