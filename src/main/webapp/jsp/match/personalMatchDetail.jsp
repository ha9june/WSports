<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<c:set var="state" value="${empty param.state ? 'recruiting' : param.state}" />
<c:set var="isHost" value="${fn:startsWith(state, 'host') or state eq 'completedHost' or state eq 'cancelledHost'}" />
<c:set var="pageTitle" value="경기 상세" />
<c:set var="pageCss" value="match" />
<c:set var="activeNav" value="${isHost ? '' : 'match'}" />
<c:set var="demoStates" value="recruiting:모집중|saved:찜함|applied:신청 완료|applyCancel:신청취소 모달|closed:모집 마감|completed:경기 종료|cancelledMin:자동 취소|host:주최자 관리|hostConfirmed:주최자-경기 예정|hostCancel:주최자-취소 모달|hostDelete:주최자-삭제 모달|completedHost:주최자-경기 종료|cancelledHost:주최자-취소됨" />
<%@ include file="/jsp/common/header.jsp" %>
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

</style>
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
  <c:when test="${state eq 'closed'}"><c:set var="pillCls" value="pill-neutral" /><c:set var="pillText" value="모집 마감" /></c:when>
  <c:when test="${state eq 'completed' or state eq 'completedHost'}"><c:set var="pillCls" value="pill-neutral" /><c:set var="pillText" value="경기 종료" /></c:when>
  <c:when test="${state eq 'cancelledMin' or state eq 'cancelledHost'}"><c:set var="pillCls" value="pill-neutral" /><c:set var="pillText" value="경기 취소" /></c:when>
  <c:when test="${state eq 'hostConfirmed'}"><c:set var="pillCls" value="pill-brand" /><c:set var="pillText" value="경기 예정" /></c:when>
  <c:otherwise><c:set var="pillCls" value="pill-brand" /><c:set var="pillText" value="모집중" /></c:otherwise>
</c:choose>

<c:if test="${role eq 'admin'}">
  <div class="admin-post-bar">관리자(사이트) 보기 · 운영 정책에 맞지 않는 경기는 삭제할 수 있어요.</div>
</c:if>

<main class="page">
  <div class="container">
    <nav class="breadcrumb">
      <c:choose>
        <c:when test="${isHost}"><a href="${ctx}/jsp/mypage/myPageCreatedPersonalMatch.jsp">내 경기</a><span class="sep">›</span><span>만든 경기</span><span class="sep">›</span><span>${state eq 'completedHost' or state eq 'cancelledHost' ? '경기 상세' : '경기 관리'}</span></c:when>
        <c:otherwise><a href="${ctx}/jsp/match/personalMatchList.jsp">경기 찾기</a><span class="sep"></span><span>경기 상세</span></c:otherwise>
      </c:choose>
    </nav>

    <%-- ===== 상단 : 종목 / 제목 / 호스트 ===== --%>
    <section class="detail-top">
      <span class="sport-chip">${personalMatch.sport }</span>
      <div class="title-row">
        <h1>
        	${personalMatch.title }
        </h1>
        <span class="pill pill-lg ${pillCls}">${personalMatch.status }</span>
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
         · 주 활동 지역 
         서울
          · 매너 양호</small></div>
        <div class="hover-card">
          <div class="top"><span class="avatar md"><img src="${ctx}/img/avatar-01.jpg" alt=""></span>
            <div><strong>
            ${personalMatch.nickname }
            </strong><p>서울 · 중급</p><p class="rating">4.8 · 21개 평가</p></div></div>
          <dl><dt>주 활동 지역</dt><dd>서울 마포구</dd><dt>선호 시간</dt><dd>주말 저녁</dd></dl>
        </div>
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
            <div class="info-row"><dt>참가비</dt><dd>${personalMatch.participationFee }원</dd></div>
            <div class="info-row"><dt>참가 인원</dt>
	            <dd>${personalMatch.currentPeople}명 / ${personalMatch.maxPeople}명
	            	<c:if test="${personalMatch.currentPeople >= personalMatch.minPeople}"><small>최소 진행 8명 · 충족 ✓</small></c:if>
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


        <c:if test="${empty sessionScope.user}">
          <div class="detail-actions">
            <button type="button" class="fav-btn sq ${state eq 'saved' ? 'is-on' : ''}" data-fav data-auth aria-label="관심 경기">${heart}</button>
            <a class="btn btn-outline btn-sm" href="${ctx}/jsp/support/reportWrite.jsp?targetType=personal&targetNo=${personalMatch.personalMatchId}" data-auth style="height:36px">신고</a>
          </div>
        </c:if>
      </div>

      <%-- ===== 우측 패널 : 상태별 액션 ===== --%>
      <aside class="detail-side">
        <c:choose>
          <%-- 신청 완료 (참가자) --%>
          <c:when test="${state eq 'applied' or state eq 'applyCancel'}">
            <div class="side-card">
              <h2>참가 <span class="pill pill-info">신청 완료</span></h2>
              <p class="sub">결제가 완료되어 참가가 확정되었습니다.</p>
              <div class="kv">참가비 <b>10,000원</b></div>
              <div class="kv">결제 완료 <b>9/16 10:24</b></div>
              <hr>
              <p class="note">경기 전까지 신청 상태와 참가자 정보를 확인할 수 있어요.</p>
              <div class="actions row">
                <a class="btn btn-primary btn-sm" href="${ctx}/jsp/match/personalMatchProfileList.jsp">참가자 8명 보기</a>
                <button type="button" class="btn btn-danger btn-sm" data-modal-open="applyCancelModal">신청 취소</button>
              </div>
            </div>
          </c:when>

          <c:when test="${state eq 'closed'}">
            <div class="side-card">
              <h2>모집이 마감되었습니다</h2>
              <p class="sub">모집 기간이 종료되어 더 이상 참가 신청을 받을 수 없습니다.</p>
            </div>
          </c:when>

          <c:when test="${state eq 'completed' or state eq 'completedHost'}">
            <div class="side-card done">
              <h2>경기가 종료되었습니다</h2>
              <p class="sub">함께 경기한 참가자의 매너를 평가하고 후기를 남겨보세요.</p>
              <div class="actions">
                <a class="btn btn-primary" href="${ctx}/jsp/review/reviewWrite.jsp?state=pastMatch">후기 작성</a>
                <c:choose>
                  <c:when test="${state eq 'completedHost'}"><a class="btn btn-primary" href="${ctx}/jsp/match/personalMatchAfterMatchEdit.jsp?state=host">출석 체크 · 참가자 평가</a></c:when>
                  <c:otherwise><a class="btn btn-primary" href="${ctx}/jsp/match/personalMatchAfterMatchEdit.jsp?state=participant">참가자 평가</a></c:otherwise>
                </c:choose>
              </div>
            </div>
          </c:when>

          <c:when test="${state eq 'cancelledMin'}">
            <div class="side-card">
              <span class="pill pill-danger bd">자동 취소</span>
              <p class="status-title">최소 인원 미달로 자동 취소</p>
              <p class="sub">모집 마감까지 최소 인원이 충족되지 않아 경기가 자동으로 취소되었습니다.</p>
              <p class="note">결제한 참가비는 환불 규정에 따라 처리됩니다.</p>
            </div>
          </c:when>

          <c:when test="${state eq 'cancelledHost'}">
            <div class="side-card">
              <span class="pill pill-danger bd">작성자 취소</span>
              <p class="status-title">작성자가 경기를 취소했어요</p>
              <p class="sub">호스트가 경기를 취소했습니다. 참가자에게 취소 알림이 발송됩니다.</p>
              <p class="note">결제된 참가비는 환불 규정에 따라 처리됩니다.</p>
            </div>
          </c:when>

          <%-- 주최자(작성자) 경기 관리 --%>
          <%-- <c:when test="${isHost}"> --%>
          <c:when test="${not empty sessionScope.user && sessionScope.user.userId == personalMatch.userId}">
            <div class="side-card">
              <h2>내가 작성한 경기</h2>
              <p style="margin-top:8px"><span class="pill ${state eq 'hostConfirmed' ? 'pill-info' : 'pill-brand'}">${state eq 'hostConfirmed' ? '경기 예정' : '모집중'}</span></p>
              <p class="sub">${state eq 'hostConfirmed' ? '모집 마감 · 내일 경기' : '마감까지 1일 3시간'}</p>
              <div class="actions">
                <a class="btn btn-primary" href="${ctx}/jsp/match/personalMatchAfterMatchEdit.jsp?state=host">출석 현황</a>
                <a class="btn btn-outline" href="${ctx}/match/detail/profile/list?personalMatchId=${personalMatch.personalMatchId}">참가자 명단 (${personalMatch.currentPeople}/${personalMatch.maxPeople} )</a>
                <a class="btn btn-outline" href="${ctx}/match/edit/form?num=${personalMatch.personalMatchId}" data-auth>경기 정보 수정</a>
              </div>
              <p class="note">수정 시 참가자에게 알림이 전송돼요.</p>
              <button type="button" class="cancel-link" data-modal-open="hostCancelModal" style="width:100%">경기 취소</button>
              <c:if test="${state ne 'hostConfirmed'}">
                <button type="button" class="btn-text t-12" style="display:block;margin:10px auto 0" data-modal-open="hostDeleteModal">모집글 삭제</button>
              </c:if>
            </div>
          </c:when>

          <%-- 기본 : 모집중 / 찜함 → 결제 안내 --%>
          <c:otherwise>
            <div class="side-card">
              <h2>결제 안내</h2>
              <div class="kv">참가비 <b class="lg">${personalMatch.participationFee }원</b></div>
              <hr>
              <p class="note" style="margin-top:0">결제하면 참가가 바로 확정됩니다.</p>
              <div class="actions">
                <a class="btn btn-primary" href="${ctx}/jsp/payment/toss_checkout.jsp?state=match" data-auth>결제하기</a>
                <a class="btn btn-primary" href="${ctx}/match/detail/participation?personalMatchId=${personalMatch.personalMatchId}" data-auth>참가하기</a>
            	<a class="btn btn-primary" href="#" data-auth>수정하기</a>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </aside>
    </div>
  </div>
</main>

<%-- ===== 모달 ===== --%>
<div class="modal ${state eq 'applyCancel' ? 'is-open' : ''}" id="applyCancelModal" role="dialog" aria-modal="true">
  <div class="modal-card">
    <h2 class="modal-title">참가를 취소할까요?</h2>
    <p class="modal-desc">취소 시 환불 규정에 따라 참가비가 처리됩니다.</p>
    <div class="modal-actions" style="justify-content:flex-start">
      <button type="button" class="btn btn-primary" data-modal-close>닫기</button>
      <%-- TODO: 신청 취소 서블릿으로 POST --%>
      <button type="button" class="btn btn-danger" data-toast="참가 신청을 취소했어요.">신청 취소</button>
    </div>
  </div>
</div>

<div class="modal ${state eq 'hostCancel' ? 'is-open' : ''}" id="hostCancelModal" role="dialog" aria-modal="true">
  <div class="modal-card">
    <h2 class="modal-title">경기를 취소할까요?</h2>
    <p class="modal-desc">경기를 취소하면 참가자 전원에게 취소 알림이 발송되고, 결제한 참가비는 환불 규정에 따라 처리됩니다.</p>
    <div class="modal-actions">
      <button type="button" class="btn btn-outline" data-modal-close>닫기</button>
      <button type="button" class="btn btn-danger" data-toast="경기를 취소했어요.">경기 취소</button>
    </div>
  </div>
</div>

<div class="modal ${state eq 'hostDelete' ? 'is-open' : ''}" id="hostDeleteModal" role="dialog" aria-modal="true">
  <div class="modal-card">
    <h2 class="modal-title">모집글을 삭제할까요?</h2>
    <p class="modal-desc">삭제한 모집글은 복구할 수 없습니다. 참가자가 있는 경기는 삭제 대신 경기 취소를 이용해주세요.</p>
    <div class="modal-actions">
      <button type="button" class="btn btn-outline" data-modal-close>닫기</button>
      <button type="button" class="btn btn-danger" data-toast="모집글을 삭제했어요.">삭제</button>
    </div>
  </div>
</div>

<c:if test="${role eq 'admin'}">
  <div class="modal" id="adminDeleteModal" role="dialog" aria-modal="true">
    <div class="modal-card sm">
      <h2 class="modal-title">경기를 삭제할까요?</h2>
      <p class="modal-desc">삭제한 경기는 복구할 수 없습니다.</p>
      <div class="modal-actions">
        <button type="button" class="btn btn-outline" data-modal-close>취소</button>
        <button type="button" class="btn btn-danger" data-toast="경기를 삭제했어요.">삭제</button>
      </div>
    </div>
  </div>
</c:if>

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
