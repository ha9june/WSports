<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  공통 오류 화면 (error.jsp)
  서블릿 catch / 업무 오류에서 메시지만 넘기면 됩니다.
     request.setAttribute("errorMsg", "존재하지 않는 경기입니다.");
     request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
  - errorMsg 가 없으면(주소로 직접 접근 등) 기본 문구가 나옵니다.
  - 예외 메시지·스택트레이스는 화면에 출력하지 않습니다. (서버 로그에만 남기세요)
--%>
<c:set var="msg" value="${empty requestScope.error ? '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.' : requestScope.error}" />
<c:set var="pageTitle" value="오류" />
<c:set var="pageCss" value="error" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="error-box">
    <div class="icon">!</div>
    <h1>문제가 발생했어요</h1>
    <%-- 사용자 입력이 섞인 메시지일 수 있으므로 반드시 c:out 으로 출력 (XSS 방지) --%>
    <p class="msg"><c:out value="${msg}" /></p>
    <div class="btn-group"><a class="btn btn-primary" href="${ctx}/home/main">메인으로</a></div>
  </div>
</main>
<script src="${ctx}/js/common.js"></script>
</body>
</html>
