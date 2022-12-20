package web.jsp11.servlet;

import java.io.IOException;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


//1. 컨트롤러 클래스 생성, HttpServlet 상속받아 Servlet 으로 만들기
public class HomeController extends HttpServlet {
	
	@Override
	public void init() throws ServletException {
	//초기에 세팅해줄 것 있으면 여기에 작성
		System.out.println("init!!!!!");
	}
	
	
	// service 메서드 오버라이딩 : 요청일 들어올때마다 실행된다!!
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {

		System.out.println("hello HomeController!!");
		String uri =request.getRequestURI();
		System.out.println(uri);
		
		
		request.setAttribute("num", 1111);
		request.setAttribute("name", "sm");
		
		HttpSession session= request.getSession();
		session.setAttribute("memId", "java");
		
		
		//view (jsp 파일)을 지정해서 응답하라고 시키기
		RequestDispatcher rd = request.getRequestDispatcher("/jsp11/home.jsp");
		rd.forward(request, resp);
		
	}
	
}
