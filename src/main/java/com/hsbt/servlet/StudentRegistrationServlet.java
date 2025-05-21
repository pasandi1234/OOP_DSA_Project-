package com.hsbt.servlet;

import com.hsbt.model.Student;
import com.hsbt.service.StudentManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
public class StudentRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentManagementService studentService;
    @Override
    public void init() throws ServletException {
        super.init();
        studentService = StudentManagementService.getInstance();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String[] preferredSubjectsArray = request.getParameterValues("preferredSubjects");
        String SubjectStream = request.getParameter("SubjectStream");
        String[] preferredDaysArray = request.getParameterValues("preferredDays");
        String preferredTimeSlot = request.getParameter("preferredTimeSlot");
        if (preferredSubjectsArray == null) {
            preferredSubjectsArray = new String[0];
        }
        if (preferredDaysArray == null) {
            preferredDaysArray = new String[0];
        }
        Student student = new Student(
            0,
            name,
            email,
            phone,
            address,
            preferredSubjectsArray,
            SubjectStream,
            preferredDaysArray,
            preferredTimeSlot,
            true
        );

        Student registeredStudent = studentService.registerStudent(student);
        request.setAttribute("student", registeredStudent);
        request.getRequestDispatcher("/student-success.jsp").forward(request, response);
    }
}
