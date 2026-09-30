package config;

import java.util.List;

import org.springframework.core.io.ClassPathResource;
import com.google.auth.oauth2.GoogleCredentials;

public class FCMConfig {
	public static String getAccessToken() throws Exception{
		GoogleCredentials googleCredentials = GoogleCredentials
				.fromStream(new ClassPathResource("resource/service-account.json").getInputStream())
				.createScoped(List.of("https://www.googleapis.com/auth/firebase.messaging"));
		
		googleCredentials.refresh();
		return googleCredentials.getAccessToken().getTokenValue();
		
	}
}
