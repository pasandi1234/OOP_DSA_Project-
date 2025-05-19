package com.hsbt.servlet;

import com.hsbt.service.StudentManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
public class StudentDeleteServlet extends HttpServlet {
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
        String deactivateOnly = request.getParameter("deactivateOnly");
        boolean softDelete = "true".equals(deactivateOnly);
        
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                boolean success;
                
                if (softDelete) {
                    success = studentService.deactivateStudent(id);
                    if (success) {
                        request.setAttribute("message", "Student deactivated successfully.");
                    } else {
                        request.setAttribute("error", "Failed to deactivate student. Student not found.");
                    }
                } else {
                    success = studentService.deleteStudent(id);
                    if (success) {
                        request.setAttribute("message", "Student deleted successfully.");
                    } else {
                        request.setAttribute("error", "Failed to delete student. Student not found.");
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid student ID format.");
            }
        } else {
            request.setAttribute("error", "No student ID provided.");
        }
        request.getRequestDispatcher("/student-search.jsp").forward(request, response);
    }
}
