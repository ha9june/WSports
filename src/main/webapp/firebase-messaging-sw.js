importScripts("https://www.gstatic.com/firebasejs/11.6.0/firebase-compat.js")
importScripts("https://www.gstatic.com/firebasejs/11.6.0/firebase-messaging-compat.js")

const firebaseConfig = {
	apiKey: "AIzaSyD6AQvoWax-SrIYas-4T61w2hUs97d_8-U",
	authDomain: "wsports-d9450.firebaseapp.com",
	projectId: "wsports-d9450",
	storageBucket: "wsports-d9450.firebasestorage.app",
	messagingSenderId: "382436529763",
	appId: "1:382436529763:web:3d1204435cbfadc9e50a56",
	measurementId: "G-8NR43DQVDQ"
};

if (!firebase.apps.length) {
	firebase.initializeApp(firebaseConfig);
}

const messaging = firebase.messaging();
messaging.onBackgroundMessage(function(payload) {
	console.log(payload)

	const notificationTitle = payload.notification.title;
	const notificationOptions = {
		body: payload.notification.body
	};

	self.registration.showNotification(
		notificationTitle,
		notificationOptions
	);
})