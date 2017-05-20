/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import bo.UserBO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UserController", urlPatterns = {"/User"})
public class UserServlet extends HttpServlet {

    public static final String USER_SESSION = "userSession";
    UserBO _DAO;

    public UserServlet() {
        this._DAO = new UserBO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String command = request.getParameter("command");
        switch (command) {
            case "login":
                checkLogin(request, response);
                break;
            case "register":
                Register(request, response);
                break;
            case "view":
                response.getWriter().print("pass");
                break;
            case "reactive":
                LostPassword(request, response);
                break;
        }

    }

    void checkLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        User item;
        //check user
        item = _DAO.checkEmailUser(user);
        if (item == null) {
            response.getWriter().print("user");
            return;
        }
        //check pass
        item = _DAO.checkLogin(user, pass);
        if (item == null) {
            response.getWriter().print("pass");
            return;
        } else {
            if (item.getRoles() == 0) {
                response.getWriter().print("active");
                return;
            }
            request.getSession().setAttribute(USER_SESSION, item);
            response.getWriter().print("success");
        }

    }

    void Register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String email = request.getParameter("email");
        User item;
        //check email
        item = _DAO.checkEmail(email);
        if (item != null) {
            response.getWriter().print("email");
            return;
        }
        //check user
        item = _DAO.checkUser(user);
        if (item != null) {
            response.getWriter().print("user");
            return;
        }
        item = new User(System.currentTimeMillis(), user, email, pass, 0);
        //check pass
        if (_DAO.addItem(item) > 0) {
            response.getWriter().print("success");

        } else {
            response.getWriter().print("failed");
        }

    }

    void Active(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String key = request.getParameter("key");
        String message = "";
        if (_DAO.activeItem(key) > 0) {
            message = ("Account was actived. <a href='index.jsp'>Login here</a>");
        } else {
            message = ("You key not correct, try again.");
        }
        request.setAttribute("message", message);
        request.getRequestDispatcher("public/view.jsp").forward(request, response);

    }

    void LostPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");

        if (_DAO.reactiveItem(email) > 0) {
            response.getWriter().print("success");
        } else {
            response.getWriter().print("failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String command = request.getParameter("command");
        switch (command) {
            case "active":
                Active(request, response);
                break;
            case "showpass":
                ShowPass(request, response);
                break;
            case "logout":
                request.getSession().removeAttribute(USER_SESSION);
                response.sendRedirect("public/index.jsp");
                return;

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void ShowPass(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String key = request.getParameter("key");
        String pass = _DAO.viewPassByKey(key);
        String message = "";
        if (pass.equalsIgnoreCase("")) {
            message = "Your key not correct or had used";
        } else {
            message = "Your pass is :" + pass;
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("public/view.jsp").forward(request, response);
    }
}
