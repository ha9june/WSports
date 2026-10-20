<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  후기 작성 (reviewWrite.jsp) - 담당: 강신우
  피그마: Review / Form / Desktop, Review / Form / From Past Match, Review / Form / From Club Match
   state : select(참여 경기 직접 선택) | pastMatch(개인 경기에서 진입 - 경기 고정) | clubMatch(팀 경기에서 진입 - 경기 고정)
--%>

<c:set var="pageTitle" value="후기 작성" />
<c:set var="pageCss" value="match,team,review" />
<c:set var="activeNav" value="review" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates"
	value="select:경기 선택|pastMatch:개인 경기에서|clubMatch:팀 경기에서" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<form class="form-rail match-form review-form" action="${ctx}/review/create" method="post"
		enctype="multipart/form-data">
		<nav class="breadcrumb">
			<a href="${ctx}/review/list">후기</a><span class="sep">›</span><span>작성</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">후기 작성</h1>
			<p class="page-desc">경기 후기를 작성하고 경험을 공유해보세요.</p>
		</div>

		<div class="team-form-inner">
			<section class="form-section match-section">
				<h2 class="sub-title">참여 경기</h2>
				<div class="field">
					<c:choose>
						<%-- 마이페이지에서 진입: 경기 고정 (라벨 숨김) --%>
						<c:when test="${not empty fixedMatch}">
							<label class="sr-only" for="matchNo">참여 경기</label>
							<input type="text" class="input" id="matchNo"
								value="<c:out value='${fixedMatch.matchTitle}'/>" readonly>
							<input type="hidden" name="matchNo"
								value="${fixedMatch.matchType}:${fixedMatch.matchId}">
						</c:when>
						<%-- 후기 목록에서 진입: 직접 선택 --%>
						<c:otherwise>
							<label class="field-label strong" for="matchNo">경기 선택</label>
							<select class="select" id="matchNo" name="matchNo" required>
								<option value="">참여한 경기를 선택하세요</option>
								<c:forEach var="m" items="${myMatches}">
									<option value="${m.matchType}:${m.matchId}"><c:out value="${m.title}" /></option>
								</c:forEach>
							</select>
						</c:otherwise>
					</c:choose>
				</div>
			</section>

			<section class="form-section">
				<h2 class="sub-title">후기 내용</h2>
				<div class="field">
					<label class="field-label strong" for="rvTitle">제목</label>
					<input class="input" id="rvTitle" name="title" placeholder="후기 제목을 입력하세요" required>
				</div>
				<div class="field">
					<label class="field-label strong" for="rvBody">내용</label>
					<textarea class="textarea soft" id="rvBody" name="content" rows="7"
						placeholder="경기에서 좋았던 점이나 참고할 내용을 적어주세요." required></textarea>
				</div>
				<div class="field">
					<span class="field-label strong">사진 <span class="hint-gray">선택 · 최대 5장</span></span>
					<div class="photo-upload">
						<label class="photo-add"><span class="plus">+</span>사진 추가
							<input type="file" id="photos" name="photos" accept="image/png,image/jpeg" multiple hidden>
						</label>
						<div id="photoPreviewList"></div>
					</div>
					<p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p>
				</div>
			</section>

			<div class="form-actions">
				<a class="btn btn-outline" href="${ctx}/review/list">취소</a>
				<button type="submit" class="btn btn-primary">등록</button>
			</div>
		</div>
	</form>
	<script>
		(function() {
			var MAX = 5;
			var selected = [];
			var input = document.getElementById("photos");
			var list = document.getElementById("photoPreviewList");

			input.addEventListener("change", function() {
				var incoming = Array.from(input.files);
				if (selected.length + incoming.length > MAX) {
					alert("사진은 최대 5장까지 첨부할 수 있어요.");
				}
				incoming.forEach(function(f) {
					if (selected.length < MAX)
						selected.push(f);
				});
				render();
			});

			function render() {
				// 서버로 전송될 파일 목록을 누적본으로 교체
				var dt = new DataTransfer();
				selected.forEach(function(f) {
					dt.items.add(f);
				});
				input.files = dt.files;

				list.innerHTML = "";
				selected.forEach(function(file, idx) {
					var wrap = document.createElement("div");
					wrap.className = "photo-item";

					var img = document.createElement("img");
					img.alt = "첨부 사진 " + (idx + 1);
					var reader = new FileReader();
					reader.onload = function(e) {
						img.src = e.target.result;
					};
					reader.readAsDataURL(file);

					var del = document.createElement("button");
					del.type = "button";
					del.className = "photo-del";
					del.textContent = "×";
					del.title = "사진 삭제";
					del.setAttribute("aria-label", "사진 삭제");
					del.onclick = function() {
						selected.splice(idx, 1);
						render();
					};

					wrap.appendChild(img);
					wrap.appendChild(del);
					list.appendChild(wrap);
				});
			}
		})();
	</script>
</main>
<%@ include file="/jsp/common/footer.jsp"%>