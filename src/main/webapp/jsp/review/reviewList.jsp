<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  후기 목록 (reviewList.jsp) - 담당: 강신우
  피그마: Review / List / Desktop, Review / List / Grouped by Match / Desktop
  ─ 하나의 JSP 로 처리 ─
   state : recent(최근 후기 카드) | grouped(경기별 모아보기)
--%>
<c:set var="state" value="${empty param.state ? 'recent' : param.state}" />
<c:set var="pageTitle" value="후기" />
<c:set var="pageCss" value="review" />
<c:set var="activeNav" value="review" />
<c:set var="showFooter" value="true" />
<c:set var="demoStates" value="recent:최근 후기|grouped:경기별 모아보기" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container review-list">
		<div class="page-head">
			<h1 class="page-title">후기</h1>
			<p class="page-desc">경기 후기를 찾아보고 경험을 공유해보세요.</p>
		</div>
		<form class="review-toolbar" method="get" action="${ctx}/review/list">
			<input type="hidden" name="state" value="recent"> <input
				type="hidden" name="status" id="statusInput"
				value="${empty param.status ? 'ALL' : param.status}">

			<div class="chip-group">
				<c:set var="st" value="${empty param.status ? 'ALL' : param.status}" />
				<button type="button"
					class="chip ${st eq 'ALL' ? 'is-selected' : ''}" data-value="ALL">전체</button>
				<button type="button"
					class="chip ${st eq '축구/풋살' ? 'is-selected' : ''}"
					data-value="축구/풋살">축구/풋살</button>
				<button type="button"
					class="chip ${st eq '농구' ? 'is-selected' : ''}" data-value="농구">농구</button>
				<button type="button"
					class="chip ${st eq '테니스' ? 'is-selected' : ''}" data-value="테니스">테니스</button>
				<button type="button"
					class="chip ${st eq '배드민턴' ? 'is-selected' : ''}" data-value="배드민턴">배드민턴</button>
			</div>

			<div class="search-box">
				<input class="input" name="keyword"
					value="<c:out value='${param.keyword}'/>"
					placeholder="제목 또는 경기명 검색">
				<button type="submit" class="btn btn-primary btn-lg">검색</button>
			</div>
		</form>

		<c:choose>
			<c:when test="${state eq 'grouped'}">
				<div class="section-head">
					<h2 class="sub-title">경기별 후기</h2>
					<a class="btn btn-outline btn-xs btn-pill"
						href="${ctx}/review/list?state=recent">전체 후기 보기</a>
				</div>
				<div class="group-grid">
					<c:forEach var="g" items="${groupList}">
						<c:set var="first" value="${g.value[0]}" />
						<div class="review-group">
							<div class="group-title">
								<strong title="${fn:escapeXml(first.matchTitle)}"><c:out value="${first.matchTitle}" /></strong>
								<span>후기 ${g.value.size()}</span>
							</div>
							<div class="group-reviews">
								<c:forEach var="r" items="${g.value}">
									<a class="review-card" href="${ctx}/review/detail?reviewId=${r.reviewId}">
										<div class="thumb">
											<c:choose>
												<c:when test="${not empty r.image}">
													<img class="photo" src="${ctx}/uploads/${r.image}" alt="">
												</c:when>
												<c:otherwise>
													<img src="${ctx}/img/w-sports-5e-logo.svg" alt="">
												</c:otherwise>
											</c:choose>
										</div>
										<div class="body">
											<strong><c:out value="${r.title}" /></strong>
											<p class="by">작성자 · <c:out value="${r.nickname}" /></p>
											<p class="link">참여 경기 · <c:out value="${r.matchTitle}" /></p>
											<p class="cnt">♡ ${empty r.likeCount ? 0 : r.likeCount}
												&nbsp; 댓글 ${empty r.commentCount ? 0 : r.commentCount}</p>
										</div>
									</a>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
				</div>
				<c:if test="${empty groupList}">
					<p class="empty">등록된 후기가 없어요.</p>
				</c:if>
				<div class="more-wrap">
					<button type="button" class="btn-more" id="groupMore">
						<span class="arrow">↓</span> 더보기
					</button>
				</div>
			</c:when>
			<c:otherwise>
				<div class="section-head">
					<h2 class="sub-title">최근 후기</h2>
					<a class="btn btn-outline btn-xs btn-pill"
						href="${ctx}/review/list?state=grouped">경기별 모아보기</a>
				</div>
				<div class="review-grid">
					<c:forEach var="r" items="${reviewList}">
						<a class="review-card"
							href="${ctx}/review/detail?reviewId=${r.reviewId}">
							<div class="thumb">
								<c:choose>
									<c:when test="${not empty r.image}">
										<img class="photo" src="${ctx}/uploads/${r.image}" alt="">
									</c:when>
									<c:otherwise>
										<img src="${ctx}/img/w-sports-5e-logo.svg" alt="">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="body">
								<strong><c:out value="${r.title}" /></strong>
								<p class="by">
									작성자 ·
									<c:out value="${r.nickname}" />
								</p>
								<p class="link">
									참여 경기 ·
									<c:out value="${r.matchTitle}" />
								</p>
								<p class="cnt">♡ ${empty r.likeCount ? 0 : r.likeCount}
									&nbsp; 댓글 ${empty r.commentCount ? 0 : r.commentCount}</p>
							</div>
						</a>
					</c:forEach>
				</div>
				<c:if test="${empty reviewList}">
					<p class="empty">등록된 후기가 없어요.</p>
				</c:if>
				<!-- 페이징 -->
				<c:if test="${pageInfo.allPage > 1}">
					<nav class="pagination">
						<c:url var="base" value="/review/list">
							<c:param name="state" value="recent" />
							<c:param name="status"
								value="${empty param.status ? 'ALL' : param.status}" />
							<c:param name="keyword" value="${param.keyword}" />
						</c:url>

						<a
							href="${pageInfo.curPage > 1 ? base.concat('&page=').concat(pageInfo.curPage - 1) : '#'}">&lt;</a>

						<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}"
							var="p">
							<a href="${base}&page=${p}"
								class="${pageInfo.curPage eq p ? 'is-active' : ''}">${p}</a>
						</c:forEach>

						<a
							href="${pageInfo.curPage < pageInfo.allPage ? base.concat('&page=').concat(pageInfo.curPage + 1) : '#'}">&gt;</a>
					</nav>
				</c:if>
			</c:otherwise>
		</c:choose>
	</div>
</main>
<script>
$(function () {
	var step = 9, shown = step;
	var $groups = $('.group-grid > .review-group');
	var $more = $('#groupMore');

	function render() {
		$groups.hide().slice(0, shown).show();
		if (shown >= $groups.length) $more.closest('.more-wrap').hide();
	}

	$more.on('click', function () {
		shown += step;
		render();
	});
	render();
});
	document.querySelectorAll('.review-toolbar .chip').forEach(function(chip) {
		chip.addEventListener('click', function() {
			document.getElementById('statusInput').value = chip.dataset.value;
			chip.closest('form').submit();
		});
	});
</script>
<a class="fab" href="${ctx}/review/create" data-auth><span
	class="fab-label">후기 쓰기</span><span class="fab-btn" aria-hidden="true"></span></a>
<%@ include file="/jsp/common/footer.jsp"%>