/* =========================================================
   홈 / 경기 찾기 : 필터 더보기, 필터 초기화, 지도 핀 선택, 지도 검색 자동완성
   ========================================================= */
(function () {
  'use strict';

  // 필터 더보기 패널
  document.querySelectorAll('.filter-more').forEach(function (box) {
    var btn = box.querySelector('[data-filter-toggle]');
    var countEl = box.querySelector('.count');
    var panel = box.querySelector('.filter-panel');

    if (!btn || !panel) return;

    btn.addEventListener('click', function (e) {
      e.stopPropagation();
      box.classList.toggle('is-open');
    });

    panel.addEventListener('click', function () {
      setTimeout(function () {
        // '전체' 를 제외한 선택 칩 수를 배지에 표시
        var n = box.querySelectorAll(
          '.filter-panel .chip.is-selected:not([data-all])'
        ).length;

        if (countEl) countEl.textContent = n;
      }, 0);
    });
  });

  document.addEventListener('click', function (e) {
    // 필터 내부 클릭이면 패널을 닫지 않음
    if (e.target.closest('.filter-more')) return;

    document.querySelectorAll('.filter-more.is-open').forEach(function (b) {
      b.classList.remove('is-open');
    });
  });


  // 필터 초기화
  document.querySelectorAll('[data-filter-reset]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var shell = btn.closest('.search-shell');

      if (!shell) return;

      shell.querySelectorAll('.chip.is-selected:not([data-all])')
        .forEach(function (c) {
          c.classList.remove('is-selected');
        });

      shell.querySelectorAll('.chip[data-all]')
        .forEach(function (c) {
          c.classList.add('is-selected');
        });

      // common.js가 만든 hidden 필터값 초기화
      shell.querySelectorAll('.chip-group[data-name]')
        .forEach(function (group) {
          var name = group.getAttribute('data-name');

          var hidden = group.querySelector(
            'input[type="hidden"][name="' + name + '"]'
          );

          if (hidden) hidden.value = '';
        });

      var countEl = shell.querySelector('.filter-more .count');
      if (countEl) countEl.textContent = '0';

      shell.querySelectorAll('input[type=text]').forEach(function (i) {
        i.value = '';
      });
    });
  });


  // ↓↓↓ 여기부터 기존 지도 코드 그대로 ↓↓↓

  // 지도 핀 / 목록 선택 (데모: 같은 data-pin 값끼리 활성화)
  function selectPin(key) {
    document.querySelectorAll('[data-pin]').forEach(function (el) {
      el.classList.toggle('is-active', el.getAttribute('data-pin') === key);
    });
  }

  document.querySelectorAll('.map-canvas .pin, .map-list a').forEach(function (el) {
    el.addEventListener('click', function (e) {
      if (el.classList.contains('is-active') && el.tagName === 'A') return;
      e.preventDefault();
      selectPin(el.getAttribute('data-pin'));
    });
  });

  // 지도 검색 입력 : 입력 중이면 자동완성 드롭다운 표시
  var mapInput = document.querySelector('.map-query input');
  var dropdown = document.querySelector('.search-dropdown');

  if (mapInput && dropdown) {
    var wrap = mapInput.closest('.map-query');

    mapInput.addEventListener('focus', function () {
      wrap.classList.add('is-focus');
    });

    mapInput.addEventListener('blur', function () {
      wrap.classList.remove('is-focus');
    });

    mapInput.addEventListener('input', function () {
      dropdown.hidden = mapInput.value.trim() === '';
    });

    document.addEventListener('click', function (e) {
      if (!e.target.closest('.map-query')) dropdown.hidden = true;
    });
  }
})();