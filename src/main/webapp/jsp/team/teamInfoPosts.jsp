<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀 작성글 (teamInfoPosts.jsp) - 담당: 하준수
  피그마: Club / Team Info / Match Posts / Desktop (팀원 전용 조회)
  TODO: <c:forEach var="p" items="${teamMatchPostList}">
--%>
<c:set var="infoMode" value="true" />
<c:set var="manageTab" value="posts" />
<c:set var="pageTitle" value="팀 작성글" />
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
    <h2 class="sub-title">작성한 팀 매칭 글</h2><p class="section-desc" style="margin-bottom:24px">우리 팀이 작성한 상대 팀 모집 글이에요.</p>
    <div class="post-grid">
      <div class="post-card" data-href="${ctx}/jsp/team/teamMatchDetail.jsp?state=recruiting"><p class="ttl" style="margin:0">서울 풋살 크루 vs 상대 팀 모집 <span class="pill pill-success">모집중</span></p><p>9/27 (일) 17:00 - 19:00 · 난지 풋살장</p></div>
      <div class="post-card" data-href="${ctx}/jsp/team/teamMatchDetail.jsp?state=recruiting"><p class="ttl" style="margin:0">주말 연습경기 상대 팀 모집 <span class="pill pill-success">모집중</span></p><p>10/4 (일) 15:00 - 17:00 · 월드컵보조경기장</p></div>
      <div class="post-card" data-href="${ctx}/jsp/team/teamMatchDetail.jsp?state=completed"><p class="ttl" style="margin:0">서울 풋살 크루 vs 망원 FC <span class="pill pill-neutral">경기 종료</span></p><p>9/13 (일) 17:00 - 19:00 · 난지 풋살장</p></div>
    </div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
