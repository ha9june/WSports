<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
공지사항 목록 (noticeList.jsp) - 담당: 박우리
피그마: Notice / List / Desktop
상단 고정(pinned) 공지는 맨 위에 '고정' 배지와 함께 노출됩니다.
TODO: <c:forEach var="n" items="${noticeList}">
--%>
<c:set var="pageTitle" value="공지사항" />
<c:set var="pageCss" value="mypage" />
<c:set var="activeNav" value="notice" />
<c:set var="showFooter" value="true" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
<div class="rail">
<div class="page-head"><h1 class="page-title lg">공지사항</h1><p class="page-desc">서비스 운영 안내와 주요 변경사항을 확인하세요.</p></div>
<form class="list-toolbar" method="get" style="margin-bottom:28px">
<input type="hidden" name="type" value="${type}">
<c:set var="keyword" value="${empty param.keyword ? '' : param.keyword}" />
<c:set var="type" value="${empty param.type ? 'ALL' : param.type}" />
<div class="notice-search">
<div class="seg pill neutral notice-seg">
<a class="seg-item ${type eq 'ALL' ? 'is-active' : ''}" href="?type=ALL">전체</a>
<a class="seg-item ${type eq 'NOTICE' ? 'is-active' : ''}" href="?type=NOTICE">공지</a>
<a class="seg-item ${type eq 'POLICY' ? 'is-active' : ''}" href="?type=POLICY">정책</a>
<a class="seg-item ${type eq 'CHECK' ? 'is-active' : ''}" href="?type=CHECK">점검</a>
<a class="seg-item ${type eq 'EVENT' ? 'is-active' : ''}" href="?type=EVENT">이벤트</a>
<a class="seg-item ${type eq 'UPDATE' ? 'is-active' : ''}" href="?type=UPDATE">업데이트</a>
</div>
<label class="field-label" for="noticeKeyword" style="position:absolute;width:1px;height:1px;overflow:hidden;clip:rect(0 0 0 0)">검색</label>
<div class="notice-find">
<input class="input" id="noticeKeyword" name="keyword" value="<c:out value='${keyword}'/>" placeholder="제목 · 내용 · 작성자 검색">
<button type="submit" class="btn btn-primary">검색</button>
</div>
</div>
</form>
<h2 class="sub-title" style="margin-bottom:14px">공지 ${pageInfo.totalCnt}건</h2>
<div class="row-list">
<c:forEach var="n" items="${noticeList}">
<a class="row-card" href="${ctx}/support/notice/detail?noticeId=${n.notice_id}">
<div>
<p class="title"><c:out value="${n.title}"/></p>
<p class="meta"><c:out value="${n.created_at}"/> · <c:out value="${n.nickname}"/></p>
</div>
<c:if test="${n.is_pinned}">
<span class="pill pill-brand" style="width:84px">📌 고정</span>
</c:if>
</a>
</c:forEach>
<c:if test="${empty noticeList}">
<div class="empty-box">
<img src="${ctx}/img/emptylist-image.png" alt="빈리스트 대체 이미지">
<p>" 조회된 결과가 없어요 ! "</p>
</div>
</c:if>
</div>
<c:if test="${not empty noticeList }">
<nav class="pagination" style="display: flex; justify-content:center; padding:0px">
<a href="${pageInfo.curPage > 1 ? ctx += '/support/notice/list?type=' += type += '&page=' += (pageInfo.curPage - 1) += '&keyword=' += keyword : '#'}">&lt;</a>
<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="page">
<a href="${ctx}/support/notice/list?type=${type}&amp;page=${page}&amp;keyword=${keyword}" class="${pageInfo.curPage eq page ? 'is-active' : ''}">${page}</a>
</c:forEach>
<a href="${pageInfo.curPage < pageInfo.allPage ? ctx += '/support/notice/list?type=' += type += '&page=' += (pageInfo.curPage + 1) += '&keyword=' += keyword : '#'}">&gt;</a>
</nav>
</c:if>
</div>
</main>
<c:if test="${sessionScope.user.grade eq 'Admin'}">
<a class="fab" href="${ctx}/admin/notice/write"><span class="fab-label">공지 작성</span><span class="fab-btn" aria-hidden="true"></span></a>
</c:if>
<%@ include file="/jsp/common/footer.jsp" %>