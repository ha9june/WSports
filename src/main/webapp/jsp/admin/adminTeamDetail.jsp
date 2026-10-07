<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  팀 상세 (adminTeamDetail.jsp) - 담당: 임태균
  피그마: Admin / Club Detail / Desktop, Admin / Club Delete / Modal
   state : default | penalty(패널티 부여/차감 모달) | delete(팀 삭제 모달)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="팀 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="team" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'default' : param.state}" />
<c:set var="demoStates" value="default:기본|penalty:패널티 모달|delete:삭제 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  	<div style="width:760px;max-width:100%">
    	<section class="admin-card">	
    		<div style="display:flex; align-items:center; gap:12px; margin-bottom:20px">
    			<c:choose>
					<c:when test="${not empty teaminfo.profile_image}">
						<img src="${ctx}${uploadPath}/${teaminfo.profile_image}" alt="${teaminfo.team_name}"
							style="width: 60px; height: 60px; object-fit: cover">
					</c:when>
					<c:otherwise>
						<span class="avatar default"></span>
					</c:otherwise>

				</c:choose>	
				<strong style="font-size:18px">${teaminfo.team_name}</strong>	
    		</div>
			<%-- 해제되지 않은 영구정지 기록이 있는지 확인 --%>
			<c:set var="isPermanent" value="false" />
			<c:forEach var="p" items="${penaltylist}">
				<c:if test="${p.permanent_suspension and empty p.cancelled_admin_id}">
					<c:set var="isPermanent" value="true" />
				</c:if>
			</c:forEach>
      		<dl class="kv2">
      			<dt>주장</dt>	<dd>${captain.nickname }</dd>
      			<dt>팀원</dt>	<dd>${membercnt}명</dd>
      			<dt>패널티점수</dt>	<dd>${empty penaltylist ? 0 : penaltylist[0].score}점</dd>
      			<dt>주 활동 지역</dt>
      			<dd>${teaminfo.region1} 
      				${empty teaminfo.region2 ? '' : ', ' += teaminfo.region2}
      				${empty teaminfo.region3 ? '' : ', ' += teaminfo.region3} </dd>
      			<dt>상태</dt>	<dd class="${suspension eq '정지' ? 't-danger' : ''}">${suspension}</dd>
      			<dt>영구정지 여부</dt><dd class="${isPermanent ? 't-danger' : ''}">${isPermanent ? 'O' : 'X'}</dd>
      		</dl>
      	</section>
		<section class="admin-card">
			<h2>패널티 점수 이력</h2>
			<c:forEach var="h" items="${penaltylist}" varStatus="st">
				<c:set var="prevScore" value="${st.last ? 0 : penaltylist[st.index + 1].score}" />
				<c:set var="diff" value="${h.score - prevScore}" />
				<div class="history-row">
					<span class="t-2">
						<fmt:formatDate value="${h.received_at}" pattern="M/dd" />
					</span>
					<b>${h.reason}</b>
					<b>${diff}점</b>
				</div>
			</c:forEach>
			<c:if test="${empty penaltylist}">
				<p class="t-12 t-2">패널티 점수 이력이 없습니다.</p>
			</c:if>
		</section>
    	<div class="btn-group mt-24">
    		<button type="button" class="btn btn-success-outline btn-sm" data-modal-open="penaltyModal">팀 정지</button>
    		<button type="button" class="btn btn-success-outline btn-sm" data-modal-open="scoreModal">패널티 점수 조정</button>
    		<button type="button" class="btn btn-success-outline btn-sm" data-modal-open="permanentStop">영구 정지</button>
    	</div>
  	</div>
</div>
<div class="modal" id="penaltyModal" role="dialog" aria-modal="true">
	<div class="modal-card md">
		<h2 class="modal-title">팀 정지</h2>
		<div class="modal-body">
  			<label class="field-label">정지 기간 (일)</label>
    		<input class="input" id="days">
    		<div class="field mt-16">
    			<label class="field-label">사유</label>
    			<textarea id="penaltyreason" class="textarea soft" rows="3"></textarea>
    		</div>
		</div>
		<div class="modal-actions">
  			<button type="button" class="btn btn-danger" id="applySanction">적용</button>
  			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
  		</div>
	</div>
</div>
<div class="modal" id="scoreModal" role="dialog" aria-modal="true">
	<div class="modal-card md">
		<h2 class="modal-title">페널티점수</h2>
		<div class="modal-body">
    		<div class="field">
    			<div class="chip-group" data-select="single">
    				<button type="button" class="chip is-selected">부여</button>
    				<button type="button" class="chip">차감</button>
    			</div>
    		</div>
    		<div class="field mt-16">
    			<label class="field-label">점수</label>
    			<input class="input" id="score">
    		</div>
			<div class="field mt-16">
				<label class="field-label">사유</label>
				<textarea id="scorereason" class="textarea soft" rows="3"></textarea>
			</div>
		</div>
		<div class="modal-actions">
			<button type="button" class="btn btn-danger" id="applyScore">적용</button>
			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
  		</div>
	</div>
</div>
<div class="modal" id="permanentStop" role="dialog" aria-modal="true">
	<div class="modal-card md">
		<h2 class="modal-title">영구정지</h2>
		<div class="modal-body">
			<div class="field">
				<label class="field-label">사유</label>
				<textarea id="permanentreason" class="textarea soft" rows="3"></textarea>
			</div>
		</div>
		<div class="modal-actions">
			<button type="button" class="btn btn-danger" id="applyPermanent">적용</button>
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
		
		let teamId = '${teaminfo.team_id}';
		let days = $("#days").val();
		let reason = $("#penaltyreason").val();
		
		if (!days || !/^[1-9][0-9]*$/.test(days)) {
			alert('정지 기간은 1 이상의 숫자로 입력해주세요.');
			return;
		}
		if (!reason.trim()) {
			alert('사유를 입력해주세요.');
			return;
		}
		
		$.ajax({
			url:'${ctx}/admin/team/detail',
			type:'post',
			dataType:'text',
			data:{
				action: 'suspend',
				teamId: teamId,
				days:days,
				reason:reason
			},
			success:function(result) {
				if ($.trim(result) === "true") {
					alert('제재 적용');
					location.reload();
				} else {
					alert('제재 적용 실패');
				}
			},
			error: function () {
				alert('처리 중 오류 발생');
			}
		});
	});
	//페널티 점수 조정
	$("#applyScore").click(function(e){
		e.preventDefault();
		
		let teamId = '${teaminfo.team_id}';
		let type = $("#scoreModal .chip.is-selected").text().trim();
		let score = $("#score").val();
		let reason = $('#scorereason').val();
		
		if(!score || !/^[1-9][0-9]*$/.test(score)){
			alert('페널티 점수는 1 이상의 숫자로 입력해주세요.');
			return;
		}
		if(!reason.trim()) {
			alert('사유를 입력하세요');
			return;
		}
		let change = (type === '차감') ? -Number(score) : Number(score);
		$.ajax({
			url:'${ctx}/admin/team/detail',
			type:'post',
			dataType:'text',
			data:{
				action:'adjust',
				teamId: teamId,
				change:change,
				reason: reason
			},
			success:function(result) {
				if($.trim(result) === "true") {
					alert('제제 적용');
					location.reload();
				}else {
					alert('제제 적용 실패');
				}
			},
			error: function(){
				alert('처리 중 오류 발생');
			}
		});
	});
	
	//영구정지
	$("#applyPermanent").click(function(e){
		e.preventDefault();
		let teamId = '${teaminfo.team_id}';
		let reason = $("#permanentreason").val();
		
		if (!reason.trim()) {
			alert('사유를 입력해주세요.');
			return;
		}
		if (!confirm('영구 정지는 되돌리기 어렵습니다. 진행할까요?')) return;
		$.ajax({
			url:'${ctx}/admin/team/detail',
			type:'post',
			dataType:'text',
			data:{
				action: 'permanent',
				teamId: teamId,
				reason: reason
			},
			success:function(result) {
				if ($.trim(result) === "true") {
					alert('영구 정지 적용');
					location.reload();
				} else {
					alert('영구 정지 적용 실패');
				}
			},
			error: function () {
				alert('처리 중 오류 발생');
			}
		});
	});
});
</script>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
