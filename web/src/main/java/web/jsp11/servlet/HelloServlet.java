package web.jsp11.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//어노테이션으로 요청주소 매핑한 방법 url 주소임
@WebServlet("/HelloServlet")


public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
    public HelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
    //요청이 들어올때마다 호출되는 메서드
    //오버라이딩 ->doGet(),doPost()는 자동호출이 안될것임
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	PrintWriter pw = response.getWriter(); 
    	pw.println("<html>");
    	pw.println("<body>");
    	pw.println("<h2>hello servlet!!!!</h2>");
    	pw.println("</body>");
    	pw.println("</html>");
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("doGet!!!!");
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
