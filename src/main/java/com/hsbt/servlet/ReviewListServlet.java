package com.hsbt.servlet;

import com.hsbt.model.Review;
import com.hsbt.model.Tutor;
import com.hsbt.model.Student;
import com.hsbt.service.ReviewManagementService;
import com.hsbt.service.TutorManagementService;
import com.hsbt.service.StudentManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewManagementService reviewService;
    private TutorManagementService tutorService;
    private StudentManagementService studentService;

    @Override
    public void init() throws ServletException {
        super.init();
        reviewService = ReviewManagementService.getInstance();
        tutorService = TutorManagementService.getInstance();
        studentService = StudentManagementService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tutorIdStr = request.getParameter("tutorId");
        String studentIdStr = request.getParameter("studentId");
        String approvalStatus = request.getParameter("status");
        String reviewType = request.getParameter("type");

        List<Tutor> tutors = tutorService.getAllTutors();
        List<Student> students = studentService.getAllStudents();

        Map<Integer, Tutor> tutorMap = new HashMap<>();
        Map<Integer, Student> studentMap = new HashMap<>();
        
        for (Tutor tutor : tutors) {
            tutorMap.put(tutor.getId(), tutor);
        }
        
        for (Student student : students) {
            studentMap.put(student.getId(), student);
        }

        request.setAttribute("tutors", tutorMap);
        request.setAttribute("students", studentMap);

        List<Review> filteredReviews;
        
        if (tutorIdStr != null && !tutorIdStr.isEmpty()) {
            try {
                int tutorId = Integer.parseInt(tutorIdStr);
                Tutor selectedTutor = tutorService.getTutorById(tutorId);
                
                if (selectedTutor != null) {
                    request.setAttribute("selectedTutor", selectedTutor);
                    
                    if ("approved".equals(approvalStatus)) {
                        filteredReviews = reviewService.getApprovedReviewsByTutorId(tutorId);
                    } else {
                        filteredReviews = reviewService.getReviewsByTutorId(tutorId);
                    }
                } else {
                    filteredReviews = reviewService.getAllReviews();
                }
            } catch (NumberFormatException e) {
                filteredReviews = reviewService.getAllReviews();
            }
        } else if (studentIdStr != null && !studentIdStr.isEmpty()) {
            try {
                int studentId = Integer.parseInt(studentIdStr);
                Student selectedStudent = studentService.getStudentById(studentId);
                
                if (selectedStudent != null) {
                    request.setAttribute("selectedStudent", selectedStudent);
                    filteredReviews = reviewService.getReviewsByStudentId(studentId);
                } else {
                    filteredReviews = reviewService.getAllReviews();
                }
            } catch (NumberFormatException e) {
                filteredReviews = reviewService.getAllReviews();
            }
        } else if (approvalStatus != null && !approvalStatus.isEmpty()) {
            request.setAttribute("selectedStatus", approvalStatus);
            
            if ("approved".equals(approvalStatus)) {
                filteredReviews = reviewService.getApprovedReviews();
            } else if ("pending".equals(approvalStatus)) {
                filteredReviews = reviewService.getPendingReviews();
            } else {
                filteredReviews = reviewService.getAllReviews();
            }
        } else if (reviewType != null && !reviewType.isEmpty()) {
            request.setAttribute("selectedType", reviewType);
            
            if ("public".equals(reviewType)) {
                filteredReviews = reviewService.getReviewsByType("PUBLIC");
            } else if ("verified".equals(reviewType)) {
                filteredReviews = reviewService.getReviewsByType("VERIFIED");
            } else {
                filteredReviews = reviewService.getAllReviews();
            }
        } else {

            filteredReviews = reviewService.getAllReviews();
        }

        request.setAttribute("reviews", filteredReviews);

        request.getRequestDispatcher("/review-list.jsp").forward(request, response);
    }
}
