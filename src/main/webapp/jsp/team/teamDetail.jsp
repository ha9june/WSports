<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀 상세 (teamDetail.jsp) - 담당: 하준수
  피그마: Club / Detail / Desktop (비가입자), Club / Detail / Member View, Club / Detail / Manager View
  ─ 하나의 JSP 로 처리 ─
   state : public(비가입자 - 팀원/작성글 잠금, 가입 신청) | member(팀원) | manager(팀장·부팀장 - 팀 관리 버튼)
   role  : guest 면 state 와 상관없이 public 화면 + 가입 신청 시 로그인 안내
   admin : 관리자는 팀 삭제 버튼 노출
  실구현 : 로그인 사용자와 팀의 관계(TEAM_MEMBER.role)로 서블릿에서 state 계산
--%>
<c:set var="state" value="${empty param.state ? 'public' : param.state}" />
<c:if test="${role eq 'guest'}"><c:set var="state" value="public" /></c:if>
<c:set var="isMember" value="${state eq 'member' or state eq 'manager'}" />
<c:set var="pageTitle" value="서울 풋살 크루" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="team" />
<c:set var="demoStates" value="public:비가입자|member:팀원|manager:팀장" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="container">
    <nav class="breadcrumb"><a href="${ctx}/jsp/team/teamList.jsp">팀</a><span class="sep">›</span><span>서울 풋살 크루</span></nav>
    <div class="detail-grid" style="margin-top:0">
      <div class="gallery">
        <div class="main-photo" style="height:348px">활동 사진</div>
        <div class="thumbs"><span>사진 1</span><span>사진 2</span><span>사진 3</span><em style="margin-right:auto;margin-left:160px">활동 사진 3장</em></div>
      </div>
      <aside class="team-side">
        <div class="top"><span class="logo-ph"><img src="${ctx}/img/team-football.png" alt="대표"></span>
          <div><h1>서울 풋살 크루</h1><p>서울 · 축구/풋살 · 팀원 34명</p></div></div>
        <h2>모집 조건</h2>
        <dl class="cond"><dt>성별</dt><dd>성별 무관</dd><dt>연령대</dt><dd>20대 · 30대</dd><dt>레벨</dt><dd>초급</dd><dt>활동 지역</dt><dd>마포 · 서대문</dd></dl>
        <c:choose>
          <c:when test="${state eq 'manager'}"><hr style="margin-bottom:0"><a class="btn btn-primary btn-block" href="${ctx}/jsp/team/teamManageApplication.jsp">팀 관리</a></c:when>
          <c:when test="${state eq 'member'}"><hr><p class="note">가입된 팀입니다. 팀원과 작성글을 확인할 수 있어요.</p></c:when>
          <c:otherwise>
            <hr><p class="note">가입 신청 후 주장 승인이 필요합니다.</p>
            <a class="btn btn-join btn-block" href="${ctx}/jsp/team/teamApplication.jsp" data-auth>가입 신청하기</a>
          </c:otherwise>
        </c:choose>
        <c:if test="${role eq 'admin'}"><button type="button" class="btn btn-danger btn-block btn-sm" data-modal-open="teamDeleteModal">팀 삭제</button></c:if>
      </aside>
    </div>

    <nav class="tabs team-tabs">
      <a class="tab is-active" href="#intro">소개글</a>
      <a class="tab ${isMember ? '' : 'locked'}" href="#members">팀원</a>
      <a class="tab ${isMember ? '' : 'locked'}" href="#posts">팀 작성글</a>
    </nav>

    <section class="team-section" id="intro">
      <h2>팀 소개</h2>
      <p class="intro">주말 저녁에 가볍게 풋살하는 모임입니다.<br>초보자도 참가할 수 있고, 월 2~3회 정기 경기를 진행합니다.<br>서로 배려하며 꾸준히 함께 운동할 멤버를 기다리고 있어요.</p>
    </section>

    <c:choose>
      <c:when test="${isMember}">
        <section class="team-section" id="members" style="margin-top:56px">
          <div class="section-head"><div><h2>팀원 34명</h2><p class="section-desc">함께 활동 중인 팀원의 역할과 프로필을 확인할 수 있어요.</p></div>
            <a class="btn btn-outline btn-sm" href="${ctx}/jsp/team/teamInfoMembers.jsp">전체보기</a></div>
          <div class="member-grid">
            <div class="member-card"><span class="avatar"><img src="${ctx}/img/avatar-01.jpg" alt=""></span><div class="info"><strong>풋살초보</strong><p class="meta">서울 마포구 · 초급</p></div></div>
            <div class="member-card"><span class="avatar"><img src="${ctx}/img/avatar-02.jpg" alt=""></span><div class="info"><strong>운동하자</strong><span class="pill pill-brand role">부팀장</span><p class="meta">서울 서대문구 · 중급</p></div></div>
            <div class="member-card"><span class="avatar"><img src="${ctx}/img/avatar-03.jpg" alt=""></span><div class="info"><strong>공차는날</strong><p class="meta">서울 은평구 · 초중급</p></div></div>
          </div>
        </section>
        <section class="team-section" id="posts" style="margin-top:48px">
          <div class="section-head"><div><h2>팀 작성글</h2><p class="section-desc">팀이 작성한 상대 팀 모집 글이에요.</p></div>
            <a class="btn btn-outline btn-sm" href="${ctx}/jsp/team/teamInfoPosts.jsp">전체보기</a></div>
          <div class="post-grid">
            <a class="post-card" href="${ctx}/jsp/team/teamMatchDetail.jsp"><p class="ttl" style="margin:0">서울 풋살 크루 vs 상대 팀 모집 <span class="pill pill-success">모집중</span></p><p>9/27 (일) 17:00 - 19:00 · 난지 풋살장</p></a>
            <a class="post-card" href="${ctx}/jsp/team/teamMatchDetail.jsp"><p class="ttl" style="margin:0">주말 연습경기 상대 팀 모집 <span class="pill pill-success">모집중</span></p><p>10/4 (일) 15:00 - 17:00 · 월드컵보조경기장</p></a>
          </div>
        </section>
      </c:when>
      <c:otherwise>
        <section class="team-section" id="members" style="margin-top:56px">
          <h2>팀원</h2><p class="section-desc">가입한 팀원만 확인할 수 있는 정보입니다.</p>
          <div class="locked-wrap">
            <div class="member-grid blur" aria-hidden="true">
              <div class="member-card"><span class="avatar default"></span><div class="info"><strong>팀원</strong><p class="meta">서울 · 초급</p></div></div>
              <div class="member-card"><span class="avatar default"></span><div class="info"><strong>팀원</strong><p class="meta">서울 · 중급</p></div></div>
              <div class="member-card"><span class="avatar default"></span><div class="info"><strong>팀원</strong><p class="meta">서울 · 초급</p></div></div>
            </div>
            <div class="lock-msg"><strong>🔒 가입 후 확인할 수 있어요</strong><p>이 팀에 가입하면 팀원 프로필과 역할 정보를 확인할 수 있습니다.</p></div>
          </div>
        </section>
        <section class="team-section" id="posts" style="margin-top:40px">
          <h2>팀 작성글</h2><p class="section-desc">팀원에게만 공개되는 작성글입니다.</p>
          <div class="locked-wrap">
            <div class="post-grid blur" aria-hidden="true"><div class="post-card"><p class="ttl" style="margin:0">팀 작성글</p><p>일정 · 장소</p></div><div class="post-card"><p class="ttl" style="margin:0">팀 작성글</p><p>일정 · 장소</p></div></div>
            <div class="lock-msg"><strong>🔒 가입 후 확인할 수 있어요</strong><p>가입 신청 후 주장 승인이 완료되면 볼 수 있어요.</p></div>
          </div>
        </section>
      </c:otherwise>
    </c:choose>
  </div>
</main>
<c:if test="${role eq 'admin'}">
<div class="modal" id="teamDeleteModal" role="dialog" aria-modal="true"><div class="modal-card sm">
  <h2 class="modal-title">팀을 삭제할까요?</h2><p class="modal-desc">팀과 팀 작성글이 모두 삭제되며 복구할 수 없습니다.</p>
  <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-danger" data-toast="팀을 삭제했어요.">삭제</button></div></div></div>
</c:if>
<%@ include file="/jsp/common/footer.jsp" %>
