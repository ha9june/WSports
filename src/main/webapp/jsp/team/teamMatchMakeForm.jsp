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
<script type="text/javascript">
$(function () {
	function syncSport() {
		var sport = $('#team').find('option:selected').data('sport') || '';
		$('.sport-readonly .chip').removeClass('is-selected')
			.filter(function () { return $(this).data('value') === sport; })
			.addClass('is-selected');
		$('#sportCode').val(sport);
	}

	// 팀의 성별을 기본 선택으로 채움 (사용자가 이후 바꿀 수 있음)
	function syncGender() {
		var gender = $('#team').find('option:selected').data('gender') || '';
		$('#genderBtn .chip').removeClass('is-selected')
			.filter(function () { return $(this).data('value') === gender; })
			.addClass('is-selected');
		$('#gender').val(gender);
	}

	$('#team').on('change', function () {
		syncSport();
		syncGender();
	});
	syncSport();
	syncGender();

	// 사용자가 성별 칩을 직접 바꿀 때 hidden 갱신
	$('#genderBtn').on('click', '.chip', function () {
		$('#gender').val($(this).data('value'));
	});
});
</script>
<main class="page">
	<form class="form-rail"
		action="${ctx}/jsp/team/teamMatchDetail.jsp?state=hostRecruiting"
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
			<div class="form-row c-2">
				<div class="field">
					<label class="field-label strong" for="team">팀</label> 
					<select class="select" id="team" name="teamNo">
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
					<button type="button" class="chip" data-value="축구/풋살" tabindex="-1">축구/풋살</button>
					<button type="button" class="chip" data-value="농구" tabindex="-1">농구</button>
					<button type="button" class="chip" data-value="테니스" tabindex="-1">테니스</button>
					<button type="button" class="chip" data-value="배드민턴" tabindex="-1">배드민턴</button>
				</div>
				<input type="hidden" name="sportCode" id="sportCode">
			</div>
			</div>

			<div class="field mt-24">
				<label class="field-label strong" for="tmTitle">제목</label> 
				<input class="input" id="tmTitle" name="title" value=""
					placeholder="제목" required>
			</div>

			<div class="form-row c-2 mt-24">
				<div class="field">
					<label class="field-label strong" for="tmDate">경기일자</label> 
					<input class="input" type="date" id="tmDate" name="matchDate">
				</div>
				<div class="field">
					<span class="field-label strong">시간</span>
					<div class="time-range">
						<select class="select" name="startTime">
							<c:forEach var="h" begin="0" end="23">
								<c:set var="hh" value="${h<10 ? '0' :  ''}${h}"></c:set>
								<option value="${hh}:00">${hh}:00</option>
								<option value="${hh}:30">${hh}:30</option>
							</c:forEach>
						</select> 
						<span>~</span> 
						<select class="select" name="endTime">
							<c:forEach var="h" begin="0" end="23">
								<c:set var="hh" value="${h < 10 ? '0' : ''}${h}" />
								<c:if test="${h > 0}"><option value="${hh}:00">${hh}:00</option></c:if>
								<option value="${hh}:30">${hh}:30</option>
							</c:forEach>
							<option value="24:00">24:00</option>
						</select>
					</div>
				</div>
			</div>

			<div class="form-row c-2 mt-24">
				<div class="field">
					<label class="field-label strong" for="tmDeadline">모집 마감</label> <input
						class="input" type="datetime-local" id="tmDeadline"
						name="deadline">
				</div>
				<div class="field">
					<label class="field-label strong" for="tmSize">경기 인원</label> <select
						class="select" id="tmSize" name="teamSize">
						<option>인원 선택</option>
						<option value="2">2 vs 2</option>
						<option value="3">3 vs 3</option>
						<option value="5">5 vs 5</option>
						<option value="6">6 vs 6</option>
						<option value="8">8 vs 8</option>
						<option value="11">11 vs 11</option>
					</select>
				</div>
			</div>

			<div class="form-row c-wide mt-24">
				<div class="field">
					<label class="field-label strong" for="tmPlace">장소</label> <input
						class="input" id="tmPlace" name="place" value=""
						placeholder="장소를 검색하세요">
				</div>
				<div class="field">
					<label class="field-label strong" for="tmFee">참가비</label> <input
						class="input" id="tmFee" name="fee" value="" placeholder="50,000원">
				</div>
			</div>

			<div class="field mt-24">
				<span class="field-label strong">연령대 <span class="hint-gray">복수
						선택 가능</span></span>
				<div class="chip-group" id="agesBtn" data-select="multi">
					<button type="button" class="chip" data-value="20대">20대</button>
					<button type="button" class="chip" data-value="30대">30대</button>
					<button type="button" class="chip" data-value="40대">40대</button>
					<button type="button" class="chip" data-value="50대 이상">50대 이상</button>
					<button type="button" class="chip" data-value="연령 무관">연령 무관</button>
				</div>
				<input type="hidden" name="ages" id="ages">
			</div>

			<div class="field mt-24">
				<span class="field-label strong">성별</span>
				<div class="chip-group" id="genderBtn" data-select="single">
					<button type="button" class="chip" data-value="남자">남자</button>
					<button type="button" class="chip" data-value="여자">여자</button>
					<button type="button" class="chip" data-value="성별 무관">성별 무관</button>
				</div>
				<input type="hidden" name="gender" id="gender">
			</div>

			<div class="field mt-24">
				<span class="field-label strong">팀 레벨 <span class="hint-gray">복수
						선택 가능</span></span>
				<div class="chip-group" data-select="multi" data-name="levels">
					<button type="button" class="chip">입문</button>
					<button type="button" class="chip is-selected">초급</button>
					<button type="button" class="chip">중급</button>
					<button type="button" class="chip">상급</button>
				</div>
			</div>

			<div class="field mt-24">
				<label class="field-label strong" for="tmDesc">상세 설명</label>
				<textarea class="textarea soft" id="tmDesc" name="content" rows="5"
					placeholder="경기 방식, 준비물, 팀 유니폼 색상 등을 적어주세요."></textarea>
			</div>

			<div class="field mt-24">
				<span class="field-label strong">사진 <span class="hint-gray">선택
						· 최대 5장</span></span>
				<div class="photo-upload">
					<label class="photo-add"><span class="plus">+</span>사진 추가<input
						type="file" name="photos" accept="image/png,image/jpeg" multiple
						data-preview data-max="5"></label>
					<div class="photo-preview">미리보기</div>
					<div class="photo-preview">미리보기</div>
				</div>
				<p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p>
			</div>

			<div class="form-actions">
				<a class="btn btn-outline" href="${ctx}/jsp/team/teamMatchList.jsp">취소</a>
				<button type="submit" class="btn btn-primary">등록</button>
			</div>
		</div>
	</form>
</main>
<%@ include file="/jsp/common/footer.jsp"%>
