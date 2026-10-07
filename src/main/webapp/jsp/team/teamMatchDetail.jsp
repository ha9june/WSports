<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 경기 상세 (teamMatchDetail.jsp) - 담당: 하준수
  피그마: Club Match / Detail (기본·Guest·Saved·Applied·Recruitment Closed·Admin View),
          Club Match / Cancelled · Failed · Completed Detail, Club Match / Host Manage / Matched,
          Club Match / Delete · Cancel · Apply Cancel / Modal
  ─ 하나의 JSP 로 처리 ─
   role  : guest → 신청 시 로그인 안내 / admin → 관리자 헤더 + 경기 삭제
   state : recruiting | saved | applied | applyCancel | closed | cancelled | failed | completed
           | hostRecruiting | hostDelete | hostCancel | hostMatched
  실구현 : 경기 상태 + (로그인 사용자 팀이 작성 팀인지 / 신청 팀인지) 로 서블릿에서 state 계산
--%>
<c:set var="state"
	value="${empty param.state ? 'recruiting' : param.state}" /> 
<c:set var="isHost" value="${fn:startsWith(state, 'host')}" />
<c:set var="hostRecruit"
	value="${state eq 'hostRecruiting' or state eq 'hostDelete' or state eq 'hostCancel'}" />
<c:set var="pageTitle" value="팀 경기 상세" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="teamMatch" />
<%-- <c:set var="demoStates" value="recruiting:모집중|saved:찜함|applied:신청 완료|applyCancel:신청취소 모달|closed:모집 마감|cancelled:경기 취소|failed:매칭 실패|completed:경기 종료|hostRecruiting:작성팀-모집중|hostDelete:작성팀-삭제 모달|hostCancel:작성팀-취소 모달|hostMatched:작성팀-매칭 확정" /> --%>
<%@ include file="/jsp/common/header.jsp"%>

<%-- 모집중 / 모집 마감/ 경기 종료 / 경기 취소 --%>
<c:choose>
	<c:when test="${state eq 'applied' or state eq 'applyCancel'}">
		<c:set var="pillCls" value="pill-neutral" />
		<c:set var="pillText" value="신청 완료" />
	</c:when>
	<c:when test="${state eq 'closed'}">
		<c:set var="pillCls" value="pill-neutral" />
		<c:set var="pillText" value="모집 마감" />
	</c:when>
	<c:when test="${state eq 'cancelled'}">
		<c:set var="pillCls" value="pill-neutral" />
		<c:set var="pillText" value="경기 취소" />
	</c:when>
	<c:when test="${state eq 'failed'}">
		<c:set var="pillCls" value="pill-neutral" />
		<c:set var="pillText" value="매칭 실패" />
	</c:when>
	<c:when test="${state eq 'completed'}">
		<c:set var="pillCls" value="pill-neutral" />
		<c:set var="pillText" value="경기 종료" />
	</c:when>
	<c:when test="${state eq 'hostMatched'}">
		<c:set var="pillCls" value="pill-neutral" />
		<c:set var="pillText" value="모집 마감" />
	</c:when>
	<c:otherwise>
		<c:set var="pillCls" value="pill-brand" />
		<c:set var="pillText" value="모집중" />
	</c:otherwise>
</c:choose>
<c:set var="opponent"
	value="${state eq 'completed' ? '망원 FC' : (state eq 'hostMatched' ? '마포 FC' : '상대 팀 모집')}" />

<c:if test="${role eq 'admin'}">
	<div class="admin-post-bar">관리자(사이트) 보기 · 운영 정책에 맞지 않는 팀 경기는 삭제할
		수 있어요.</div>
</c:if>

<main class="page">
	<div class="container">
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><a
				href="${ctx}/team-match/list">상대팀 찾기</a>
		</nav>
		<section class="detail-top">
			<div class="title-row" style="margin-top: 0">
				<h1>서울 풋살 크루 vs ${opponent}</h1>
				<span class="pill pill-lg ${pillCls}">${pillText}</span>
				<c:if test="${role eq 'admin'}">
					<button type="button" class="btn btn-danger btn-sm"
						data-modal-open="adminDeleteModal">팀 경기 삭제</button>
				</c:if>
			</div>
			<p class="mt-16">
				<span class="sport-chip">축구/풋살</span>
			</p>
			<div class="host-inline">
				<span class="avatar default"></span>
				<div>
					<a href="${ctx}/jsp/member/userProfileInfo.jsp"><strong>풋살초보</strong></a><small>호스트
						· 서울 풋살 크루 주장</small>
				</div>
			</div>
		</section>

		<div class="detail-grid">
			<div class="detail-main">
				<section class="info-card">
					<h2>경기 정보</h2>
					<dl class="info-list">
						<div class="info-row">
							<dt>일시</dt>
							<dd>9/27 (일) 17:00 - 19:00</dd>
						</div>
						<div class="info-row">
							<dt>장소</dt>
							<dd>난지 풋살장</dd>
						</div>
						<div class="info-row">
							<dt>우리 팀</dt>
							<dd>
								<a href="${ctx}/jsp/team/teamDetail.jsp">서울 풋살 크루</a>
							</dd>
						</div>
						<div class="info-row">
							<dt>경기 인원</dt>
							<dd>6 vs 6</dd>
						</div>
						<div class="info-row">
							<dt>참가비</dt>
							<dd>50,000원</dd>
						</div>
						<div class="info-row">
							<dt>마감</dt>
							<dd>9/25 18:00</dd>
						</div>
						<div class="info-row">
							<dt>성별</dt>
							<dd>무관</dd>
						</div>
						<div class="info-row">
							<dt>연령</dt>
							<dd>20대 · 30대</dd>
						</div>
						<div class="info-row">
							<dt>팀 레벨</dt>
							<dd>초급 · 중급</dd>
						</div>
					</dl>
					<div class="desc">
						<h3>상세 설명</h3>
						<p>
							6 vs 6 풋살 경기입니다. 경기 시작 10분 전까지 도착해주세요.<br>팀 유니폼은 어두운 계열로
							맞춰주세요.
						</p>
					</div>
				</section>
				<section class="map-card">
					<div class="head">
						<strong>경기 위치</strong><span>서울 마포구 상암동 난지 풋살장</span>
					</div>
					<div class="map-box">
						<div class="map-pin">
							<div>
								<strong>난지 풋살장</strong><small>지도 API로 실제 위치 표시</small>
							</div>
						</div>
					</div>
				</section>
				<c:if test="${not isHost}">
					<div class="detail-actions">
						<button type="button"
							class="fav-btn sq ${state eq 'saved' ? 'is-on' : ''}" data-fav
							data-auth aria-label="관심 경기">${heart}</button>
						<a class="btn btn-outline btn-sm"
							href="${ctx}/jsp/support/reportWrite.jsp?targetType=team&targetNo=${teamMatch.teamMatchId}"
							data-auth style="height: 36px">신고</a>
					</div>
				</c:if>
			</div>

			<aside class="detail-side">
				<c:choose>
					<c:when test="${state eq 'applied' or state eq 'applyCancel'}">
						<div class="side-card">
							<h2>
								신청 완료 <span class="pill pill-info">결제 완료</span>
							</h2>
							<p class="sub">결제가 완료되어 팀 매칭 신청이 접수되었습니다.</p>
							<div class="kv">
								참가비 <b>50,000원</b>
							</div>
							<div class="kv">
								결제 금액 <b>54,000원</b>
							</div>
							<div class="actions row">
								<a class="btn btn-outline btn-sm"
									href="${ctx}/jsp/team/teamMatchParticipants.jsp">참가 팀 확인</a>
								<button type="button" class="btn btn-danger btn-sm"
									data-modal-open="applyCancelModal">신청 취소</button>
							</div>
						</div>
					</c:when>
					<c:when test="${state eq 'closed'}">
						<div class="side-card">
							<h2>상대 팀 모집이 마감되었습니다</h2>
							<p class="sub">모집 기간이 종료되어 더 이상 팀 매칭 신청을 받을 수 없어요.</p>
						</div>
					</c:when>
					<c:when test="${state eq 'cancelled'}">
						<div class="side-card">
							<span class="pill pill-danger bd">작성자 취소</span>
							<p class="status-title">경기가 취소되었습니다</p>
							<p class="sub">팀 작성자가 경기를 취소했습니다. 신청 팀에게 취소 알림이 발송됩니다.</p>
							<p class="note">결제된 참가비는 환불 규정에 따라 처리됩니다.</p>
						</div>
					</c:when>
					<c:when test="${state eq 'failed'}">
						<div class="side-card">
							<span class="pill pill-danger bd">매칭 실패</span>
							<p class="status-title">상대 팀을 구하지 못했어요</p>
							<p class="sub">모집 마감까지 신청한 팀이 없어 매칭이 종료되었습니다.</p>
						</div>
					</c:when>
					<c:when test="${state eq 'completed'}">
						<div class="side-card done">
							<h2>경기가 종료되었습니다</h2>
							<p class="sub">우리 팀과 상대 팀의 경기 매너를 팀 단위로 평가해주세요.</p>
							<div class="actions">
								<a class="btn btn-primary"
									href="${ctx}/jsp/review/reviewWrite.jsp?state=clubMatch">후기
									작성</a><a class="btn btn-primary"
									href="${ctx}/jsp/team/teamMatchResultEdit.jsp">참가 팀 평가</a>
							</div>
						</div>
					</c:when>
					<c:when test="${state eq 'hostMatched'}">
						<div class="side-card">
							<h2>내가 작성한 팀 매칭</h2>
							<p style="margin-top: 8px">
								<span class="pill pill-info">매칭 확정</span>
							</p>
							<p class="sub">상대 팀 · 마포 FC</p>
							<div class="actions">
								<a class="btn btn-primary"
									href="${ctx}/jsp/team/teamMatchResultEdit.jsp">출석 체크</a> <a
									class="btn btn-outline"
									href="${ctx}/jsp/team/teamMatchParticipants.jsp">양 팀 참가자</a> <a
									class="btn btn-outline"
									href="${ctx}/jsp/team/teamMatchEdit.jsp">경기 정보 수정</a>
							</div>
							<p class="note">수정 시 상대 팀에 알림이 전송돼요.</p>
							<button type="button" class="cancel-link" style="width: 100%"
								data-modal-open="hostCancelModal">경기 취소</button>
						</div>
					</c:when>
					<c:when test="${hostRecruit}">
						<div class="side-card">
							<h2>내가 작성한 팀 매칭</h2>
							<p style="margin-top: 8px">
								<span class="pill pill-brand">모집중</span>
							</p>
							<div class="actions">
								<a class="btn btn-outline"
									href="${ctx}/jsp/team/teamMatchEdit.jsp">경기 수정</a>
								<button type="button" class="btn btn-danger"
									data-modal-open="hostDeleteModal">경기 삭제</button>
								<button type="button" class="btn btn-danger"
									data-modal-open="hostCancelModal">경기 취소</button>
							</div>
							<div class="actions row">
								<button type="button" class="btn btn-outline btn-sm" disabled>출석
									체크</button>
								<button type="button" class="btn btn-outline btn-sm" disabled>양
									팀 참가자</button>
							</div>
							<p class="note">참가 팀이 확정되면 경기 관리 기능을 사용할 수 있습니다.</p>
						</div>
					</c:when>
					<c:otherwise>
						<div class="side-card">
							<h2>팀 매칭 신청</h2>
							<div class="field mt-16">
								<label class="field-label" for="myTeam">내 팀 선택</label>
								<%-- TODO: 내가 팀장/부팀장인 팀 목록 --%>
								<select class="select" id="myTeam" name="teamNo"><option>서울
										풋살 크루</option>
									<option>성동 농구 모임</option></select>
							</div>
							<p class="note">신청 후 모집 팀 주장이 확인합니다.</p>
							<div class="actions">
								<a class="btn btn-primary"
									href="${ctx}/jsp/payment/toss_checkout.jsp?state=teamMatch"
									data-auth>신청하기</a>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</aside>
		</div>
	</div>
</main>

<div class="modal ${state eq 'applyCancel' ? 'is-open' : ''}"
	id="applyCancelModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">팀 매칭 신청을 취소할까요?</h2>
		<p class="modal-desc">취소 시 환불 규정에 따라 참가비가 처리됩니다.</p>
		<div class="modal-actions" style="justify-content: flex-start">
			<button type="button" class="btn btn-primary" data-modal-close>닫기</button>
			<button type="button" class="btn btn-danger"
				data-toast="팀 매칭 신청을 취소했어요.">신청 취소</button>
		</div>
	</div>
</div>
<div class="modal ${state eq 'hostDelete' ? 'is-open' : ''}"
	id="hostDeleteModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">경기를 삭제할까요?</h2>
		<p class="modal-desc">삭제한 경기는 복구할 수 없습니다. 신청 팀이 없는 경우에만 삭제할 수 있고,
			신청 팀이 있으면 경기 취소를 이용해주세요.</p>
		<div class="modal-actions">
			<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
			<button type="button" class="btn btn-danger" data-toast="경기를 삭제했어요.">경기
				삭제</button>
		</div>
	</div>
</div>
<div class="modal ${state eq 'hostCancel' ? 'is-open' : ''}"
	id="hostCancelModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">경기를 취소할까요?</h2>
		<p class="modal-desc">경기 취소 시 신청 팀에게 취소 알림이 발송되고, 결제된 참가비는 환불 규정에
			따라 처리됩니다.</p>
		<div class="modal-actions">
			<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
			<button type="button" class="btn btn-danger" data-toast="경기를 취소했어요.">경기
				취소</button>
		</div>
	</div>
</div>
<c:if test="${role eq 'admin'}">
	<div class="modal" id="adminDeleteModal" role="dialog"
		aria-modal="true">
		<div class="modal-card sm">
			<h2 class="modal-title">팀 경기를 삭제할까요?</h2>
			<p class="modal-desc">삭제한 경기는 복구할 수 없습니다.</p>
			<div class="modal-actions">
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
				<button type="button" class="btn btn-danger"
					data-toast="팀 경기를 삭제했어요.">삭제</button>
			</div>
		</div>
	</div>
</c:if>
<%@ include file="/jsp/common/footer.jsp"%>
