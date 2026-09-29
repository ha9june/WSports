<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀원 보기 (teamInfoMembers.jsp) - 담당: 하준수
  피그마: Club / Team Info / Members / Desktop (팀원 전용 조회 화면 - 관리 메뉴 없음)
--%>
<c:set var="infoMode" value="true" />
<c:set var="manageTab" value="members" />
<c:set var="pageTitle" value="팀원" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="team" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="container">
    <%--
  팀 관리 공통 상단 (가입 신청 / 팀원 관리 / 팀 작성글 관리 탭)
   - manageTab : application | members | posts
   - infoMode  : true 면 팀원용 조회 화면(팀원 보기 / 팀 작성글 보기) 탭으로 표시
--%>
<nav class="breadcrumb"><a href="${ctx}/jsp/team/teamList.jsp">팀</a><span class="sep">›</span><a href="${ctx}/jsp/team/teamDetail.jsp?state=${infoMode ? 'member' : 'manager'}">서울 풋살 크루</a><span class="sep">›</span><span>${infoMode ? '팀 정보' : '관리'}</span></nav>
<div class="page-head" style="margin-bottom:24px">
  <h1 class="page-title">${infoMode ? '서울 풋살 크루' : '팀 관리'}</h1>
  <p class="page-desc">${infoMode ? '팀원과 팀 작성글을 확인할 수 있어요.' : '가입 신청, 팀원, 팀 작성글 관리를 한 화면에서 전환합니다.'}</p>
</div>
<nav class="tabs">
  <c:choose>
    <c:when test="${infoMode}">
      <a class="tab ${manageTab eq 'members' ? 'is-active' : ''}" href="${ctx}/jsp/team/teamInfoMembers.jsp">팀원</a>
      <a class="tab ${manageTab eq 'posts' ? 'is-active' : ''}" href="${ctx}/jsp/team/teamInfoPosts.jsp">팀 작성글</a>
    </c:when>
    <c:otherwise>
      <a class="tab ${manageTab eq 'application' ? 'is-active' : ''}" href="${ctx}/jsp/team/teamManageApplication.jsp">가입 신청</a>
      <a class="tab ${manageTab eq 'members' ? 'is-active' : ''}" href="${ctx}/jsp/team/teamManageMembers.jsp">팀원 관리</a>
      <a class="tab ${manageTab eq 'posts' ? 'is-active' : ''}" href="${ctx}/jsp/team/teamManagePosts.jsp">팀 작성글 관리</a>
    </c:otherwise>
  </c:choose>
</nav>
    <h2 class="sub-title">팀원 34명</h2><p class="section-desc" style="margin-bottom:24px">함께 활동 중인 팀원의 역할과 프로필을 확인할 수 있어요.</p>
    <%-- TODO: <c:forEach var="m" items="${memberList}"> --%>
    <div class="member-grid">
      <div class="member-card"><span class="avatar"><img src="${ctx}/img/avatar-01.jpg" alt=""></span>
        <div class="info"><strong>풋살초보</strong><p class="meta">서울 마포구 · 초급</p>
          <div class="hover-card"><div class="top"><span class="avatar md"><img src="${ctx}/img/avatar-01.jpg" alt=""></span><div><strong>풋살초보</strong><p>서울 마포구 · 초급</p><p class="rating">4.8 · 18개 평가</p></div></div>
            <dl><dt>주 활동 지역</dt><dd>서울 마포구</dd><dt>선호 시간</dt><dd>평일 저녁</dd></dl></div></div>
        </div>
      <div class="member-card"><span class="avatar"><img src="${ctx}/img/avatar-02.jpg" alt=""></span>
        <div class="info"><strong>운동하자</strong><span class="pill pill-brand role">부팀장</span><p class="meta">서울 서대문구 · 중급</p>
          <div class="hover-card"><div class="top"><span class="avatar md"><img src="${ctx}/img/avatar-02.jpg" alt=""></span><div><strong>운동하자</strong><p>서울 서대문구 · 중급</p><p class="rating">4.8 · 18개 평가</p></div></div>
            <dl><dt>주 활동 지역</dt><dd>서울 서대문구</dd><dt>선호 시간</dt><dd>평일 저녁</dd></dl></div></div>
        </div>
      <div class="member-card"><span class="avatar"><img src="${ctx}/img/avatar-03.jpg" alt=""></span>
        <div class="info"><strong>공차는날</strong><p class="meta">서울 은평구 · 초중급</p>
          <div class="hover-card"><div class="top"><span class="avatar md"><img src="${ctx}/img/avatar-03.jpg" alt=""></span><div><strong>공차는날</strong><p>서울 은평구 · 초중급</p><p class="rating">4.8 · 18개 평가</p></div></div>
            <dl><dt>주 활동 지역</dt><dd>서울 은평구</dd><dt>선호 시간</dt><dd>평일 저녁</dd></dl></div></div>
        </div>
      <div class="member-card"><span class="avatar"><img src="${ctx}/img/avatar-04.jpg" alt=""></span>
        <div class="info"><strong>주말풋살러</strong><p class="meta">서울 용산구 · 초급</p>
          <div class="hover-card"><div class="top"><span class="avatar md"><img src="${ctx}/img/avatar-04.jpg" alt=""></span><div><strong>주말풋살러</strong><p>서울 용산구 · 초급</p><p class="rating">4.8 · 18개 평가</p></div></div>
            <dl><dt>주 활동 지역</dt><dd>서울 용산구</dd><dt>선호 시간</dt><dd>평일 저녁</dd></dl></div></div>
        </div>
      <div class="member-card"><span class="avatar"><img src="${ctx}/img/avatar-05.jpg" alt=""></span>
        <div class="info"><strong>패스마스터</strong><p class="meta">서울 영등포구 · 중급</p>
          <div class="hover-card"><div class="top"><span class="avatar md"><img src="${ctx}/img/avatar-05.jpg" alt=""></span><div><strong>패스마스터</strong><p>서울 영등포구 · 중급</p><p class="rating">4.8 · 18개 평가</p></div></div>
            <dl><dt>주 활동 지역</dt><dd>서울 영등포구</dd><dt>선호 시간</dt><dd>평일 저녁</dd></dl></div></div>
        </div>
      <div class="member-card"><span class="avatar"><img src="${ctx}/img/avatar-06.jpg" alt=""></span>
        <div class="info"><strong>골때리는날</strong><p class="meta">서울 강서구 · 초중급</p>
          <div class="hover-card"><div class="top"><span class="avatar md"><img src="${ctx}/img/avatar-06.jpg" alt=""></span><div><strong>골때리는날</strong><p>서울 강서구 · 초중급</p><p class="rating">4.8 · 18개 평가</p></div></div>
            <dl><dt>주 활동 지역</dt><dd>서울 강서구</dd><dt>선호 시간</dt><dd>평일 저녁</dd></dl></div></div>
        </div>
    </div>
    <nav class="pagination"><a href="#">‹</a><a href="#" class="is-active">1</a><a href="#">2</a><a href="#">3</a><a href="#">›</a></nav>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
