package com.hsbt.servlet;

import com.hsbt.model.Student;
import com.hsbt.service.StudentManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
public class StudentSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentManagementService studentService;
    @Override
    public void init() throws ServletException {
        super.init();
        studentService = StudentManagementService.getInstance();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchType = request.getParameter("searchType");
        String query = request.getParameter("query");
        String activeOnly = request.getParameter("activeOnly");
        if (query == null) {
            query = "";
        }

        boolean showActiveOnly = "true".equals(activeOnly);

        List<Student> results = null;
        
        if ("name".equals(searchType)) {
            results = studentService.searchStudentsByName(query);
        } else if ("subject".equals(searchType)) {
            results = studentService.searchStudentsBySubject(query);
        } else {
            results = showActiveOnly ? studentService.getActiveStudents() : studentService.getAllStudents();
        }
        if (showActiveOnly && results != null && !results.isEmpty()) {
            results.removeIf(student -> !student.isActive());
        }
        request.setAttribute("students", results);
        request.getRequestDispatcher("/student-search-results.jsp").forward(request, response);
    }
}
