<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="회원 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="member" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>

<div class="admin-inner">
	<div style="width:760px;max-width:100%">
    <section class="admin-card">
    	<c:set var="info" value="${detail[0]}" />	
    	<div style="display:flex; align-items:center; gap:12px; margin-bottom:20px">
    		<span class="avatar default"></span>
    		<strong style="font-size:18px">${info.login_id}</strong>
    	</div>
    	
    	<dl class="kv1">
        	<dt>닉네임</dt><dd>${info.nickname}</dd>
        	<dt>이메일</dt><dd>${info.email}</dd>
        	<dt>상태</dt>	<dd class="${info.suspend ? 't-danger' : ''}">${info.suspended ? '정지' : '정상'}</dd>
        	<dt>패널티 점수</dt><dd>${empty info.score ? 0 : info.score}점</dd>
        	<c:if test="${not empty info.withdrawal_at }">
        		<dt>탈퇴일시</dt><dd>${info.withdrawal_at}</dd>
        	</c:if>
        	<dt>영구정지 여부</dt>
        	<dd>${info.permanent_suspension ? 'O' : 'X' }</dd>
      	</dl>
      	<h3 class="t-13 t-bold mt-32">페널티 이력</h3>
      	<c:forEach var="h" items="${detail}">
      		<c:if test="${not empty h.penalty_id }">
      			<div class="history-row">
      				<span>${h.received_at}</span>
      				<span>${h.reason}</span>
      				<b class="plus">${h.score }점</b>
      			</div>
      		</c:if>
      	</c:forEach>
      	<c:if test="${empty info.penalty_id}">
			<p class="t-12 mt-8 t-2">페널티 이력이 없습니다.</p>
		</c:if>
		
		<h3 class="t-13 t-bold mt-32">정지 이력</h3>
		<c:set var="s" value="false" />
		<c:forEach var="h" items="${detail}">
			<c:if test="${not empty h.suspension_start_at}">
				<c:set var="s" value="true" />
				<p class="t-12 mt-8" style="line-height:1.8">${h.suspension_start_at} ~ ${h.suspension_end_at}	
				</p>
			</c:if>
		</c:forEach>
		<c:if test="${not s}">
			<p class="t-12 mt-8 t-2">정지 이력이 없습니다.</p>
		</c:if>
		</section>
		<div class="mt-8" style="display:flex;gap:8px;flex-shrink:0">
			<button type="button" class="btn btn-success-outline btn-sm" data-modal-open="sanctionModal">제재 변경</button>
			<button type="button" class="btn btn-success-outline btn-sm" data-modal-open="permanentStop">영구 정지</button>
		</div>
  </div>
</div>

<div class="modal" id="sanctionModal" role="dialog" aria-modal="true">
	<div class="modal-card md">
		<h2 class="modal-title">회원 제재</h2>
		<p class="modal-desc">기간, 사유를 입력하면 회원에게 알림이 발송됩니다.</p>
  		<div class="modal-body">
  			<label class="field-label">정지 기간 (일)</label>
    		<input type="number" class="field mt-16" id="days" min="1">
    		<div class="field mt-16">
    			<label class="field-label">사유</label>
    			<textarea id="reason" class="textarea soft" rows="3"></textarea>
    		</div>
		</div>
		<div class="modal-actions">
  			<button type="button" class="btn btn-danger" id="applySanction">적용</button>
  			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
  		</div>
  	</div>
</div>
<div class="modal" id="permanentStop" role="dialog" aria-modal="true">
	<div class="modal-card md">
		<h2 class="modal-title">영구 정지</h2>
		<p class="modal-desc">사유를 입력하면 회원에게 알림이 발송됩니다.</p>
    	<div class="field mt-16">
    		<label class="field-label">사유</label>
    		<textarea id="permanentReason" class="textarea soft" rows="3"></textarea>
    	</div>

		<div class="modal-actions">
  			<button type="button" class="btn btn-danger" data-toast="제재를 적용했어요.">적용</button>
  			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
  		</div>
  	</div>
</div>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function(){
	//기간 정지
	$("#applySanction").click(function(e){
		e.preventDefault();
		
		let userId = '${info.user_id}';
		let days = $("#days").val();
		let reason = $("#reason").val();
		
		if (!days || !/^[1-9][0-9]*$/.test(days)) {
			alert('정지 기간은 1 이상의 숫자로 입력해주세요.');
			return;
		}
		if (!reason.trim()) {
			alert('사유를 입력해주세요.');
			return;
		}
		
		$.ajax({
			url:'${ctx}/admin/member/detail',
			type:'post',
			dataType:'text',
			data:{
				action: 'suspend',
				userId: userId,
				days:days,
				reason:reason
			},
			success:function(result) {
				if ($.trim(result) === "true") {
					alert('제재를 적용했어요.');
					location.reload();
				} else {
					alert('제재 적용에 실패했습니다.');
				}
			},
			error: function () {
				alert('처리 중 오류가 발생했습니다.');
			}
		});
	});
		
	// 영구 정지
	$("#applyPermanent").click(function(e){
		e.preventDefault();
		let userId = '${info.user_id}';
		let reason = $("#permanentReason").val();
		
		if (!reason.trim()) {
			alert('사유를 입력해주세요.');
			return;
		}
		if (!confirm('영구 정지는 되돌리기 어렵습니다. 진행할까요?')) return;
		$.ajax({
			url:'${ctx}/admin/member/detail',
			type:'post',
			dataType:'text',
			data:{
				action: 'permanent',
				userId: userId,
				reason: reason
			},
			success:function(result) {
				if ($.trim(result) === "true") {
					alert('영구 정지를 적용했어요.');
					location.reload();
				} else {
					alert('영구 정지 적용에 실패했습니다.');
				}
			},
			error: function () {
				alert('처리 중 오류가 발생했습니다.');
			}
		});
	});
});
</script>
<%@ include file="/jsp/common/footer.jsp" %>
