package util;

import java.io.InputStream;
import java.util.Properties;

/**
 * 토스페이먼츠 시크릿 키 공통 관리
 *  - resource/db.properties 의 toss.secret.key 값을 한 번만 읽어서 보관
 *  - 사용 : TossKey.SECRET_KEY
 */
public class TossKey {

	public static final String SECRET_KEY = load();

	// 객체 생성 막기 (상수만 쓰는 클래스)
	private TossKey() {}

	private static String load() {
		try (InputStream is = TossKey.class.getClassLoader()
				.getResourceAsStream("resource/api.properties")) {   // mybatis-config.xml의 resource 경로와 같게

			if (is == null) {
				throw new IllegalStateException("resource/api.properties 파일을 찾을 수 없습니다.");
			}

			Properties props = new Properties();
			props.load(is);

			String key = props.getProperty("toss.secret.key");
			if (key == null || key.isBlank()) {
				throw new IllegalStateException("api.properties에 toss.secret.key 값이 없습니다.");
			}
			return key.trim();

		} catch (Exception e) {
			throw new RuntimeException("토스 시크릿 키를 불러오지 못했습니다.", e);
		}
	}
}