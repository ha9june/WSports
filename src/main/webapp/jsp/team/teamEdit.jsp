<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  상대 팀 모집 수정 (teamMatchEdit.jsp) - 담당: 하준수
  서블릿에서 넘기는 값
    t           : 수정할 경기 (TeamMatch)
    agesValue   : "20대,30대" 형식
    skillsValue : "초급,중급" 형식
    imageList   : 저장된 사진 파일명 목록
--%>
<c:set var="pageTitle" value="상대 팀 모집 수정" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="teamMatch" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp"%>
<script
	src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>
<script type="text/javascript">
	$(function() {
		// ---------- 주소 검색 ----------
		$('#postSearch')
				.on(
						'click',
						function(e) {
							e.preventDefault();
							new daum.Postcode(
									{
										oncomplete : function(data) {
											$('#address').val(data.roadAddress);
											$('#lat').val('');
											$('#lng').val('');
											if (data.buildingName) {
												$('#placeName').val(
														data.buildingName);
											} else if (!$.trim($('#placeName')
													.val())) {
												$('#placeName').focus();
											}
											new kakao.maps.services.Geocoder()
													.addressSearch(
															data.roadAddress,
															function(result,
																	status) {
																if (status === kakao.maps.services.Status.OK) {
																	$('#lat')
																			.val(
																					result[0].y);
																	$('#lng')
																			.val(
																					result[0].x);
																} else {
																	showToast('주소의 좌표를 찾지 못했어요. 다른 주소로 다시 검색해 주세요.');
																	$(
																			'#address')
																			.val(
																					'');
																}
															});
										}
									}).open();
						});

		// ---------- 제출 검사 ----------
		$('.form-rail').on(
				'submit',
				function(e) {
					var msg = '';
					if (!$('#address').val() || !$('#lat').val())
						msg = '장소를 검색해 선택해 주세요.';
					else if (!$.trim($('#placeName').val())) {
						msg = '장소명을 입력해 주세요.';
						$('#placeName').focus();
					} else if (!$('select[name="startTime"]').val()
							|| !$('select[name="endTime"]').val())
						msg = '경기 시간을 선택해 주세요.';
					else if (!$('#tmSize').val())
						msg = '경기 인원을 선택해 주세요.';
					if (msg) {
						e.preventDefault();
						showToast(msg);
					}
				});

		// ---------- 사진 ----------
		var MAX_PHOTOS = 5, MAX_SIZE = 5 * 1024 * 1024;
		var photos = [];
		var $photoInput = $('#photoInput');
		var $photoBox = $('#photoBox');

		function currentCount() {
			return $photoBox.find('.photo-preview.is-saved').length
					+ photos.length;
		}
		function syncPhotoInput() {
			var dt = new DataTransfer();
			photos.forEach(function(f) {
				dt.items.add(f);
			});
			$photoInput[0].files = dt.files;
		}
		function refreshAddButton() {
			$photoBox.find('.photo-add').toggle(currentCount() < MAX_PHOTOS);
		}
		function renderNewPhotos() {
			$photoBox.find('.photo-preview.is-file').each(function() {
				URL.revokeObjectURL($(this).find('img').attr('src'));
			}).remove();
			photos
					.forEach(function(f, i) {
						var $p = $('<div class="photo-preview is-file" data-index="' + i + '">'
								+ '<img alt=""><button type="button" class="remove" aria-label="사진 삭제">✕</button></div>');
						$p.find('img').attr('src', URL.createObjectURL(f));
						$photoBox.append($p);
					});
			refreshAddButton();
		}

		$photoInput.on('change', function() {
			Array.prototype.forEach.call(this.files, function(f) {
				if (currentCount() >= MAX_PHOTOS) {
					showToast('사진은 최대 ' + MAX_PHOTOS + '장까지 올릴 수 있어요.');
					return;
				}
				if (!/^image\/(png|jpeg)$/.test(f.type)) {
					showToast('JPG, PNG 이미지만 첨부할 수 있어요.');
					return;
				}
				if (f.size > MAX_SIZE) {
					showToast('사진 한 장은 5MB 이하여야 해요.');
					return;
				}
				var dup = photos.some(function(p) {
					return p.name === f.name && p.size === f.size
							&& p.lastModified === f.lastModified;
				});
				if (!dup)
					photos.push(f);
			});
			syncPhotoInput();
			renderNewPhotos();
		});

		$photoBox.on('click', '.photo-preview.is-file .remove', function(e) {
			e.stopPropagation();
			photos.splice($(this).closest('.photo-preview').data('index'), 1);
			syncPhotoInput();
			renderNewPhotos();
		});

		// 저장된 사진 삭제: hidden(keepImages)도 같이 사라짐
		$photoBox.on('click', '.photo-preview.is-saved .remove', function(e) {
			e.stopPropagation();
			$(this).closest('.photo-preview').remove();
			refreshAddButton();
		});
		refreshAddButton();
	});
</script>
<main class="page">
	<form class="form-rail" action="${ctx}/team-match/edit" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="teamMatchId" value="${t.teamMatchId}">
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><a
				href="${ctx}/team-match/list">팀 매칭</a><span class="sep">›</span><span>경기
				수정</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">상대 팀 모집 수정</h1>
			<p class="page-desc">경기 정보를 수정해 주세요.</p>
		</div>

		<div class="team-form-inner">
			<section class="form-section">
				<h2 class="sub-title">경기 정보</h2>
				<div class="form-row c-2">
					<div class="field">
						<label class="field-label strong" for="team">팀</label> <select
							class="select" id="team" disabled>
							<option><c:out value="${t.teamName}" /></option>
						</select>
					</div>
					<div class="field">
						<label class="field-label strong" for="sport">종목</label> <select
							class="select" id="sport" disabled>
							<option><c:out value="${t.sport}" /></option>
						</select>
					</div>
				</div>
				<p class="field-help">팀과 종목은 수정할 수 없어요.</p>
				<div class="field">
					<label class="field-label strong" for="tmTitle">제목</label> <input
						class="input" id="tmTitle" name="title"
						value="<c:out value='${t.title}' />" placeholder="제목" required>
				</div>
			</section>

			<section class="form-section">
				<h2 class="sub-title">일정 및 장소</h2>
				<div class="form-row c-2">
					<div class="field">
						<label class="field-label strong" for="tmDate">경기일자</label> <input
							class="input" type="date" id="tmDate" name="matchDate"
							value="${t.matchDate}">
					</div>
					<div class="field">
						<span class="field-label strong">시간</span>
						<c:set var="st" value="${fn:substring(t.startTime, 0, 5)}" />
						<c:set var="et" value="${fn:substring(t.endTime, 0, 5)}" />
						<div class="time-range">
							<select class="select" name="startTime">
								<option value="" disabled>시간 선택</option>
								<c:forEach var="h" begin="0" end="23">
									<c:set var="hh" value="${h < 10 ? '0' : ''}${h}" />
									<c:set var="v1" value="${hh}:00" />
									<c:set var="v2" value="${hh}:30" />
									<option value="${v1}" ${st eq v1 ? 'selected' : ''}>${v1}</option>
									<option value="${v2}" ${st eq v2 ? 'selected' : ''}>${v2}</option>
								</c:forEach>
							</select> <span>~</span> <select class="select" name="endTime">
								<option value="" disabled>시간 선택</option>
								<c:forEach var="h" begin="0" end="23">
									<c:set var="hh" value="${h < 10 ? '0' : ''}${h}" />
									<c:set var="v1" value="${hh}:00" />
									<c:set var="v2" value="${hh}:30" />
									<c:if test="${h > 0}">
										<option value="${v1}" ${et eq v1 ? 'selected' : ''}>${v1}</option>
									</c:if>
									<option value="${v2}" ${et eq v2 ? 'selected' : ''}>${v2}</option>
								</c:forEach>
								<option value="24:00" ${et eq '24:00' ? 'selected' : ''}>24:00</option>
							</select>
						</div>
					</div>
				</div>

				<div class="field">
					<label class="field-label strong" for="address">장소</label>
					<div class="field-row place-row">
						<input class="input place-address" id="address" name="address"
							value="<c:out value='${t.address}' />" placeholder="주소를 검색하세요"
							readonly>
						<button type="button" id="postSearch"
							class="btn btn-primary btn-lg">검색</button>
						<input class="input place-name" id="placeName" name="placeName"
							value="<c:out value='${t.placeName}' />" maxlength="100"
							placeholder="장소명 (예: 마포 풋살장)">
					</div>
					<input type="hidden" id="lat" name="latitude" value="${t.latitude}">
					<input type="hidden" id="lng" name="longitude"
						value="${t.longitude}">
				</div>
			</section>

			<section class="form-section">
				<h2 class="sub-title">경기 설정</h2>
				<div class="form-row c-2">
					<div class="field">
						<label class="field-label strong" for="tmSize">경기 인원</label> <select
							class="select" id="tmSize" name="teamSize">
							<option value="" disabled>인원 선택</option>
							<option value="2" ${t.matchPeople eq 2 ? 'selected' : ''}>2
								vs 2</option>
							<option value="3" ${t.matchPeople eq 3 ? 'selected' : ''}>3
								vs 3</option>
							<option value="5" ${t.matchPeople eq 5 ? 'selected' : ''}>5
								vs 5</option>
							<option value="6" ${t.matchPeople eq 6 ? 'selected' : ''}>6
								vs 6</option>
							<option value="8" ${t.matchPeople eq 8 ? 'selected' : ''}>8
								vs 8</option>
							<option value="11" ${t.matchPeople eq 11 ? 'selected' : ''}>11
								vs 11</option>
						</select>
					</div>
					<div class="field">
						<label class="field-label strong" for="tmFee">참가비</label> <input
							class="input" id="tmFee" name="participationFee"
							value="<fmt:formatNumber value="${t.participationFee}" pattern="#,###" />" placeholder="10,000원">
					</div>
				</div>
				<div class="form-row c-2">
					<div class="field">
						<label class="field-label strong" for="tmDeadline">모집 마감</label> <input
							class="input" type="datetime-local" id="tmDeadline"
							name="deadline" value="${fn:substring(t.deadline, 0, 16)}">
					</div>
				</div>
			</section>

			<section class="form-section">
				<h2 class="sub-title">모집 조건</h2>
				<p class="section-desc">신청 가능한 팀의 연령대, 성별, 팀 레벨을 설정하세요.</p>
				<div class="field">
					<span class="field-label strong">연령대 <span class="hint-gray">복수
							선택 가능</span></span>
					<div class="chip-group" data-select="multi" data-hidden="ages">
						<button type="button" class="chip" data-value="20대">20대</button>
						<button type="button" class="chip" data-value="30대">30대</button>
						<button type="button" class="chip" data-value="40대">40대</button>
						<button type="button" class="chip" data-value="50대 이상">50대
							이상</button>
						<button type="button" class="chip" data-value="연령 무관">연령
							무관</button>
					</div>
					<input type="hidden" name="ages" id="ages"
						value="<c:out value='${agesValue}' />">
				</div>
				<div class="field">
					<span class="field-label strong">성별</span>
					<div class="chip-group" data-select="single" data-hidden="gender">
						<button type="button" class="chip" data-value="남자">남자</button>
						<button type="button" class="chip" data-value="여자">여자</button>
						<button type="button" class="chip" data-value="성별 무관">성별
							무관</button>
					</div>
					<input type="hidden" name="gender" id="gender"
						value="<c:out value='${t.gender}' />">
				</div>
				<div class="field">
					<span class="field-label strong">팀 레벨 <span
						class="hint-gray">복수 선택 가능</span></span>
					<div class="chip-group" data-select="multi" data-hidden="skill">
						<button type="button" class="chip" data-value="입문">입문</button>
						<button type="button" class="chip" data-value="초급">초급</button>
						<button type="button" class="chip" data-value="중급">중급</button>
						<button type="button" class="chip" data-value="상급">상급</button>
					</div>
					<input type="hidden" name="skill" id="skill"
						value="<c:out value='${skillsValue}' />">
				</div>
			</section>

			<section class="form-section">
				<h2 class="sub-title">상세 내용</h2>
				<div class="field">
					<label class="field-label strong" for="tmDesc">상세 설명</label>
					<textarea class="textarea soft" id="tmDesc" name="content" rows="5"
						placeholder="경기 방식, 준비물, 팀 유니폼 색상 등을 적어주세요."><c:out
							value="${t.content}" /></textarea>
				</div>
				<div class="field">
					<span class="field-label strong">사진 <span class="hint-gray">선택
							· 최대 5장</span></span>
					<div class="photo-upload" id="photoBox">
						<label class="photo-add"><span class="plus">+</span>사진 추가<input
							type="file" id="photoInput" name="photos"
							accept="image/png,image/jpeg" multiple></label>
						<c:forEach var="img" items="${imageList}">
							<div class="photo-preview is-saved">
								<img src="${ctx}/uploads/${img}" alt=""> <input
									type="hidden" name="keepImages" value="${img}">
								<button type="button" class="remove" aria-label="사진 삭제">✕</button>
							</div>
						</c:forEach>
					</div>
					<p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p>
				</div>
			</section>

			<div class="form-actions">
				<a class="btn btn-outline"
					href="${ctx}/team-match/detail/view?teamMatchId=${t.teamMatchId}">취소</a>
				<button type="submit" class="btn btn-primary">수정 완료</button>
			</div>
		</div>
	</form>
</main>
<script>
	// 저장된 값으로 칩 선택 상태 복원 (hidden 값 → is-selected)
	document.querySelectorAll(".chip-group[data-hidden]").forEach(
			function(group) {
				var hidden = document.getElementById(group.dataset.hidden);
				var saved = hidden.value ? hidden.value.split(/\s*[,·]\s*/)
						: [];
				group.querySelectorAll(".chip").forEach(function(btn) {
					if (saved.indexOf(btn.dataset.value) !== -1) {
						btn.classList.add("is-selected");
					}
				});
			});

	// 칩 클릭 시 hidden 값 갱신
	document.querySelectorAll(".chip-group[data-hidden]").forEach(
			function(group) {
				var hidden = document.getElementById(group.dataset.hidden);
				group.addEventListener("click", function() {
					setTimeout(function() {
						var values = [];
						group.querySelectorAll(".chip.is-selected").forEach(
								function(btn) {
									values.push(btn.dataset.value);
								});
						hidden.value = values.join(",");
					}, 0);
				});
			});
</script>
<%@ include file="/jsp/common/footer.jsp"%>