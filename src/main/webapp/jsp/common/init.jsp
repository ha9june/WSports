<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  ============================================================
  공통 초기화 (모든 페이지 최상단에서 include)
  - ctx   : 컨텍스트 경로
  - role  : guest | member | admin  (화면 권한)
  - state : 페이지별 화면 상태 (각 페이지에서 기본값 지정)

  [시연용] ?role=admin&state=applied 처럼 파라미터로 화면을 바꿀 수 있습니다.
           한 번 지정한 role 은 세션(demoRole)에 저장되어 다른 페이지로 이동해도 유지됩니다.
  [실구현] 로그인 서블릿에서 session.setAttribute("loginUser", memberDTO) 로 저장하면
           아래 두 번째 분기에서 loginUser.role 기준으로 권한이 결정됩니다.
           (DTO 에 getRole() 이 'ADMIN' / 'USER' 를 반환한다고 가정)
  ============================================================
--%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />	
<%-- 공통 하트 아이콘 (찜 버튼) : ${heart} 로 출력 --%>
<c:set var="heart"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 20.5s-7.5-4.6-9.6-9C.9 8.3 2.8 4.5 6.5 4.5c2.3 0 3.8 1.3 5.5 3.2 1.7-1.9 3.2-3.2 5.5-3.2 3.7 0 5.6 3.8 4.1 7-2.1 4.4-9.6 9-9.6 9z"/></svg></c:set>
