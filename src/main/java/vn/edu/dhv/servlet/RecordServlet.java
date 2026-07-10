package vn.edu.dhv.servlet;

import vn.edu.dhv.dao.RecordDAO;
import vn.edu.dhv.model.Record;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/records")
public class RecordServlet extends HttpServlet {
    private RecordDAO recordDAO;

    @Override
    public void init() {
        recordDAO = new RecordDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_FOUND);
            response.setHeader("Location", "login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        // GET only handles listing records
        listRecords(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_FOUND);
            response.setHeader("Location", "login");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addRecord(request, response);
        } else if ("update".equals(action)) {
            updateRecord(request, response);
        } else if ("delete".equals(action)) {
            deleteRecord(request, response);
        } else {
            response.setStatus(HttpServletResponse.SC_FOUND);
            response.setHeader("Location", "records");
        }
    }

    private void listRecords(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Record> records = recordDAO.getAllRecords();
        request.setAttribute("records", records);
        request.getRequestDispatcher("/records.jsp").forward(request, response);
    }

    private void addRecord(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String stname = request.getParameter("stname");
        String course = request.getParameter("course");
        int fee = Integer.parseInt(request.getParameter("fee"));

        Record record = new Record(stname, course, fee);
        recordDAO.insertRecord(record);
        response.setStatus(HttpServletResponse.SC_FOUND);
        response.setHeader("Location", "records");
    }

    private void updateRecord(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String stname = request.getParameter("stname");
        String course = request.getParameter("course");
        int fee = Integer.parseInt(request.getParameter("fee"));

        Record record = new Record(id, stname, course, fee);
        recordDAO.updateRecord(record);
        response.setStatus(HttpServletResponse.SC_FOUND);
        response.setHeader("Location", "records");
    }

    private void deleteRecord(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        recordDAO.deleteRecord(id);
        response.setStatus(HttpServletResponse.SC_FOUND);
        response.setHeader("Location", "records");
    }
}
