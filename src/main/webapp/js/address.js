(function () {
  'use strict';
  var SEOUL = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구",
                 "도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구",
                 "양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
    var GYEONGGI = [
        "고양시", "과천시", "광명시", "광주시", "구리시",
        "군포시", "김포시", "남양주시", "동두천시", "부천시",
        "성남시", "수원시", "시흥시", "안산시", "안성시",
        "안양시", "양주시", "여주시", "오산시", "용인시",
        "의왕시", "의정부시", "이천시", "파주시", "평택시",
        "포천시", "하남시", "화성시"
    ];
    var MAX = 3;

    var sido = document.getElementById("sido");
    var sigungu = document.getElementById("sigungu");
    var picked = document.getElementById("pickedRegions");
    var regionInputs = document.getElementById("regionInputs");
    var maxMsg = document.getElementById("maxRegion");
    var selected = [];

    function resetSigungu(list) {
      sigungu.innerHTML = "";
      var ph = document.createElement("option");
      ph.value = "";
      ph.textContent = "시군구";
      sigungu.appendChild(ph);
      list.forEach(function (name) {
        var op = document.createElement("option");
        op.value = name;
        op.textContent = name;
        sigungu.appendChild(op);
      });
      sigungu.disabled = list.length === 0;
    }

    function render() {
      picked.innerHTML = "";
      regionInputs.innerHTML = "";
      selected.forEach(function (region, index) {
        var chip = document.createElement("span");
        chip.className = "token-chip";

        var label = document.createElement("span");
        label.textContent = region;

        var del = document.createElement("button");
        del.type = "button";
        del.className = "deleteRegion";
        del.setAttribute("data-index", index);
        del.setAttribute("aria-label", region + " 삭제");
        del.textContent = "✕";

        chip.appendChild(label);
        chip.appendChild(del);
        picked.appendChild(chip);

        var hidden = document.createElement("input");
        hidden.type = "hidden";
        hidden.name = "regions";
        hidden.value = region;
        regionInputs.appendChild(hidden);
      });
    }

    sido.addEventListener("change", function () {
      if (sido.value === "서울시") resetSigungu(SEOUL);
      else if (sido.value === "경기도") resetSigungu(GYEONGGI);
      else resetSigungu([]);
    });

    sigungu.addEventListener("change", function () {
      if (!sigungu.value) return;
      var region = sido.value + " " + sigungu.value;

      if (selected.indexOf(region) !== -1) {      // 중복 선택 방지
        sigungu.value = "";
        return;
      }
      if (selected.length >= MAX) {
        maxMsg.style.display = "";
        sigungu.value = "";
        return;
      }
      selected.push(region);
      render();
      sigungu.value = "";                          // 같은 지역을 다시 고를 수 있게 초기화
    });

    picked.addEventListener("click", function (e) {
      if (!e.target.classList.contains("deleteRegion")) return;
      selected.splice(Number(e.target.getAttribute("data-index")), 1);
      render();
      maxMsg.style.display = "none";
    });

    // 필터 초기화 버튼과 같이 지역도 비우기
    var resetBtn = document.querySelector("[data-filter-reset]");
    if (resetBtn) {
      resetBtn.addEventListener("click", function () {
        selected = [];
        render();
        sido.value = "";
        resetSigungu([]);
        maxMsg.style.display = "none";
      });
    }

})();
