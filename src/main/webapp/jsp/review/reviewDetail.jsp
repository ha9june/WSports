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
<c:set var="pageTitle" value="후기 상세" />
<c:set var="pageCss" value="review,match" />
<c:set var="activeNav" value="review" />
<%@ include file="/jsp/common/header.jsp"%>
<style>
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
	margin-top: 8px !important; /* 본문 글씨와 사진 사이의 간격을 밀착 (원하는 만큼 조절 가능) */
	padding-top: 0px !important;
	display: flex !important;
	flex-wrap: wrap !important; /* 사진이 3개 이상일 때 다음 줄로 넘김 */
	gap: 8px !important; /* 사진과 사진 사이의 간격 */
}

/* 3. 각각의 이미지 태그 크기 제어 (3등분) */
.review-detail .photos img {
	/* gap 공간을 제외하고 정확히 한 줄에 3개씩 분할하기 위한 계산식 */
	width: calc(( 100% - 16px)/3) !important;
	height: 230px !important; /* 사진 높이를 고정하여 균일하게 정렬 */
	object-fit: cover !important; /* 사진이 고정 높이에서 찌그러지지 않게 방지 */
	border-radius: 4px; /* 사진 모서리를 약간 둥글게 (선택사항) */
}
</style>

<main class="page">
	<div class="rail">
		<nav class="breadcrumb">
			<a href="${ctx}/review/list">후기</a><span class="sep">›</span><span>상세</span>
		</nav>

		<div class="detail-top" style="margin-bottom: 16px">
			<div class="title-row" style="margin-top: 0">
				<h1>
					<c:out value="${review.title}" />
				</h1>
				<c:if test="${role eq 'admin'}">
					<button type="button" class="btn btn-danger btn-sm"
						data-modal-open="deleteModal">후기 삭제</button>
				</c:if>
			</div>
			<div class="host-inline">
				<c:choose>
					<c:when test="${not empty review.profileImage}">
						<img class="avatar" src="${ctx}/profiles/${review.profileImage}"
							style="object-fit: cover;" alt="프로필">
					</c:when>
					<c:otherwise>
						<span class="avatar default"></span>
					</c:otherwise>
				</c:choose>
				<div>
					<a
						href="${ctx}/jsp/member/userProfileInfo.jsp?userId=${review.userId}"><strong>${review.nickname}</strong></a>
					<small>작성자 · ${review.createdAtStr}</small>
				</div>
			</div>
			<p class="mt-8">
				<span class="sport-chip" style="height: 26px"><c:out
						value="${review.sport}" /></span>
			</p>
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
							href="${ctx}/jsp/match/teamMatchDetail.jsp?teamMatchId=${review.matchId}">${review.title}</a>
					</c:when>
					<c:otherwise>
						<a
							href="${ctx}/jsp/match/personalMatchDetail.jsp?personalMatchId=${review.matchId}">${review.title}</a>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="acts">
				<div class="like-wrapper"
					style="display: inline-flex; align-items: center; gap: 6px;">
					<button type="button"
						class="fav-btn sq ${isFavorite ? 'is-on' : ''}" data-fav
						data-type="review" data-auth aria-label="좋아요">${heart}</button>
					<span id="likeCountDisplay" class="t-14" style="font-weight: bold;">${likeCount}</span>
				</div>

				<c:choose>
					<c:when test="${state eq 'mine'}">
						<a class="btn btn-outline btn-sm"
							href="${ctx}/review/edit?reviewId=${review.reviewId}">수정</a>

						<button type="button" class="btn btn-danger-soft btn-sm"
							data-modal-open="deleteModal">삭제</button>
					</c:when>
					<c:otherwise>
						<a class="btn btn-outline btn-sm"
							href="${ctx}/jsp/support/reportWrite.jsp?targetType=review&targetNo=${review.reviewId}"
							data-auth>신고</a>
					</c:otherwise>
				</c:choose>
				<span class="btn btn-outline btn-sm">댓글
					${fn:length(commentList)}</span>
			</div>
		</section>

		<section style="width: 744px; max-width: 100%" class="mt-48">
			<h2 class="sub-title" style="margin-bottom: 14px">댓글
				${fn:length(commentList)}</h2>
			<c:forEach var="cm" items="${commentList}">
				<div class="comment">
					<c:choose>
						<c:when test="${not empty cm.profileImage}">
							<img class="avatar sm" src="${ctx}/profiles/${cm.profileImage}"
								style="object-fit: cover;" alt="프로필">
						</c:when>
						<c:otherwise>
							<span class="avatar sm default"></span>
						</c:otherwise>
					</c:choose>
					<b>${cm.nickname}</b> <span><c:out value="${cm.content}" /></span>
					<span class="t-11 t-3">${cm.createdAtStr}</span>
					<c:if test="${sessionScope.user.userId eq cm.userId}">
						<button type="button" class="btn-text t-11 btn-del-comment"
							data-comment-id="${cm.commentId}">삭제</button>
					</c:if>
				</div>
			</c:forEach>
			<c:if test="${empty commentList}">
				<p class="t-3" style="padding: 16px 0">첫 댓글을 남겨보세요.</p>
			</c:if>

			<form class="comment-form" method="post"
				action="${ctx}/review/comment">
				<input type="hidden" name="reviewId" value="${review.reviewId}">
				<input class="input" name="content"
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
			$.post('${ctx}/admin/content/review-delete', {
				reviewId : $("#reviewId").val()
			}, function(result) {
				if (result.trim() === 'true') {
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