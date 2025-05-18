package com.hsbt.servlet;

import com.hsbt.model.Review;
import com.hsbt.model.Booking;
import com.hsbt.model.Tutor;
import com.hsbt.model.Student;
import com.hsbt.service.ReviewManagementService;
import com.hsbt.service.BookingManagementService;
import com.hsbt.service.TutorManagementService;
import com.hsbt.service.StudentManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReviewViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewManagementService reviewService;
    private BookingManagementService bookingService;
    private TutorManagementService tutorService;
    private StudentManagementService studentService;

    @Override
    public void init() throws ServletException {
        super.init();
        reviewService = ReviewManagementService.getInstance();
        bookingService = BookingManagementService.getInstance();
        tutorService = TutorManagementService.getInstance();
        studentService = StudentManagementService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reviewIdStr = request.getParameter("id");
        
        if (reviewIdStr != null && !reviewIdStr.isEmpty()) {
            try {
                int reviewId = Integer.parseInt(reviewIdStr);
                Review review = reviewService.getReviewById(reviewId);
                
                if (review != null) {

                    Booking booking = null;
                    if (review.getBookingId() > 0) {
                        booking = bookingService.getBookingById(review.getBookingId());
                    }
                    Tutor tutor = tutorService.getTutorById(review.getTutorId());
                    Student student = studentService.getStudentById(review.getStudentId());

                    request.setAttribute("review", review);
                    if (booking != null) {
                        request.setAttribute("booking", booking);
                    }
                    request.setAttribute("tutor", tutor);
                    request.setAttribute("student", student);

                    request.getRequestDispatcher("/review-details.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {

            }
        }

        response.sendRedirect("tutor-search.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reviewIdStr = request.getParameter("id");
        String voteType = request.getParameter("voteType");
        
        if (reviewIdStr != null && !reviewIdStr.isEmpty() && voteType != null && !voteType.isEmpty()) {
            try {
                int reviewId = Integer.parseInt(reviewIdStr);
                
                boolean success = false;
                if ("helpful".equals(voteType)) {
                    success = reviewService.voteHelpful(reviewId);
                } else if ("unhelpful".equals(voteType)) {
                    success = reviewService.voteUnhelpful(reviewId);
                }
                
                if (success) {

                    response.sendRedirect("view-review?id=" + reviewId + "&voted=true");
                    return;
                }
            } catch (NumberFormatException e) {

            }
        }

        response.sendRedirect("tutor-search.jsp");
    }
}
