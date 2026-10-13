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
		top: var(--header-h)
		z-index: 40;
		background: #fff;
	}

</style>

<c:set var="pageTitle" value="경기 상세" />
<c:set var="pageCss" value="match" />
<c:set var="activeNav" value="${isHost ? '' : 'match'}" />
<script src="${ctx}/js/common.format.js"></script>
<%@ include file="/jsp/common/header.jsp" %>

<c:set var="status" value="${personalMatch.status}" />
<c:set var="isAdmin" value="${sessionScope.user.grade eq 'Admin'}" />
<c:set var="isUser" value="${sessionScope.user.grade eq 'User'}" />
<c:set var="isHost" value="${sessionScope.user.userId eq personalMatch.userId}" />
<c:set var="applied" value="${applied }" />
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>
<script>
	$(function() {

		const profileImage = '${personalMatch.image}';
		const sport = '${personalMatch.sport}';

		let imageSrc = '';

		if (profileImage) {
			imageSrc = '${ctx}/uploads/' + profileImage;
		} else if (sport === '축구/풋살') {
			imageSrc = '${ctx}/img/team-football.png';
		} else if (sport === '농구') {
			imageSrc = '${ctx}/img/team-basketball.png';
		} else if (sport === '테니스') {
			imageSrc = '${ctx}/img/team-tennis.png';
		} else if (sport === '배드민턴') {
			imageSrc = '${ctx}/img/team-badminton.png';
		}

		$('#mainPhoto').html('<img src="' + imageSrc + '" alt="팀 프로필 이미지">');

		 const images = [ '${personalMatch.image1}', '${personalMatch.image2}',
				'${personalMatch.image3}', '${personalMatch.image4}',
				'${personalMatch.image5}' ];


		var hasImage = images.some(function(image) {
			return image;
		});

		if (!hasImage) {
			$('#activePhoto').hide();

			return;
		}

		let html = '';
		let mainPhoto = '<img src="${ctx}/uploads/' + images[0]	 + '" alt="활동 사진">';

		images.forEach(function(image, index) {
					if (image && index === 0) {
						html += '<span>'
								+ '<img class="subImg" src="${ctx}/uploads/' + image + '" alt="활동 사진" style="border: 2px solid #1677ff">'
								+ '</span>';
					} else if (image) {
						html += '<span>'
								+ '<img class="subImg" src="${ctx}/uploads/' + image + '" alt="활동 사진">'
								+ '</span>';
					}
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
	<div class="admin-post-bar">관리자(사이트) 보기 · 운영 정책에 맞지 않는 팀 경기는 삭제할
		수 있어요.</div>
</c:if>

<main class="page">
  <div class="container">
    <nav class="breadcrumb">
      <%-- <c:choose>
        <c:when test="${isHost}"><a href="${ctx}/jsp/mypage/myPageCreatedPersonalMatch.jsp">내 경기</a><span class="sep">›</span><span>만든 경기</span><span class="sep">›</span><span>${status eq 'completedHost' or state eq 'cancelledHost' ? '경기 상세' : '경기 관리'}</span></c:when>
        <c:otherwise><a href="${ctx}/jsp/match/personalMatchList.jsp">경기 찾기</a><span class="sep"></span><span>경기 상세</span></c:otherwise>
      </c:choose> --%>
    </nav>

    <%-- ===== 상단 : 종목 / 제목 / 호스트 ===== --%>
    <section class="detail-top">
      <span class="sport-chip">${personalMatch.sport }</span>
      <div class="title-row">
        <h1>
        	${personalMatch.title }
        </h1>
        <span class="pill pill-lg ${pillCls}">${status }</span>
        <c:if test="${role eq 'admin'}">
          <button type="button" class="btn btn-danger btn-sm admin-del" data-modal-open="adminDeleteModal">경기 삭제</button>
        </c:if>
      </div>
      <div class="host-inline">
        <span class="avatar default"></span>
        <div><a href="${ctx}/jsp/member/userProfileInfo.jsp"><strong>
        ${personalMatch.nickname }
        </strong></a><small>
        호스트
        </small></div>

      </div>
    </section>

    <div class="detail-grid">
      <div class="detail-main">
        <div class="gallery">
			<div class="main-photo" style="height: 348px" id="mainPhoto"></div>
			<div class="thumbs" id="thumbs"></div>
        </div>


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
            <div class="info-row"><dt>참가비</dt><dd><fmt:formatNumber value="${personalMatch.participationFee }" />원</dd></div>
            
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
	            	<c:if test="${personalMatch.currentPeople >= personalMatch.minPeople}">
	            		<small>최소 진행 ${personalMatch.minPeople }명 · 충족 ✓</small>
            		</c:if>
	           	</dd>
           	</div>
            <div class="info-row"><dt>마감</dt><dd>
            ${fn:replace(personalMatch.deadline, 'T', ' ')}
            </dd></div>
            <div class="info-row"><dt>성별</dt><dd>${personalMatch.gender}</dd></div>
            <div class="info-row"><dt>연령</dt>
            	<dd>
		            <c:if test="${personalMatch.age20s}">20대 </c:if>
					<c:if test="${personalMatch.age30s}">30대 </c:if>
					<c:if test="${personalMatch.age40s}">40대 </c:if>
					<c:if test="${personalMatch.age50s}">50대 </c:if>
					<c:if test="${personalMatch.age60Plus}">60대+ </c:if>
            	</dd>
            </div>
            
            <div class="info-row"><dt>실력</dt>
            	<dd>
            	<c:if test="${personalMatch.skillIntro}">입문 </c:if>
				<c:if test="${personalMatch.skillBeginner}">초급 </c:if>
				<c:if test="${personalMatch.skillIntermediate}">중급 </c:if>
				<c:if test="${personalMatch.skillAdvanced}">고급 </c:if>
            	</dd>
          </dl>
          <div class="desc">
            <h3>상세 설명</h3>
            <p>${personalMatch.content}</p>
          </div>
        </section>

        <section class="map-card">
          <div class="head"><strong>경기 위치</strong><span>서울 마포구 망원 풋살장</span></div>
          <div id="map" style="width:100%;height:300px;">
          </div>
        </section>


          <div class="detail-actions">
            <button type="button" class="fav-btn sq ${personalMatch.favorite ? 'is-on' : ''}" 
            data-fav2 data-auth data-match-id="${personalMatch.personalMatchId }" data-match-type="Personal" aria-label="관심 경기">${heart}</button>
            <a class="btn btn-outline btn-sm" href="${ctx}/jsp/support/reportWrite.jsp?targetType=personal&targetNo=${personalMatch.personalMatchId}" data-auth style="height:36px">신고</a>
          </div>
      </div>


      <%-- ===== 우측 패널 : 상태별 액션 ===== --%>
      <aside class="detail-side">
        <c:choose>
        	
        	<c:when test="${status eq '모집중'}">
        		<c:choose>
        			<c:when test="${isAdmin}">
        				
        			</c:when>
        			<c:when test="${isHost}">
						<div class="side-card">
			              <h2>내가 작성한 경기</h2>
        			      <p style="margin-top:8px"><span class="pill ${pillCls}">${status} </span></p>			             
			              <div class="actions">
			                <a class="btn btn-outline btn-primary" href="${ctx}/match/profile/list?personalMatchId=${personalMatch.personalMatchId}">참가자 명단 (${personalMatch.currentPeople}/${personalMatch.maxPeople} )</a>
			                <a class="btn btn-outline" href="${ctx}/match/edit/form?personalMatchId=${personalMatch.personalMatchId}" data-auth>경기 정보 수정</a>
			              </div>
			              <p class="note">수정 시 참가자에게 알림이 전송돼요.</p>
			              <button class="btn btn-danger btn-sm" type="button" class="cancel-link" data-modal-open="hostCancelModal" style="width:100%">경기 취소</button>
			              <c:if test="${status ne 'hostConfirmed'}">
			              </c:if>
			            </div>
        			</c:when>
        			<c:when test="${isUser and applied}">
	        			<div class="side-card">
			              <h2>참가 <span class="pill pill-info">신청 완료</span></h2>
			              <p class="sub">결제가 완료되어 참가가 확정되었습니다.</p>
			              <div class="kv">참가비 <b>10,000원</b></div>
			              <p>
			              	<div class="kv">결제 완료 <b>9/16 10:24</b></div>
			              </p>
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
			              <div class="kv">참가비 <b class="lg">${personalMatch.participationFee }원</b></div>
			              <hr>
			              <p class="note" style="margin-top:0">결제하면 참가가 바로 확정됩니다.</p>
			              <div class="actions">
			                <a class="btn btn-primary" href="${ctx}/payment/confirm?state=match&matchId=${personalMatch.personalMatchId}" data-auth>결제하기</a>
			                <%-- <a class="btn btn-primary" href="${ctx}/match/participant/update?personalMatchId=${personalMatch.personalMatchId}&updateType='참가'" data-auth>참가하기</a> --%>
			              </div>
			            </div>
        			</c:when>
        		</c:choose>
        	</c:when>
        	<c:when test="${status eq '모집 마감'}">
        		<div class="side-card">
	              <h2>모집이 마감되었습니다</h2>
	              <p class="sub">모집 기간이 종료되어 더 이상 참가 신청을 받을 수 없습니다.</p>
		            <c:if test="${applied }">
		            	<p class="sub">결제가 완료되어 참가가 확정되었습니다.</p>
			              <div class="kv">참가비 <b>10,000원</b></div>
			              <p>
			              	<div class="kv">결제 완료 <b>9/16 10:24</b></div>
			              </p>
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
	              <p class="sub">경기가 취소되었습니다.</p>
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
<div class="modal" id="applyCancelModal" role="dialog" aria-modal="true">
  <div class="modal-card">
    <h2 class="modal-title">참가를 취소할까요?</h2>
    <p class="modal-desc">취소 시 환불 규정에 따라 참가비가 처리됩니다.</p>
    <form action="${ctx}/match/participant/update" method="post" class="modal-actions">
		<input type="hidden" name="updateType" value="participantCancel">
		<input type="hidden" name="personalMatchId" value="${personalMatch.personalMatchId}">			
		<button type="button" class="btn btn-outline" data-modal-close>취소</button>
      	<button type="submit" class="btn btn-danger">경기 취소</button>
	</form>
  </div>
</div>
<c:if test="${isHost}">
	<div class="modal" id="hostCancelModal" role="dialog" aria-modal="true">
	  <div class="modal-card">
	    <h2 class="modal-title">경기를 취소할까요?</h2>
	    <p class="modal-desc">경기를 취소하면 참가자 전원에게 취소 알림이 발송되고, 결제한 참가비는 환불 규정에 따라 처리됩니다.</p>
	    <form action="${ctx}/match/status/update" method="post" class="modal-actions">
			<input type="hidden" name="updateType" value="hostCancel">
			<input type="hidden" name="personalMatchId" value="${personalMatch.personalMatchId}">			
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
      <form action="${ctx}/match/status/update" method="post" class="modal-actions">
			<input type="hidden" name="updateType" value="adminDelete">
			<input type="hidden" name="personalMatchId" value="${personalMatch.personalMatchId}">			
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
		<p class="modal-desc">
				<p class="t-12 t-danger" style="margin-bottom:12px">
				환불하면 경기참가가 취소됩니다. 처리후에는 되돌릴 수 없어요.<br>
				모집 마감 전까지만 환불할 수 있어요.
				</p>  
		</p>
		<form method="post" action="${ctx}/payment/match/detail/refund" id="refundForm">
			<input type="hidden" name="matchType" value="Personal"/>
			<div class="modal-body">
				<p>환불금액 : <b><fmt:formatNumber value="${personalMatch.participationFee - personalMatch.fee}"  pattern="#,###"/>원</b></p>
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
