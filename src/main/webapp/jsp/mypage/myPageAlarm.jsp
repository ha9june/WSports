<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  알림 (myPageAlarm.jsp) - 담당: 강신우
  피그마: MyPage / Notifications / Desktop
  미확인 알림을 누르면 읽음 처리 후 관련 화면으로 이동합니다.
--%>
<c:set var="pageTitle" value="알림" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="alarm" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner" style="width:860px">
  <div class="page-head row" style="margin-bottom:0">
    <div><h1 class="page-title">알림</h1><p class="page-desc">중요한 활동 소식만 빠르게 확인하세요.</p></div>
    <button type="button" class="btn btn-outline btn-sm" data-toast="모든 알림을 읽음 처리했어요.">모두 읽음</button>
  </div>
  <%-- TODO: <c:forEach var="n" items="${alarmList}"> 읽음 여부(n.readYn)로 그룹 분리 --%>
  <section class="noti-group">
    <h2>미확인</h2>
    <a class="noti-item unread" href="${ctx}/jsp/match/personalMatchDetail.jsp?state=applied"><strong>참가가 확정되었습니다.</strong><p>토요일 저녁 풋살 한 판! · 결제가 완료되어 참가가 확정됐어요.</p><time>10:24</time></a>
    <a class="noti-item unread" href="${ctx}/jsp/match/personalMatchDetail.jsp?state=closed"><strong>경기 모집이 마감되었습니다.</strong><p>주말 실내 농구 같이 하실 분 · 모집 인원이 모두 찼어요.</p><time>09:12</time></a>
  </section>
  <section class="noti-group" style="margin-top:28px">
    <h2>확인</h2>
    <a class="noti-item" href="${ctx}/jsp/match/personalMatchAfterMatchEdit.jsp?state=participant"><strong>참가자 평가를 남겨주세요.</strong><p>지난 경기에 함께한 참가자를 평가할 수 있어요.</p><time>9/11</time></a>
    <a class="noti-item" href="${ctx}/jsp/team/teamDetail.jsp?state=member"><strong>팀 가입 신청이 승인되었습니다.</strong><p>마포 풋살 크루에 가입되었어요.</p><time>9/10</time></a>
    <a class="noti-item" href="${ctx}/jsp/support/noticeDetail.jsp"><strong>서비스 이용 안내</strong><p>서비스 이용 정책이 업데이트되었습니다.</p><time>9/08</time></a>
  </section>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
