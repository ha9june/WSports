<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  회원가입 (join.jsp) - 담당: 박우리
  피그마: Auth / Sign Up / Desktop, Signup / Region Search Popover
--%>
<c:set var="role" value="guest" />
<c:set var="pageTitle" value="회원가입" />
<c:set var="pageCss" value="auth" />
<c:set var="demoRoles" value="guest" />
<%@ include file="/jsp/common/header.jsp" %>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function () {
	$("#id-check").click(function(e) {
		e.preventDefault();
		if($("#loginId").val().length==0) {
			alert('아이디를 입력하세요.')
			return;
		}
		$.ajax({
			url:'${ctx}/auth/join/id-check',
			type:'post',
			dataType:'text',
			data:{loginId:$('#loginId').val()},
			success:function(result) {
				if(result=='true') {
					alert('사용중인 아이디입니다.')
				} else if(result=='false') {
					alert('사용 가능한 아이디 입니다.')
				} else {
					alert(result);
				}
			}
		})
	})
	
	$("#nickname-check").click(function(e) {
		e.preventDefault();
		if($("#nick").val().length==0) {
			alert('닉네임을 입력하세요.')
			return;
		}
		$.ajax({
			url:'${ctx}/auth/join/nickname-check',
			type:'post',
			dataType:'text',
			data:{nickname:$('#nick').val()},
			success:function(result) {
				if(result=='true') {
					alert('사용중인 닉네임입니다.')
				} else if(result=='false') {
					alert('사용 가능한 닉네임 입니다.')
				} else {
					alert(result);
				}
			}
		})
	})
})

$(function() {
	var pw = $('#pw');
	var pw2 = $('#pw2');

	$('#join-wrap').submit(function() {
		if (pw.val() != pw2.val()) {
			alert('비밀번호를 확인해주세요.');
			pw2.focus();
			return false;
		}	
		return true;
	});
});
</script>


<main class="page">
  <%-- TODO: action 을 회원가입 서블릿으로 교체 (예: ${ctx}/join) --%>
  <form class="join-wrap" id="join-wrap" action="${ctx}/auth/join" method="post">
    <nav class="breadcrumb"><span>회원</span><span class="sep">›</span><span>회원가입</span></nav>
    <div class="page-head"><h1 class="page-title">회원가입</h1><p class="page-desc">가입에 필요한 기본 정보를 입력해주세요.</p></div>

    <div class="form-grid">
      <div class="field"><label class="field-label" for="loginId">아이디</label>
        <div class="field-row"><input class="input" id="loginId" name="loginId" placeholder="영문·숫자 4~20자" required>
          <!-- <button type="button" class="btn btn-brand-outline" data-toast="사용 가능한 아이디예요.">중복 확인</button></div></div> -->
      <button type="button" name="id-check" id="id-check" class="btn btn-brand-outline">중복 확인</button></div></div>
      <div class="field"><label class="field-label" for="name">이름</label><input class="input" id="name" name="name" placeholder="이름" required></div>
      <div class="field"><label class="field-label" for="pw">비밀번호</label><input class="input" type="password" id="pw" name="password" placeholder="8자 이상 비밀번호" required></div>
      <div class="field"><label class="field-label" for="pw2">비밀번호 확인</label><input class="input" type="password" id="pw2" name="passwordConfirm" placeholder="비밀번호를 다시 입력" required></div>
      <div class="field"><label class="field-label" for="email">이메일</label><input class="input" type="email" id="email" name="email" placeholder="example@email.com" required></div>
      <div class="field"><label class="field-label" for="nick">닉네임</label>
        <div class="field-row"><input class="input" id="nick" name="nickname" placeholder="2~12자 닉네임" required>
          <button type="button" name="nickname-check" id="nickname-check" class="btn btn-brand-outline">중복 확인</button></div></div>
      <div class="field"><label class="field-label" for="birth">생년월일</label><input class="input" id="birth" name="birth" placeholder="YYYY.MM.DD" required></div>
      <div class="field"><label class="field-label" for="phone">전화번호</label><input class="input" id="phone" name="phone" placeholder="010-0000-0000" required></div>
      <div class="field full"><span class="field-label">성별</span>
        <div class="chip-group" data-select="single" data-name="gender"><button type="button" class="chip" data-value="M">남성</button><button type="button" class="chip" data-value="F">여성</button></div></div>
    </div>

    <section class="form-section">
      <p class="field-label" style="font-size:15px;color:var(--ds-text)">맞춤 설정 <span class="hint">선택 · 나중에 변경할 수 있어요</span></p>
      <div class="field mt-16"><span class="field-label">관심 종목 <span class="hint">복수 선택 가능</span></span>
        <div class="chip-group" data-select="multi" data-name="sports">
          <button type="button" class="chip is-selected">축구/풋살</button><button type="button" class="chip is-selected">농구</button>
          <button type="button" class="chip">테니스</button><button type="button" class="chip">배드민턴</button></div></div>
      <div class="field mt-24" style="width:360px"><span class="field-label">주 활동 지역 <span class="hint">복수 선택 가능 · 최대 3개</span></span>
        <div class="dropdown" style="display:block">
          <button type="button" class="select" data-dropdown-toggle style="text-align:left">지역을 검색하거나 선택하세요</button>
          <div class="dropdown-menu" style="left:0;right:auto;width:360px;padding:14px">
            <input class="input sm" placeholder="예: 마포구, 성남시">
            <div class="chip-group mt-16" data-select="multi" data-max="3" data-name="regions">
              <button type="button" class="chip chip-sm">서울 마포구</button><button type="button" class="chip chip-sm">서울 영등포구</button>
              <button type="button" class="chip chip-sm">서울 강남구</button><button type="button" class="chip chip-sm">서울 송파구</button>
              <button type="button" class="chip chip-sm">경기 성남시</button><button type="button" class="chip chip-sm">경기 고양시</button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <div class="join-foot">
      <label class="check"><input type="checkbox" name="agree" required>필수 약관에 동의합니다.</label>
      <button type="submit" id="submit" class="btn btn-primary">가입하기</button>
    </div>
  </form>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
