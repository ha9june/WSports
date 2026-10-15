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
<style>
.review-card .thumb {
	display: flex;
	align-items: center;
	justify-content: center;
	background: #fff;
	border-bottom: 1px solid #eef0f3; /* 본문과 구분선 */
}

.review-card .thumb img {
	height: 56px; /* 로고가 꽉 차 보이지 않게 */
	object-fit: contain;
}

.review-toolbar .chip.is-selected {
	background: #eef4ff;
	border: 1px solid #1a6bff;
	color: #1a6bff;
	font-weight: 700;
}

.review-toolbar .chip:hover {
	border-color: #1a6bff;
	color: #1a6bff;
}

.review-toolbar .search-btn {
	height: 44px;
	padding: 0 22px;
	border: 1px solid #1a6bff;
	border-radius: 10px;
	background: #1a6bff;
	color: #fff;
	font-size: 14px;
	font-weight: 600;
	white-space: nowrap;
	cursor: pointer;
}

.review-toolbar .search-btn:hover {
	background: #1558d6;
	border-color: #1558d6;
	color: #fff;
}

.review-toolbar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	/* 칩은 왼쪽, 검색은 오른쪽 끝 */
	gap: 16px;
	flex-wrap: wrap;
	justify-content: space-between;
}

.review-toolbar .search-box {
	display: flex;
	align-items: center;
	gap: 8px;
}

.review-toolbar .search-box .input {
	width: 300px;
	height: 44px;
	box-sizing: border-box;
}

.review-toolbar .search-btn {
	height: 44px; /* 입력창 높이와 동일 */
	padding: 0 22px;
	white-space: nowrap;
}

.review-toolbar .chip-group {
	display: flex;
	align-items: center;
	gap: 8px;
	margin: 0;
}

.review-toolbar .btn-filter-reset {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 36px;
	margin-left: 4px;
	padding: 0 18px;
	border: 0;
	border-radius: 999px; /* 알약 모양 */
	background: #f3f4f6; /* 연회색 배경 */
	color: #6b7280; /* 회색 글자 */
	font-size: 13px;
	font-weight: 500;
	text-decoration: none; /* 밑줄 제거 */
	white-space: nowrap;
	cursor: pointer;
	transition: background .2s, color .2s;
}

.review-toolbar .btn-filter-reset:hover {
	background: #e5e7eb;
	color: #374151;
}
</style>
<main class="page">
	<div class="rail">
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
				<c:if
					test="${(not empty param.status and param.status ne 'ALL') or not empty param.keyword}">
					<a class="btn-filter-reset" href="${ctx}/review/list?state=recent">필터
						초기화</a>
				</c:if>
			</div>

			<div class="search-box">
				<input class="input" name="keyword"
					value="<c:out value='${param.keyword}'/>"
					placeholder="제목 또는 경기명 검색">
				<button type="submit" class="search-btn">검색</button>
			</div>
		</form>

		<c:choose>
			<c:when test="${state eq 'grouped'}">
				<div class="section-head">
					<h2 class="sub-title">경기별 후기</h2>
					<a class="btn btn-outline btn-xs btn-pill"
						href="${ctx}/review/list?state=recent">전체 후기 보기</a>
				</div>
				<c:forEach var="g" items="${groupList}" varStatus="st">
					<c:set var="first" value="${g.value[0]}" />
					<div class="group-title"
						<c:if test="${not st.first}"> style="margin-top:32px"</c:if>>
						<strong><c:out value="${first.matchTitle}" /></strong> <span><c:out
								value="${first.matchInfo}" /> · 후기 ${g.value.size()}</span>
					</div>

					<div class="review-grid">
						<c:forEach var="r" items="${g.value}">
							<a class="review-card"
								href="${ctx}/review/detail?reviewId=${r.reviewId}">
								<div class="thumb">
								<c:choose>
									<c:when test="${not empty r.image}">
										<img src="${ctx}/uploads/${r.image}"
											style="width: 100%; height: 100%; object-fit: cover;" alt="">
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
				</c:forEach>
				<c:if test="${empty groupList}">
					<p>등록된 후기가 없어요.</p>
				</c:if>
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
										<img src="${ctx}/uploads/${r.image}"
											style="width: 100%; height: 100%; object-fit: cover;" alt="">
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
					<p>등록된 후기가 없어요.</p>
				</c:if>
				<!-- 페이징 -->
				<c:if test="${pageInfo.allPage > 1}">
					<nav class="pagination"
						style="display: flex; justify-content: center; padding: 0">
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