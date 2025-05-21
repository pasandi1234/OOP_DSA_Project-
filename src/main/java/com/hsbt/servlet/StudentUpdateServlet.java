package com.hsbt.servlet;

import com.hsbt.model.Student;
import com.hsbt.service.StudentManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
public class StudentUpdateServlet extends HttpServlet {
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
                    request.getRequestDispatcher("/student-update.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
            }
        }
        response.sendRedirect("student-search.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        int id = 0;
        
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("student-search.jsp");
            return;
        }
        Student existingStudent = studentService.getStudentById(id);
        
        if (existingStudent == null) {
            response.sendRedirect("student-search.jsp");
            return;
        }
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String[] preferredSubjectsArray = request.getParameterValues("preferredSubjects");
        String SubjectStream = request.getParameter("SubjectStream");
        String[] preferredDaysArray = request.getParameterValues("preferredDays");
        String preferredTimeSlot = request.getParameter("preferredTimeSlot");
        String activeStr = request.getParameter("active");

        if (preferredSubjectsArray == null) {
            preferredSubjectsArray = new String[0];
        }
        
        if (preferredDaysArray == null) {
            preferredDaysArray = new String[0];
        }

        boolean active = "true".equals(activeStr);

        Student updatedStudent = new Student(
            id,
            name,
            email,
            phone,
            address,
            preferredSubjectsArray,
            SubjectStream,
            preferredDaysArray,
            preferredTimeSlot,
            active
        );

        boolean success = studentService.updateStudent(updatedStudent);
        
        if (success) {
            request.setAttribute("student", updatedStudent);
            request.setAttribute("message", "Student updated successfully.");

            request.getRequestDispatcher("/student-success.jsp").forward(request, response);
        } else {
            request.setAttribute("student", existingStudent);
            request.setAttribute("error", "Failed to update student. Please try again.");
            request.getRequestDispatcher("/student-update.jsp").forward(request, response);
        }
    }
}
