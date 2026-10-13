package controller.settlement;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.member.MemberService;
import service.member.MemberServiceImpl;

/**
 * Servlet implementation class SettlementPersonalAccountChange
 */
@WebServlet("/settlement/account")
public class SettlementAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SettlementAccount() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User loginUser = (User) request.getSession().getAttribute("user");
		
		String returnUrl = request.getParameter("returnUrl");
        if (!"/settlement/team/list".equals(returnUrl)) returnUrl = "/settlement/personal/list";
		
		String bank = request.getParameter("bank");
        String accountNo = request.getParameter("accountNo");
        String accountHolder = request.getParameter("accountHolder");
        
        if (accountNo != null) accountNo = accountNo.replaceAll("[\\s-]", "");
        
        boolean valid = bank != null && !bank.isEmpty()
        				&& accountNo != null && !accountNo.isEmpty()
        				&& accountHolder != null && !accountHolder.trim().isEmpty();
        if (!valid) {
            response.sendRedirect(request.getContextPath()+returnUrl+"?account=fail");
            return;
        }
        
        User user = new User();
        user.setLoginId(loginUser.getLoginId());
        user.setName(loginUser.getName());
        user.setEmail(loginUser.getEmail());
        user.setNickname(loginUser.getNickname());
        user.setBirthDate(loginUser.getBirthDate());
        user.setPhone(loginUser.getPhone());
        user.setBankName(bank);
        user.setAccountNumber(accountNo);
        user.setAccountHolder(accountHolder);
        
        try {
        	MemberService service = new MemberServiceImpl();
            User updateUser = service.mypageEdit(user);
            request.getSession().setAttribute("user", updateUser);
            
            response.sendRedirect(request.getContextPath()+returnUrl+"?account=ok");
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
}
