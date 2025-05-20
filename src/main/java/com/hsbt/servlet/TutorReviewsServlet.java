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

public class TutorReviewsServlet extends HttpServlet {
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

        String tutorIdStr = request.getParameter("id");
        
        if (tutorIdStr != null && !tutorIdStr.isEmpty()) {
            try {
                int tutorId = Integer.parseInt(tutorIdStr);
                Tutor tutor = tutorService.getTutorById(tutorId);
                
                if (tutor != null) {

                    List<Review> reviews = reviewService.getApprovedReviewsByTutorId(tutorId);

                    Map<Integer, Student> studentMap = new HashMap<>();
                    for (Review review : reviews) {
                        Student student = studentService.getStudentById(review.getStudentId());
                        if (student != null) {
                            studentMap.put(student.getId(), student);
                        }
                    }

                    request.setAttribute("tutor", tutor);
                    request.setAttribute("reviews", reviews);
                    request.setAttribute("students", studentMap);

                    request.getRequestDispatcher("/tutor-reviews.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {

            }
        }

        response.sendRedirect("tutor-search.jsp");
    }
}
