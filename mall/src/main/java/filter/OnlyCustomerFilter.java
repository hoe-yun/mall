package filter;

import java.io.IOException;
import java.net.http.HttpResponse;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

// 작성자 : 정인호  C231106 U231106
// 오직 회원만 접근가능한 페이지
@WebFilter(urlPatterns={"/customerInfo.jsp","/customerApiController.jsp"})
public class OnlyCustomerFilter implements Filter{
	
	public void init(FilterConfig filterConfig) throws ServletException{
		System.out.println("log // OnlyCustomerFilter init");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest)request; // HttpServletRequest는 ServletRequest를 상속한다. 예전엔 http가 없었음. 세션도 나중에 생김
		String requestUrl = httpRequest.getRequestURI();
		System.out.println(">>fiter ::  OnlyCustomerFilter   >>  url :" +  requestUrl);
		HttpSession session = httpRequest.getSession();
		Integer customerNo = (Integer) session.getAttribute("customerNo");
		//세션 로그인 여부체크
		if(customerNo == null) {
			HttpServletResponse httpResponse = (HttpServletResponse)response;// 마찬가지. sendredirect가 없음
			httpResponse.sendRedirect("customerLogin.jsp"); // 로그인페이지로 
			return;
		}
		
		chain.doFilter(request, response); //요청의 흐름을 이어나감
	}
	
}
