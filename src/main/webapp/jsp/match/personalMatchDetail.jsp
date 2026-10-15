<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>

<style>
	.main-photo {
		width: 100%;
		height: 348px;
		overflow: hidden;
		border-radius: 20px;
		background: #1f2328;
	}
	.main-photo img {
		width: 100%;
		height: 100%;
		object-fit: contain;
		display: block;
	}
	.thumbs {
		display: flex;
		gap: 12px;
		margin-top: 12px;
	}
	.thumbs span {
		width: 120px;
		height: 90px;
		overflow: hidden;
		border-radius: 8px;
		background: #1f2328;
		flex-shrink: 0;
	}
	.thumbs span img {
		width: 100%;
		height: 100%;
		object-fit: cover;
		display: block;
	}
	.detail-grid.no-photo .team-tabs {
		margin-top: 0;
	}
	.detail-grid.no-photo .team-side {
		width: 100%;
	}

	.intro {
	    white-space: pre-line;
	}
	.team-tabs {
		position: sticky;
		top: var(--header-h); 
		z-index: 40;
		background: #fff;
	}
	
	.host-name-link:hover {
	text-decoration: underline;
}

.side-card .btn-danger-soft {
	background: #fff !important;
	color: #dc2626 !important;
	border: 1px solid #fca5a5 !important;
}
.side-card .btn-danger-soft:hover {
	background: #fef2f2 !important;
}

</style>

<c:set var="status" value="${personalMatch.status}" />
<c:set var="isAdmin" value="${sessionScope.user.grade eq 'Admin'}" />
<c:set var="isUser" value="${not empty sessionScope.user}" />
<c:set var="isHost" value="${sessionScope.user.userId eq personalMatch.userId}" />

<c:set var="pageTitle" value="경기 상세" />
<c:set var="pageCss" value="match" />
<c:set var="activeNav" value="${isHost ? '' : 'match'}" />
<script src="${ctx}/js/common.format.js"></script>
<%@ include file="/jsp/common/header.jsp" %>

<%-- [참고] 카카오 키: 가능하면 서버 설정값(${kakaoKey})으로 빼고, 카카오 콘솔에서 허용 도메인 등록 확인 --%>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>

<script>
	$(function() {

		const profileImage = '<c:out value="${personalMatch.image}" />';
		const sport = '<c:out value="${personalMatch.sport}" />';

		const sportIcons = {
			'축구/풋살': 'sport-icon-football.png',
			'농구': 'sport-icon-basketball.png',
			'테니스': 'sport-icon-tennis.png',
			'배드민턴': 'sport-icon-badminton.png'
		};

		let imageSrc = '';

		if (profileImage) {
			imageSrc = '${ctx}/uploads/' + profileImage;
			$('#mainPhoto').html('<img src="' + imageSrc + '" alt="경기 이미지">');
		}

		//$('#mainPhoto').html('<img src="' + imageSrc + '" alt="경기 이미지">');

		const images = [
			'<c:out value="${personalMatch.image1}" />',
			'<c:out value="${personalMatch.image2}" />',
			'<c:out value="${personalMatch.image3}" />',
			'<c:out value="${personalMatch.image4}" />',
			'<c:out value="${personalMatch.image5}" />'
		].filter(function(image) {
			return image;
		});

		if (images.length === 0) {
			$('#activePhoto').hide();
			return;
		}

		let html = '';
		let mainPhoto = '<img src="${ctx}/uploads/' + images[0] + '" alt="활동 사진">';

		images.forEach(function(image, index) {
			const border = (index === 0) ? ' style="border: 2px solid #1677ff"' : '';
			html += '<span>'
					+ '<img class="subImg" src="${ctx}/uploads/' + image + '" alt="활동 사진"' + border + '>'
					+ '</span>';
		});

		$('#mainPhoto').html(mainPhoto);
		$('#thumbs').html(html);
		$('#thumbs').on('click', '.subImg', function() {
			// 메인 사진 변경
			$('#mainPhoto img').attr('src', $(this).attr('src'));
			// 기존 선택 표시 제거
			$('.subImg').css('border', 'none');
			// 클릭한 사진 선택 표시
			$(this).css('border', '2px solid #1677ff');
		}); 

	});
</script>

<%-- 상태별 제목 옆 배지 --%>
<c:choose>
	<c:when test="${status eq '모집중'}">
		<c:set var="pillCls" value="pill-success" /><c:set var="pillText" value="모집중" />
	</c:when>
	<c:when test="${status eq '모집 마감' or status eq '경기 종료'}">
		<c:set var="pillCls" value="pill-info" /><c:set var="pillText" value="${status}" />
	</c:when>
	<c:when test="${status eq '경기 취소'}">
		<c:set var="pillCls" value="pill-danger" /><c:set var="pillText" value="경기 취소" />
	</c:when>
	<c:otherwise>
		<c:set var="pillCls" value="pill-neutral" /><c:set var="pillText" value="${status}" />
	</c:otherwise>
</c:choose>
<c:if test="${isAdmin}">
	<div class="admin-post-bar">관리자(사이트) 보기 · 운영 정책에 맞지 않는 경기는 삭제할
		수 있어요.</div>
</c:if>

<main class="page">
  <div class="container">
    <nav class="breadcrumb">
    </nav>
    
    
    <%-- ===== 상단 : 종목 / 제목 / 호스트 ===== --%>
    <section class="detail-top">
      <span class="sport-chip">${personalMatch.sport }</span>
      <div class="title-row">
        <h1>
        	${personalMatch.title }
        </h1>
        <span class="pill pill-lg ${pillCls}">${status }</span>
        <c:if test="${isAdmin && !personalMatch.deleted}">
			<button type="button" class="btn btn-danger btn-sm"
				data-modal-open="adminDeleteModal">팀 경기 삭제</button>
		</c:if>
      </div>
      <div class="host-inline">
	      	<span class="avatar">
				<c:choose>
				    <c:when test="${not empty personalMatch.profileImage}">
				        <img src="${ctx}/profiles/${personalMatch.profileImage}" alt=""
				             onerror="this.onerror=null;this.src='${ctx}/img/default-profile.svg';"
				             style="width:100%;height:100%;border-radius:50%;object-fit:cover;display:block;">
				    </c:when>
				    <c:otherwise>				    
				        <img src="${ctx}/img/default-profile.svg" alt=""
				             style="width:100%;height:100%;border-radius:50%;object-fit:cover;display:block;">
				    </c:otherwise>
				</c:choose>
			</span>
			<div><a class="host-name-link" href="${ctx}/member/publicProfile/view?userId=${personalMatch.userId}"><strong style="color: #111827;">
			${personalMatch.nickname }
			</strong></a><small>
			호스트
			</small></div>

      </div>
      
    </section>

    <div class="detail-grid">
      <div class="detail-main">
      
      	<c:if test="${not empty personalMatch.image}">
	      	<div class="gallery">
				<div class="main-photo" style="height: 348px" id="mainPhoto"></div>
				<div class="thumbs" id="thumbs"></div>
	        </div>
      	</c:if>



        <section class="info-card">
          <h2>경기 정보</h2>
          <dl class="info-list">
            <div class="info-row"><dt>일시</dt><dd>          
            ${personalMatch.matchDate}（${personalMatch.dayOfWeekKorean}）
            ${personalMatch.startTime} ～ 
            ${personalMatch.endTime}
            </dd></div>
            <div class="info-row"><dt>주소</dt><dd>${personalMatch.address}</dd></div>
            <div class="info-row"><dt>장소</dt><dd>${personalMatch.placeName}</dd></div>
            <div class="info-row"><dt>참가비</dt><dd><fmt:formatNumber value="${personalMatch.participationFee}" />원</dd></div>
            
            <div class="info-row"><dt>참가 인원</dt>
	            <dd>${personalMatch.currentPeople}명 / ${personalMatch.maxPeople}명
	            	<c:choose>
	            		<c:when test="${personalMatch.currentPeople >= personalMatch.minPeople}">
	            			<small>최소 진행 ${personalMatch.minPeople }명 · 충족 ✓</small>
	            		</c:when>
	            		<c:otherwise>
	            			<small style="color:red;">최소 진행 ${personalMatch.minPeople }명 · 미충족</small>
	            		</c:otherwise>
	            	</c:choose>
	           	</dd>
           	</div>
            <div class="info-row"><dt>마감</dt><dd>
            ${fn:replace(personalMatch.deadline, 'T', ' ')}
            </dd></div>
            <div class="info-row"><dt>성별</dt><dd>${personalMatch.gender eq '혼성' ? '성별무관' : personalMatch.gender}</dd></div>
            <div class="info-row"><dt>연령</dt>
            	<dd>
					${ages }
            	</dd>
            </div>
            
            <div class="info-row"><dt>실력</dt>
            	<dd>
				${skills}
            	</dd>
            </div> 
          </dl>
          <div class="desc">
            <h3>상세 설명</h3>
            <p>${personalMatch.content}</p>
          </div>
        </section>

        <section class="map-card">
          <div class="head"><strong>경기 위치</strong><span>${personalMatch.address} ${personalMatch.placeName}</span></div>
          <div id="map" style="width:100%;height:300px;">
          </div>
        </section>


          <div class="detail-actions">
            <button type="button" class="fav-btn sq ${personalMatch.favorite ? 'is-on' : ''}" 
            data-fav2 data-auth data-match-id="${personalMatch.personalMatchId }" data-match-type="Personal" aria-label="관심 경기">${heart}</button>

            <a class="btn btn-outline btn-sm" href="${ctx}/support/report/create?targetType=personalMatch&targetNo=${personalMatch.personalMatchId}" data-auth style="height:36px">신고</a>
          </div>
      </div>


      <aside class="detail-side">
        <c:choose>
        	
        	<c:when test="${status eq '모집중'}">
        		<c:choose>
        			<%-- <c:when test="${isAdmin}">
        				<div class="side-card">
							<p style="margin-top:8px"><span class="pill ${pillCls}">${status}</span></p>
								<div class="actions">
									<a class="btn btn-primary" href="${ctx}/match/profile/list?personalMatchId=${personalMatch.personalMatchId}">참가자 명단 (${personalMatch.currentPeople}/${personalMatch.maxPeople})</a>
									
								</div>
							<p class="note">삭제 시 참가자에게 알림이 전송돼요.</p>
						</div>
        			</c:when> --%>
        			<c:when test="${isHost}">
						<div class="side-card">
							<h2>내가 작성한 경기</h2>
							<p style="margin-top:8px"><span class="pill ${pillCls}">${status}</span></p>
								<div class="actions">
									<a class="btn btn-primary" href="${ctx}/match/profile/list?personalMatchId=${personalMatch.personalMatchId}">참가자 명단 (${personalMatch.currentPeople}/${personalMatch.maxPeople})</a>
									<a class="btn btn-outline" href="${ctx}/match/edit/form?personalMatchId=${personalMatch.personalMatchId}" data-auth>경기 정보 수정</a>
									<button type="button" class="btn btn-outline btn-danger-soft"
										data-modal-open="hostCancelModal">경기 취소</button>
								</div>
							<p class="note">수정 시 참가자에게 알림이 전송돼요.</p>
						</div>
					</c:when>
        			<c:when test="${isUser and applied}">
	        			<div class="side-card">
			              <h2>참가 <span class="pill pill-info">신청 완료</span></h2>
			              <p class="sub">결제가 완료되어 참가가 확정되었습니다.</p>
			              		<div class="kv">
										참가비 <b><fmt:formatNumber value="${personalMatch.participationFee}" />원</b>
									</div>
									<div class="kv">
										수수료 (참가비의 8%) <b><fmt:formatNumber value="${personalMatch.fee}" />원</b>
									</div>
									<hr>
									<div class="kv">
										합계 <b class="lg"><fmt:formatNumber value="${personalMatch.participationFee + personalMatch.fee}" />원</b>
								</div>
			              <hr>
			              <p class="note">경기 전까지 신청 상태와 참가자 정보를 확인할 수 있어요.</p>
			              <div class="actions row">			             
			                <a class="btn btn-primary btn-sm" href="${ctx}/match/profile/list?personalMatchId=${personalMatch.personalMatchId}">참가자 보기</a>
			                <button type="button" class="btn btn-danger btn-sm" data-modal-open="refundModal">신청 취소</button>
			              </div>
			            </div>
						
        			</c:when>
        			<c:when test="${isUser and !applied}">
						<div class="side-card">
			              <h2>결제 안내</h2>
			              <div class="kv">
								참가비 <b><fmt:formatNumber value="${personalMatch.participationFee}" />원</b>
							</div>
							<div class="kv">
								수수료 (참가비의 8%) <b><fmt:formatNumber value="${personalMatch.fee}" />원</b>
							</div>
							<hr>
							<div class="kv">
								합계 <b class="lg"><fmt:formatNumber value="${personalMatch.participationFee + personalMatch.fee}" />원</b>
							</div>
			              <hr>
			              <p class="note" style="margin-top:0">결제하면 참가가 바로 확정됩니다.</p>
			              <div class="actions">
			                <a class="btn btn-primary" href="${ctx}/payment/confirm?state=match&matchId=${personalMatch.personalMatchId}" data-auth>결제하기</a>
			              </div>
			            </div>
        			</c:when>
        			<c:otherwise>
						<div class="side-card">
							<h2>경기 신청</h2>
							<p class="sub">로그인 후 신청할 수 있어요.</p>
							<div class="actions">
								<a class="btn btn-primary" href="${ctx}/auth/login" data-auth>로그인</a>
							</div>
        				</div>
        			</c:otherwise>
        		</c:choose>
        	</c:when>
        	<c:when test="${status eq '모집 마감'}">
        		<div class="side-card">
	              <h2>모집이 마감되었습니다</h2>
	              <p class="sub">모집 기간이 종료되어 더 이상 참가 신청을 받을 수 없습니다.</p>
		            <c:if test="${applied }">
		            	<p class="sub">결제가 완료되어 참가가 확정되었습니다.</p>
			              	<div class="kv">
									참가비 <b><fmt:formatNumber value="${personalMatch.participationFee}" />원</b>
								</div>
								<div class="kv">
									수수료 (참가비의 8%) <b><fmt:formatNumber value="${personalMatch.fee}" />원</b>
								</div>
								<hr>
								<div class="kv">
									합계 <b class="lg"><fmt:formatNumber value="${personalMatch.participationFee + personalMatch.fee}" />원</b>
							</div>
			              <hr>
			              <p class="note">경기 전까지 신청 상태와 참가자 정보를 확인할 수 있어요.</p>
			              <div class="actions row">
			                <a class="btn btn-primary btn-sm" href="${ctx}/match/profile/list?personalMatchId=${personalMatch.personalMatchId}">참가자 보기</a>
			              </div>
		            </c:if>
	            </div>
        	</c:when>
        	

        	<c:when test="${status eq '경기 종료'}">
				<div class="side-card done">
	              <h2>경기가 종료되었습니다</h2>
	              <p class="sub">함께 경기한 참가자의 매너를 평가하고 후기를 남겨보세요.</p>
	              <div class="actions">	              
	              	<c:if test="${isHost}">	              	
	              		<a class="btn btn-primary" href="${ctx}/match/after/profile/list?personalMatchId=${personalMatch.personalMatchId}">출석 체크 · 참가자 평가</a>
	              	</c:if>
	              	<c:if test="${isUser and applied}">
	              		<a class="btn btn-primary" href="${ctx}/review/create">후기 작성</a>
         		        <a class="btn btn-primary" href="${ctx}/match/after/profile/list?personalMatchId=${personalMatch.personalMatchId}">참가자 평가</a>
	              	</c:if>
	              </div>
	            </div>
        	</c:when>
			<c:when test="${status eq '경기 취소'}">
	            <div class="side-card">
	              <span class="pill pill-danger bd">경기 취소</span>
	              <p class="status-title">경기가 취소되었습니다.</p>
	              <p class="sub">호스트 또는 운영 사정으로 경기가 진행되지 않아요.</p>
	              <p class="note">결제한 참가비는 환불 규정에 따라 처리됩니다.</p>
	            </div>
	          </c:when>
         </c:choose>    
      </aside>
    </div>
  </div>
</main>

<%-- ===== 모달 ===== --%>
<div class="modal" id="applyParticipantModal" role="dialog" aria-modal="true">
  <div class="modal-card">
    <h2 class="modal-title">경기를 참가할까요?</h2>
    <p class="modal-desc">경기 참가 버튼 클릭 시 결제 페이지로 이동합니다.</p>
    <form action="${ctx}/match/participant/update" method="post" class="modal-actions">
		<input type="hidden" name="updateType" value="participant">
		<input type="hidden" name="personalMatchId" value="${personalMatch.personalMatchId}">			
		<button type="button" class="btn btn-outline" data-modal-close>취소</button>
      	<button type="submit" class="btn btn-primary">경기 참가</button>
	</form>
  </div>
</div>

<c:if test="${isHost}">
	<div class="modal" id="hostCancelModal" role="dialog" aria-modal="true">
	  <div class="modal-card">
	    <h2 class="modal-title">경기를 취소할까요?</h2>
	    <p class="modal-desc">경기를 취소하면 참가자 전원에게 취소 알림이 발송되고, 결제한 참가비는 환불 규정에 따라 처리됩니다.</p>
	    <form action="${ctx}/payment/match/detail/allrefund" method="post" class="modal-actions">
			<input type="hidden" name="matchType" value="Personal">
			<input type="hidden" name="matchId" value="${personalMatch.personalMatchId}">			
			<input type="hidden" name="matchTitle" value="${personalMatch.title}">			
			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
	      	<button type="submit" class="btn btn-danger">경기 취소</button>
		</form>
	  </div>
	</div>
</c:if>
<c:if test="${isAdmin}">
  <div class="modal" id="adminDeleteModal" role="dialog" aria-modal="true">
    <div class="modal-card sm">
      <h2 class="modal-title">경기를 삭제할까요?</h2>
      <p class="modal-desc">삭제한 경기는 복구할 수 없습니다.</p>
      <form action="${ctx}/payment/match/detail/allrefund" method="post" class="modal-actions">
			<input type="hidden" name="matchType" value="Personal">
			<input type="hidden" name="matchId" value="${personalMatch.personalMatchId}">			
			<input type="hidden" name="matchTitle" value="${personalMatch.title}">			
			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
        	<button type="submit" class="btn btn-danger">삭제</button>
		</form>
    </div>
  </div>
</c:if>
<!-- 환불 확인 모달 -->
<div class="modal" id="refundModal" role="dialog" aria-modal="true">
	<div class="modal-card md">
		<h2 class="modal-title">환불할까요?</h2>
		<div class="modal-desc">
			<p class="t-12 t-danger" style="margin-bottom:12px">
			환불하면 경기참가가 취소됩니다. 처리후에는 되돌릴 수 없어요.<br>
			모집 마감 전까지만 환불할 수 있어요.
			</p>  
		</div>
		<form method="post" action="${ctx}/payment/match/detail/refund" id="refundForm">
			<input type="hidden" name="matchType" value="Personal"/>
			<div class="modal-body">
				<p>환불금액 : <b><fmt:formatNumber value="${personalMatch.participationFee + personalMatch.fee}"  pattern="#,###"/>원</b></p>
				<div class="field mt-16">
					<label class="field-label">환불사유</label>
					<select class="select" name="cancelReason" required>
						<option>일정이 맞지 않음</option>
						<option>개인 사정</option>
						<option>잘못 결제함</option>
						<option>기타</option>
					</select>
				</div>
			</div>
			<input type="hidden" name="matchId" value="${personalMatch.personalMatchId }"/>
			<div class="modal-actions">
				<button type="submit" class="btn btn-danger" id="refundSubmit">환불하기</button>
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
			</div>
		</form>
	</div>
</div>

<%@ include file="/jsp/common/footer.jsp" %>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
	    center: new kakao.maps.LatLng(${personalMatch.latitude}, ${personalMatch.longitude}), // 지도의 중심좌표
	    level: 5 // 지도의 확대 레벨
	};
	var map = new kakao.maps.Map(mapContainer, mapOption);
	var markerPosition = new kakao.maps.LatLng(
	    ${personalMatch.latitude},
	    ${personalMatch.longitude}
	);
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	marker.setMap(map);
</script>
