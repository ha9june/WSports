
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
	  팀 찾기 (teamList.jsp) - 담당: 하준수
	  피그마: Club / Find / Desktop (Guest · Member)
	  비회원은 [팀 만들기] 클릭 시 로그인 안내 모달이 열립니다.
	--%>
<c:set var="pageTitle" value="팀 찾기" />
<c:set var="pageCss" value="home,team" />
<c:set var="pageJs" value="home" />
<c:set var="activeNav" value="team" />
<c:set var="showFooter" value="true" />
<c:set var="demoRoles" value="guest,member" />
<%@ include file="/jsp/common/header.jsp"%>
<script type="text/javascript">

    let page = 1;

    function teamList(page) {

        var data = $('#teamSearchForm').serializeArray();

        data.push({
            name: 'page',
            value: page
        });

        data.push({
            name: 'requestType',
            value: 'ajax'
        });

        $('.btn-more').prop('disabled', true);
        
        $.ajax({
            url: '${ctx}/team/list',
            type: 'get',
            dataType: 'json',
            data: data,

            success: function(result) {

                let html = "";
                
                $('#teamCnt b').text('팀 ' + result.teamCnt + '개');

                result.teamList.forEach(function(team) {
                	
                	var imageSrc = '';

                    if (team.profileImage) {
                        imageSrc = '${ctx}/uploads/' + team.profileImage;
                    } else if (team.sport === '축구/풋살') {
                        imageSrc = '${ctx}/img/team-football.png';
                    } else if (team.sport === '농구') {
                        imageSrc = '${ctx}/img/team-basketball.png';
                    } else if (team.sport === '테니스') {
                        imageSrc = '${ctx}/img/team-tennis.png';
                    } else if (team.sport === '배드민턴') {
                        imageSrc = '${ctx}/img/team-badminton.png';
                    }

                    html +=
                        '<a class="team-card" href="${ctx}/jsp/team/teamDetail.jsp">' +
                            '<div class="top">' +
                            	'<img src="' + imageSrc + '" alt="">'+
                                '<div>' +
                                    '<strong>' + team.teamName + '</strong>' +
                                    '<p class="meta">' + team.sport + '</p>' +
                                    '<p class="sub">' +
                                        '<span><img src="${ctx}/img/icon-user-12.svg" alt="">' + team.currentPeople + '명</span>' +
                                        '<span><img src="${ctx}/img/icon-pin-12.svg" alt="">' + team.regions + '</span>' +
                                    '</p>' +
                                '</div>' +
                            '</div>' +
                            '<p class="cond">' +
	                            team.days + '<br>' +
	                            team.ages + '<br>' +
	                            team.skill + '·' + team.gender +
                            '</p>' +
                        '</a>';
                });
                
                // 검색 / 정렬
            if (page === 1) {
                $('#team-grid').html(html);
            }
            // 더보기
            else {
                $('#team-grid').append(html);
            }
                

                
         // 현재 화면에 나온 팀 개수
            var loadedCnt = $('#team-grid .team-card').length;

            // 전부 불러왔으면 더보기 숨김
			if (loadedCnt >= result.teamCnt) {
			    $('.btn-more').prop('disabled', true).hide();
			} else {
			    $('.btn-more').prop('disabled', false).show();
			}
                
            },

            error: function(xhr) {
                console.log(xhr);
            }
        });
    }
			
			$(function() {

			    $('#teamSearchForm').on('submit', function(e) {

			        e.preventDefault();

			        page = 1;

			        teamList(page);
			    });
			    
			    $('#sort').on('change',function(e){
			    	e.preventDefault();
			    	page = 1;
			    	teamList(page);
			    })
			    
			    $('.btn-more').on('click', function() {
		            page++;
		            teamList(page);
		        });
			    
	
			});	
		
</script>
<main class="page">
	<div class="rail">
		<div class="page-head" style="margin-bottom: 18px">
			<h1 class="page-title lg">팀</h1>
			<p class="page-desc">가입할 팀을 찾거나 다른 팀과 매칭해보세요.</p>
		</div>
		<nav class="tabs big">
			<a class="tab is-active" href="${ctx}/team/list">팀 찾기</a><a
				class="tab" href="${ctx}/team-match/list">팀 경기</a>
		</nav>

		<form class="search-shell" id="teamSearchForm" method="get"
			action="${ctx}/team/list">
			<div class="filter-row">
				<div class="filter-cluster">
					<div class="chip-group" data-select="multi" data-name="sports">
						<span class="chip-label">종목</span>
						<button type="button" class="chip" data-value="축구/풋살">축구/풋살</button>
						<button type="button" class="chip" data-value="농구">농구</button>
						<button type="button" class="chip" data-value="테니스">테니스</button>
						<button type="button" class="chip" data-value="배드민턴">배드민턴</button>
					</div>
					<div class="filter-more">
						<button type="button" class="btn btn-outline btn-sm"
							data-filter-toggle>필터 더보기 +</button>
						<span class="count">0</span>
						<div class="filter-panel">
							<div class="chip-group" data-select="single" data-name="gender">
								<span class="chip-label">성별</span>
								<button type="button" class="chip" data-value="남자">남자</button>
								<button type="button" class="chip" data-value="여자">여자</button>
								<button type="button" class="chip" data-value="성별 무관">성별
									무관</button>
							</div>
							<div class="chip-group" data-select="multi" data-name="days">
								<span class="chip-label">요일</span>
								<button type="button" class="chip" data-value="월">월</button>
								<button type="button" class="chip" data-value="화">화</button>
								<button type="button" class="chip" data-value="수">수</button>
								<button type="button" class="chip" data-value="목">목</button>
								<button type="button" class="chip" data-value="금">금</button>
								<button type="button" class="chip" data-value="토">토</button>
								<button type="button" class="chip" data-value="일">일</button>
							</div>
							<div class="chip-group" data-select="multi" data-name="skills">
								<span class="chip-label">실력</span>
								<button type="button" class="chip" data-value="입문">입문</button>
								<button type="button" class="chip" data-value="초급">초급</button>
								<button type="button" class="chip" data-value="중급">중급</button>
								<button type="button" class="chip" data-value="상급">상급</button>
							</div>
						</div>
					</div>
				</div>
				<button type="button" class="btn-reset" data-filter-reset>필터
					초기화</button>
			</div>
			<div class="input-row">
				<select class="select" id="sido" name="sido" style="width: 140px"
					aria-label="시·도">
					<option value="">시 · 도</option>
					<option value="서울시">서울시</option>
					<option value="경기도">경기도</option>
				</select> <select class="select" id="sigungu" name="sigungu"
					style="width: 140px" aria-label="시군구" disabled>
					<option value="">시군구</option>
				</select> <input class="input keyword" name="keyword"
					placeholder="팀명 또는 키워드 검색">
				<button type="submit" class="btn btn-primary btn-lg"
					style="width: 108px">검색</button>
			</div>
			<p id="maxRegion" class="region-max" style="display: none">최대
				3개까지 선택 가능합니다.</p>
			<div class="picked" id="pickedRegions"></div>
			<div id="regionInputs"></div>
		</form>

		<div class="list-meta">
			<p id="teamCnt">
				<b>팀 ${teamCnt}개</b>
			</p>
			<select class="select" id="sort" name="sort" form="teamSearchForm"
				aria-label="정렬">
				<option value="day">최신순</option>
				<option value="member">인원순</option>
			</select>
		</div>

		<%-- TODO: <c:forEach var="t" items="${teamList}"> 로 교체. (아래는 시연용 더미 데이터) --%>
		<div class="team-grid" id="team-grid">
			<c:forEach var="team" items="${teamList }">
				<a class="team-card" href="${ctx}/jsp/team/teamDetail.jsp">
					<div class="top">
						<c:choose>
							<c:when test="${not empty team.profileImage}">
								<img src="${ctx}/uploads/${team.profileImage}" alt="">
							</c:when>
							<c:when test="${team.sport eq '축구/풋살' }">
								<img src="${ctx}/img/team-football.png" alt="">
							</c:when>
							<c:when test="${team.sport eq '농구' }">
								<img src="${ctx}/img/team-basketball.png" alt="">
							</c:when>
							<c:when test="${team.sport eq '테니스' }">
								<img src="${ctx}/img/team-tennis.png" alt="">
							</c:when>
							<c:when test="${team.sport eq '배드민턴' }">
								<img src="${ctx}/img/team-badminton.png" alt="">
							</c:when>
						</c:choose>
						<div>
							<strong>${team.teamName}</strong>
							<p class="meta">${team.sport}</p>
							<p class="sub">
								<span><img src="${ctx}/img/icon-user-12.svg" alt="">${team.currentPeople}명</span><span><img
									src="${ctx}/img/icon-pin-12.svg" alt="">${team.regions }</span>
							</p>
						</div>
					</div>
					<p class="cond">${team.days}<br>${team.ages }<br>${team.skill}·${team.gender }
					</p>
				</a>
			</c:forEach>
		</div>
		<c:if test="${teamCnt > 12}">
		    <div class="more-wrap">
		        <button type="button" class="btn-more">
		            ↓ &nbsp;더보기
		        </button>
		    </div>
		</c:if>
	</div>
</main>
<a class="fab" href="${ctx}/jsp/team/teamMakeForm.jsp" data-auth><span
	class="fab-label">팀 만들기</span><span class="fab-btn" aria-hidden="true"></span></a>

<script>
	  (function () {
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
	</script>
<%@ include file="/jsp/common/footer.jsp"%>