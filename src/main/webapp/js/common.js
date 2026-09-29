/* =========================================================
   매치온 공통 스크립트
   - 모달 / 드롭다운 / 알림 패널 / 칩 선택 / 찜 / 토스트 / 별점 / 사진 미리보기
   - 비로그인(guest) 사용자가 [data-auth] 요소를 누르면 로그인 안내 모달을 띄웁니다.
   ========================================================= */
(function () {
  'use strict';

  var body = document.body;
  var isGuest = body.getAttribute('data-role') === 'guest';

  /* ---------- 모달 ---------- */
  function openModal(id) {
    var m = document.getElementById(id);
    if (!m) return;
    m.classList.add('is-open');
    var focusEl = m.querySelector('textarea, input, button');
    if (focusEl) setTimeout(function () { focusEl.focus(); }, 30);
  }
  function closeModal(m) {
    if (typeof m === 'string') m = document.getElementById(m);
    if (m) m.classList.remove('is-open');
  }
  window.openModal = openModal;
  window.closeModal = closeModal;

  /* ---------- 토스트 ---------- */
  var toastTimer;
  function showToast(msg) {
    var t = document.getElementById('toast');
    if (!t) return;
    t.textContent = msg;
    t.classList.add('is-show');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(function () { t.classList.remove('is-show'); }, 2200);
  }
  window.showToast = showToast;

  function closeAllDropdowns(except) {
    document.querySelectorAll('.dropdown.is-open').forEach(function (d) {
      if (d !== except) d.classList.remove('is-open');
    });
  }

  document.addEventListener('click', function (e) {
    var t = e.target;

    // 로그인 필요 기능
    var authEl = t.closest('[data-auth]');
    if (authEl && isGuest) {
      e.preventDefault();
      e.stopPropagation();
      openModal('loginRequiredModal');
      return;
    }

    // 모달 열기 / 닫기
    var opener = t.closest('[data-modal-open]');
    if (opener) {
      e.preventDefault();
      closeAllDropdowns();
      openModal(opener.getAttribute('data-modal-open'));
      return;
    }
    var closer = t.closest('[data-modal-close]');
    if (closer) {
      e.preventDefault();
      closeModal(closer.closest('.modal'));
      return;
    }
    if (t.classList.contains('modal')) { closeModal(t); return; }

    // 드롭다운
    var ddToggle = t.closest('[data-dropdown-toggle]');
    if (ddToggle) {
      e.preventDefault();
      var dd = ddToggle.closest('.dropdown');
      closeAllDropdowns(dd);
      dd.classList.toggle('is-open');
      return;
    }
    if (!t.closest('.dropdown-menu')) closeAllDropdowns();

    // 헤더 알림 패널
    var notiBtn = t.closest('[data-noti-toggle]');
    var panel = document.getElementById('notiPanel');
    if (notiBtn && panel) { panel.classList.toggle('is-open'); return; }
    if (panel && !t.closest('#notiPanel')) panel.classList.remove('is-open');

    // 칩 선택 (단일/복수)
    var chip = t.closest('.chip-group[data-select] .chip');
    if (chip) {
      e.preventDefault();
      var group = chip.closest('.chip-group');
      var mode = group.getAttribute('data-select');
      if (mode === 'single') {
        group.querySelectorAll('.chip').forEach(function (c) { c.classList.remove('is-selected'); });
        chip.classList.add('is-selected');
      } else {
        var max = parseInt(group.getAttribute('data-max') || '0', 10);
        var selectedCount = group.querySelectorAll('.chip.is-selected').length;
        if (!chip.classList.contains('is-selected') && max && selectedCount >= max) {
          showToast('최대 ' + max + '개까지 선택할 수 있어요.');
          return;
        }
        chip.classList.toggle('is-selected');
      }
      syncChipInput(group);
      return;
    }

    // 찜(하트)
    var fav = t.closest('[data-fav]');
    if (fav) {
      e.preventDefault();
      e.stopPropagation();
      fav.classList.toggle('is-on');
      showToast(fav.classList.contains('is-on') ? '관심 경기에 추가했어요.' : '관심 경기에서 삭제했어요.');
      return;
    }

    // 별점 입력
    var star = t.closest('.star-input button');
    if (star) {
      e.preventDefault();
      var wrap = star.closest('.star-input');
      var stars = wrap.querySelectorAll('button');
      var idx = Array.prototype.indexOf.call(stars, star) + 1;
      stars.forEach(function (s, i) { s.classList.toggle('is-on', i < idx); });
      var score = wrap.querySelector('.score');
      if (score) score.textContent = idx.toFixed(1);
      var hidden = wrap.querySelector('input[type=hidden]');
      if (hidden) hidden.value = idx;
      return;
    }

    // 사진 미리보기 삭제
    var rm = t.closest('.photo-preview .remove');
    if (rm) { e.preventDefault(); rm.closest('.photo-preview').remove(); return; }

    // 데모용 토스트 버튼
    var toastBtn = t.closest('[data-toast]');
    if (toastBtn) {
      if (toastBtn.tagName === 'A' || toastBtn.type === 'submit') e.preventDefault();
      closeModal(toastBtn.closest('.modal'));
      showToast(toastBtn.getAttribute('data-toast'));
    }
  });

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') {
      document.querySelectorAll('.modal.is-open').forEach(closeModal);
      closeAllDropdowns();
      var panel = document.getElementById('notiPanel');
      if (panel) panel.classList.remove('is-open');
    }
  });

  /* 칩 선택값을 hidden input 에 콤마로 저장 (서버 전송용) */
  function syncChipInput(group) {
    var name = group.getAttribute('data-name');
    if (!name) return;
    var input = group.querySelector('input[type=hidden][name="' + name + '"]');
    if (!input) {
      input = document.createElement('input');
      input.type = 'hidden';
      input.name = name;
      group.appendChild(input);
    }
    var values = [];
    group.querySelectorAll('.chip.is-selected').forEach(function (c) {
      values.push(c.getAttribute('data-value') || c.textContent.trim());
    });
    input.value = values.join(',');
  }
  document.querySelectorAll('.chip-group[data-name]').forEach(syncChipInput);

  /* ---------- 사진 업로드 미리보기 ---------- */
  document.addEventListener('change', function (e) {
    var input = e.target;
    if (!input.matches('input[type=file][data-preview]')) return;
    var box = input.closest('.photo-upload');
    var max = parseInt(input.getAttribute('data-max') || '5', 10);
    Array.prototype.forEach.call(input.files, function (file) {
      if (box.querySelectorAll('.photo-preview.is-file').length >= max) {
        showToast('사진은 최대 ' + max + '장까지 올릴 수 있어요.');
        return;
      }
      var reader = new FileReader();
      reader.onload = function (ev) {
        var placeholder = box.querySelector('.photo-preview:not(.is-file)');
        if (placeholder) placeholder.remove();
        var div = document.createElement('div');
        div.className = 'photo-preview is-file';
        div.innerHTML = '<img alt=""><button type="button" class="remove" aria-label="사진 삭제">✕</button>';
        div.querySelector('img').src = ev.target.result;
        box.appendChild(div);
      };
      reader.readAsDataURL(file);
    });
  });

  /* ---------- 글자수 카운터 ---------- */
  document.querySelectorAll('[data-count-target]').forEach(function (el) {
    var target = document.getElementById(el.getAttribute('data-count-target'));
    var update = function () { if (target) target.textContent = el.value.length; };
    el.addEventListener('input', update);
    update();
  });
})();

/* 카드 전체 클릭 이동 : 카드 안에 버튼/링크가 있어 <a> 로 감쌀 수 없을 때 data-href 사용 */
document.addEventListener('click', function (e) {
  var card = e.target.closest('[data-href]');
  if (!card || e.target.closest('a, button, input, select, textarea, label')) return;
  location.href = card.getAttribute('data-href');
});
