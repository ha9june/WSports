<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--
  신고 목록 (reportList.jsp) - 담당: 박우리
  피그마: Reports / List / Desktop  (신고 / 문의사항 탭으로 reportList ↔ inquiryList 이동)
  TODO: <c:forEach var="r" items="${list}">, 상태 필터는 ?status=
--%>
<c:set var="pageTitle" value="신고・문의사항" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="support" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner" style="width:860px">
  <h1 class="section-title">신고・문의사항</h1>
  <p class="section-desc">신고 접수 내역과 문의사항을 한 곳에서 확인합니다.</p>
  <div class="seg" style="margin-bottom:12px">
    <a class="seg-item is-active" href="${ctx}/support/report/list">신고</a>
    <a class="seg-item " href="${ctx}/support/inquiry/list">문의사항</a>
  </div>
  <c:set var="status" value="${empty param.status ? 'ALL' : param.status}" />
  <div class="seg pill neutral" style="margin-bottom:32px">
  <a class="seg-item ${status eq 'ALL' ? 'is-active' : ''}" href="?status=ALL">전체</a>
  <a class="seg-item ${status eq 'WAIT' ? 'is-active' : ''}" href="?status=WAIT">접수</a>
  <a class="seg-item ${status eq 'DONE' ? 'is-active' : ''}" href="?status=DONE">처리 완료</a></div>
  
  <div class="row-list">
    <c:forEach var="r" items="${reportList}"> 
    <a class="row-card" href="${ctx}/jsp/support/reportDetail.jsp?reportId=${r.report_id}" style="padding:18px 24px">
    <div><p class="title"><c:out value="${r.title}"/></p>
    <p class="meta"><c:out value="${r.type}"/> · <c:out value="${r.created_at}"/></p></div>
    <span class="status">
   		 <c:choose>
          <c:when test="${r.status eq '처리완료'}"><span class="pill pill-neutral">처리 완료</span></c:when>
          <c:otherwise><span class="pill pill-brand">접수</span></c:otherwise>
         </c:choose>
    </span>
    </a>
    </c:forEach>
    <c:if test="${empty reportList}">
      <p class="meta" style="text-align:center;padding:40px 0">신고 내역이 없습니다.</p>
    </c:if>
  </div>
		<nav class="pagination" style="display: flex; justify-content:center; padding:0px">
			<a href="${pageInfo.curPage > 1 ? ctx += '/support/report/list?status=' += status += '&page=' += (pageInfo.curPage - 1) : '#'}">&lt;</a>
			<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="page">
				<a href="${ctx}/support/report/list?status=${status}&amp;page=${page}" class="${pageInfo.curPage eq page ? 'is-active' : ''}">${page}</a>
			</c:forEach>
			<a href="${pageInfo.curPage < pageInfo.allPage ? ctx += '/support/report/list?status=' += status +=  '&page=' += (pageInfo.curPage + 1) : '#'}">&gt;</a>
		</nav>
</div>
</main></div>
<a class="fab" href="${ctx}/support/report/create"><span class="fab-label">신고 접수</span><span class="fab-btn" aria-hidden="true"></span></a>
<%@ include file="/jsp/common/footer.jsp" %>
