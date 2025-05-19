package com.hsbt.servlet;

import com.hsbt.model.Student;
import com.hsbt.service.StudentManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
public class StudentProfileServlet extends HttpServlet {
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
        String idStr = request.getParameter("id");
        
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                Student student = studentService.getStudentById(id);
                
                if (student != null) {
                    request.setAttribute("student", student);
                    request.getRequestDispatcher("/student-profile.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
            }
        }
        response.sendRedirect("student-search.jsp");
    }
}
