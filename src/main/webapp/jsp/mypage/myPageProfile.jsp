<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  내 프로필 (myPageProfile.jsp) - 담당: 박우리
  피그마: MyPage / Profile / Desktop
--%>
<c:set var="pageTitle" value="내 프로필" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="profile" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner" style="padding-left:24px">
  <h1 class="sub-title">프로필 사진</h1>
  <p class="section-desc">현재 프로필 사진입니다.</p>
  <div class="profile-photo"><span class="avatar lg default"></span></div>
  <dl class="pf-list">
    <dt>관심 종목</dt><dd>축구/풋살 · 농구</dd>
    <dt>주 활동 지역</dt><dd>서울 마포구 · 서울 영등포구 · 서울 강남구</dd>
  </dl>
  <h2 class="sub-title mt-32">종목별 프로필</h2>
  <dl class="pf-list" style="margin-top:14px">
    <dt>축구/풋살</dt><dd class="brand">초급</dd><dt>농구</dt><dd class="brand">중급</dd>
    <dt>테니스</dt><dd class="brand">입문</dd><dt>배드민턴</dt><dd class="brand">초급</dd>
  </dl>
  <h2 class="sub-title mt-32">한 줄 소개</h2>
  <p class="t-12 mt-8">즐겁게 운동하고 좋은 사람들과 꾸준히 함께하고 싶어요.</p>
  <div class="form-actions"><a class="btn btn-primary" href="${ctx}/jsp/mypage/myPageUpdateProfile.jsp" style="width:92px">수정</a></div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
