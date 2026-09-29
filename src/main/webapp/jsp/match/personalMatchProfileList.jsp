<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  참가자 프로필 목록 (personalMatchProfileList.jsp) - 담당: 변재언
  피그마: Participants / Profile / Desktop
  경기 참가자(신청 완료자)와 작성자만 볼 수 있는 화면입니다.
--%>
<c:set var="pageTitle" value="참가자 프로필" />
<c:set var="pageCss" value="match" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>

<main class="page">
  <div class="container">
    <nav class="breadcrumb"><a href="${ctx}/jsp/mypage/myPagePersonalMatch.jsp">내 경기</a><span class="sep">›</span><span>참가자 프로필</span></nav>
    <div class="page-head">
      <h1 class="page-title">참가자 프로필</h1>
      <p class="page-desc">토요일 저녁 풋살 한 판! · 현재 8명 / 정원 10명 · 최소 8명</p>
    </div>

    <h2 class="section-title">토요일 저녁 풋살 한 판!</h2>
    <p class="t-11 t-brand" style="margin:6px 0 24px">참가자 8명 / 정원 10명</p>

    <%-- TODO: <c:forEach var="p" items="${participantList}"> --%>
    <div class="people-grid">
      <a class="person-row" href="${ctx}/jsp/member/userProfileInfo.jsp"><span class="avatar sm default"></span><strong>풋살초보</strong><span class="lv">중급</span><span class="rating">4.6</span></a>
      <a class="person-row" href="${ctx}/jsp/member/userProfileInfo.jsp"><span class="avatar sm default"></span><strong>마포킥커</strong><span class="lv">초급</span><span class="rating">4.5</span></a>
      <a class="person-row" href="${ctx}/jsp/member/userProfileInfo.jsp"><span class="avatar sm default"></span><strong>주말러너</strong><span class="lv">중급</span><span class="rating">4.6</span></a>
      <a class="person-row" href="${ctx}/jsp/member/userProfileInfo.jsp"><span class="avatar sm default"></span><strong>수비장인</strong><span class="lv">상급</span><span class="rating">4.9</span></a>
      <a class="person-row" href="${ctx}/jsp/member/userProfileInfo.jsp"><span class="avatar sm default"></span><strong>골키퍼K</strong><span class="lv">중급</span><span class="rating">4.9</span></a>
      <a class="person-row" href="${ctx}/jsp/member/userProfileInfo.jsp"><span class="avatar sm default"></span><strong>유나이티드7</strong><span class="lv">중급</span><span class="rating">4.7</span></a>
      <a class="person-row" href="${ctx}/jsp/member/userProfileInfo.jsp"><span class="avatar sm default"></span><strong>MF88</strong><span class="lv">중급</span><span class="rating">4.7</span></a>
      <a class="person-row" href="${ctx}/jsp/member/userProfileInfo.jsp"><span class="avatar sm default"></span><strong>FC마포</strong><span class="lv">초급</span><span class="rating">4.4</span></a>
    </div>

    <div class="form-actions"><a class="btn btn-outline btn-sm" href="${ctx}/jsp/mypage/myPagePersonalMatch.jsp">내 경기로 돌아가기</a></div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
