<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
  문의 상세 (adminInquiryDetail.jsp) - 담당: 임태균
  피그마: Admin / Inquiry Detail / Desktop
   state : waiting(답변 작성) | answered(등록된 답변 - 수정 가능)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="문의 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="inquiry" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'waiting' : param.state}" />
<c:set var="demoStates" value="waiting:답변 대기|answered:답변 완료" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
	<div class="page-head">
		<h1 class="page-title">문의 상세</h1>
	</div>

	<form class="admin-card" style="width:760px;max-width:100%">
    	<div style="display:flex;justify-content:space-between">
    		<div>
    			<span>${inquirydetail.inquiry_id } · ${inquirydetail.type }</span>
    			<h2 style="margin:8px 0 0">${inquirydetail.title }</h2>
    		</div>
     	</div>
    	<dl class="kv1 mt-24">
    		<dt>작성자</dt><dd>${inquirydetail.nickname }</dd>
    		<dt>접수일</dt>
    		<dd>${inquirydetail.created_at}</dd>
    	</dl>
    	<h3 class="t-12 t-bold mt-24">내용</h3>
    	<p class="t-12 mt-8" style="line-height:1.7">${inquirydetail.content }</p>
    	<div class="field answer-box">
    		<label class="field-label strong" for="answer">답변</label>
      		<textarea class="textarea" id="answer" rows="5">${inquirydetail.answer}</textarea>
      	</div>
    	<div class="form-actions">
    		<button type="submit" class="btn btn-primary btn-sm" id="applySanction"
    		${inquirydetail.answer_status eq '답변대기' ? '' : 'disabled'}>
    		${inquirydetail.answer_status eq '답변대기' ? '답변 등록' : '답변 완료'}</button>
    	</div>
	</form>
</div>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function(){
	//답변완료
	$("#applySanction").click(function(e){
		e.preventDefault();
		
		let inquiryId = '${inquirydetail.inquiry_id}';
		let answer = $("#answer").val();
		
		if(!answer.trim()){
			alert('내용을 입력해주세요');
			return;
		}
		$.ajax({
			url:'${ctx}/admin/inquiry/detail',
			type:'post',
			dataType:'text',
			data:{
				action:'status',
				inquiryId:inquiryId,
				answer:answer,
			},
			success:function(result) {
				if($.trim(result) === "true"){
					alert('응답 완료');
					location.reload();
				}else{
					alert('응답 완료 실패');
				}
			},
			error: function(){
				alert('처리 중 오류 발생');
			}
		});
	});
})
</script>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
