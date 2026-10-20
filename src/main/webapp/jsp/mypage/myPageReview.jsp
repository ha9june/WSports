<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  내 후기 (myPageReview.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Reviews, Review / Delete / Modal, Review / Deleted / Toast
   state : default | deleteModal(삭제 확인 모달) | deleted(삭제 완료 토스트)
--%>
<c:set var="state"
	value="${empty param.state ? 'default' : param.state}" />
<c:set var="pageTitle" value="내 후기" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="review" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates"
	value="default:기본|deleteModal:삭제 모달|deleted:삭제 완료" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<style>
.created {

}

</style>
<div class="work-inner mp-body">
	<h1 class="section-title">내 후기</h1>
	<p class="section-desc">내가 작성한 후기와 연결된 경기를 확인하고 수정하거나 삭제할 수 있어요.</p>

	<div class="act-head t-11">
		<span class="t-2">작성한 후기 ${pageInfo.totalCnt}개</span> <span
			class="t-2">${pageInfo.curPage} / ${pageInfo.allPage} 페이지</span>
	</div>

	<c:if test="${empty Review}">
		<p style="text-align: center; color: #9ca3af; padding: 40px 0;">작성한
			후기가 없어요.</p>
	</c:if>
	<c:forEach var="r" items="${Review}">
		<div class="my-review"
			data-href="${ctx}/review/detail?reviewId=${r.reviewId}"
			style="cursor: pointer;"
			onclick="if(event.target.tagName !== 'BUTTON' && event.target.tagName !== 'A') location.href=this.dataset.href;">

			<div class="mr-art">
				<c:choose>
					<c:when test="${r.sport eq '축구/풋살'}">
						<img src="${ctx}/img/art-football.png" alt="축구/풋살">
					</c:when>
					<c:when test="${r.sport eq '농구'}">
						<img src="${ctx}/img/art-basketball.png" alt="농구">
					</c:when>
					<c:when test="${r.sport eq '테니스'}">
						<img src="${ctx}/img/art-tennis.png" alt="테니스">
					</c:when>
					<c:when test="${r.sport eq '배드민턴'}">
						<img src="${ctx}/img/art-badminton.png" alt="배드민턴">
					</c:when>
					<c:otherwise>
						<img src="${ctx}/img/match-default.png" alt="">
					</c:otherwise>
				</c:choose>
			</div>

			<div class="mr-main">
				<strong><c:out value="${r.title}" /></strong>
				<p class="mr-link">
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M10 13a5 5 0 0 0 7.07 0l3-3a5 5 0 0 0-7.07-7.07l-1.5 1.5"/><path d="M14 11a5 5 0 0 0-7.07 0l-3 3a5 5 0 0 0 7.07 7.07l1.5-1.5"/></svg>
					<span>연결 경기 · <c:out value="${r.matchTitle}" /></span>
				</p>
				<p class="mr-meta">
					<span><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M20.8 4.6a5.5 5.5 0 0 0-7.8 0L12 5.7l-1-1.1a5.5 5.5 0 0 0-7.8 7.8l1 1.1L12 21l7.8-7.5 1-1.1a5.5 5.5 0 0 0 0-7.8z"/></svg>${empty r.likeCount ? 0 : r.likeCount}</span>
					<span><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 11.5a8.4 8.4 0 0 1-9 8.4 8.5 8.5 0 0 1-3.8-.9L3 21l2-5.2A8.4 8.4 0 0 1 3 11.5 8.5 8.5 0 0 1 12 3a8.5 8.5 0 0 1 9 8.5z"/></svg>댓글 ${empty r.commentCount ? 0 : r.commentCount}</span>
				</p>
			</div>

			<div class="aside">
				<%-- <time>${r.createdAt}</time> --%>
				<a class="btn btn-primary btn-sm"
					href="${ctx}/review/edit?reviewId=${r.reviewId}">수정</a>
				<button type="button"
					class="btn btn-danger btn-sm btn-review-delete"
					data-id="${r.reviewId}">삭제</button>
			</div>
		</div>
	</c:forEach>


	<c:if test="${pageInfo.allPage > 1}">
		<nav class="pagination">
			<c:if test="${pageInfo.curPage > 1}">
				<a href="?page=${pageInfo.curPage - 1}">‹</a>
			</c:if>
			<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}"
				var="p">
				<a href="?page=${p}"
					class="${pageInfo.curPage eq p ? 'is-active' : ''}">${p}</a>
			</c:forEach>
			<c:if test="${pageInfo.curPage < pageInfo.allPage}">
				<a href="?page=${pageInfo.curPage + 1}">›</a>
			</c:if>
		</nav>
	</c:if>

	<div class="modal" id="reviewDeleteModal" role="dialog"
		aria-modal="true">
		<div class="modal-card">
			<h2 class="modal-title">후기를 삭제할까요?</h2>
			<p class="modal-desc">삭제한 후기는 되돌릴 수 없어요.</p>
			<input type="hidden" id="deleteReviewId">
			<div class="modal-actions">
				<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
				<button type="button" class="btn btn-danger"
					id="confirmReviewDelete">삭제</button>
			</div>
		</div>
	</div>

	<script>
		$(function() {
			// [추가] 후기 리스트 카드 클릭 시 상세 페이지로 이동 처리
			$(document).on('click', '.my-review', function(e) {
				// 클릭된 요소가 버튼(삭제)이나 링크(수정)가 아닐 때만 이동
				if (!$(e.target).is('button, a')) {
					var url = $(this).data('href');
					if (url) {
						location.href = url;
					}
				}
			});

			// 기존 삭제 모달 기능 유지
			$(document).on('click', '.btn-review-delete', function(e) {
				e.stopPropagation(); // 카드 클릭 이동 이벤트 버블링 방지
				$('#deleteReviewId').val($(this).data('id'));
				$('#reviewDeleteModal').addClass('is-open');
			});

			$('#confirmReviewDelete').on('click', function() {
				$.post('${ctx}/mypage/reviews', {
					action : 'delete',
					reviewId : $('#deleteReviewId').val()
				}, function(res) {
					res = res.trim();
					if (res === 'ok')
						location.reload();
					else if (res === 'login')
						location.href = '${ctx}/login';
					else
						showToast('삭제에 실패했어요.');
				});
			});
		});
	</script>

	<%@ include file="/jsp/common/footer.jsp"%>