<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  공지사항 관리 (adminNotice.jsp) - 담당: 임태균
  피그마: Admin / Notices / Desktop, Admin / Notice Delete / Modal
   state : default | deleteModal(삭제 확인 모달)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="공지사항 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="notice" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'default' : param.state}" />
<c:set var="demoStates" value="default:기본|deleteModal:삭제 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="admin-inner">
	<p class="eyebrow-path">관리자(사이트)</p>
	<div class="page-head">
		<h1 class="page-title">공지사항 관리</h1>
		<p class="page-desc">사용자에게 노출되는 공지사항을 작성하고 관리합니다.</p>
	</div>
	<!-- 주소에 있는 status 값을 꺼내 status에 담음, 값이 없으면 ALL을 대신 넣음 -->
	<c:set var="status" value="${empty param.status ? 'ALL' : param.status}" />
	<form class="list-toolbar" method="get" style="flex-direction: column; align-items: flex-start; gap: 20px; margin-bottom: 24px">
		<div style="width:860px;max-width:100%">
    		<nav class="tabs big">
    			<a class="tab ${status eq 'ALL' ? 'is-active' : ''}" href="?status=ALL">전체</a>
    			<a class="tab ${status eq 'PIN' ? 'is-active' : ''}" href="?status=PIN">핀</a>
    			<a class="tab ${status eq 'NOPIN' ? 'is-active' : ''}" href="?status=NOPIN">핀 아님</a>
    		</nav>
    	</div>
    </form>
	<div style="width:fit-content; max-width:100%">
		<div class="tbl-head" style="grid-template-columns:70px 100px 70px 100px 200px 110px 130px;
    	justify-self: start; justify-items: center; padding-left: 0px">
    		<span>공지번호</span>
    		<span>공지날짜</span>
    		<span>공지유형</span>
    		<span>공지작성자</span>
    		<span>공지제목</span>
    		<span>핀 여부</span>
    		<span>수정,삭제</span>
    	</div>
		<c:forEach var="n" items="${noticelist}">
			<div class="tbl-row" id="notice-${n.notice_id}" style="grid-template-columns: 70px 100px 70px 100px 200px 110px 130px; 
			justify-items: center; align-items: center; padding-left: 0px">
    			<span>${n.notice_id }</span>
    			<b><fmt:formatDate value="${n.created_at}" pattern="yyyy/MM/dd" /></b>
    			<span>${n.type }</span>
    			<span>${n.nickname}</span>
    			<span>${n.title }</span>
   				<%-- 핀 고정 / 해제 --%>
				<button type="button" class="pill pin-btn ${n.is_pinned ? 'pill-success' : 'pill-neutral'}"
		        data-id="${n.notice_id}" style="cursor: pointer; font-family: inherit">
				📌 ${n.is_pinned ? '상단 고정' : '고정 안 함'}
				</button>

				<%-- 수정(상세) / 삭제 --%>
				<div style="display:flex; gap:6px ">
					<a class="btn btn-outline btn-xs" href="${ctx}/admin/notice/modify?noticeId=${n.notice_id}">수정</a>
					<button type="button" class="btn btn-danger btn-xs delete-btn" data-id="${n.notice_id}">삭제</button>
				</div>
			</div>
    	</c:forEach>
   		<nav class="pagination" style="display: flex; justify-content:center; padding:0px">
			<a href="${pageInfo.curPage > 1 ? ctx += '/admin/notice?status=' += status += '&page=' += (pageInfo.curPage - 1) : '#'}">&lt;</a>
			<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="page">
				<a href="${ctx}/admin/notice?status=${status}&amp;page=${page}" class="${pageInfo.curPage eq page ? 'is-active' : ''}">${page}</a>
			</c:forEach>
			<a href="${pageInfo.curPage < pageInfo.allPage ? ctx += '/admin/notice?status=' += status +=  '&page=' += (pageInfo.curPage + 1) : '#'}">&gt;</a>
		</nav>
	</div>
</div>

<a class="fab" href="${ctx}/admin/notice/write">
	<span class="fab-label">공지 작성</span>
	<span class="fab-btn" aria-hidden="true"></span>
</a>
<div class="modal ${state eq 'deleteModal' ? 'is-open' : ''}" id="noticeDeleteModal" role="dialog" aria-modal="true">
	<div class="modal-card sm">
  		<h2 class="modal-title">공지사항을 삭제할까요?</h2>
  		<p class="modal-desc">삭제한 공지는 사용자 화면에서 바로 사라지며 복구할 수 없습니다.</p>
  		<div class="modal-actions">
  			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
  			<button type="button" class="btn btn-danger" data-toast="공지사항을 삭제했어요.">삭제</button>
  		</div>
  	</div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function () {
	// 핀 고정  해제
	$(".pin-btn").click(function () {
		let btn = $(this);
		let noticeId = btn.data("id");

		$.ajax({
			url: '${ctx}/admin/notice',
			type: 'post',
			dataType: 'text',
			data: { action: 'pin', noticeId: noticeId },
			success: function (result) {
				if ($.trim(result) === "true") {
					// 버튼 모양만 반대로 바꾸기
					let pinned = btn.hasClass("pill-success");
					btn.toggleClass("pill-success", !pinned)
					   .toggleClass("pill-neutral", pinned)
					   .text(pinned ? '📌 고정 안 함' : '📌 상단 고정');
				} else {
					alert('핀 변경에 실패했습니다.');
				}
			},
			error: function () {
				alert('처리 중 오류가 발생했습니다.');
			}
		});
	});

	// 삭제
	$(".delete-btn").click(function () {
		let noticeId = $(this).data("id");
		if (!confirm('이 공지를 삭제할까요?')) return;

		$.ajax({
			url: '${ctx}/admin/notice',
			type: 'post',
			dataType: 'text',
			data: { action: 'delete', noticeId: noticeId },
			success: function (result) {
				if ($.trim(result) === "true") {
					$("#notice-" + noticeId).remove();
				} else {
					alert('삭제에 실패했습니다.');
				}
			},
			error: function () {
				alert('처리 중 오류가 발생했습니다.');
			}
		});
	});
});
</script>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
