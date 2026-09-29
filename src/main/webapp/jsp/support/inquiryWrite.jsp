<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  문의하기 (inquiryWrite.jsp) - 담당: 박우리
  피그마: Inquiry / Form / Desktop
--%>
<c:set var="pageTitle" value="문의하기" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="support" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<%-- TODO: action 을 문의 등록 서블릿으로 교체 --%>
<form class="work-inner" action="${ctx}/jsp/support/inquiryList.jsp" method="post" style="width:860px">
  <div class="page-head" style="margin-bottom:24px"><h1 class="page-title">문의하기</h1><p class="page-desc">서비스 이용 중 궁금한 점이나 오류를 남겨주세요. 확인 후 답변해드릴게요.</p></div>
  <div class="form-card" style="width:780px;max-width:100%">
    <div class="field"><label class="field-label" for="qType">문의 유형</label>
      <select class="select" id="qType" name="inquiryType"><option>결제 관련 문의</option><option>경기·참가 문의</option><option>팀 문의</option><option>오류 신고</option><option>기타</option></select></div>
    <div class="field"><label class="field-label" for="qTitle">문의 제목</label><input class="input" id="qTitle" name="title" placeholder="문의 제목을 입력해주세요." required></div>
    <div class="field"><label class="field-label" for="qBody">문의 내용</label>
      <textarea class="textarea" id="qBody" name="content" rows="8" placeholder="궁금한 점이나 발생한 오류 상황을 자세히 입력해주세요.&#10;오류 문의라면 어떤 화면에서 어떤 행동을 했는지도 함께 적어주세요." required></textarea></div>
    <p class="notice-box">에러 문의 시 발생 시간과 화면, 재현 방법을 함께 적어주시면 더 빠르게 확인할 수 있어요.</p>
  </div>
  <div class="form-actions" style="width:780px;max-width:100%">
    <a class="btn btn-outline" href="${ctx}/jsp/support/inquiryList.jsp">취소</a>
    <button type="submit" class="btn btn-primary">문의 등록</button>
  </div>
</form>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
