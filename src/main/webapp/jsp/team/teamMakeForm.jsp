<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 만들기 (teamMakeForm.jsp) - 담당: 하준수
  피그마: Club / Form / Desktop
--%>
<c:set var="pageTitle" value="팀 만들기" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="team" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<script type="text/javascript">
	
		function removePhoto(e, btn) {
			e.preventDefault();
			e.stopPropagation();                 // label 클릭으로 파일 선택창이 열리지 않게
			var label = btn.closest('label');
			label.querySelector('input[type="file"]').value = '';
			var img = label.querySelector('img');
			img.removeAttribute('src');
			img.style.display = 'none';
			label.querySelector('span').style.display = '';   // '사진 추가' 문구 복원
			btn.style.display = 'none';
		}
		function photoChosen(input) {            // 사진을 고르면 ✕ 표시
			var btn = input.closest('label').querySelector('.ph-remove');
			if (btn) btn.style.display = '';
		}
	
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById("profileImgPreview").src = e.target.result;
					  document.getElementById("profileImgPreview").style.cssText = "display: block; width: 100%; height: 100%; object-fit: cover;";
					document.getElementById("profilePreviewText").style.display = "none";
					photoChosen(input);
				}
				reader.readAsDataURL(input.files[0])
			}
		}

		function previewActivity(input, previewId, textId) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					var preview = document.getElementById(previewId);
					var text = document.getElementById(textId);

					preview.src = e.target.result;
					preview.style.display = "block";
					text.style.display = "none";
					photoChosen(input);
				};

				reader.readAsDataURL(input.files[0]);
			}
		}
		
		
		
		
	</script>

	<form class="form-rail" action="${ctx}/team/create" method="post"
		enctype="multipart/form-data">
		<nav class="breadcrumb">
			<a href="${ctx}/jsp/team/teamList.jsp">팀</a><span class="sep">›</span><span>팀
				만들기</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">팀 만들기</h1>
			<p class="page-desc">기본 정보와 소개글을 입력해 팀을 만들어보세요.</p>
		</div>
		<div class="team-form-inner">
			<div class="field">
				<label class="field-label" for="teamName">팀명
					<span class="hint" id="teamNameCount">0/15</span>
				</label>
				<input class="input" id="teamName" name="teamName" value=""
					maxlength="15" autocomplete="off"
					placeholder="팀 이름을 입력하세요 (2~15자)">
			</div>

			<div class="field mt-24">
				<span class="field-label strong"> 대표 사진 <span
					class="t-11 t-2" style="font-weight: 400"> JPG, PNG · 1장 </span>
				</span>

				<div class="photo-box">

					<label class="ph" style="cursor: pointer;"> <span
						id="profilePreviewText">사진 추가</span> <img id="profileImgPreview"
						alt=""
						style="display: none; width: 100%; height: 100%; object-fit: cover;">

						<input type="file" name="profileImage" accept="image/*" hidden
						onchange="readURL(this)">
						<button type="button" class="ph-remove" style="display: none;"
							aria-label="사진 삭제" onclick="removePhoto(event, this)">✕</button>
					</label>

					<div>
						<p>팀을 대표하는 사진을 등록해주세요. 목록과 상세 화면에 표시됩니다.</p>
						<p>사진 영역을 다시 클릭하면 다른 사진으로 변경할 수 있어요.</p>
					</div>

				</div>
			</div>
			<div class="field mt-24">
				<span class="field-label strong"> 활동 사진 <span
					class="t-11 t-2" style="font-weight: 400"> JPG, PNG · 최대 5장
				</span>
				</span>

				<div class="photo-box activity-photo-box">

					<label class="ph" style="cursor: pointer;"> <span
						id="activityText1">사진 추가</span> <img id="activityPreview1" alt=""
						style="display: none; width: 100%; height: 100%; object-fit: cover;">
						<input type="file" name="activityImg1" accept="image/*" hidden
						onchange="previewActivity(this, 'activityPreview1', 'activityText1')">
						<button type="button" class="ph-remove" style="display: none;"
							aria-label="사진 삭제" onclick="removePhoto(event, this)">✕</button>
					</label> <label class="ph" style="cursor: pointer;"> <span
						id="activityText2">사진 추가</span> <img id="activityPreview2" alt=""
						style="display: none; width: 100%; height: 100%; object-fit: cover;">
						<input type="file" name="activityImg2" accept="image/*" hidden
						onchange="previewActivity(this, 'activityPreview2', 'activityText2')">
						<button type="button" class="ph-remove" style="display: none;"
							aria-label="사진 삭제" onclick="removePhoto(event, this)">✕</button>
					</label> <label class="ph" style="cursor: pointer;"> <span
						id="activityText3">사진 추가</span> <img id="activityPreview3" alt=""
						style="display: none; width: 100%; height: 100%; object-fit: cover;">
						<input type="file" name="activityImg3" accept="image/*" hidden
						onchange="previewActivity(this, 'activityPreview3', 'activityText3')">
						<button type="button" class="ph-remove" style="display: none;"
							aria-label="사진 삭제" onclick="removePhoto(event, this)">✕</button>
					</label> <label class="ph" style="cursor: pointer;"> <span
						id="activityText4">사진 추가</span> <img id="activityPreview4" alt=""
						style="display: none; width: 100%; height: 100%; object-fit: cover;">
						<input type="file" name="activityImg4" accept="image/*" hidden
						onchange="previewActivity(this, 'activityPreview4', 'activityText4')">
						<button type="button" class="ph-remove" style="display: none;"
							aria-label="사진 삭제" onclick="removePhoto(event, this)">✕</button>
					</label> <label class="ph" style="cursor: pointer;"> <span
						id="activityText5">사진 추가</span> <img id="activityPreview5" alt=""
						style="display: none; width: 100%; height: 100%; object-fit: cover;">
						<input type="file" name="activityImg5" accept="image/*" hidden
						onchange="previewActivity(this, 'activityPreview5', 'activityText5')">
						<button type="button" class="ph-remove" style="display: none;"
							aria-label="사진 삭제" onclick="removePhoto(event, this)">✕</button>
					</label>
					<div class="photo-guide">
						<p>팀 활동 모습을 보여주는 사진을 여러 장 등록할 수 있어요.</p>
						<p>사진 영역을 다시 클릭하면 다른 사진으로 변경할 수 있어요.</p>
					</div>

				</div>
			</div>

			<div class="field mt-24">
				<label class="field-label" for="sport">종목</label> <select
					class="select" id="sport" name="sportCode">
					<option value="" selected disabled>종목 선택</option>
					<option value="축구/풋살">축구/풋살</option>
					<option value="농구">농구</option>
					<option value="테니스">테니스</option>
					<option value="배드민턴">배드민턴</option>
				</select>
			</div>

			<div class="field mt-24">
				<span class="field-label strong"> 활동 요일 <span class="hint"> 복수 선택 가능 </span>
				</span>

				<div class="chip-group" data-select="multi" data-hidden="days">

					<c:forTokens items="월,화,수,목,금,토,일" delims="," var="d">
						<button type="button" data-value="${d}" class="chip">
							${d}</button>
					</c:forTokens>
				</div>

				<input type="hidden" name="days" id="days">
			</div>
			<div class="field mt-24">
				<span class="field-label strong"> 활동 시간대 <span class="hint"> 복수 선택 가능 </span>
				</span>

				<div class="chip-group" data-select="multi" data-hidden="times">

					<button type="button" class="chip" data-value="아침 06~09시">아침
						06~09시</button>
 
					<button type="button" class="chip" data-value="오전 09~12시">오전
						09~12시</button>

					<button type="button" class="chip" data-value="오후 12~18시">오후
						12~18시</button>

					<button type="button" class="chip" data-value="저녁 18~22시">저녁
						18~22시</button>

					<button type="button" class="chip" data-value="야간 22~06시">야간
						22~06시</button>
				</div>

				<input type="hidden" name="times" id="times">
			</div>
			<div class="field mt-24">
				<span class="field-label strong"> 연령대 <span class="hint"> 복수 선택 가능 </span>
				</span>

				<div class="chip-group" data-select="multi" data-hidden="ages">

					<button type="button" class="chip" data-value="20대">20대</button>

					<button type="button" class="chip" data-value="30대">30대</button>

					<button type="button" class="chip" data-value="40대">40대</button>

					<button type="button" class="chip" data-value="50대 이상">50대
						이상</button>

					<button type="button" class="chip" data-value="연령 무관">연령
						무관</button>
				</div>

				<input type="hidden" name="ages" id="ages">
			</div>

			<div class="field mt-24">
				<span class="field-label strong">활동 지역 <span class="hint">복수 선택 가능 · 최대 3개</span></span>
				<div class="region-box">
					<div class="row2">
						<div class="field">
							<span class="field-label">1. 시 · 도</span><select class="select"
								name="sido" id="sido">
								<option value="" selected disabled>시 · 도 선택</option>
								<option value="서울시">서울시</option>
								<option value="경기도">경기도</option>
							</select>
						</div>
						<div class="field">
							<span class="field-label">2. 세부 지역</span><select class="select"
								name="sigungu" id="sigungu">
								<option value="" selected disabled>세부 지역 선택</option>
							</select>
						</div>
					</div>
					<p class="field-help mt-8">서울은 구 단위, 경기도는 시 단위로 선택합니다. 예: 마포구 /
						성남시</p>
					<p id="maxRegion" class="field-help mt-8"
						style="color: red; display: none;">최대 3개까지 선택 가능합니다.</p>
					<div class="picked"></div>
					<div id="regionInputs"></div>
				</div>
			</div>

			<div class="field mt-24">
				<span class="field-label strong">성별</span>

				<div class="chip-group" data-select="single" data-hidden="gender">

					<button type="button" class="chip" data-value="남자">남자</button>

					<button type="button" class="chip" data-value="여자">여자</button>

					<button type="button" class="chip" data-value="성별 무관">성별
						무관</button>
				</div>

				<input type="hidden" name="gender" id="gender">
			</div>
			<div class="field mt-24">
				<span class="field-label strong"> 팀 레벨 <span class="t-11 t-2"
					style="font-weight: 400"> 대표적인 팀 실력을 선택해주세요. </span>
				</span>

				<div class="chip-group" data-select="single" data-hidden="skill">

					<button type="button" class="chip" data-value="입문">입문</button>

					<button type="button" class="chip" data-value="초급">초급</button>

					<button type="button" class="chip" data-value="중급">중급</button>

					<button type="button" class="chip" data-value="상급">상급</button>
				</div>

				<input type="hidden" name="skill" id="skill">
			</div>
			<div class="field mt-24">
				<label class="field-label strong" for="intro">팀 소개</label>
				<textarea class="textarea" id="intro" name="intro" rows="6"
					placeholder="모임 성격, 활동 방식, 가입 조건 등을 적어주세요."></textarea>
			</div>

			<div class="form-actions">
				<a class="btn btn-outline" href="${ctx}/team/list">취소</a>
				<button type="submit" class="btn btn-primary">저장</button>
			</div>
		</div>
	</form>
	<script>
		const sido = document.getElementById("sido");
		const sigungu = document.getElementById("sigungu");
		
		const selectedRegions = []; 
		
		const maxRegion = document.getElementById("maxRegion");
		
		const regionInputs = document.getElementById("regionInputs");
		
		const picked = document.querySelector(".picked");
		
		const teamNameInput = document.getElementById("teamName");
		const teamNameCount = document.getElementById("teamNameCount");

		teamNameInput.addEventListener("input", function() {
			teamNameCount.textContent = teamNameInput.value.length + "/15";
		});
		
		sido.addEventListener("change", function(){
			sigungu.innerHTML = "";
			if(sido.value === "서울시"){
				sigungu.innerHTML = `
					<option value="" selected disabled>세부 지역 선택</option>
					<option value="강남구">강남구</option>
					<option value="강동구">강동구</option>
					<option value="강북구">강북구</option>
					<option value="강서구">강서구</option>
					<option value="관악구">관악구</option>
					<option value="광진구">광진구</option>
					<option value="구로구">구로구</option>
					<option value="금천구">금천구</option>
					<option value="노원구">노원구</option>
					<option value="도봉구">도봉구</option>
					<option value="동대문구">동대문구</option>
					<option value="동작구">동작구</option>
					<option value="마포구">마포구</option>
					<option value="서대문구">서대문구</option>
					<option value="서초구">서초구</option>
					<option value="성동구">성동구</option>
					<option value="성북구">성북구</option>
					<option value="송파구">송파구</option>
					<option value="양천구">양천구</option>
					<option value="영등포구">영등포구</option>
					<option value="용산구">용산구</option>
					<option value="은평구">은평구</option>
					<option value="종로구">종로구</option>
					<option value="중구">중구</option>
					<option value="중랑구">중랑구</option>
				`;
			} else if(sido.value === "경기도"){
				sigungu.innerHTML = `
					<option value="" selected disabled>세부 지역 선택</option>
					<option value="고양시">고양시</option>
					<option value="과천시">과천시</option>
					<option value="광명시">광명시</option>
					<option value="광주시">광주시</option>
					<option value="구리시">구리시</option>
					<option value="군포시">군포시</option>
					<option value="김포시">김포시</option>
					<option value="남양주시">남양주시</option>
					<option value="동두천시">동두천시</option>
					<option value="부천시">부천시</option>
					<option value="성남시">성남시</option>
					<option value="수원시">수원시</option>
					<option value="시흥시">시흥시</option>
					<option value="안산시">안산시</option>
					<option value="안성시">안성시</option>
					<option value="안양시">안양시</option>
					<option value="양주시">양주시</option>
					<option value="여주시">여주시</option>
					<option value="오산시">오산시</option>
					<option value="용인시">용인시</option>
					<option value="의왕시">의왕시</option>
					<option value="의정부시">의정부시</option>
					<option value="이천시">이천시</option>
					<option value="파주시">파주시</option>
					<option value="평택시">평택시</option>
					<option value="포천시">포천시</option>
					<option value="하남시">하남시</option>
					<option value="화성시">화성시</option>
				`;
			}
		})
		
		function renderRegions() {
			picked.innerHTML = "";
			regionInputs.innerHTML = "";
			
			selectedRegions.forEach(function(region, index) {

			    picked.innerHTML +=
			        '<span class="token-chip">'
			            + '<span>' + region + '</span>'
			            + '<button type="button" class="deleteRegion" data-index="' + index + '">✕</button>'
			        + '</span>';
			        
			    regionInputs.innerHTML += 
			    	'<input type="hidden" name="regions" value="'+ region +'">';

			});
					
		}
		
		sigungu.addEventListener("change", function(){

			const region = sido.value + " " + sigungu.value;
			
			if (selectedRegions.indexOf(region) !== -1) return;
			if(selectedRegions.length>=3){
				maxRegion.style.display = "";
				return;
			}
			selectedRegions.push(region);
			renderRegions();				    
		})
		
		picked.addEventListener("click", function(e) {

		    if (!e.target.classList.contains("deleteRegion")) {
		        return;
		    }

		    const index = Number(e.target.dataset.index);

		    selectedRegions.splice(index, 1);

		    renderRegions();
		    
		    maxRegion.style.display="none";
		});
	
		document.querySelectorAll(".chip-group[data-hidden]").forEach(
				function(group) {

					var hiddenId = group.dataset.hidden;
					var hidden = document.getElementById(hiddenId);

					group.addEventListener("click", function() {

						// 기존 공통 JS가 is-selected를 처리한 뒤 실행되도록
						setTimeout(function() {

							var selected = group
									.querySelectorAll(".chip.is-selected");

							var values = [];

							selected.forEach(function(btn) {
								values.push(btn.dataset.value);
							});

							hidden.value = values.join(",");

							console.log(hiddenId + " = " + hidden.value);

						}, 0);
					});
				});
		
		document.querySelector('.form-rail').addEventListener('submit', function (e) {
			var msg = '';
			var $ = function (id) { return document.getElementById(id); };

			var name = $('teamName').value.trim().replace(/\s+/g, ' ');

			if (!name) msg = '팀명을 입력해 주세요.';
			else if (name.length < 2 || name.length > 15) msg = '팀명은 2~15자로 입력해 주세요.';
			else if (!/^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9 ]+$/.test(name)) msg = '팀명은 한글, 영문, 숫자, 공백만 사용할 수 있어요.';
			else if (!$('sport').value) msg = '종목을 선택해 주세요.';
			else if (!$('days').value) msg = '활동 요일을 선택해 주세요.';
			else if (!$('times').value) msg = '활동 시간대를 선택해 주세요.';
			else if (!$('ages').value) msg = '연령대를 선택해 주세요.';
			else if (!document.querySelectorAll('input[name="regions"]').length) msg = '활동 지역을 1개 이상 선택해 주세요.';
			else if (!$('gender').value) msg = '성별을 선택해 주세요.';
			else if (!$('skill').value) msg = '팀 레벨을 선택해 주세요.';
			else if (!$('intro').value.trim()) msg = '팀 소개를 입력해 주세요.';

			if (msg) {
				e.preventDefault();
				showToast(msg);
			}
		});
	</script>
</main>
<%@ include file="/jsp/common/footer.jsp"%>
