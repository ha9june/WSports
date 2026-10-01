import { initializeApp } from "https://www.gstatic.com/firebasejs/11.6.0/firebase-app.js";
import { getMessaging, getToken, onMessage } from "https://www.gstatic.com/firebasejs/11.6.0/firebase-messaging.js";

const firebaseConfig = {
	apiKey: "AIzaSyD6AQvoWax-SrIYas-4T61w2hUs97d_8-U",
	authDomain: "wsports-d9450.firebaseapp.com",
	projectId: "wsports-d9450",
	storageBucket: "wsports-d9450.firebasestorage.app",
	messagingSenderId: "382436529763",
	appId: "1:382436529763:web:3d1204435cbfadc9e50a56",
	measurementId: "G-8NR43DQVDQ"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const messaging = getMessaging(app);

console.log("window.contextPath =", window.contextPath);

console.log(
    "sw path =",
    window.contextPath + "/firebase-messaging-sw.js"
);

if ('serviceWorker' in navigator) {
	//1. 서비스 워커를 프로젝트 경로에 맞게 수동 등록
	navigator.serviceWorker.register(window.contextPath + '/firebase-messaging-sw.js')
		.then((registration) => {
			console.log("서비스 워커 등록 성공", registration)

			getToken(messaging, {
				vapidKey: 'BMmmJVPh4ow15t5OvoCbab1mi-wxRai0Rr5Xowr9XDwO2H8M-T_sEicA4tQivAykBA3xZa27Sqqp8_B2UrOU-Ho',
				serviceWorkerRegistration: registration
			}).then((token) => {
				window.fcmToken = token;
				console.log(token)
				onMessageListener();
			})
		}).catch(error => {
			console.log(error)
		})
}

const onMessageListener = () => {
	return new Promise((resolve) => {
		onMessage(messaging, (payload) => {
			console.log("onMessage")
			console.log(payload);

			const event = new CustomEvent("fcmMessageReceived", { detail: payload.data })
			window.dispatchEvent(event);

			resolve(payload);
		})
	})
}