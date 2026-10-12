
(function () {
  'use strict';

/* ---------- 위치 ---------- */
  function getUserLocation() {
	    const saved = sessionStorage.getItem("userLocation");
	    if ( saved) {
	        const location = JSON.parse(saved);
	        if (Date.now() - location.savedAt < 60000) {
	            return Promise.resolve(location);
	        }
	    }
	    return new Promise((resolve, reject) => {
	        navigator.geolocation.getCurrentPosition(
	            position => {
	                const location = {
	                    lat: position.coords.latitude,
	                    lng: position.coords.longitude,
	                    savedAt: Date.now()
	                };
	                sessionStorage.setItem("userLocation", JSON.stringify(location));
	                resolve(location);
	            },
	            reject,
	            { enableHighAccuracy: false, timeout: 5000, maximumAge: 60000 }
	        );
	    });
	}
	window.getUserLocation = getUserLocation;
})();



