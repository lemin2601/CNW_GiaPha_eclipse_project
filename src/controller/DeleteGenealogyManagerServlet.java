package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GenealogyDAO;
import model.Genealogy;

/**
 * Servlet implementation class DeleteGenealogyManagerServlet
 */
@WebServlet("/DeleteGenealogyManagerServlet")
public class DeleteGenealogyManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteGenealogyManagerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		GenealogyDAO dao = new GenealogyDAO();
		dao.deleteItem(Long.parseLong(id));
		ArrayList<Genealogy> list = new ArrayList<>();
		list = dao.getList();
		request.setAttribute("msg", "Deleted successful!");
		request.setAttribute("list", list);
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/GenealogyManager.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
