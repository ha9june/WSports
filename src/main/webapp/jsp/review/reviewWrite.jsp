<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  후기 작성 (reviewWrite.jsp) - 담당: 강신우
  피그마: Review / Form / Desktop, Review / Form / From Past Match, Review / Form / From Club Match
   state : select(참여 경기 직접 선택) | pastMatch(개인 경기에서 진입 - 경기 고정) | clubMatch(팀 경기에서 진입 - 경기 고정)
--%>

<c:set var="pageTitle" value="후기 작성" />
<c:set var="pageCss" value="review" />
<c:set var="activeNav" value="review" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates"
	value="select:경기 선택|pastMatch:개인 경기에서|clubMatch:팀 경기에서" />
<%@ include file="/jsp/common/header.jsp"%>
<style>
/* 내용 입력칸과 사진 영역 사이 간격 */
.photo-upload {
	display: flex;
	flex-wrap: wrap;
	align-items: flex-start;
	gap: 14px;
	margin-top: 28px;
	padding-top: 4px;
}

/* 미리보기 목록 */
#photoPreviewList {
	display: flex;
	flex-wrap: wrap;
	gap: 14px;
}

.photo-item {
	position: relative;
	width: 130px;
	height: 120px;
}

.photo-item img {
	display: block;
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 12px;
	border: 1px solid #e5e7eb;
}

/* 삭제 버튼: 사진 오른쪽 위 모서리 바깥으로 튀어나오게 */
.photo-del {
	position: absolute;
	top: -9px;
	right: -9px;
	width: 26px;
	height: 26px;
	padding: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 2px solid #fff;
	border-radius: 50%;
	background: #0b5fff;
	color: #fff;
	font-size: 16px;
	font-weight: 700;
	line-height: 1;
	cursor: pointer;
	box-shadow: 0 2px 6px rgba(0, 0, 0, .3);
}

.photo-del:hover {
	background: #ef4444;
}

.field-help {
	margin-top: 12px;
}
</style>
<main class="page">
	<form class="rail" action="${ctx}/review/create" method="post"
		enctype="multipart/form-data"
		style="display: block; box-sizing: border-box; width: 100%; max-width: 744px; margin: 0 auto !important; padding-left: 0 !important; padding-right: 0 !important;">
		<nav class="breadcrumb">
			<a href="${ctx}/review/list">후기</a><span class="sep">›</span><span>작성</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">후기 작성</h1>
			<p class="page-desc">경기 후기를 작성하고 경험을 공유해보세요.</p>
		</div>

		<div style="width: 100%;">
			<div class="field">
				<label class="field-label" for="matchNo">참여 경기</label>
				<c:choose>
					<c:when test="${not empty fixedMatch}">
						<input type="text" class="input"
							style="background: #f3f4f6; color: #6b7280; cursor: not-allowed;"
							value="<c:out value='${fixedMatch.matchTitle}'/>" readonly>
						<input type="hidden" name="matchNo"
							value="${fixedMatch.matchType}:${fixedMatch.matchId}">
					</c:when>
					<c:otherwise>
						<select class="select" id="matchNo" name="matchNo"
							style="width: 100%; display: block;" required>
							<option value="">참여한 경기를 선택하세요</option>
							<c:forEach var="m" items="${myMatches}">
								<option value="${m.matchType}:${m.matchId}">${m.title}</option>
							</c:forEach>
						</select>
					</c:otherwise>
				</c:choose>
			</div>

			<div class="field mt-24" style="margin-top: 24px !important;">
				<label class="field-label" for="rvTitle">제목</label> <input
					class="input" id="rvTitle" name="title" style="width: 100%"
					placeholder="후기 제목을 입력하세요" required>
			</div>

			<div class="field mt-24">
				<label class="field-label" for="rvBody">내용</label>
				<textarea class="textarea soft" id="rvBody" name="content" rows="7"
					style="width: 100%; display: block;"
					placeholder="경기에서 좋았던 점이나 참고할 내용을 적어주세요." required></textarea>
			</div>
			<div class="photo-upload">
				<label class="photo-add"><span class="plus">+</span>사진 추가 <input
					type="file" id="photos" name="photos" accept="image/png,image/jpeg"
					multiple hidden> </label>
				<div id="photoPreviewList"></div>
			</div>
			<p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p>
		</div>

		<div class="form-actions">
			<a class="btn btn-outline" href="${ctx}/review/list">취소</a>
			<button type="submit" class="btn btn-primary">등록</button>
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