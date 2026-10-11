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
.noti-item {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	padding: 14px 20px 14px 36px;
	margin-bottom: 8px;
	border: 1px solid #e5e7eb;
	border-radius: 10px;
	background: #fff;
	position: relative;
	text-decoration: none;
	color: inherit;
}

.noti-item.unread {
	background: #f7f8fa;
}

.noti-item.unread::before {
	content: "";
	position: absolute;
	left: 16px;
	top: 20px;
	width: 7px;
	height: 7px;
	border-radius: 50%;
	background: #0d6efd;
}

.noti-body {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

.noti-title {
	font-size: 14px;
	font-weight: 700;
}

.noti-desc {
	font-size: 12px;
	color: #6b7280;
}

.noti-time {
	font-size: 12px;
	color: #9ca3af;
	white-space: nowrap;
}
</style>

<div class="work-inner" style="width: 860px">
	<div class="page-head row" style="margin-bottom: 0">
		<div>
			<h1 class="page-title">알림</h1>
			<p class="page-desc">중요한 활동 소식만 빠르게 확인하세요.</p>
		</div>
		<form method="post" action="${ctx}/mypage/notifications/read-all">
			<button type="submit" class="btn btn-outline btn-sm">모두 읽음</button>
		</form>
	</div>

	<section class="noti-group">
	<h3>미확인</h3>
	<c:forEach var="n" items="${notiList}">
		<c:if test="${not n.isRead}">
			<form method="post" action="${ctx}/mypage/notifications/read"
				style="margin: 0">
				<input type="hidden" name="id" value="${n.notificationId}">
				<button type="submit" class="noti-item unread"
					style="width: 100%; text-align: left; font: inherit; cursor: pointer">
					<div class="noti-body">
						<strong class="noti-title"><c:out value="${n.title}" /></strong>
						<span class="noti-desc"><c:out value="${n.content}" /></span>
					</div>
					<small class="noti-time">${n.createdAtStr}</small>
				</button>
			</form>
		</c:if>
	</c:forEach>
</section>
	<section class="noti-group" style="margin-top: 28px">
		<h3>확인</h3>
		<c:forEach var="n" items="${notiList}">
			<c:if test="${n.isRead}">
				<a class="noti-item ${n.isRead ? '' : 'unread'}"
					href="${ctx}${n.link}">
					<div class="noti-body">
						<strong class="noti-title"><c:out value="${n.title}" /></strong>
						<span class="noti-desc"><c:out value="${n.content}" /></span>
					</div> <small class="noti-time">${n.createdAtStr}</small>
				</a>
			</c:if>
		</c:forEach>
	</section>
</div>
</main>
</div>
<%@ include file="/jsp/common/footer.jsp"%>
