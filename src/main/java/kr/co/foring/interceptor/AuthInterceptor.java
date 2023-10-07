package kr.co.foring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
				throws Exception {

			HttpSession session = request.getSession();
			String contextPath = request.getContextPath();
			
			if (session.getAttribute("login") == null) {
				log.info("current user is not logined");
				
				response.sendRedirect(contextPath + "/foring/login");
				
				return false;
			}
			return true;
		}
	
	private void saveDest(HttpServletRequest request) {
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		
		uri = uri.substring(contextPath.length());
		log.info("uri =========> " + uri);
		
		String query = request.getQueryString();
		
		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		
		if (request.getMethod().equals("GET")) {
			log.info("dest : " + (uri + query));
			
			request.getSession().setAttribute("dest", uri + query);
			
		}
	}
}
