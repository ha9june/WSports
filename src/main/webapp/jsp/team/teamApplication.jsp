<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀 가입 신청 (teamApplication.jsp) - 담당: 하준수
  피그마: Club / Application Form / Desktop
  내 프로필 정보는 회원 프로필에서 자동으로 불러오고, 가입 멘트만 입력합니다.
--%>
<c:set var="pageTitle" value="가입 신청" />
<c:set var="pageCss" value="team" />
<c:set var="activeNav" value="team" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <%-- TODO: action 을 가입 신청 서블릿으로 교체 (teamNo hidden 전달) --%>
  <form class="rail" action="${ctx}/jsp/mypage/myPageMyTeam.jsp?state=applications" method="post">
    <input type="hidden" name="teamNo" value="${param.teamNo}">
    <nav class="breadcrumb"><a href="${ctx}/jsp/team/teamList.jsp">팀</a><span class="sep">›</span><a href="${ctx}/jsp/team/teamDetail.jsp">서울 풋살 크루</a><span class="sep">›</span><span>가입 신청</span></nav>
    <div class="page-head" style="padding-left:24px"><h1 class="page-title">가입 신청</h1><p class="page-desc">주장이 프로필과 가입 멘트를 확인한 뒤 승인합니다.</p></div>
    <div style="width:744px;max-width:100%;margin-left:24px">
      <section class="apply-card">
        <h2>내 프로필</h2><span class="avatar default"></span>
        <dl><dt>주 활동 지역</dt><dd>서울 마포구 · 서울 영등포구 · 서울 강남구</dd><dt>관심 종목</dt><dd>축구/풋살 · 농구</dd><dt>축구/풋살 실력</dt><dd>초급</dd><dt>한 줄 소개</dt><dd>즐겁게 운동하고 좋은 사람들과 꾸준히 함께하고 싶어요.</dd></dl>
        <div class="field"><label class="field-label strong" for="joinMsg">가입 멘트</label>
          <textarea class="textarea" id="joinMsg" name="message" maxlength="200" placeholder="간단한 자기소개나 가입하고 싶은 이유를 적어주세요." required></textarea></div>
      </section>
      <div class="btn-group mt-32"><a class="btn btn-outline btn-sm" href="${ctx}/jsp/team/teamDetail.jsp" style="width:84px">취소</a><button type="submit" class="btn btn-primary btn-sm" style="width:104px">가입 신청</button></div>
    </div>
  </form>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
