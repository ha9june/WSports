<%@ page pageEncoding="UTF-8" %>
<%--
  관리자(사이트) 사이드바 (adminSideBar.jsp)
   - adminMenu : revenue | settlement | member | report | team | inquiry | notice
  ※ 이 파일은 <div class="workspace admin"> ... <main class="work"> 를 열어둡니다.
     페이지 본문 마지막에서 </main></div> 로 닫아주세요.
--%>
<div class="workspace admin ${adminGray ? 'gray' : ''}">
	<aside class="side" aria-label="관리자 메뉴">
    	<div class="group">
      		<p class="group-title">관리자(사이트) 메뉴</p>
      		<nav class="menu">
        		<a href="${ctx}/admin/revenue" class="${adminMenu eq 'revenue' ? 'is-active' : ''}">수익 관리</a>
        		<a href="${ctx}/admin/settlement/person" class="${adminMenu eq 'settlement' ? 'is-active' : ''}">정산 관리 <span class="count-badge">5</span></a>
        		<a href="${ctx}/admin/member" class="${adminMenu eq 'member' ? 'is-active' : ''}">회원 관리 <span class="count-badge">3</span></a>
        		<a href="${ctx}/admin/team" class="${adminMenu eq 'team' ? 'is-active' : ''}">팀 관리 <span class="count-badge">2</span></a>
        		<a href="${ctx}/admin/report" class="${adminMenu eq 'report' ? 'is-active' : ''}">신고 관리 <span class="count-badge">7</span></a>
       			<a href="${ctx}/admin/inquiry" class="${adminMenu eq 'inquiry' ? 'is-active' : ''}">문의 관리 <span class="count-badge">5</span></a>
        		<a href="${ctx}/admin/notice" class="${adminMenu eq 'notice' ? 'is-active' : ''}">공지 관리 <span class="count-badge">0</span></a>
      		</nav>
    	</div>
    	<div class="admin-stats">
      		<strong>운영 현황</strong>
      		<div class="grid">
        		<div>회원<b>1,248명</b></div>
        		<div>팀<b>328개</b></div>
        		<div>진행 경기<b>3,492건</b></div>
        		<div>수익<b>1,248만원</b></div>
      		</div>
    	</div>
    </aside>
	<main class="work">

