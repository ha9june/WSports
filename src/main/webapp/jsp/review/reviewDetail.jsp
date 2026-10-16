<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--
후기 상세 (reviewDetail.jsp) - 담당: 강신우
피그마: Review / Detail / Desktop (+ 댓글)
role : guest → 좋아요/댓글/신고 시 로그인 안내 | admin → 후기 삭제 버튼
state : default(다른 사람 후기) | mine(내가 쓴 후기 - 수정/삭제)
--%>
<c:set var="state"
	value="${sessionScope.user.userId eq review.userId ? 'mine' : 'default'}" />
<c:set var="isAdmin" value="${sessionScope.user.grade eq 'Admin'}" />
<c:set var="pageTitle" value="후기 상세" />
<c:set var="pageCss" value="review,match" />
<c:set var="activeNav" value="review" />
<%@ include file="/jsp/common/header.jsp"%>
<style>
.cmt-title {
	display: flex !important;
	align-items: center;
	gap: 6px;
	margin: 0 0 12px !important;
	font-size: 18px;
	font-weight: 700;
	color: #111827;
}

.cmt-count {
	color: #1a6bff;
}

.cmt-list {
	display: flex !important;
	flex-direction: column;
	gap: 8px;
	margin: 0 !important;
	padding: 0 !important;
}

.cmt-item {
	position: relative;
	display: flex !important;
	align-items: flex-start;
	gap: 12px;
	padding: 14px 16px !important;
	border: 1px solid #eef0f3 !important;
	border-radius: 14px !important;
	background: #fff;
}

.cmt-item:hover {
	background: #f9fafb;
}

.cmt-avatar {
	flex-shrink: 0;
	width: 40px !important;
	height: 40px !important;
	border-radius: 50% !important;
	object-fit: cover;
	display: block;
}

.cmt-avatar-default {
	background: #dcf5e7;
}

.cmt-body {
	flex: 1;
	min-width: 0;
	padding-right: 130px; /* 날짜+삭제 자리 */
}

.cmt-name {
	display: flex !important;
	align-items: center;
	gap: 6px;
	line-height: 1.3;
}

.cmt-nick {
	font-size: 14px;
	font-weight: 700;
	color: #111827;
}

.cmt-writer {
	padding: 1px 7px;
	border-radius: 999px;
	background: #e8f0ff;
	font-size: 11px;
	font-weight: 700;
	color: #1a6bff;
}

.cmt-text {
	white-space: normal;
	word-break: break-all;
}

.cmt-side {
	position: absolute;
	top: 14px;
	right: 16px;
	display: flex !important;
	align-items: center;
	gap: 8px;
	white-space: nowrap;
}

.cmt-time {
	font-size: 12px;
	color: #9ca3af;
}

/* 삭제 버튼: 후기 삭제와 같은 연핑크 스타일 */
.cmt-del {
	padding: 3px 12px !important;
	border: 0 !important;
	border-radius: 8px !important;
	background: #fdecec !important;
	font-size: 12px;
	font-weight: 600;
	color: #e5484d !important;
	cursor: pointer;
	transition: background .15s;
}

.cmt-del:hover {
	background: #fbd5d5 !important;
}

.cmt-empty {
	margin: 0 !important;
	padding: 28px 0;
	text-align: center;
	font-size: 14px;
	color: #9ca3af;
	background: #f9fafb;
	border-radius: 14px;
}

.cmt-form {
	display: flex;
	gap: 8px;
	margin-top: 16px;
}

.cmt-input {
	flex: 1;
	min-width: 0;
	height: 46px;
	padding: 0 16px;
	border: 1px solid #e5e7eb;
	border-radius: 12px;
	background: #f9fafb;
	font-size: 14px;
	box-sizing: border-box;
}

.cmt-input:focus {
	outline: 0;
	border-color: #1a6bff;
	background: #fff;
	box-shadow: 0 0 0 3px rgba(26, 107, 255, 0.12);
}

.cmt-submit {
	height: 46px;
	padding: 0 24px;
	border: 0;
	border-radius: 12px;
	background: #1a6bff;
	font-size: 14px;
	font-weight: 700;
	color: #fff;
	cursor: pointer;
}

.cmt-submit:hover {
	background: #1558d6;
}
/* 본문 박스 내부의 상단 여백을 대폭 줄임 */
.review-detail {
	padding-top: 10px !important; /* 기존 여백을 무시하고 10px로 밀착 (원하는 만큼 조절 가능) */
}

/* 혹시 본문 p 태그 자체에 위쪽 마진이 들어가 있을 경우를 방지 */
.review-detail p.text {
	margin-top: 0px !important;
	padding-top: 0px !important;
}
/* 2. 이미지를 감싸는 부모 박스 (.photos) 공백 조절 및 3정렬 정렬 */
.review-detail .photos {
	margin-top: 8px !important;
	padding-top: 0 !important;
	display: grid !important;
	grid-template-columns: repeat(6, 1fr);
	gap: 8px !important;
}

.review-detail .photos img {
	width: 100% !important;
	height: 100% !important;
	min-height: 0;
	object-fit: cover !important;
	border-radius: 8px;
	display: block;
	aspect-ratio: 4/3;
	grid-column: span 2; /* 기본: 한 줄에 3개 */
}
/* 1장: 크게 한 장 */
.review-detail .photos img:only-child {
	grid-column: span 6;
	aspect-ratio: 16/10;
}

.review-detail .photos img:first-child:nth-last-child(2), .review-detail .photos img:first-child:nth-last-child(2) 
	 ~ img {
	grid-column: span 3;
	aspect-ratio: 1/1;
}
/* 3장: 큰 1장(위) + 작은 2장(아래) */
.review-detail .photos img:first-child:nth-last-child(3) {
	grid-column: span 6;
	aspect-ratio: 16/9;
}
/* 4장: 큰 1장(위) + 작은 3장(아래) */
.review-detail .photos img:first-child:nth-last-child(4) {
	grid-column: span 6;
	aspect-ratio: 16/9;
}

.review-detail .photos img:first-child:nth-last-child(4) ~ img {
	grid-column: span 2;
	aspect-ratio: 1/1;
}

/* 5장: 위 2장(반반) + 아래 3장(3등분) */
.review-detail .photos img:first-child:nth-last-child(5), .review-detail .photos img:first-child:nth-last-child(5)+img
	{
	grid-column: span 3;
	aspect-ratio: 4/3;
}

.review-detail .photos img:first-child:nth-last-child(5) ~ img:nth-child(n+3)
	{
	grid-column: span 2;
	aspect-ratio: 1/1;
}

.review-detail .photos img:first-child:nth-last-child(3) ~ img {
	grid-column: span 3;
	aspect-ratio: 4/3;
}

.host-inline a, .host-inline a strong {
	color: #111827 !important;
}

.host-inline a:hover strong {
	text-decoration: underline;
}
.cmt-name a:hover strong{
	text-decoration: underline;
}
</style>
<main class="page">
	<div class="rail">
		<nav class="breadcrumb">
			<a href="${ctx}/review/list">후기</a><span class="sep">›</span><span>상세</span>
		</nav>

		<div class="detail-top" style="margin-bottom: 16px">
			<p style="margin: 0 0 8px">
				<span class="sport-chip" style="height: 26px"><c:out
						value="${review.sport}" /></span>
			</p>
			<div class="title-row" style="margin-top: 0">
				<h1>
					<c:out value="${review.title}" />
				</h1>
				<c:if test="${isAdmin}">
					<button type="button" class="btn btn-danger btn-sm"
						data-modal-open="deleteModal">후기 삭제</button>
				</c:if>
			</div>
			<div class="host-inline">
				<p class="mt-8">
					<c:choose>
						<c:when test="${not empty review.profileImage}">
							<img class="avatar" src="${ctx}/profiles/${review.profileImage}"
								style="object-fit: cover;" alt="프로필">
						</c:when>
						<c:otherwise>
							<img class="cmt-avatar"
								src="${ctx}/profiles/<c:out value='${cm.profileImage}' />"
								alt="프로필"
								onerror="this.onerror=null;this.src='${ctx}/img/default-profile.svg';">
						</c:otherwise>
					</c:choose>
				<div>
					<a href="${ctx}/member/publicProfile/view?userId=${review.userId}"><strong>${review.nickname}</strong></a>
					<small>작성자 · ${review.createdAtStr}</small>
				</div>
			</div>
		</div>
		<section class="review-detail" style="width: 744px; max-width: 100%">
			<c:if test="${not empty review.image}">
				<div class="photos">
					<c:forEach var="img" items="${fn:split(review.image, ',')}">
						<img src="${pageContext.request.contextPath}/uploads/${img}"
							alt="경기 사진" />
					</c:forEach>
				</div>
			</c:if>
			<p class="text" style="white-space: pre-line;">
				<c:out value="${review.content}" />
			</p>
			<div class="linked">
				<span class="t-2">참여 경기</span>
				<c:choose>
					<c:when test="${review.matchType eq 'TEAM'}">
						<a
							href="${ctx}/team-match/detail/view?teamMatchId=${review.matchId}"><c:out
								value="${review.matchTitle}" /></a>
					</c:when>
					<c:otherwise>
						<a
							href="${ctx}/match/detail/view?personalMatchId=${review.matchId}"><c:out
								value="${review.matchTitle}" /></a>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="acts"
				style="display: flex; align-items: center; gap: 8px;">
				<div class="like-wrapper"
					style="display: inline-flex; align-items: center; gap: 6px;">

					<button type="button"
						class="fav-btn sq ${isFavorite ? 'is-on' : ''}" data-fav
						data-type="review" data-auth aria-label="좋아요">${heart}</button>
					<span id="likeCountDisplay" class="t-14" style="font-weight: bold;">${likeCount}</span>
				</div>

				<span class="btn btn-outline btn-sm">댓글
					${fn:length(commentList)}</span>

				<div style="margin-left: auto; display: flex; gap: 8px;">
					<c:choose>
						<c:when test="${state eq 'mine'}">
							<a class="btn btn-outline btn-sm"
								href="${ctx}/review/edit?reviewId=${review.reviewId}">수정</a>
							<button type="button" class="btn btn-danger-soft btn-sm"
								data-modal-open="deleteModal">삭제</button>
						</c:when>
						<c:otherwise>
							<a class="btn btn-outline btn-sm"
								href="${ctx}/support/report/create?targetType=review&targetNo=${review.reviewId}"
								data-auth>신고</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<section style="width: 744px; max-width: 100%" class="mt-48">
				<h2 class="cmt-title">
					댓글 <span class="cmt-count">${fn:length(commentList)}</span>
				</h2>

				<div class="cmt-list">
					<c:forEach var="cm" items="${commentList}">
						<div class="cmt-item">
							<c:choose>
								<c:when test="${not empty cm.profileImage}">
									<img class="cmt-avatar"
										src="${ctx}/profiles/${cm.profileImage}" alt="프로필">
								</c:when>
								<c:otherwise>
									<img class="cmt-avatar"
										src="${ctx}/profiles/<c:out value='${cm.profileImage}' />"
										alt="프로필"
										onerror="this.onerror=null;this.src='${ctx}/img/default-profile.svg';">
								</c:otherwise>
							</c:choose>

							<div class="cmt-body">
								<div class="cmt-name">
									<b class="cmt-nick"> <a href="${ctx}/member/publicProfile/view?userId=${cm.userId}">
									<strong>${cm.nickname}</strong>
									</a>
									</b> 
									<c:if test="${review.userId eq cm.userId}">
										<span class="cmt-writer">작성자</span>
									</c:if>
								</div>
								<p class="cmt-text">
									<c:out value="${cm.content}" />
								</p>
							</div>

							<div class="cmt-side">
								<span class="cmt-time">${cm.createdAtStr}</span>
								<c:if test="${sessionScope.user.userId eq cm.userId}">
									<button type="button" class="cmt-del btn-del-comment"
										data-comment-id="${cm.commentId}">삭제</button>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>

				<c:if test="${empty commentList}">
					<p class="cmt-empty">아직 댓글이 없어요. 첫 댓글을 남겨보세요.</p>
				</c:if>

				<form class="cmt-form" method="post" action="${ctx}/review/comment">
					<input type="hidden" name="reviewId" value="${review.reviewId}">
					<input class="cmt-input" name="content" autocomplete="off"
						placeholder="${empty sessionScope.user ? '로그인 후 댓글을 남길 수 있어요.' : '댓글을 입력하세요.'}"
						${empty sessionScope.user ? 'readonly data-auth' : 'required'}>
					<button type="submit" class="cmt-submit" data-auth>등록</button>
				</form>
			</section>
		</section>
	</div>
</main>

<div class="modal" id="deleteModal" role="dialog" aria-modal="true">
	<div class="modal-card sm">
		<h2 class="modal-title">후기를 삭제할까요?</h2>
		<p class="modal-desc">삭제한 후기와 댓글은 복구할 수 없어요.</p>
		<form id="deleteReviewForm" class="modal-actions">
			<input type="hidden" id="reviewId" name="reviewId"
				value="${review.reviewId}">
			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
			<button type="button" class="btn btn-danger" id="confirmReviewDelete">삭제</button>
		</form>
	</div>
</div>

<script>
	$(function() {
		$("#confirmReviewDelete").on("click",function() {
					var isAdmin = ${isAdmin};
					var url = isAdmin ? '${ctx}/admin/content/review-delete': '${ctx}/mypage/reviews';
					var data = isAdmin ? {reviewId : $("#reviewId").val()} : {action : 'delete',reviewId : $("#reviewId").val()};
					$.post(url, data, function(result) {
						result = result.trim();
						if (result === 'true' || result === 'ok') {
							location.href = '${ctx}/review/list';
						} else {
							showToast("삭제에 실패했습니다.");
						}
					}, 'text');
				});
		$(".review-detail .fav-btn").off("click").click(function(e) {
			e.preventDefault();
			e.stopPropagation();

			var $btn = $(this);
			var isCurrentlyOn = $btn.hasClass("is-on");

			$.ajax({
				url : '${ctx}/review/detail',
				type : 'post',
				dataType : 'text',
				data : {
					reviewId : "${review.reviewId}",
					heart : !isCurrentlyOn
				},
				success : function(result) {
					result = result.trim();

					var $countSpan = $("#likeCountDisplay");
					var currentCount = parseInt($countSpan.text()) || 0;

					if (result === 'insert') {
						$btn.addClass("is-on");
						showToast("게시글에 좋아요를 눌렀어요.");
						$countSpan.text(currentCount + 1);
					} else if (result === 'delete') {
						$btn.removeClass("is-on");
						showToast("게시글에 좋아요를 취소했어요.");
						$countSpan.text(Math.max(0, currentCount - 1));
					} else if (result === 'login') {
						showToast("로그인이 필요합니다.");
					} else {
						showToast("처리에 실패했습니다.");
					}
				},
				error : function() {
					showToast("서버 통신 중 오류가 발생했습니다.");
				}
			});
		});
	});
	$(document).on("click", ".btn-del-comment", function() {
		if (!confirm("댓글을 삭제할까요?"))
			return;
		$.post('${ctx}/review/comment/delete', {
			commentId : $(this).data("comment-id")
		}, function(result) {
			if (result.trim() === 'ok')
				location.reload();
			else if (result.trim() === 'login')
				showToast("로그인이 필요합니다.");
			else
				showToast("삭제에 실패했습니다.");
		}, 'text');
	});
</script>
<%@ include file="/jsp/common/footer.jsp"%>