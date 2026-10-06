<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 정보 수정 (teamEdit.jsp) - 담당: 하준수
  피그마: Club / Info Edit / Desktop
--%>
<c:set var="pageTitle" value="팀 정보 수정" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="team" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<form class="form-rail"
		action="${ctx}/team/edit" method="post"
		enctype="multipart/form-data">
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><span>팀
				정보 수정</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">팀 정보 수정</h1>
			<p class="page-desc">기본 정보와 소개글을 입력해 팀을 수정해보세요.</p>
		</div>
		<div style="width: 744px; max-width: 100%">
			<div class="field">
				<label class="field-label" for="teamName">팀명</label><input
					class="input" id="teamName" name="teamName" value="${team.teamName }"
					placeholder="팀 이름을 입력하세요" required>
			</div>

			<div class="field mt-24">
				<span class="field-label strong">대표 사진 <span class="t-11 t-2"
					style="font-weight: 400">JPG, PNG · 1장</span></span>
				<div class="photo-box">
					<span class="ph">사진</span>
					<div>
						<label class="btn btn-outline btn-sm">+ 사진 선택<input
							type="file" name="logoImg" accept="image/*" hidden></label>
						<p>팀을 대표하는 사진을 등록해주세요. 목록과 상세 화면에 표시됩니다.</p>
					</div>
				</div>
			</div>
			<div class="field mt-24">
				<span class="field-label strong">활동 사진 <span class="t-11 t-2"
					style="font-weight: 400">JPG, PNG · 최대 5장</span></span>
				<div class="photo-box">
					<span class="ph">활동 사진</span><span class="ph">사진 2</span><span
						class="ph">사진 3</span>
					<div>
						<label class="btn btn-outline btn-sm">+ 사진 추가<input
							type="file" name="activityImgs" accept="image/*" multiple hidden></label>
						<p>팀 활동 모습을 보여주는 사진을 여러 장 등록할 수 있어요.</p>
					</div>
				</div>
			</div>

			<div class="field mt-24">
				<label class="field-label" for="sport">종목</label> <select
					class="select" id="sport" name="sportCode" disabled><option
						selected>축구/풋살</option>
					<option>농구</option>
					<option>테니스</option>
					<option>배드민턴</option></select>
				<p class="field-help">종목은 팀 생성 후 변경할 수 없어요.</p>
			</div>

			<div class="field mt-24">
				<span class="field-label strong">활동 요일 <span class="hint"
					style="color: var(- -ds-text-2)">복수 선택 가능</span></span>
				<div class="chip-group" data-select="multi" data-name="days">
					<c:forTokens items="월,화,수,목,금,토,일" delims="," var="d">
						<button type="button"
							class="chip ${d eq '토' or d eq '일' ? 'is-selected' : ''}">${d}</button>
					</c:forTokens>
				</div>
			</div>
			<div class="field mt-24">
				<span class="field-label strong">활동 시간대 <span class="hint"
					style="color: var(- -ds-text-2)">복수 선택 가능</span></span>
				<div class="chip-group" data-select="multi" data-name="times">
					<button type="button" class="chip">새벽 06~09시</button>
					<button type="button" class="chip">오전 09~12시</button>
					<button type="button" class="chip">오후 12~18시</button>
					<button type="button" class="chip is-selected">저녁 18~22시</button>
					<button type="button" class="chip">야간 22~06시</button>
				</div>
			</div>
			<div class="field mt-24">
				<span class="field-label strong">연령대 <span class="hint"
					style="color: var(- -ds-text-2)">복수 선택 가능</span></span>
				<div class="chip-group" data-select="multi" data-name="ages">
					<button type="button" class="chip is-selected">20대</button>
					<button type="button" class="chip is-selected">30대</button>
					<button type="button" class="chip">40대</button>
					<button type="button" class="chip">50대 이상</button>
					<button type="button" class="chip">연령 무관</button>
				</div>
			</div>

			<div class="field mt-24">
				<span class="field-label strong">활동 지역 <span class="hint"
					style="color: var(- -ds-text-2)">복수 선택 가능 · 최대 3개</span></span>
				<div class="region-box">
					<div class="row2">
						<div class="field">
							<span class="field-label">1. 시 · 도</span><select class="select"
								name="sido"><option>서울시</option>
								<option>경기도</option></select>
						</div>
						<div class="field">
							<span class="field-label">2. 세부 지역</span><select class="select"
								name="sigungu"><option>마포구</option>
								<option>영등포구</option>
								<option>서대문구</option></select>
						</div>
					</div>
					<p class="field-help mt-8">서울은 구 단위, 경기도는 시 단위로 선택합니다. 예: 마포구 /
						성남시</p>
					<p class="t-11 t-bold mt-16">선택된 지역 3/3</p>
					<div class="picked">
						<span class="token-chip">서울 마포구
							<button type="button" aria-label="삭제">✕</button>
						</span><span class="token-chip">서울 영등포구
							<button type="button" aria-label="삭제">✕</button>
						</span><span class="token-chip">경기 성남시
							<button type="button" aria-label="삭제">✕</button>
						</span>
					</div>
				</div>
			</div>

			<div class="field mt-24">
				<span class="field-label strong">성별</span>
				<div class="chip-group" data-select="single" data-name="gender">
					<button type="button" class="chip">남자</button>
					<button type="button" class="chip">여자</button>
					<button type="button" class="chip is-selected">성별 무관</button>
				</div>
			</div>
			<div class="field mt-24">
				<span class="field-label strong">팀 레벨 <span class="t-11 t-2"
					style="font-weight: 400">대표적인 팀 실력을 선택해주세요.</span></span>
				<div class="chip-group" data-select="single" data-name="level">
					<button type="button" class="chip">입문</button>
					<button type="button" class="chip is-selected">초급</button>
					<button type="button" class="chip">중급</button>
					<button type="button" class="chip">상급</button>
				</div>
			</div>
			<div class="field mt-24">
				<label class="field-label strong" for="intro">팀 소개</label>
				<textarea class="textarea" id="intro" name="intro" rows="6"
					placeholder="모임 성격, 활동 방식, 가입 조건 등을 적어주세요.">주말 저녁에 가볍게 풋살하는 모임입니다. 초보자도 참가할 수 있고, 월 2~3회 정기 경기를 진행합니다.</textarea>
			</div>

			<div class="form-actions">
				<a class="btn btn-outline"
					href="${ctx}/jsp/team/teamManageApplication.jsp">취소</a>
				<button type="submit" class="btn btn-primary">수정 완료</button>
			</div>
		</div>
	</form>
</main>
<%@ include file="/jsp/common/footer.jsp"%>
