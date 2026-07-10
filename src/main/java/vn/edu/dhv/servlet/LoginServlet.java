package vn.edu.dhv.servlet;

import vn.edu.dhv.dao.UserDAO;
import vn.edu.dhv.model.User;
import vn.edu.dhv.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String passwordRaw = request.getParameter("password");

        String passwordHash = PasswordUtil.hashPassword(passwordRaw);
        User user = userDAO.authenticate(username, passwordHash);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.setStatus(HttpServletResponse.SC_FOUND);
            response.setHeader("Location", "records");
        } else {
            request.setAttribute("errorMessage", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
