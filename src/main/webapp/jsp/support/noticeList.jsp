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
    <form class="list-toolbar" method="get" style="align-items:flex-end;gap:20px;margin-bottom:28px">
      <div class="field" style="width:340px"><label class="field-label">검색</label><input class="input" name="keyword" placeholder="제목 검색"></div>
      <div class="seg pill neutral"><a class="seg-item is-active" href="?">전체</a><a class="seg-item" href="?cat=SERVICE">서비스</a><a class="seg-item" href="?cat=POLICY">정책</a><a class="seg-item" href="?cat=CHECK">점검</a></div>
    </form>
    <h2 class="sub-title" style="margin-bottom:14px">공지 12건</h2>
    <div class="row-list">
      <a class="row-card" href="${ctx}/jsp/support/noticeDetail.jsp"><div><p class="title">[안내] 9월 서비스 운영 안내</p><p class="meta">2026.09.12 · 운영팀</p></div><span class="pill pill-brand" style="width:84px">📌 고정</span></a>
      <a class="row-card" href="${ctx}/jsp/support/noticeDetail.jsp"><div><p class="title">경기 취소·환불 정책 문구 변경 안내</p><p class="meta">2026.09.08 · 운영팀</p></div></a>
      <a class="row-card" href="${ctx}/jsp/support/noticeDetail.jsp"><div><p class="title">결제 시스템 점검 안내</p><p class="meta">2026.09.03 · 운영팀</p></div></a>
      <a class="row-card" href="${ctx}/jsp/support/noticeDetail.jsp"><div><p class="title">팀 경기 기능 업데이트</p><p class="meta">2026.08.28 · 운영팀</p></div></a>
    </div>
    <nav class="pagination"><a href="#">‹</a><a href="#" class="is-active">1</a><a href="#">2</a><a href="#">3</a><a href="#">›</a></nav>
  </div>
</main>
<c:if test="${role eq 'admin'}">
  <a class="fab" href="${ctx}/jsp/admin/adminNoticeWrite.jsp"><span class="fab-label">공지 작성</span><span class="fab-btn" aria-hidden="true"></span></a>
</c:if>
<%@ include file="/jsp/common/footer.jsp" %>
