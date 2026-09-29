<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  수익 관리 (adminRevenue.jsp) - 담당: 임태균
  피그마: Admin / Revenue Dashboard (수익 대시보드)
  월별 매출/수익 막대 그래프와 기간 조회 결과. TODO: 그래프 높이는 금액 비율(%)로 계산해 style 에 넣기
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="수익 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="revenue" />
<c:set var="demoRoles" value="admin" />
<c:set var="adminGray" value="true" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  <p class="eyebrow-path">관리자(사이트) / 수익 관리</p>
  <div class="page-head"><h1 class="page-title">수익 대시보드</h1><p class="page-desc">매출과 플랫폼 수익 흐름을 한눈에 확인합니다.</p></div>
  <div class="kpi-grid">
    <div class="kpi"><p>총 매출</p><b>56,824,000원</b><small>누적 결제 금액</small></div>
    <div class="kpi"><p>총 수익</p><b>4,218,500원</b><small>플랫폼 순수익</small></div>
    <div class="kpi"><p>월간 매출</p><b>18,742,000원</b><small>9월 결제 금액</small></div>
    <div class="kpi"><p>월간 수익</p><b>1,513,900원</b><small>9월 순수익</small></div>
  </div>
  <section class="admin-panel">
    <div class="head"><div><h2>월별 매출과 수익</h2><p>최근 6개월 실적 비교 · 단위 만원</p></div>
      <div class="legend"><span><i style="background:#2b4257"></i>매출</span><span><i style="background:var(--ds-brand)"></i>수익</span></div></div>
    <div class="bar-chart" role="img" aria-label="4월부터 9월까지 월별 매출과 수익 막대 그래프">
      <c:forTokens var="b" delims="|" items="4월^45^35|5월^40^30|6월^52^43|7월^56^45|8월^60^50|9월^76^62">
        <c:set var="v" value="${fn:split(b, '^')}" />
        <div class="grp"><div class="bars"><i class="sales" style="height:${v[1]}%"></i><i class="profit" style="height:${v[2]}%"></i></div><span>${v[0]}</span></div>
      </c:forTokens>
    </div>
    <div style="height:20px"></div>
  </section>
  <form class="admin-panel" method="get">
    <div class="period-panel">
      <strong class="t-13" style="padding-bottom:10px">기간 조회</strong>
      <div class="field"><label class="field-label t-11">시작 날짜</label><input class="input sm" type="date" name="from" value="2026-09-01"></div>
      <div class="field"><label class="field-label t-11">종료 날짜</label><input class="input sm" type="date" name="to" value="2026-09-30"></div>
      <button type="submit" class="btn btn-primary btn-sm" style="margin-bottom:2px">조회</button>
      <span class="note">조회 기간 2026.09.01 - 2026.09.30 · 30일</span>
    </div>
    <div class="period-result">
      <div><p>결제 건수</p><b>1,284건</b></div><div><p>총 매출</p><b>18,741,264원</b></div><div><p>수익</p><b>1,514,294원</b></div><div><p>수익률</p><b>8.08%</b></div>
    </div>
  </form>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
