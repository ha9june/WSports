<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  상대 팀 모집 (teamMatchMakeForm.jsp) - 담당: 하준수
  피그마: Club Match / Form / Desktop
--%>
<c:set var="pageTitle" value="상대 팀 모집" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="teamMatch" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp"%>
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b050be3c87edea9bbf7f3ec1e5fba8d&libraries=services"></script>
<script type="text/javascript">
	$(function() {
		function syncSport() { //팀 종목에 맞춰서 종목 고르기
			var sport = $('#team').find('option:selected').data('sport') || '';
			$('.sport-readonly .chip').removeClass('is-selected').filter(
					function() {
						return $(this).data('value') === sport;
					}).addClass('is-selected');
			$('#sportCode').val(sport);
		}

		// 팀의 성별을 기본 선택으로 채움 (사용자가 이후 바꿀 수 있음)
		function syncGender() {
			var gender = $('#team').find('option:selected').data('gender')
					|| '';
			$('#genderBtn .chip').removeClass('is-selected').filter(function() {
				return $(this).data('value') === gender;
			}).addClass('is-selected');
			$('#gender').val(gender);
		}

		$('#team').on('change', function() {
			syncSport();
			syncGender();
		});
		syncSport();
		syncGender();

		// 사용자가 성별 칩을 직접 바꿀 때 hidden 갱신
		$('#genderBtn').on('click', '.chip', function() {
			$('#gender').val($(this).data('value'));
		});

		// 연령대(복수 선택): 선택된 칩 값을 쉼표로 이어 hidden에 저장
		$('#agesBtn').on('click', '.chip', function() {
			setTimeout(function() { // 공통 JS가 is-selected를 먼저 처리한 뒤 읽기
				var ageValues = $('#agesBtn .chip.is-selected').map(function() {
					return $(this).data('value');
				}).get();
				$('#ages').val(ageValues.join(','));
			}, 0);
		});
		
		$('#skillBtn').on('click', '.chip', function() {
			setTimeout(function() { // 공통 JS가 is-selected를 먼저 처리한 뒤 읽기
				var skillValues = $('#skillBtn .chip.is-selected').map(function() {
					return $(this).data('value');
				}).get();
				$('#skill').val(skillValues.join(','));
			}, 0);
		});
		
		/* $('#postSearch').on("click", function(e) {
		    e.preventDefault();
	        new daum.Postcode({
	            oncomplete: function(data) {
	                $('#address').val(data.roadAddress);
	                console.log($('#address').val());
	      
	                var geocoder = new kakao.maps.services.Geocoder();
	                geocoder.addressSearch(data.roadAddress, function(result, status) {
	                    if (status === kakao.maps.services.Status.OK) {
	                        var lat = result[0].y;
	                        var lng = result[0].x;
	                        $('#lat').val(lat);
	                        $('#lng').val(lng);
	                    }
	                });
	            }
	        }).open();
		}); */
		//지도 관련
		$('#postSearch').on('click', function (e) {
			e.preventDefault();
			new daum.Postcode({
				oncomplete: function (data) {
					$('#address').val(data.roadAddress);
					$('#lat').val(''); $('#lng').val('');             // 이전 좌표 초기화
		
					if (data.buildingName) {
						$('#placeName').val(data.buildingName);        // 건물명이 있으면 자동 입력
					} else if (!$.trim($('#placeName').val())) {
						$('#placeName').focus();                       // 비어 있으면 직접 입력하도록 안내
					}
		
					new kakao.maps.services.Geocoder().addressSearch(data.roadAddress, function (result, status) {
						if (status === kakao.maps.services.Status.OK) {
							$('#lat').val(result[0].y);
							$('#lng').val(result[0].x);
						} else {
							showToast('주소의 좌표를 찾지 못했어요. 다른 주소로 다시 검색해 주세요.');
							$('#address').val('');
						}
					});
				}
			}).open();
		});
		
		// 제출 시 검사
		$('.form-rail').on('submit', function (e) {
			var msg = '';
			if (!$('#address').val() || !$('#lat').val()) msg = '장소를 검색해 선택해 주세요.';
			else if (!$.trim($('#placeName').val())) { msg = '장소명을 입력해 주세요.'; $('#placeName').focus(); }
			else if (!$('select[name="startTime"]').val() || !$('select[name="endTime"]').val()) msg = '경기 시간을 선택해 주세요.';
			else if (!$('#tmSize').val()) msg = '경기 인원을 선택해 주세요.';
			if (msg) { e.preventDefault(); showToast(msg); }
			
		});
		
		//사진 관련
		var MAX_PHOTOS = 5, MAX_SIZE = 5 * 1024 * 1024;   // 5MB
		var photos = [];                                   // 실제로 업로드할 파일 목록
		var $photoInput = $('#photoInput');
		var $photoBox = $('#photoBox');

		// 배열 → input.files (삭제한 사진이 업로드되지 않게 하는 핵심)
		function syncPhotoInput() {
			var dt = new DataTransfer();
			photos.forEach(function (f) { dt.items.add(f); });
			$photoInput[0].files = dt.files;
		}

		function renderPhotos() {
			$photoBox.find('.photo-preview').each(function () {
				URL.revokeObjectURL($(this).find('img').attr('src'));   // 메모리 해제
			}).remove();

			photos.forEach(function (f, i) {
				var $p = $('<div class="photo-preview is-file" data-index="' + i + '">'
					+ '<img alt=""><button type="button" class="remove" aria-label="사진 삭제">✕</button></div>');
				$p.find('img').attr('src', URL.createObjectURL(f));
				$photoBox.append($p);
			});

			$photoBox.find('.photo-add').toggle(photos.length < MAX_PHOTOS);   // 5장이면 추가 버튼 숨김
		}

		// 사진 추가: 새로 고른 파일을 기존 목록에 누적
		$photoInput.on('change', function () {
			Array.prototype.forEach.call(this.files, function (f) {
				if (photos.length >= MAX_PHOTOS) { showToast('사진은 최대 ' + MAX_PHOTOS + '장까지 올릴 수 있어요.'); return; }
				if (!/^image\/(png|jpeg)$/.test(f.type)) { showToast('JPG, PNG 이미지만 첨부할 수 있어요.'); return; }
				if (f.size > MAX_SIZE) { showToast('사진 한 장은 5MB 이하여야 해요.'); return; }
				var dup = photos.some(function (p) {
					return p.name === f.name && p.size === f.size && p.lastModified === f.lastModified;
				});
				if (!dup) photos.push(f);
			});
			syncPhotoInput();   // 방금 고른 것만이 아니라 누적된 전체 목록으로 교체
			renderPhotos();
		});

		// 사진 삭제: 배열에서 빼고 input도 다시 만듦
		$photoBox.on('click', '.remove', function (e) {
			e.stopPropagation();   // 공통 JS의 삭제(화면만 지움)가 같이 실행되지 않게 막음
			photos.splice($(this).closest('.photo-preview').data('index'), 1);
			syncPhotoInput();
			renderPhotos();
		});
	});
</script>
<main class="page">
	<form class="form-rail"
		action="${ctx}/team-match/create"
		method="post" enctype="multipart/form-data">
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><a
				href="${ctx}/team-match/list">팀 매칭</a><span class="sep">›</span><span>경기
				만들기</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">상대 팀 모집</h1>
			<p class="page-desc">상대 팀을 모집할 경기 정보를 입력해 주세요.</p>
		</div>

		<div class="team-form-inner">
			<section class="form-section">
				<h2 class="sub-title">경기 정보</h2>
				<div class="form-row c-2">
					<div class="field">
						<label class="field-label strong" for="team">팀</label> <select
							class="select" id="team" name="teamNo">
							<c:forEach var="t" items="${teamList}">
								<option value="${t.teamId}"
									data-sport="<c:out value='${t.sport}' />"
									data-gender="<c:out value='${t.gender}' />">
									<c:out value="${t.teamName}" />
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="field">
						<span class="field-label strong">종목</span>
						<div class="chip-group sport-readonly">
							<button type="button" class="chip" data-value="축구/풋살"
								tabindex="-1">축구/풋살</button>
							<button type="button" class="chip" data-value="농구" tabindex="-1">농구</button>
							<button type="button" class="chip" data-value="테니스" tabindex="-1">테니스</button>
							<button type="button" class="chip" data-value="배드민턴"
								tabindex="-1">배드민턴</button>
						</div>
						<input type="hidden" name="sportCode" id="sportCode">
					</div>
				</div>

				<div class="field">
					<label class="field-label strong" for="tmTitle">제목</label> <input
						class="input" id="tmTitle" name="title" value="" placeholder="제목"
						required>
				</div>
			</section>

			<section class="form-section">
				<h2 class="sub-title">일정 및 장소</h2>
				<div class="form-row c-2">
					<div class="field">
						<label class="field-label strong" for="tmDate">경기일자</label> <input
							class="input" type="date" id="tmDate" name="matchDate">
					</div>
					<div class="field">
						<span class="field-label strong">시간</span>
						<div class="time-range">
							<select class="select" name="startTime">
								<option value="" disabled selected>시간 선택</option>
								<c:forEach var="h" begin="0" end="23">
									<c:set var="hh" value="${h<10 ? '0' :  ''}${h}"></c:set>
									<option value="${hh}:00">${hh}:00</option>
									<option value="${hh}:30">${hh}:30</option>
								</c:forEach>
							</select> 
							<span>~</span> 
							<select class="select" name="endTime">
								<option value="" disabled selected>시간 선택</option>
								<c:forEach var="h" begin="0" end="23">
									<c:set var="hh" value="${h < 10 ? '0' : ''}${h}" />
									<c:if test="${h > 0}">
										<option value="${hh}:00">${hh}:00</option>
									</c:if>
									<option value="${hh}:30">${hh}:30</option>
								</c:forEach>
								<option value="24:00">24:00</option>
							</select>
						</div>
					</div>
				</div>

				<div class="field">
					<label class="field-label strong" for="address">장소</label>
					<div class="field-row place-row">
						<input class="input place-address" id="address" name="address"
							placeholder="주소를 검색하세요" readonly>
						<button type="button" id="postSearch" class="btn btn-primary btn-lg">검색</button>
						<input class="input place-name" id="placeName" name="placeName"
							maxlength="100" placeholder="장소명 (예: 마포 풋살장)">
					</div>
					<input type="hidden" id="lat" name="latitude">
					<input type="hidden" id="lng" name="longitude">
				</div>
			</section>

			<section class="form-section">
				<h2 class="sub-title">경기 설정</h2>
				<div class="form-row c-2">
					<div class="field">
						<label class="field-label strong" for="tmSize">경기 인원</label> <select
							class="select" id="tmSize" name="teamSize">
							<option value="" disabled selected>인원 선택</option>
							<option value="2">2 vs 2</option>
							<option value="3">3 vs 3</option>
							<option value="5">5 vs 5</option>
							<option value="6">6 vs 6</option>
							<option value="8">8 vs 8</option>
							<option value="11">11 vs 11</option>
						</select>
					</div>
					<div class="field">
						<label class="field-label strong" for="tmFee">참가비</label> <input
							class="input" id="tmFee" name="participationFee" value=""
							placeholder="10,000원">
					</div>
				</div>

				<div class="form-row c-2">
					<div class="field">
						<label class="field-label strong" for="tmDeadline">모집 마감</label> <input
							class="input" type="datetime-local" id="tmDeadline"
							name="deadline">
					</div>
				</div>
			</section>

			<section class="form-section">
				<h2 class="sub-title">모집 조건</h2>
				<p class="section-desc">신청 가능한 팀의 연령대, 성별, 팀 레벨을 설정하세요.</p>
				<div class="field">
					<span class="field-label strong">연령대 <span class="hint-gray">복수
							선택 가능</span></span>
					<div class="chip-group" id="agesBtn" data-select="multi">
						<button type="button" class="chip" data-value="20대">20대</button>
						<button type="button" class="chip" data-value="30대">30대</button>
						<button type="button" class="chip" data-value="40대">40대</button>
						<button type="button" class="chip" data-value="50대 이상">50대
							이상</button>
						<button type="button" class="chip" data-value="연령 무관">연령
							무관</button>
					</div>
					<input type="hidden" name="ages" id="ages">
				</div>

				<div class="field">
					<span class="field-label strong">성별</span>
					<div class="chip-group" id="genderBtn" data-select="single">
						<button type="button" class="chip" data-value="남자">남자</button>
						<button type="button" class="chip" data-value="여자">여자</button>
						<button type="button" class="chip" data-value="성별 무관">성별
							무관</button>
					</div>
					<input type="hidden" name="gender" id="gender">
				</div>

				<div class="field">
					<span class="field-label strong">팀 레벨 <span
						class="hint-gray">복수 선택 가능</span></span>
					<div class="chip-group" id="skillBtn" data-select="multi">
						<button type="button" class="chip" data-value="입문">입문</button>
						<button type="button" class="chip" data-value="초급">초급</button>
						<button type="button" class="chip" data-value="중급">중급</button>
						<button type="button" class="chip" data-value="상급">상급</button>
					</div>
					<input type="hidden" name="skill" id="skill">
				</div>
			</section>

			<section class="form-section">
				<h2 class="sub-title">상세 내용</h2>
				<div class="field">
					<label class="field-label strong" for="tmDesc">상세 설명</label>
					<textarea class="textarea soft" id="tmDesc" name="content" rows="5"
						placeholder="경기 방식, 준비물, 팀 유니폼 색상 등을 적어주세요."></textarea>
				</div>

				<div class="field">
					<span class="field-label strong">사진 <span class="hint-gray">선택 · 최대 5장</span></span>
					<div class="photo-upload" id="photoBox">
						<label class="photo-add"><span class="plus">+</span>사진 추가<input
							type="file" id="photoInput" name="photos" accept="image/png,image/jpeg" multiple></label>
					</div>
					<p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p>
				</div>
			</section>

			<div class="form-actions">
				<a class="btn btn-outline" href="${ctx}/team-match/list">취소</a>
				<button type="submit" class="btn btn-primary">등록</button>
			</div>
		</div>
	</form>
</main>
<%@ include file="/jsp/common/footer.jsp"%>
