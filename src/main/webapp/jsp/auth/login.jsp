<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  로그인 (login.jsp) - 담당: 박우리
  피그마: Auth / Login / Desktop
   state : default | error(아이디/비밀번호 불일치)
  로그인 화면은 항상 비로그인 헤더로 보여줍니다.
--%>
<c:set var="role" value="guest" />
<c:set var="pageTitle" value="로그인" />
<c:set var="pageCss" value="auth" />
<c:set var="demoRoles" value="guest" />
<c:set var="demoStates" value="default:기본|error:로그인 실패" />
<%@ include file="/jsp/common/header.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
    window.contextPath = "${ctx}";
    console.log("JSP contextPath =", window.contextPath);
</script>
<script type="module" src="${ctx}/js/fcm-message.js"></script>

<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function () {
	$("#submit").click(function(e) {
		e.preventDefault();
		alert('아이디/비밀번호를 확인하세요.')
		return;
	})
})
</script> -->

<main class="page">
  <div class="auth-wrap">
    <div class="page-head">
      <h1 class="page-title md">로그인</h1>
      <p class="page-desc">매치온 계정으로 로그인하세요.</p>
    </div>
    <%-- TODO: action 을 로그인 서블릿으로 교체 (예: ${ctx}/login) --%>
    <form class="auth-card" action="${ctx}/auth/login" method="post" id="loginform">
      <input type="hidden" name="fcmToken" id="fcmToken">
      <div class="field"><label class="field-label" for="loginId">아이디</label>
        <input class="input" id="loginId" name="loginId" placeholder="아이디를 입력하세요" autocomplete="username" required></div>
      <div class="field"><label class="field-label" for="loginPw">비밀번호</label>
        <input class="input" type="password" id="loginPw" name="password" placeholder="비밀번호를 입력하세요" autocomplete="current-password" required></div>
      <button type="submit" id="submit" class="btn btn-primary btn-block">로그인</button>
      <div class="auth-links"><a href="#" data-toast="아이디 찾기는 준비 중이에요.">아이디 찾기</a><a href="#" data-toast="비밀번호 찾기는 준비 중이에요.">비밀번호 찾기</a></div>
      <p class="auth-join">아직 계정이 없나요?<a href="${ctx}/auth/join">회원가입</a></p>
    </form>
  </div>
  <script type="text/javascript">
	$("#loginform").submit(function(e){
		$("#fcmToken").val(fcmToken);
	})
</script>
</main>
<%@ include file="/jsp/common/footer.jsp" %>