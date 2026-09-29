<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  패널티 점수 팀 관리 (adminTeam.jsp) - 담당: 임태균
  피그마: Admin / Clubs / Desktop
  TODO: <c:forEach var="t" items="${penaltyTeamList}">
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="패널티 점수 팀 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="team" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  <p class="eyebrow-path">관리자(사이트)</p>
  <div class="page-head"><h1 class="page-title">패널티 점수 팀 관리</h1><p class="page-desc">패널티 점수가 있는 팀만 확인하고 제재 상태를 관리합니다.</p></div>
  <div class="kpi-grid three"><div class="kpi"><p>패널티 점수 보유</p><b>9개</b></div><div class="kpi"><p>5점 이상</p><b>4개</b></div><div class="kpi"><p>활동 제한</p><b>2개</b></div></div>
  <form class="list-toolbar" method="get" style="margin:24px 0 16px">
    <input class="input sm" name="keyword" placeholder="팀명 / 주장 검색" style="width:280px">
    <div class="seg pill success"><a class="seg-item is-active" href="?">전체 패널티 팀</a><a class="seg-item" href="?min=5">5점 이상</a><a class="seg-item" href="?status=LIMITED">활동 제한</a></div>
  </form>
  <div style="width:940px;max-width:100%">
    <div class="tbl-head" style="grid-template-columns:1.4fr 1fr 70px 80px 100px 1.4fr 70px"><span>팀</span><span>주장</span><span>팀원</span><span>패널티 점수</span><span>상태</span><span>최근 사유</span><span>상세</span></div>
    <div class="tbl-body">
      <div class="tbl-row" style="grid-template-columns:1.4fr 1fr 70px 80px 100px 1.4fr 70px"><b>서울 풋살 크루</b><span>풋살초보</span><span>34명</span><b>2점</b><span class="pill pill-neutral">주의</span><span>경기 당일 취소</span><a class="btn btn-outline btn-xs t-brand" href="${ctx}/jsp/admin/adminTeamDetail.jsp">상세</a></div>
      <div class="tbl-row" style="grid-template-columns:1.4fr 1fr 70px 80px 100px 1.4fr 70px"><b>주말 바스켓</b><span>운동하자</span><span>22명</span><b class="t-warning">5점</b><span class="pill pill-warning">경고</span><span>상대팀 신고 인정</span><a class="btn btn-outline btn-xs t-brand" href="${ctx}/jsp/admin/adminTeamDetail.jsp">상세</a></div>
      <div class="tbl-row" style="grid-template-columns:1.4fr 1fr 70px 80px 100px 1.4fr 70px"><b>셔틀콕 데이</b><span>콕마스터</span><span>26명</span><b class="t-danger">12점</b><span class="pill pill-danger">활동 제한</span><span>누적 패널티 점수 초과</span><a class="btn btn-outline btn-xs t-brand" href="${ctx}/jsp/admin/adminTeamDetail.jsp">상세</a></div>
    </div>
  </div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
