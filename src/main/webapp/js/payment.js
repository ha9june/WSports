/* =========================================================
   결제 : 환불 정책 동의 체크 → 결제 버튼 활성화 → 토스페이먼츠 결제창 호출
   ========================================================= */
(function () {
  'use strict';
  var agree = document.getElementById('refundAgree');
  var openBtn = document.getElementById('payOpenBtn');
  if (agree && openBtn) {
    agree.addEventListener('change', function () { openBtn.disabled = !agree.checked; });
    // 확인 모달 상태로 바로 열린 경우(시연)에는 동의 처리
    if (document.querySelector('#payConfirmModal.is-open')) { agree.checked = true; openBtn.disabled = false; }
  }

  var payBtn = document.getElementById('tossPayBtn');
  if (!payBtn) return;
  payBtn.addEventListener('click', function () {
    var amount = Number(payBtn.dataset.amount);
    var orderId = 'MATCHON-' + Date.now(); // TODO: 서버에서 주문번호 생성 후 전달받기
    var successUrl = location.origin + payBtn.dataset.successUrl;
    var failUrl = location.origin + payBtn.dataset.failUrl;

    // TODO: 실제 클라이언트 키로 교체 (테스트 키 : test_ck_ 로 시작)
    var CLIENT_KEY = '';
    if (window.TossPayments && CLIENT_KEY) {
      var toss = window.TossPayments(CLIENT_KEY);
      toss.requestPayment('카드', {
        amount: amount,
        orderId: orderId,
        orderName: payBtn.dataset.orderName,
        successUrl: successUrl,
        failUrl: failUrl
      }).catch(function (err) {
        if (err.code !== 'USER_CANCEL') location.href = failUrl + '?code=' + err.code + '&message=' + encodeURIComponent(err.message);
      });
    } else {
      // [시연] 클라이언트 키가 없으면 결제 성공 화면으로 바로 이동
      location.href = successUrl + '?paymentKey=demo&orderId=' + orderId + '&amount=' + amount;
    }
  });
})();
