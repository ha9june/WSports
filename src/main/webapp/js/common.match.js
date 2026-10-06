$(function () {
	//사진 등록하기
	  var input = document.querySelector('input[name="photos"]');
	  var box = input.closest('.photo-upload');
	  var max = parseInt(input.getAttribute('data-max') || '5', 10);
	  var dt = new DataTransfer();   // 누적 저장소

	  function same(a, b) {
	    return a.name === b.name && a.size === b.size && a.lastModified === b.lastModified;
	  }

	  // 선택할 때마다 누적
	  input.addEventListener('change', function () {
	    var picked = Array.prototype.slice.call(input.files);
	    picked.forEach(function (file) {
	      var dup = Array.prototype.some.call(dt.files, function (f) { return same(f, file); });
	      if (dup) return;
	      if (dt.files.length >= max) {
	        showToast('사진은 최대 ' + max + '장까지 올릴 수 있어요.');
	        return;
	      }
	      dt.items.add(file);

	      var reader = new FileReader();
	      reader.onload = function (ev) {
	        var placeholder = box.querySelector('.photo-preview:not(.is-file)');
	        if (placeholder) placeholder.remove();
	        var div = document.createElement('div');
	        div.className = 'photo-preview is-file';
	        div.innerHTML = '<img alt=""><button type="button" class="remove" aria-label="사진 삭제">✕</button>';
	        div.querySelector('img').src = ev.target.result;
	        div._file = file;
	        box.appendChild(div);
	      };
	      reader.readAsDataURL(file);
	    });
	    input.files = dt.files;      // 누적 목록으로 복원
	  });

	  // ✕ 클릭: 공통 핸들러(DOM 삭제)보다 먼저 실행되도록 capture 사용
	  document.addEventListener('click', function (e) {
	    var rm = e.target.closest('.photo-preview .remove');
	    if (!rm || !box.contains(rm)) return;
	    var file = rm.closest('.photo-preview')._file;
	    if (!file) return;
	    var next = new DataTransfer();
	    Array.prototype.forEach.call(dt.files, function (f) {
	      if (!same(f, file)) next.items.add(f);
	    });
	    dt = next;
	    input.files = dt.files;
	  }, true);
	});