package util;

import java.util.HashMap;
import java.util.Map;

/** 토스 카드사 코드 → 카드사 이름 */
public class CardCompany {

	private static final Map<String, String> NAMES = new HashMap<>();
	static {
		NAMES.put("3K", "기업BC카드");
		NAMES.put("46", "광주은행");
		NAMES.put("71", "롯데카드");
		NAMES.put("30", "KDB산업은행");
		NAMES.put("31", "BC카드");
		NAMES.put("51", "삼성카드");
		NAMES.put("38", "새마을금고");
		NAMES.put("41", "신한카드");
		NAMES.put("62", "신협");
		NAMES.put("36", "씨티카드");
		NAMES.put("33", "우리카드");
		NAMES.put("W1", "우리카드");
		NAMES.put("37", "우체국");
		NAMES.put("39", "저축은행");
		NAMES.put("35", "전북은행");
		NAMES.put("42", "제주은행");
		NAMES.put("15", "카카오뱅크");
		NAMES.put("3A", "케이뱅크");
		NAMES.put("24", "토스뱅크");
		NAMES.put("21", "하나카드");
		NAMES.put("61", "현대카드");
		NAMES.put("11", "KB국민카드");
		NAMES.put("91", "NH농협카드");
		NAMES.put("34", "Sh수협은행");
	}

	private CardCompany() {}

	// 모르는 코드면 코드 그대로 반환
	public static String nameOf(String code) {
		if (code == null) return null;
		return NAMES.getOrDefault(code, code);
	}
}