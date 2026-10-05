<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  신고 상세 (adminReportDetail.jsp) - 담당: 임태균
  피그마: Admin / Report Detail / Member · Post, Admin / Report Reject · Action / Modal
   state : member(회원 신고) | post(게시글 신고) | reject(기각 모달) | action(조치 모달)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="신고 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="report" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'member' : param.state}" />
<c:set var="isPost" value="${state eq 'post'}" />
<c:set var="demoStates" value="member:회원 신고|post:게시글 신고|reject:기각 모달|action:조치 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
	<div class="page-head">
		<h1 class="page-title">신고 상세</h1>
	</div>
	<section class="admin-card" style="width:760px;max-width:100%">
		<dl class="kv1">
			<dt>신고번호</dt><dd>${reportdetail.report_id }</dd>
    		<dt>제목</dt><dd>${reportdetail.title }</dd>
    		<dt>신고자</dt><dd>${reportdetail.name}</dd>
    		<dt>신고유형</dt><dd>${reportdetail.type }</dd>
    		<dt>조치상태</dt><dd class="${reportdetail.status eq '처리대기' ? 't-danger' : '' }">${reportdetail.status}</dd>
		</dl>	
		<hr class="divider">
		<dl class="kv1">
			<dt>신고내용</dt><dd>${reportdetail.content}</dd>
		</dl>
  	</section>
  	<div class="mt-8" style="display:flex;gap:8px;flex-shrink:0">
      	<button type="button" class="btn btn-success-outline btn-sm" data-modal-open="actionModal" style="width:70px">조치</button>
    </div>
</div>

<div class="modal ${state eq 'action' ? 'is-open' : ''}" id="actionModal" role="dialog" aria-modal="true">
	<div class="modal-card">
  		<h2 class="modal-title">신고 조치</h2>
  		<p class="modal-desc">대상에게 적용할 조치를 선택하세요. 패널티 점수는 회원 누적 점수에 반영됩니다.</p>
  		<div class="modal-body">
			<div class="field mt-16">
				<label class="field-label">처리 메모</label>
				<textarea class="textarea soft" id="answer" rows="3"></textarea>
			</div>
		</div>
  		<div class="modal-actions split">
  			<button type="button" class="btn btn-primary" id="applySanction">조치 완료</button>
  			<button type="button" class="btn btn-outline" data-modal-close>취소</button>		
  		</div>
  	</div>
</div>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function(){
	//처리완료 응답
	$("#applySanction").click(function(e){
		e.preventDefault();
		
		let reportId = '${reportdetail.report_id}';
		let answer = $("#answer").val();

		if(!answer.trim()) {
			alert('내용을 입력해주세요');
			return;
		}
		$.ajax({
			url:'${ctx}/admin/report/detail',
			type:'post',
			dataType:'text',
			data:{
				action:'status',
				reportId:reportId,
				answer:answer,
			},
			success:function(result) {
				if($.trim(result) === "true") {
					alert('응답 완료');
					location.reload();
				}else {
					alert('응답 완료 실패');
				}
			},
			error: function() {
				alert('처리 중 오류 발생');
			}
		});
	});

})
</script>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
