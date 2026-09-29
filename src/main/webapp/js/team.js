/* =========================================================
   팀 : 필수 입력(거절 사유 등)이 채워져야 버튼 활성화
   - <textarea data-require-for="버튼id"> 형태로 사용
   ========================================================= */
(function () {
  'use strict';
  document.querySelectorAll('[data-require-for]').forEach(function (field) {
    var btn = document.getElementById(field.getAttribute('data-require-for'));
    if (!btn) return;
    var sync = function () { btn.disabled = field.value.trim() === ''; };
    field.addEventListener('input', sync);
    sync();
  });

  // 팀원 메뉴에서 모달을 열 때 대상 닉네임을 모달 제목에 반영
  document.addEventListener('click', function (e) {
    var el = e.target.closest('[data-member-name]');
    if (!el) return;
    var name = el.getAttribute('data-member-name');
    document.querySelectorAll('[data-fill-name]').forEach(function (t) { t.textContent = name; });
  }, true);
})();
