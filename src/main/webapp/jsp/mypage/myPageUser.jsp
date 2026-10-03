<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  내 정보 (myPageUser.jsp) - 담당: 박우리
  피그마: MyPage / Info (조회)
  TODO: 값은 ${loginUser.xxx} 로 교체
--%>
<c:set var="pageTitle" value="내 정보" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="user" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<form class="work-inner" action="${ctx}/member/mypage/view" method="post" style="padding-left:24px">
  <h1 class="section-title">회원정보</h1>
  <p class="section-desc">회원정보와 정산 계좌를 확인할 수 있습니다.</p>
  <div class="form-grid">
    <div class="field full"><label class="field-label">아이디</label><input class="input" value="${loginUser.loginId}" readonly></div>
    <div class="field"><label class="field-label">이름</label><input class="input" name="name" value="${loginUser.name}" readonly></div>
    <div class="field"><label class="field-label">닉네임</label><input class="input" name="nickname" value="${loginUser.nickname}" readonly></div>
    <div class="field"><label class="field-label">이메일</label><input class="input" name="email" value="${loginUser.email}" readonly></div>
    <div class="field"><label class="field-label">전화번호</label><input class="input" name="phone" value="${loginUser.phone}" readonly></div>
    <div class="field"><label class="field-label">생년월일</label><input class="input" name="birth" value="${loginUser.birthDate}" readonly></div>
    <div class="field"><label class="field-label">성별</label><input class="input" value="${loginUser.gender}" readonly></div>
  </div>

  <h2 class="section-title mt-32">정산 계좌</h2>
  <p class="section-desc">정산·환불 받을 본인 명의 계좌를 등록해주세요.</p>
  <div class="acct-row" style="grid-template-columns:167px 360px 167px">
    <div class="field"><label class="field-label">은행</label>
      <input class="input" value="${loginUser.bankName}" readonly></div>
    <div class="field"><label class="field-label">계좌번호</label><input class="input" name="accountNo" value="${loginUser.accountNumber}" readonly></div>
    <div class="field"><label class="field-label">예금주</label><input class="input" name="accountHolder" value="${loginUser.accountHolder}" readonly></div>
  </div>
  <p class="field-help mt-16">정산이 필요한 기능을 이용하기 전까지는 등록하지 않아도 됩니다.</p>
  <div class="form-actions" style="margin-top:16px">
    <a class="btn btn-primary" href="${ctx}/member/mypage/edit" style="width:92px">수정</a>
  </div>

  <section class="security">
    <h2 class="sub-title">보안 및 계정</h2>
    <div class="line"><b>비밀번호</b><span>최근 변경일을 확인하고 필요할 때 변경합니다.</span><button type="button" class="btn btn-outline btn-sm" data-modal-open="pwModal">비밀번호 변경</button></div>
    <div class="line"><b class="danger">회원 탈퇴</b><span>탈퇴 전 주의사항을 확인한 뒤 진행합니다.</span><button type="button" class="btn-text danger t-12" data-modal-open="withdrawModal">탈퇴하기</button></div>
  </section>
</form>
</main></div>

<div class="modal" id="pwModal" role="dialog" aria-modal="true">
  <div class="modal-card md">
    <h2 class="modal-title">비밀번호 변경</h2>
    <div class="modal-body">
      <div class="field"><label class="field-label">현재 비밀번호</label><input class="input" type="password"></div>
      <div class="field mt-16"><label class="field-label">새 비밀번호</label><input class="input" type="password" placeholder="8자 이상"></div>
      <div class="field mt-16"><label class="field-label">새 비밀번호 확인</label><input class="input" type="password"></div>
    </div>
    <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-primary" data-toast="비밀번호를 변경했어요.">변경</button></div>
  </div>
</div>
<div class="modal" id="withdrawModal" role="dialog" aria-modal="true">
  <div class="modal-card">
    <h2 class="modal-title">정말 탈퇴할까요?</h2>
    <p class="modal-desc">탈퇴하면 참가·작성한 경기와 팀 정보를 더 이상 확인할 수 없습니다. 정산 대기 금액이 있으면 탈퇴할 수 없어요.</p>
    <form action="${ctx}/member/withdraw" method="post">
    	<div class="modal-actions">
    		<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
    		<button type="button" class="btn btn-danger">탈퇴</button>
    	</div>
    </form>
  </div>
</div>
<%@ include file="/jsp/common/footer.jsp" %>
