<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  메인 (main.jsp) - 담당: 변재언
  피그마: Main / Landing / Desktop
  권한별 차이 : 비회원은 추천 대신 인기 경기 기준 문구, 헤더 로그인 버튼
--%>
<c:set var="pageTitle" value="메인" />
<c:set var="pageCss" value="home" />
<c:set var="pageJs" value="" />
<c:set var="showFooter" value="true" />
<%@ include file="/jsp/common/header.jsp" %>
<script>

	const isLogin = ${sessionScope.user != null};

	$(function(){
		
		function favBtn(item, extraClass){
		    if(!isLogin) return "";
		    return `<button type="button" class="fav-btn `+(extraClass||"")+(item.liked ? " is-active" : "")+`"
		            data-id="`+item.personalMatchId+`" aria-label="관심 경기">${heart}</button>`;
		}
		
		$(document).on("click", ".fav-btn", function(e){
		    e.preventDefault();
		    e.stopPropagation();
		    const $btn = $(this);

		    $.ajax({
		        url: "${ctx}/mypage/matches/saved",
		        type: "post",
		        dataType: "text",              
		        data: {
		            matchId: $btn.data("id"),
		            matchType: "PERSONAL"      
		        },
		        success: function(res){
		            if(res === "insert") $btn.addClass("is-on");
		            else if(res === "delete") $btn.removeClass("is-on");
		        },
		        error: function(xhr){
		            if(xhr.status == 401) alert("로그인이 필요합니다.");
		            else alert("오류가 생겼습니다.");
		        }
		    });
		});
		

	});
</script>
<section class="hero">
  <div class="container">
    <p class="eyebrow">혼자여도, 팀이어도, 매치온에서</p>
    <h1>경기를 찾고, 팀에 들어가고,<br>뛴 후엔 후기를 남겨보세요</h1>
    <p>경기 찾기, 팀, 후기까지 · 매치온 하나로 축구·농구·테니스·배드민턴을 즐겨보세요.</p>
    <a class="btn btn-primary" href="${ctx}/match/list">경기 찾아보기</a>
  </div>
</section>

<main class="page">
  <div class="container">
    <section>
      <div class="section-head">
        <div>
          <h2 class="section-title">경기 찾기</h2>
          <p class="section-desc">지금 열려있는 경기를 둘러보세요.</p>
        </div>
        <a class="t-brand t-13" href="${ctx}/match/list" style="font-weight:500">전체보기 →</a>
      </div>
      
      
	<div id="recomandMatchListDiv" class="feature-row">
	    <c:forEach var="match" items="${nMList}">
	  		<c:set var="sportClass" value="${match.sport eq '축구/풋살' ? 'football' :
    		    match.sport eq '농구' ? 'basketball' :	
                match.sport eq '테니스' ? 'tennis' :
                match.sport eq '배드민턴' ? 'badminton' : ''}" />
			<a class="match-card ${sportClass}" href="${ctx}/match/detail/view?personalMatchId=${match.personalMatchId}">
			    <img class="art" src="${ctx}/img/art-${sportClass}.png" alt="">
			    <span class="sport-tag ${sportClass}">${match.sport}</span>
			    <c:if test="${sessionScope.user != null}">
				    <button type="button" class="fav-btn bare ${match.favorite ? 'is-on' : ''}" data-fav data-auth data-id="${match.personalMatchId}" aria-label="관심 경기">${heart}</button>
				</c:if>
			    <span class="signal"><img src="${ctx}/img/icon-pin-14.svg" alt="">${sessionScope.user == null  ? '인기 경기' : '지역 · 실력 일치'}</span>
			    <div class="body">
			      <p class="title">${match.title}</p>
			      <p class="when"><img src="${ctx}/img/icon-calendar-14.svg" alt="">${match.startTime} · ${match.region}</p>
			      <p class="price">${match.participationFee}원</p>
			    </div>
			    <p class="count">${match.currentPeople}명<small>/ 정원 ${match.maxPeople}명</small></p>
			    <div class="bar"><i style="width:${match.currentPeople * 100 / match.maxPeople}%"></i></div>
			  </a>
	    </c:forEach>
	</div>
      
    </section>

    <section class="landing-section">
      <div class="section-head">
        <div>
          <h2 class="section-title">팀</h2>
          <p class="section-desc">꾸준히 함께 뛸 사람들을 팀에서 만나보세요.</p>
        </div>
        <a href="${ctx}/jsp/team/teamList.jsp">전체보기 →</a>
      </div>
      <div id="recomandTeamListDiv" class="team-mini-row">
    	<c:forEach var="team" items="${nTList}">
    		<c:set var="sportClass" value="${team.sport eq '축구/풋살' ? 'football' :
    		    team.sport eq '축구' ? 'football' :	
    		    team.sport eq '농구' ? 'basketball' :	
                team.sport eq '테니스' ? 'tennis' :
                team.sport eq '배드민턴' ? 'badminton' : ''}" />
	    	 <a class="team-mini" href="${ctx}/jsp/team/teamDetail.jsp">
	          <div class="top"><img src="${ctx}/img/team-${sportClass }.png" alt="">
	            <div>
		            <strong>${team.teamName}</strong>
		            <p class="meta">${team.sport} · ${team.region1}</p>
		            <p class="sub">
		            	<span>
		            		<img src="${ctx}/img/icon-user-12.svg" alt="">${team.currentPeople}
	            		</span>
	            		<span>
	            		<img src="${ctx}/img/icon-pin-12.svg" alt="">${team.region1}
	            		</span>
            		</p>
	            </div>
	           </div>
	          <div class="foot"><span class="sport-tag football">${team.sport}</span>
	          </div>
	        </a>
      	</c:forEach>
        
        
      </div>
    </section>

    <section class="landing-section">
      <div class="section-head">
        <div>
          <h2 class="section-title">후기</h2>
          <p class="section-desc">먼저 뛰어본 사람들의 이야기를 들어보세요.</p>
        </div>
        <a href="${ctx}/jsp/review/reviewList.jsp">전체보기 →</a>
      </div>

      <div class="review-mini-row">
    	<c:forEach var="review" items="${nRList}">
	    	<a class="review-mini" href="${ctx}/jsp/review/reviewDetail.jsp">
	          <div class="top"><span class="sport-tag football">${review.sport }</span><time>2026.09.16</time></div>
	          <strong>${review.title }</strong>
	          <p>${review.content }</p>
	        </a>
      	</c:forEach>
      </div>
    </section>
  </div>
</main>

<%@ include file="/jsp/common/footer.jsp" %>
