<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="회원 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="member" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'suspended' : param.state}" />
<c:set var="isNormal" value="${state eq 'normal'}" />
<c:set var="demoStates" value="suspended:정지 회원|normal:정상 회원|sanction:제재 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
    window.contextPath = "${ctx}";
    console.log("JSP contextPath =", window.contextPath);
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#change").click(function(e){
		e.preventDefault();
		
		let userId = '${info.user_id}';
		let days = $("#days").val();
		let reason = $("reason").val();
		
		if (!days || !/^[1-9][0-9]*$/.test(days)) {
			alert('정지 기간은 1 이상의 숫자로 입력해주세요.');
			return;
		}
		
		$.ajax({
			url:'${ctx}/admin/member/detail',
			type:'post',
			dataType:'text',
			data:{
				days:days,
				reason:reason
			},
			success:function(result) {
				if(result=="true"){
					$.post('${ctx}/admin/member/detail', {userId:userId, days: days, reason:reason})	
				}else if(result=="false"){
					alert('실패')
					}
				}
			}
		})
	)
 
})
</scrpit>

<div class="admin-inner">
	<div style="width:760px;max-width:100%">
    <section class="admin-card">
    	<div style="display:flex;align-items:center;gap:12px;margin-bottom:20px"><span class="avatar default"></span><strong style="font-size:18px">${isNormal ? 'player22' : 'baduser7'}</strong></div>
    	<c:set var="info" value="${detail[0]}" />
    	<dl class="kv1">
        	<dt>닉네임</dt><dd>${info.nickname}</dd>
        	<dt>이메일</dt><dd>${info.email}</dd>
        	<dt>상태</dt>	<dd class="${isNormal ? '' : 't-danger'}">${info.suspended}</dd>
        	<dt>패널티 점수</dt><dd>${info.score}</dd>
        	<c:if test="${not empty info.withdrawal_at }">
        		<dt>탈퇴한 회원</dt>
        		<dt>탈퇴일시</dt><dd>${info.score}</dd>
        	</c:if>
        	<dt>영구정지 여부</dt>
        	<dd>${info.permanent_suspended ? 'O' : 'X' }</dd>
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
			<button type="change" id="change" action="${ctx}/admin/member/detail" 
					class="btn btn-success-outline btn-sm" 
					data-modal-open="sanctionModal">제재 변경</button>
			<button type="stop" id="stop" action="${ctx}/admin/member/detail"
					class="btn btn-success-outline btn-sm" 
					data-modal-open="permanentStop">영구 정지</button>
		</div>
  </div>
</div>





<div class="modal ${state eq 'sanction' ? 'is-open' : ''}" id="sanctionModal" role="dialog" aria-modal="true">
	<div class="modal-card md">
		<h2 class="modal-title">회원 제재</h2>
		<p class="modal-desc">기간, 사유를 입력하면 회원에게 알림이 발송됩니다.</p>
  		<div class="modal-body">
  			<label class="field-label">정지 기간</label>
    		<input class="field mt-16">
    		<div class="field mt-16">
    			<label class="field-label">사유</label>
    			<textarea class="textarea soft" rows="3"></textarea>
    		</div>
		</div>
		<div class="modal-actions">
  			<button type="button" class="btn btn-danger" data-toast="제재를 적용했어요.">적용</button>
  			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
  		</div>
  	</div>
</div>
<div class="modal ${state eq 'sanction' ? 'is-open' : ''}" id="permanentStop" role="dialog" aria-modal="true">
	<div class="modal-card md">
		<h2 class="modal-title">영구 정지</h2>
		<p class="modal-desc">사유를 입력하면 회원에게 알림이 발송됩니다.</p>
    	<div class="field mt-16">
    		<label class="field-label">사유</label>
    		<textarea class="textarea soft" rows="3" placeholder="예: 노쇼 신고 확정 3회"></textarea>
    	</div>

		<div class="modal-actions">
  			<button type="button" class="btn btn-danger" data-toast="제재를 적용했어요.">적용</button>
  			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
  		</div>
  	</div>
</div>
<%@ include file="/jsp/common/footer.jsp" %>
