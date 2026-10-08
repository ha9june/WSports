<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 경기 상세 (teamMatchDetail.jsp) - 담당: 하준수
  서블릿에서 넘기는 값
    t              : 경기 정보 (TeamMatch)
    isHost         : 글쓴이 여부
    applied        : 상대 팀으로 신청한 경기인지
    myTeamList     : 내가 팀장/부팀장인 팀 목록
  t.status : 모집중 | 모집 마감 | 경기 종료 | 인원 미달 경기 취소 | 작성자 경기 취소
--%>
<c:set var="status" value="${t.status}" />
<c:set var="isAdmin" value="${sessionScope.user.grade eq 'Admin'}" />
<c:set var="pageTitle" value="팀 경기 상세" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="teamMatch" />
<%@ include file="/jsp/common/header.jsp"%>
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>
<script type="text/javascript">
$(function() {
	$(".fav-btn").click(
			function(e) {
				e.stopPropagation();
				var $btn = $(this);
				$.ajax({
					url : '${ctx}/mypage/matches/saved',
					type : 'post',
					dataType : 'text',
					data : {
						matchId : $btn.data("matchId"),
						matchType : $btn.data("matchType"),
						heart : $btn.hasClass("is-on")},
					success : function(result) {
						result = result.trim();
						if (result == 'delete') {
							$btn.removeClass('is-on');
							showToast("관심경기에 제거되었습니다.");
						}else if(result == 'insert'){
							$btn.addClass('is-on');
							showToast("관심경기에 등록되었습니다.");
						}
						if (result == 'login') {
							showToast("로그인이 필요합니다.");
						}
					}
				});
			});
	
	const images = [ '${t.image1}', '${t.image2}',
		'${t.image3}', '${t.image4}',
		'${t.image5}' ];


	var hasImage = images.some(function(image) {
		return image && image !== 'null';
	});

	if (!hasImage) {
		$('#activePhoto').remove();
		return;
	}

let html = '';
let mainPhoto = '<img src="${ctx}/uploads/' + images[0]	 + '" alt="활동 사진">';

images
		.forEach(function(image, index) {
			if (image && index === 0) {
				html += '<span>'
						+ '<img class="subImg" src="${ctx}/uploads/' + image + '" alt="활동 사진" style="border: 2px solid #1677ff">'
						+ '</span>';
			} else if (image) {
				html += '<span>'
						+ '<img class="subImg" src="${ctx}/uploads/' + image + '" alt="활동 사진">'
						+ '</span>';
			}
		});

$('#mainPhoto').html(mainPhoto);

$('#thumbs').html(html);

$('#thumbs').on('click', '.subImg', function() {

	// 메인 사진 변경
	$('#mainPhoto img').attr('src', $(this).attr('src'));

	// 기존 선택 표시 제거
	$('.subImg').css('border', 'none');

	// 클릭한 사진 선택 표시
	$(this).css('border', '2px solid #1677ff');
});
});
</script>

<c:choose>
	<c:when test="${status eq '모집중'}">
		<c:set var="pillCls" value="pill-success" /><c:set var="pillText" value="모집중" />
	</c:when>
	<c:when test="${status eq '모집 마감' or status eq '경기 종료'}">
		<c:set var="pillCls" value="pill-info" /><c:set var="pillText" value="${status}" />
	</c:when>
	<c:when test="${status eq '인원 미달 경기 취소' or status eq '작성자 경기 취소'}">
		<c:set var="pillCls" value="pill-danger" /><c:set var="pillText" value="경기 취소" />
	</c:when>
	<c:otherwise>
		<c:set var="pillCls" value="pill-neutral" /><c:set var="pillText" value="${status}" />
	</c:otherwise>
</c:choose>

<c:if test="${isAdmin}">
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
			<c:choose>
				<c:when test="${t.sport eq '축구/풋살'}"><c:set var="sportCls" value="football" /></c:when>
				<c:when test="${t.sport eq '농구'}"><c:set var="sportCls" value="basketball" /></c:when>
				<c:when test="${t.sport eq '테니스'}"><c:set var="sportCls" value="tennis" /></c:when>
				<c:when test="${t.sport eq '배드민턴'}"><c:set var="sportCls" value="badminton" /></c:when>
			</c:choose>
			<span class="sport-chip ${sportCls}"><c:out value="${t.sport}" /></span>
			<div class="title-row">
				<h1>
					<c:out value="${t.title}" />
				</h1>
				<span class="pill pill-lg ${pillCls} bd">${pillText}</span>
				<c:if test="${isAdmin}">
					<button type="button" class="btn btn-danger btn-sm"
						data-modal-open="adminDeleteModal">팀 경기 삭제</button>
				</c:if>
			</div>
			<div class="host-inline">
				<span class="avatar default"></span>
				<div>
					<a href="${ctx}/jsp/member/userProfileInfo.jsp"><strong><c:out
								value="${t.hostNickname}" /></strong></a> <small>호스트 · <c:out
							value="${t.teamName}" /> ${t.hostRole eq 'VICE_CAPTAIN' ? '부주장' : '주장'}
					</small>
				</div>
			</div>
		</section>


		<div class="detail-grid">
			<div class="detail-left">
				<div class="gallery" id="activePhoto">
					<div class="main-photo" id="mainPhoto"></div>
					<div class="thumbs" id="thumbs"></div>
				</div>
				<div class="detail-main">
					<section class="info-card">
						<h2>경기 정보</h2>
						<dl class="info-list">
							<div class="info-row">
								<dt>일시</dt>
								<dd>${t.matchDate} (${t.dayOfWeekKorean}) ${t.startTime} ~
									${t.endTime}</dd>
							</div>
							<div class="info-row">
								<dt>장소</dt>
								<dd>
									<c:out value="${t.placeName}" />
								</dd>
							</div>
							<div class="info-row">
								<dt>주소</dt>
								<dd>
									<c:out value="${t.address}" />
								</dd>
							</div>
							<div class="info-row">
								<dt>모집 팀</dt>
								<dd>
									<a class="team-link" href="${ctx}/team/detail/view?teamId=${t.teamId}"><c:out value="${t.teamName}" /></a>
									<c:choose>
										<c:when test="${t.teamRating != null}">
											<span class="rating">${t.teamRating}</span>
											<span class="t-11 t-2">(${t.teamRatingCount})</span>
										</c:when>
										<c:otherwise>
											<span class="t-11 t-2">평가 없음</span>
										</c:otherwise>
									</c:choose>
								</dd>
							</div>
							<div class="info-row">
								<dt>경기 인원</dt>
								<dd>${t.matchPeople}vs ${t.matchPeople}</dd>
							</div>
							<div class="info-row">
								<dt>참가비</dt>
								<dd>
									<fmt:formatNumber value="${t.participationFee}" />
									원
								</dd>
							</div>
							<div class="info-row">
								<dt>마감</dt>
								<dd>${fn:replace(t.deadline, 'T', ' ')}</dd>
							</div>
							<div class="info-row">
								<dt>성별</dt>
								<dd>
									<c:out value="${t.gender}" />
								</dd>
							</div>
							<div class="info-row">
								<dt>연령</dt>
								<dd>${ages }</dd>
							</div>
							<div class="info-row">
								<dt>팀 레벨</dt>
								<dd>${skills }</dd>
							</div>
						</dl>
						<div class="desc">
							<h3>상세 설명</h3>
							<p style="white-space: pre-line">
								<c:out value="${t.content}" />
							</p>
						</div>
					</section>

					<section class="map-card">
						<div class="head">
							<strong>경기 위치</strong><span><c:out value="${t.address}" /></span>
						</div>
						<div id="map" style="width: 100%; height: 300px;"></div>
					</section>

					<div class="detail-actions">
						<button type="button"
							class="fav-btn sq ${t.favorite ? 'is-on' : ''}" data-fav
							data-auth aria-label="관심 경기" data-match-type="Team"
							data-match-id="${t.teamMatchId}">${heart}</button>
						<a class="btn btn-outline btn-sm"
							href="${ctx}/jsp/support/reportWrite.jsp?targetType=team&targetNo=${t.teamMatchId}"
							data-auth style="height: 36px">신고</a>
					</div>
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
									<p style="margin-top: 8px">
										<span class="pill pill-success">모집중</span>
									</p>
									<div class="actions">
										<a class="btn btn-outline"
											href="${ctx}/team-match/edit?teamMatchId=${t.teamMatchId}">경기
											수정</a>
										<button type="button" class="btn btn-danger"
											data-modal-open="hostCancelModal">경기 취소</button>
									</div>
									<div class="actions row">
										<button type="button" class="btn btn-outline btn-sm" disabled>출석
											체크</button>
										<button type="button" class="btn btn-outline btn-sm" disabled>양
											팀 참가자</button>
									</div>
									<p class="note">상대 팀이 신청하기 전까지는 취소하면 전액 환불돼요. 상대 팀이 확정되면 경기
										관리 기능을 사용할 수 있어요.</p>
								</div>
							</c:when>
							<c:when test="${isMyTeamList}">
								<div class="side-card">
									<h2>팀 매칭 신청</h2>
									<div class="field mt-16">
										<label class="field-label" for="myTeam">내 ${t.sport} 팀 선택</label>
										<%-- TODO: 내가 팀장/부팀장인 팀 목록 (서블릿에서 myTeamList로 전달) --%>
										<select class="select" id="myTeam" name="teamNo">
											<c:forEach var="mt" items="${myTeamList}">
												<option value="${mt.teamId}"><c:out
														value="${mt.teamName}" /></option>
											</c:forEach>
										</select>
									</div>
									<p class="note">결제하면 바로 확정돼요. 확정 후에는 취소와 환불이 어려워요.</p>
									<div class="actions">
										<a class="btn btn-primary" id="payBtn"
										   href="${ctx}/payment/confirm?state=teamMatch&matchId=${t.teamMatchId}"
										   data-auth>결제하기</a>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="side-card">
									<c:choose>
										<%-- 비로그인 --%>
										<c:when test="${empty sessionScope.user}">
											<h2>팀 매칭 신청</h2>
											<p class="sub">로그인 후 팀장 또는 부팀장 계정으로 신청할 수 있어요.</p>
											<div class="actions">
												<a class="btn btn-primary" href="${ctx}/auth/login" data-auth>로그인</a>
											</div>
										</c:when>
										<%-- 로그인했지만 팀장/부팀장이 아님 --%>
										<c:otherwise>
											<h2>팀 매칭 신청</h2>
											<p class="sub">팀 경기는 <b>팀장 또는 부팀장</b>만 신청할 수 있어요.</p>
											<p class="note">팀원이라면 팀장이나 부팀장에게 이 경기를 공유해 신청을 요청해 보세요. 팀이 없다면 팀을 만들거나 가입한 뒤 신청할 수 있어요.</p>
											<div class="actions row">
												<a class="btn btn-outline btn-sm" href="${ctx}/team/list">팀 찾기</a>
												<a class="btn btn-outline btn-sm" href="${ctx}/team/create">팀 만들기</a>
											</div>
										</c:otherwise>
									</c:choose>
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
									<p style="margin-top: 8px">
										<span class="pill pill-info">모집 마감</span>
									</p>
									<div class="actions">
										<a class="btn btn-primary"
											href="${ctx}/team-match/result?teamMatchId=${t.teamMatchId}">출석
											체크</a> <a class="btn btn-outline"
											href="${ctx}/team-match/participants?teamMatchId=${t.teamMatchId}">양
											팀 참가자</a> <a class="btn btn-outline"
											href="${ctx}/team-match/edit?teamMatchId=${t.teamMatchId}">경기
											정보 수정</a>
									</div>
									<p class="note">수정 시 상대 팀에 알림이 전송돼요. 상대 팀이 확정되어 취소와 환불은
										불가해요.</p>
								</div>
							</c:when>
							<c:when test="${applied}">
								<div class="side-card">
									<h2>
										신청 완료 <span class="pill pill-info">결제 완료</span>
									</h2>
									<p class="sub">결제가 완료되어 팀 매칭 신청이 접수되었습니다.</p>
									<div class="kv">
										참가비 <b><fmt:formatNumber value="${t.participationFee}" />원</b>
									</div>
									<div class="kv">
										결제 금액 <b><fmt:formatNumber
												value="${t.participationFee + t.fee}" />원</b>
									</div>
									<div class="actions row">
										<a class="btn btn-outline btn-sm"
											href="${ctx}/team-match/participants?teamMatchId=${t.teamMatchId}">참가
											팀 확인</a>
										<p class="note">경기가 확정되어 취소와 환불이 불가해요.</p>
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
									<a class="btn btn-primary"
										href="${ctx}/jsp/review/reviewWrite.jsp?state=clubMatch">후기
										작성</a> <a class="btn btn-primary"
										href="${ctx}/jsp/team/teamMatchResultEdit.jsp">참가 팀 평가</a>
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
							<c:if test="${isHost}">
								<p class="note">결제하신 금액은 전액 환불돼요.</p>
							</c:if>
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

<%-- 작성자 경기 취소 (모집중) --%>
<div class="modal" id="hostCancelModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">경기를 취소할까요?</h2>
		<p class="modal-desc">상대 팀이 확정되기 전이라 결제하신 금액이 전액 환불돼요.</p>
		<form action="${ctx}/team-match/cancel" method="post"
			class="modal-actions">
			<input type="hidden" name="teamMatchId" value="${t.teamMatchId}">
			<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
			<button type="submit" class="btn btn-danger">경기 취소</button>
		</form>
	</div>
</div>

<%-- 관리자 삭제 --%>
<c:if test="${isAdmin}">
	<div class="modal" id="adminDeleteModal" role="dialog"
		aria-modal="true">
		<div class="modal-card sm">
			<h2 class="modal-title">팀 경기를 삭제할까요?</h2>
			<p class="modal-desc">삭제한 경기는 복구할 수 없습니다.</p>
			<form action="${ctx}/admin/team-match/delete" method="post"
				class="modal-actions">
				<input type="hidden" name="teamMatchId" value="${t.teamMatchId}">
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
				<button type="submit" class="btn btn-danger">삭제</button>
			</form>
		</div>
	</div>
</c:if>
<%@ include file="/jsp/common/footer.jsp"%>
<script>
var mapContainer = document.getElementById('map');
var mapOption = {
    center: new kakao.maps.LatLng(${t.latitude}, ${t.longitude}),
    level: 5
};
var map = new kakao.maps.Map(mapContainer, mapOption);
var markerPosition = new kakao.maps.LatLng(${t.latitude}, ${t.longitude});
var marker = new kakao.maps.Marker({ position: markerPosition });
marker.setMap(map);

// 레이아웃 변경 후 지도 크기 다시 계산
function fixMap() {
    map.relayout();
    map.setCenter(markerPosition);
}
window.addEventListener('load', fixMap);
window.addEventListener('resize', fixMap);

// 컨테이너 크기가 바뀔 때마다 자동으로 보정
if (window.ResizeObserver) {
    new ResizeObserver(fixMap).observe(mapContainer);
}

(function () {
	var payBtn = document.getElementById('payBtn');
	var myTeam = document.getElementById('myTeam');
	if (!payBtn || !myTeam) return;

	var baseHref = payBtn.getAttribute('href');

	function syncHref() {
		payBtn.setAttribute('href', baseHref + '&teamId=' + encodeURIComponent(myTeam.value));
	}
	syncHref();                              // 처음 선택된 팀도 반영
	myTeam.addEventListener('change', syncHref);
})();
</script>