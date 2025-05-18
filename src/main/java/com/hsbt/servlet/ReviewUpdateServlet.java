package com.hsbt.servlet;

import com.hsbt.model.Review;
import com.hsbt.model.PublicReview;
import com.hsbt.model.VerifiedReview;
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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class ReviewUpdateServlet extends HttpServlet {
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

                    request.getRequestDispatcher("/review-update.jsp").forward(request, response);
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
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");
        String isApprovedStr = request.getParameter("isApproved");
        String isAnonymousStr = request.getParameter("isAnonymous");
        
        try {

            int reviewId = Integer.parseInt(reviewIdStr);
            double rating = Double.parseDouble(ratingStr);

            Review existingReview = reviewService.getReviewById(reviewId);
            
            if (existingReview == null) {
                request.setAttribute("error", "Review not found.");
                request.getRequestDispatcher("/review-update.jsp").forward(request, response);
                return;
            }

            if (existingReview instanceof PublicReview) {
                PublicReview publicReview = (PublicReview) existingReview;

                publicReview.setRating(rating);
                publicReview.setComment(comment);
                publicReview.setApproved("on".equals(isApprovedStr));

                publicReview.setAnonymous("on".equals(isAnonymousStr));

                boolean success = reviewService.updateReview(publicReview);
                
                if (success) {

                    response.sendRedirect("view-review?id=" + reviewId + "&updated=true");
                    return;
                }
            } else if (existingReview instanceof VerifiedReview) {
                VerifiedReview verifiedReview = (VerifiedReview) existingReview;

                verifiedReview.setRating(rating);
                verifiedReview.setComment(comment);
                verifiedReview.setApproved("on".equals(isApprovedStr));

                String verificationMethod = request.getParameter("verificationMethod");
                String verifiedBy = request.getParameter("verifiedBy");
                String hasAttachmentsStr = request.getParameter("hasAttachments");
                
                if (verificationMethod != null && !verificationMethod.isEmpty()) {
                    verifiedReview.setVerificationMethod(verificationMethod);
                }
                
                if (verifiedBy != null && !verifiedBy.isEmpty()) {
                    verifiedReview.setVerifiedBy(verifiedBy);
                }
                
                verifiedReview.setHasAttachments("on".equals(hasAttachmentsStr));

                if ("on".equals(request.getParameter("updateVerificationDate"))) {
                    verifiedReview.setVerificationDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
                }

                boolean success = reviewService.updateReview(verifiedReview);
                
                if (success) {
                    response.sendRedirect("view-review?id=" + reviewId + "&updated=true");
                    return;
                }
            } else {
                existingReview.setRating(rating);
                existingReview.setComment(comment);
                existingReview.setApproved("on".equals(isApprovedStr));

                boolean success = reviewService.updateReview(existingReview);
                
                if (success) {

                    response.sendRedirect("view-review?id=" + reviewId + "&updated=true");
                    return;
                }
            }

            request.setAttribute("error", "Failed to update the review.");
            request.setAttribute("review", existingReview);
            request.getRequestDispatcher("/review-update.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format. Please check your inputs and try again.");
            request.getRequestDispatcher("/review-update.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/review-update.jsp").forward(request, response);
        }
    }
}
