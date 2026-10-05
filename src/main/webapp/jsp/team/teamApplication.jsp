<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 가입 신청 (teamApplication.jsp) - 담당: 하준수
  피그마: Club / Application Form / Desktop
  내 프로필 정보는 회원 프로필에서 자동으로 불러오고, 가입 멘트만 입력합니다.
--%>
<c:set var="pageTitle" value="가입 신청" />
<c:set var="pageCss" value="team" />
<c:set var="activeNav" value="team" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<form class="rail" id="applyForm" action="${ctx}/team/application" method="post">
		<input type="hidden" name="teamId" value="${team.teamId}">
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><a
				href="${ctx}/team/detail/view?teamId=${team.teamId}"><c:out value="${team.teamName}" /></a><span class="sep">›</span><span>가입
				신청</span>
		</nav>
		<div class="page-head" style="padding-left: 24px">
			<h1 class="page-title">가입 신청</h1>
			<p class="page-desc">주장이 프로필과 가입 멘트를 확인한 뒤 승인합니다.</p>
		</div>
		<div style="width: 744px; max-width: 100%; margin-left: 24px">
			<section class="apply-card">
				<h2>내 프로필</h2>
				<c:choose>
				  <c:when test="${not empty sessionScope.user.profileImage}">
				    <span class="avatar"><img src="${ctx}/uploads/${sessionScope.user.profileImage}" alt=""></span>
				  </c:when>
				  <c:otherwise>
				    <span class="avatar default"></span>
				  </c:otherwise>
				</c:choose>
				<dl>
					<dt>주 활동 지역</dt>
					<dd>${regions }</dd>
					<dt>관심 종목</dt>
					<dd>${sports }</dd>
					<dt>${team.sport } 실력</dt>
					<dd>${sportSkill }</dd>
					<dt>한 줄 소개</dt>
					<dd><c:out value="${sessionScope.user.bio}" /></dd>
				</dl>
				<div class="field">
					<label class="field-label strong" for="joinMsg">가입 멘트</label>
					<textarea class="textarea" id="joinMsg" name="message"
						maxlength="200" placeholder="간단한 자기소개나 가입하고 싶은 이유를 적어주세요."
						required></textarea>
				</div>
			</section>
			<div class="form-actions">
				<a class="btn btn-outline btn-sm"
					href="${ctx}/team/detail/view?teamId=${team.teamId}" style="width: 84px">취소</a>
				<button type="submit" class="btn btn-primary btn-sm" id="applyBtn"
					style="width: 90px">가입 신청</button>
			</div>
		</div>
	</form>
	</main>
<script>
$(function () {
  var submitted = false;

  $('#applyForm').on('submit', function (e) {
    var msg = $.trim($('#joinMsg').val());

    // 공백만 입력한 경우 차단 (required는 공백을 통과시킴)
    if (!msg) {
      e.preventDefault();
      $('#joinMsg').val('').focus();
      showToast('가입 멘트를 입력해 주세요.');
      return;
    }

    // 중복 제출 방지
    if (submitted) {
      e.preventDefault();
      return;
    }
    submitted = true;
    $('#applyBtn').prop('disabled', true).text('신청 중...');
  });

  // 뒤로가기로 돌아왔을 때 버튼이 잠긴 채 남는 것 방지
  $(window).on('pageshow', function (e) {
    if (e.originalEvent.persisted) {
      submitted = false;
      $('#applyBtn').prop('disabled', false).text('가입 신청');
    }
  });
});
</script>
<%@ include file="/jsp/common/footer.jsp"%>
