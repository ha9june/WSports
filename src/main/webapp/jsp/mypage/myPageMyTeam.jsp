<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  내 팀 (myPageMyTeam.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Clubs, MyPage / Activity / Club Applications,
          Overlay / My Club Card Menu (Member · Manager), Club / Leave Confirm / Modal
  ─ 하나의 JSP 로 처리 ─
   state : joined(가입한 팀) | applications(가입 신청 현황) | leave(탈퇴 확인 모달)
   카드 ⋮ 메뉴는 팀 내 역할(팀원 / 팀장·부팀장)에 따라 '팀 관리' 항목이 추가됩니다.
--%>
<c:set var="state" value="${empty param.state ? 'joined' : param.state}" />
<c:set var="pageTitle" value="내 팀" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="myTeam" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="joined:가입한 팀|applications:가입 신청|leave:탈퇴 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner" style="width:860px">
  <h1 class="section-title">내 팀</h1>
  <p class="section-desc">${state eq 'applications' ? '가입 신청 현황을 확인하고 대기 중인 신청을 취소할 수 있어요.' : '가입한 팀을 확인하고 팀별 역할에 따라 관리하세요.'}</p>
  <div class="seg pill neutral" style="margin-bottom:24px">
    <a class="seg-item ${state ne 'applications' ? 'is-active' : ''}" href="?state=joined">가입한 팀</a>
    <a class="seg-item ${state eq 'applications' ? 'is-active' : ''}" href="?state=applications">가입 신청</a>
  </div>

  <c:choose>
    <c:when test="${state eq 'applications'}">
      <h2 class="sub-title" style="font-size:14px;margin-bottom:14px">가입 신청 현황</h2>
      <%-- TODO: <c:forEach var="a" items="${applicationList}"> --%>
      <div class="myteam-grid">
        <div class="myteam-card">
          <img src="${ctx}/img/team-badminton.png" alt="">
          <div class="main"><strong>한강 배드민턴 클럽</strong><p class="meta">배드민턴 · 가입 신청</p>
            <p class="sub"><span><img src="${ctx}/img/icon-user-12.svg" alt="">신청일</span><span><img src="${ctx}/img/icon-pin-12.svg" alt="">9/11</span></p></div>
          <div class="aside"><span class="t-11 t-2">승인 대기</span><button type="button" class="btn btn-outline btn-xs" data-modal-open="cancelApplyModal">신청 취소</button></div>
        </div>
      </div>
    </c:when>
    <c:otherwise>
      <%-- TODO: <c:forEach var="t" items="${myTeamList}">  t.myRole 이 LEADER/VICE 면 팀 관리 메뉴 노출 --%>
      <div class="myteam-grid">
        <div class="myteam-card" data-href="${ctx}/jsp/team/teamDetail.jsp?state=member">
          <img src="${ctx}/img/team-football.png" alt="">
          <div class="main"><strong>마포 풋살 크루</strong><p class="meta">풋살 · 서울 마포</p>
            <p class="sub"><span><img src="${ctx}/img/icon-user-12.svg" alt="">24명</span><span><img src="${ctx}/img/icon-pin-12.svg" alt="">마포구</span></p></div>
          <div class="aside"><span class="pill pill-neutral">팀원</span>
            <div class="dropdown"><button type="button" class="icon-btn" data-dropdown-toggle aria-label="팀 메뉴">⋮</button>
              <div class="dropdown-menu">
                <a href="${ctx}/jsp/team/teamInfoMembers.jsp">팀원 보기</a>
                <a href="${ctx}/jsp/team/teamInfoPosts.jsp">팀 작성글 보기</a><hr>
                <button type="button" class="danger" data-modal-open="leaveModal">탈퇴하기</button>
              </div></div></div>
        </div>
        <div class="myteam-card" data-href="${ctx}/jsp/team/teamDetail.jsp?state=manager">
          <img src="${ctx}/img/team-basketball.png" alt="">
          <div class="main"><strong>성동 농구 모임</strong><p class="meta">농구 · 서울 성동</p>
            <p class="sub"><span><img src="${ctx}/img/icon-user-12.svg" alt="">18명</span><span><img src="${ctx}/img/icon-pin-12.svg" alt="">성동구</span></p></div>
          <div class="aside"><span class="pill pill-neutral">부팀장</span>
            <div class="dropdown"><button type="button" class="icon-btn" data-dropdown-toggle aria-label="팀 메뉴">⋮</button>
              <div class="dropdown-menu">
                <a href="${ctx}/jsp/team/teamInfoMembers.jsp">팀원 보기</a>
                <a href="${ctx}/jsp/team/teamInfoPosts.jsp">팀 작성글 보기</a>
                <a href="${ctx}/jsp/team/teamManageApplication.jsp">팀 관리</a><hr>
                <button type="button" class="danger" data-modal-open="leaveModal">탈퇴하기</button>
              </div></div></div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</main></div>

<div class="modal ${state eq 'leave' ? 'is-open' : ''}" id="leaveModal" role="dialog" aria-modal="true">
  <div class="modal-card">
    <h2 class="modal-title">팀에서 탈퇴할까요?</h2>
    <p class="modal-desc">탈퇴 후에는 팀 경기 신청과 팀원 전용 기능을 이용할 수 없습니다. 다시 활동하려면 가입 신청을 다시 해야 해요.</p>
    <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>닫기</button><button type="button" class="btn btn-danger" data-toast="팀에서 탈퇴했어요.">탈퇴</button></div>
  </div>
</div>
<div class="modal" id="cancelApplyModal" role="dialog" aria-modal="true">
  <div class="modal-card">
    <h2 class="modal-title">가입 신청을 취소할까요?</h2>
    <p class="modal-desc">취소한 신청은 되돌릴 수 없어요. 다시 가입하려면 새로 신청해야 합니다.</p>
    <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>닫기</button><button type="button" class="btn btn-danger" data-toast="가입 신청을 취소했어요.">신청 취소</button></div>
  </div>
</div>
<%@ include file="/jsp/common/footer.jsp" %>
