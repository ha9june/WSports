package util;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AlertUtil {
    private AlertUtil() {}   // 인스턴스 생성 방지

    public static void back(HttpServletResponse res, String msg) throws IOException {
        write(res, "alert('" + js(msg) + "'); history.back();");
    }

    public static void redirect(HttpServletResponse res, String msg, String url) throws IOException {
        write(res, "alert('" + js(msg) + "'); location.href='" + js(url) + "';");
    }

    private static void write(HttpServletResponse res, String script) throws IOException {
        res.setContentType("text/html; charset=UTF-8");
        PrintWriter out = res.getWriter();
        out.println("<script>" + script + "</script>");
    }
    public static void jsonRedirect(HttpServletResponse res, boolean success, String msg, String redirectUrl) throws IOException {
        res.setContentType("application/json");
        PrintWriter out = res.getWriter();
        out.print("{"
            + "\"success\":" + success + ","
            + "\"message\":\"" + json(msg) + "\","
            + "\"redirectUrl\":\"" + json(redirectUrl) + "\""
            + "}");
        out.flush();
    }

    private static String js(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("'", "\\'")
                .replace("\r", "")
                .replace("\n", "\\n")
                .replace("<", "\\u003C");   // </script> 로 스크립트가 끊기는 것 방지
    }
    private static String json(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
    
    // 이용 제한 안내 모달을 띄우고 이전 화면으로 돌아감 (footer.jsp 의 suspendModal)
    // 개인 정지: 버튼은 개인 패널티 내역으로
    public static void notice(HttpServletRequest req, HttpServletResponse res, String msg) throws IOException {
        notice(req, res, msg, "/mypage/penalty", "패널티 내역 보기");
    }

    // 버튼 주소와 이름을 지정 (팀 정지면 팀 패널티 내역으로). link 는 컨텍스트 경로 제외
    public static void notice(HttpServletRequest req, HttpServletResponse res, String msg,
            String link, String linkLabel) throws IOException {
        HttpSession session = req.getSession();
        session.setAttribute("suspendNotice", msg);
        session.setAttribute("suspendLink", link);
        session.setAttribute("suspendLinkLabel", linkLabel);
        res.sendRedirect(backUrl(req));
    }

    // 같은 사이트의 이전 화면 주소. 없거나 다시 막힐 화면이면 홈으로
    private static String backUrl(HttpServletRequest req) {
        String ctx = req.getContextPath();
        String home = ctx + "/home/main";
        String referer = req.getHeader("Referer");
        if (referer == null) return home;
        try {
            URI u = URI.create(referer);
            if (!req.getServerName().equals(u.getHost())) return home;          // 다른 사이트로는 보내지 않음
            String path = u.getRawPath();
            if (path == null || !path.startsWith(ctx)) return home;
            if ("GET".equals(req.getMethod()) && path.equals(req.getRequestURI())) return home;  // 같은 화면 반복 방지
            return path + (u.getRawQuery() != null ? "?" + u.getRawQuery() : "");
        } catch (Exception e) {
            return home;
        }
    }
    
}
