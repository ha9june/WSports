package util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

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
    
    
}
