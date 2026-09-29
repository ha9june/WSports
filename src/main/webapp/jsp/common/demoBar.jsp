<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  [시연용] 화면 상태 전환 바
  페이지에서 지정하는 값
   - demoRoles  : 전환 가능한 권한 (콤마 구분, 기본 guest,member,admin)
   - demoStates : "상태키:표시이름|상태키:표시이름" 형식
  하나의 JSP 가 권한/상태에 따라 달라지는 화면을 발표 때 빠르게 보여주기 위한 도구입니다.
--%>
<details class="demo-bar">
  <summary title="시연용 화면 전환">시연</summary>
  <div class="panel">
    <p>권한 (role)</p>
    <div class="grp">
      <c:forTokens items="${empty demoRoles ? 'guest,member,admin' : demoRoles}" delims="," var="r">
        <a href="?role=${r}&amp;state=${state}" class="${r eq role ? 'on' : ''}">${r eq 'guest' ? '비회원' : (r eq 'admin' ? '관리자' : '회원')}</a>
      </c:forTokens>
    </div>
    <c:if test="${not empty demoStates}">
      <p>화면 상태 (state)</p>
      <div class="grp">
        <c:forTokens items="${demoStates}" delims="|" var="s">
          <c:set var="sKey" value="${fn:substringBefore(s, ':')}" />
          <a href="?role=${role}&amp;state=${sKey}" class="${sKey eq state ? 'on' : ''}">${fn:substringAfter(s, ':')}</a>
        </c:forTokens>
      </div>
    </c:if>
  </div>
</details>
