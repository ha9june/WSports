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
<div class="work-inner" style="width: 860px">
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

			<div>
				<p class="cat">
					<c:out value="${r.sport}" />
				</p>
				<strong><c:out value="${r.title}" /></strong>
				<p>
					연결 경기 ·
					<c:out value="${r.matchTitle}" />
				</p>
				<p>
					<c:out value="${r.content}" />
				</p>
				♡ ${empty r.likeCount ? 0 : r.likeCount} &nbsp; 댓글 ${empty r.commentCount ? 0 : r.commentCount}
			</div>

			<div class="aside">
				<time>${r.createdAt}</time>
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