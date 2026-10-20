<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--
후기 상세 (reviewDetail.jsp) - 담당: 강신우
피그마: Review / Detail / Desktop (+ 댓글)
role : guest → 좋아요/댓글/신고 시 로그인 안내 | admin → 후기 삭제 버튼, 댓글 삭제 버튼
state : default(다른 사람 후기) | mine(내가 쓴 후기 - 수정/삭제)
--%>
<c:set var="state"
	value="${sessionScope.user.userId eq review.userId ? 'mine' : 'default'}" />
<c:set var="isAdmin" value="${sessionScope.user.grade eq 'Admin'}" />
<c:set var="pageTitle" value="후기 상세" />
<c:set var="pageCss" value="match,review" />
<c:set var="activeNav" value="review" />

<%-- 관리자 삭제(deleted=2) 댓글은 개수에서 제외 --%>
<c:set var="visibleCnt" value="0" />
<c:forEach var="cm" items="${commentList}">
	<c:if test="${cm.deleted eq 0}">
		<c:set var="visibleCnt" value="${visibleCnt + 1}" />
	</c:if>
</c:forEach>

<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container narrow-rail">
		<nav class="breadcrumb">
			<a href="${ctx}/review/list">후기</a><span class="sep">›</span><span>상세</span>
		</nav>

		<section class="detail-top review-top">
			<span class="sport-chip"><c:out value="${review.sport}" /></span>
			<div class="title-row">
				<h1>
					<c:out value="${review.title}" />
				</h1>
				<c:if test="${isAdmin}">
					<button type="button" class="btn btn-danger btn-sm"
						data-modal-open="deleteModal">후기 삭제</button>
				</c:if>
			</div>
			<div class="host-inline">
				<span class="avatar"> <c:choose>
						<c:when test="${not empty review.profileImage}">
							<img
								src="${ctx}/profiles/<c:out value='${review.profileImage}' />"
								alt=""
								onerror="this.onerror=null;this.src='${ctx}/img/default-profile.svg';">
						</c:when>
						<c:otherwise>
							<img src="${ctx}/img/default-profile.svg" alt="">
						</c:otherwise>
					</c:choose>
				</span>
				<div>
					<a href="${ctx}/member/publicProfile/view?userId=${review.userId}"><strong><c:out
								value="${review.nickname}" /></strong></a> <small>작성자 ·
						${review.createdAtStr}</small>
				</div>
			</div>
		</section>

		<section class="review-detail">
			<c:if test="${not empty review.image}">
				<div class="photos">
					<c:forEach var="img" items="${fn:split(review.image, ',')}">
						<img src="${ctx}/uploads/${img}" alt="경기 사진" />
					</c:forEach>
				</div>
			</c:if>
			<p class="text">
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
			<div class="acts">
				<div class="like-wrapper">
					<button type="button"
						class="fav-btn sq ${isFavorite ? 'is-on' : ''}" data-fav
						data-type="review" data-auth aria-label="좋아요">${heart}</button>
					<span id="likeCountDisplay" class="like-count">${likeCount}</span>
				</div>

				<span class="btn btn-outline btn-sm">댓글 ${visibleCnt}</span>

				<div class="acts-right">
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
		</section>

		<%-- ===== 댓글 ===== --%>
		<section class="review-comments">
			<h2 class="cmt-title">
				댓글 <span class="cmt-count">${visibleCnt}</span>
			</h2>

			<div class="cmt-list">
				<c:forEach var="cm" items="${commentList}">
					<c:choose>
						<%-- 관리자가 삭제한 댓글 --%>
						<c:when test="${cm.deleted eq 2}">
							<div class="cmt-item cmt-deleted">
								<p class="cmt-text">관리자에 의하여 댓글이 삭제되었습니다.</p>
							</div>
						</c:when>

						<%-- 정상 댓글 --%>
						<c:otherwise>
							<div class="cmt-item">
								<span class="avatar"> <c:choose>
										<c:when test="${not empty cm.profileImage}">
											<img
												src="${ctx}/profiles/<c:out value='${cm.profileImage}' />"
												alt=""
												onerror="this.onerror=null;this.src='${ctx}/img/default-profile.svg';">
										</c:when>
										<c:otherwise>
											<img src="${ctx}/img/default-profile.svg" alt="">
										</c:otherwise>
									</c:choose>
								</span>

								<div class="cmt-body">
									<div class="cmt-name">
										<a class="cmt-nick"
											href="${ctx}/member/publicProfile/view?userId=${cm.userId}"><c:out
												value="${cm.nickname}" /></a>
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
									<c:if
										test="${sessionScope.user.userId eq cm.userId or isAdmin}">
										<button type="button" class="cmt-del btn-del-comment"
											data-comment-id="${cm.commentId}">삭제</button>
									</c:if>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>

			<c:if test="${empty commentList}">
				<p class="cmt-empty">아직 댓글이 없어요. 첫 댓글을 남겨보세요.</p>
			</c:if>

			<form class="cmt-form" method="post" action="${ctx}/review/comment">
				<input type="hidden" name="reviewId" value="${review.reviewId}">
				<input class="input" name="content" autocomplete="off"
					placeholder="${empty sessionScope.user ? '로그인 후 댓글을 남길 수 있어요.' : '댓글을 입력하세요.'}"
					${empty sessionScope.user ? 'readonly data-auth' : 'required'}>
				<button type="submit" class="btn btn-primary btn-lg" data-auth>등록</button>
			</form>
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
		$("#confirmReviewDelete").on("click", function() {
			var isAdmin = '${isAdmin}' === 'true';
			var url = isAdmin ? '${ctx}/admin/content/review-delete' : '${ctx}/mypage/reviews';
			var data = isAdmin ? {reviewId : $("#reviewId").val()} : {action : 'delete', reviewId : $("#reviewId").val()};
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