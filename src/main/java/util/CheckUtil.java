package util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import dto.User;

public class CheckUtil {
	public static User getLoginUser(HttpServletRequest request) {
	    HttpSession session = request.getSession(false);

	    if (session == null) {
	        return null;
	    }

	    return (User) session.getAttribute("user");
	}
}
