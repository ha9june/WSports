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
	<div class="rail">
		<div class="page-head">
			<h1 class="page-title">후기</h1>
			<p class="page-desc">경기 후기를 찾아보고 경험을 공유해보세요.</p>
		</div>
		<form class="review-toolbar" method="get" action="${ctx}/review/list">
			<input type="hidden" name="state" value="${state}">
			<div class="field">
				<label class="field-label">검색</label><input class="input"
					name="keyword" placeholder="제목 또는 경기명 검색">
			</div>
			<div class="chip-group" data-select="single" data-name="sport"
				style="margin-bottom: 8px">
				<button type="button" class="chip neutral is-selected">전체</button>
				<button type="button" class="chip">축구/풋살</button>
				<button type="button" class="chip">농구</button>
				<button type="button" class="chip">테니스</button>
				<button type="button" class="chip">배드민턴</button>
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
									<c:out value="${r.title}" />
								</div>
								<div class="body">
									<strong><c:out value="${r.title}" /></strong>
									<p class="by">
										작성자 ·
										<c:out value="${r.userId}" />
									</p>
									<p class="link">
										참여 경기 ·
										<c:out value="${r.matchType}" />
									</p>
									♡ ${empty r.likeCount ? 0 : r.likeCount} &nbsp; 댓글 ${empty r.commentCount ? 0 : r.commentCount}
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
											style="width: 100%; height: 100%; object-fit: cover;">
									</c:when>
									<c:otherwise>
										<c:out value="${r.title}" />
									</c:otherwise>
								</c:choose>
							</div>
							<div class="body">
								<strong><c:out value="${r.title}" /></strong>
								<p class="by">
									작성자 ·
									<c:out value="${r.userId}" />
								</p>
								<p class="link">
									참여 경기 ·
									<c:out value="${r.matchType}" />
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
						<c:set var="base"
							value="${ctx}/review/list?state=${state}&keyword=${fn:escapeXml(param.keyword)}" />

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
<a class="fab" href="${ctx}/review/create" data-auth><span
	class="fab-label">후기 쓰기</span><span class="fab-btn" aria-hidden="true"></span></a>
<%@ include file="/jsp/common/footer.jsp"%>