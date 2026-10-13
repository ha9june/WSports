<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  알림 (myPageAlarm.jsp) - 담당: 강신우
  피그마: MyPage / Notifications / Desktop
  미확인 알림을 누르면 읽음 처리 후 관련 화면으로 이동합니다.
--%>
<c:set var="pageTitle" value="알림" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="alarm" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<style>
.noti-list {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.noti-head {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
}

.noti-head form {
	margin: 0;
}

.noti-readall {
	height: 36px;
	padding: 0 16px;
	border: 1px solid #d1d5db;
	border-radius: 10px;
	background: #fff;
	color: #111;
	font-size: 12px;
	font-weight: 700;
	cursor: pointer;
	transition: background .2s;
}

.noti-readall:hover:not(:disabled) {
	background: #f3f4f6;
}

.noti-readall:disabled {
	opacity: .4;
	cursor: default;
}

.noti-sec-title {
	margin: 40px 0 12px;
	font-size: 16px;
	font-weight: 800;
	display: flex;
	align-items: center;
	gap: 8px;
}


.noti-list>.noti-item {
	border: 0;
	padding: 0;
	margin: 0;
	background: none;
	box-shadow: none;
	border-radius: 0;
}

.noti-item.is-extra {
	display: none;
}

.noti-item form {
	margin: 0;
}

.noti-card {
	position: relative;
	display: block;
	width: 100%;
	box-sizing: border-box;
	text-align: left;
	font: inherit;
	color: inherit;
	text-decoration: none;
	padding: 14px 20px 14px 36px;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-radius: 12px;
}

button.noti-card, a.noti-card {
	cursor: pointer;
}

.noti-card.unread {
	background: #f5f8ff;
}

.noti-card.unread::before {
	content: "";
	position: absolute;
	left: 16px;
	top: 20px;
	width: 8px;
	height: 8px;
	border-radius: 50%;
	background: #2563eb;
}

.noti-row {
	display: flex;
	justify-content: space-between;
	gap: 12px;
}

.noti-title {
	font-size: 13px;
	font-weight: 700;
}

.noti-time {
	font-size: 12px;
	color: #94a3b8;
	white-space: nowrap;
}

.noti-body {
	margin-top: 6px;
	font-size: 12.5px;
	color: #64748b;
}

.noti-empty {
	padding: 20px;
	text-align: center;
	font-size: 13px;
	color: #94a3b8;
	border: 1px dashed #e5e7eb;
	border-radius: 12px;
}

.noti-more-wrap {
	display: flex;
	justify-content: center;
	margin-top: 16px;
}

.noti-more {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	min-width: 140px;
	height: 44px;
	padding: 0 24px;
	border: 1px solid #1a6bff;
	border-radius: 999px;
	background: #fff;
	color: #1a6bff;
	font-size: 14px;
	font-weight: 700;
	cursor: pointer;
	transition: background .2s, color .2s;
}

.noti-more:hover {
	background: #1a6bff;
	color: #fff;
}

.noti-more-wrap[hidden] {
	display: none;
}
</style>
<%-- 미확인/확인 개수 계산 (isRead 가 Integer/Long/Boolean 어느 타입이어도 동작) --%>
<c:set var="uCnt" value="0" />
<c:set var="rCnt" value="0" />
<c:forEach var="n" items="${notiList}">
	<c:choose>
		<c:when test="${n.isRead ne 0}">
			<c:set var="rCnt" value="${rCnt + 1}" />
		</c:when>
		<c:otherwise>
			<c:set var="uCnt" value="${uCnt + 1}" />
		</c:otherwise>
	</c:choose>
</c:forEach>


<main class="page">
	<div class="rail">
		<div class="page-head noti-head">
			<div>
				<h1 class="page-title">알림</h1>
				<p class="page-desc">중요한 활동 소식만 빠르게 확인하세요.</p>
			</div>
			<form method="post" action="${ctx}/mypage/notifications">
				<input type="hidden" name="action" value="readAll">
				<button type="submit" class="noti-readall"
					${uCnt == 0 ? 'disabled' : ''}>모두 읽음</button>
			</form>
		</div>

		<%-- ===== 미확인 ===== --%>
		<section data-noti-section>
			<h2 class="noti-sec-title" >
				미확인
			</h2>
			<div class="noti-list">
				<c:set var="idx" value="0" />
				<c:forEach var="n" items="${notiList}">
					<c:if test="${n.isRead eq 0}">
						<c:set var="idx" value="${idx + 1}" />
						<div class="noti-item ${idx > 5 ? 'is-extra' : ''}">
							<%-- 클릭 시 읽음 처리 후 link 로 이동 (서버에서 updateRead → selectLink → redirect) --%>
							<form method="post" action="${ctx}/mypage/notifications">
								<input type="hidden" name="action" value="read"> <input
									type="hidden" name="notificationId" value="${n.notificationId}">
								<button type="submit" class="noti-card unread">
									<div class="noti-row">
										<div class="noti-title">
											<c:out value="${n.title}" />
										</div>
										<div class="noti-time">
											<c:out value="${n.createdAtStr}" />
										</div>
									</div>
									<div class="noti-body">
										<c:out value="${n.content}" />
									</div>
								</button>
							</form>
						</div>
					</c:if>
				</c:forEach>
				<c:if test="${uCnt == 0}">
					<div class="noti-empty">미확인 알림이 없습니다.</div>
				</c:if>
			</div>
			<div class="noti-more-wrap" hidden>
				<button type="button" class="noti-more">↓ 더보기</button>
			</div>
		</section>

		<%-- ===== 확인 ===== --%>
		<section data-noti-section>
			<h2 class="noti-sec-title">확인</h2>
			<div class="noti-list">
				<c:set var="idx" value="0" />
				<c:forEach var="n" items="${notiList}">
					<c:if test="${n.isRead ne 0}">
						<c:set var="idx" value="${idx + 1}" />
						<div class="noti-item ${idx > 5 ? 'is-extra' : ''}">
							<c:choose>
								<c:when test="${not empty n.link}">
									<a class="noti-card" href="${ctx}${n.link}">
										<div class="noti-row">
											<div class="noti-title">
												<c:out value="${n.title}" />
											</div>
											<div class="noti-time">
												<c:out value="${n.createdAtStr}" />
											</div>
										</div>
										<div class="noti-body">
											<c:out value="${n.content}" />
										</div>
									</a>
								</c:when>
								<c:otherwise>
									<div class="noti-card">
										<div class="noti-row">
											<div class="noti-title">
												<c:out value="${n.title}" />
											</div>
											<div class="noti-time">
												<c:out value="${n.createdAtStr}" />
											</div>
										</div>
										<div class="noti-body">
											<c:out value="${n.content}" />
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
				</c:forEach>
				<c:if test="${rCnt == 0}">
					<div class="noti-empty">확인한 알림이 없습니다.</div>
				</c:if>
			</div>
			<div class="noti-more-wrap" hidden>
				<button type="button" class="noti-more">↓ 더보기</button>
			</div>
		</section>
	</div>
</main>
<script>
	(function() {
		var STEP = 5;
		document
				.querySelectorAll('[data-noti-section]')
				.forEach(
						function(sec) {
							var wrap = sec.querySelector('.noti-more-wrap');
							var btn = sec.querySelector('.noti-more');

							function update() {
								wrap.hidden = sec
										.querySelectorAll('.noti-item.is-extra').length === 0;
							}

							btn
									.addEventListener(
											'click',
											function() {
												var hidden = sec
														.querySelectorAll('.noti-item.is-extra');
												for (var i = 0; i < Math.min(
														STEP, hidden.length); i++) {
													hidden[i].classList
															.remove('is-extra');
												}
												update();
											});

							update();
						});
	})();
</script>
<%@ include file="/jsp/common/footer.jsp"%>
