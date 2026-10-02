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
  <div class="profile-photo">
  	<c:choose>
  		<c:when test="${not empty loginUser.profileImage }">
  			<img class="avatar lg"
  				src="${ctx}/upload/profile/${loginUser.profileImage }"
  				alt="프로필 사진">
		</c:when>
		<c:otherwise>
			<img class="avatar lg"
				src="${ctx }/img/profile-default.png"
				alt="기본 프로필 사진">
		</c:otherwise>
	</c:choose>	
 </div>
  <dl class="pf-list">
    <dt>관심 종목</dt><dd>${loginUser.preferredSport1} · ${loginUser.preferredSport2} · ${loginUser.preferredSport3}</dd>
    <dt>주 활동 지역</dt><dd>${loginUser.preferredRegion1} · ${loginUser.preferredRegion2} · ${loginUser.preferredRegion3}</dd>
  </dl>
  <h2 class="sub-title mt-32">종목별 프로필</h2>
  <dl class="pf-list" style="margin-top:14px">
    <dt>축구/풋살</dt><dd class="brand">${loginUser.soccerSkill}</dd><dt>농구</dt><dd class="brand">${loginUser.basketballSkill}</dd>
    <dt>테니스</dt><dd class="brand">${loginUser.tennisSkill}</dd><dt>배드민턴</dt><dd class="brand">${loginUser.badmintonSkill}</dd>
  </dl>
  <h2 class="sub-title mt-32">한 줄 소개</h2>
  <p class="t-12 mt-8">"${loginUser.bio}"</p>
  <div class="form-actions"><a class="btn btn-primary" href="${ctx}/jsp/mypage/myPageUpdateProfile.jsp" style="width:92px">수정</a></div>
</div>
<%@ include file="/jsp/common/footer.jsp" %>
