package com.hsbt.servlet;

import com.hsbt.model.Review;
import com.hsbt.service.ReviewManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReviewDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewManagementService reviewService;

    @Override
    public void init() throws ServletException {
        super.init();
        reviewService = ReviewManagementService.getInstance();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reviewIdStr = request.getParameter("id");
        String action = request.getParameter("action");
        String returnUrl = request.getParameter("returnUrl");

        if (returnUrl == null || returnUrl.isEmpty()) {
            returnUrl = "tutor-reviews";
        }

        if (reviewIdStr != null && !reviewIdStr.isEmpty()) {
            try {
                int reviewId = Integer.parseInt(reviewIdStr);
                Review review = reviewService.getReviewById(reviewId);

                if (review != null) {
                    boolean success = false;

                    try {
                        if ("delete".equals(action)) {
                            // Delete the review
                            success = reviewService.deleteReview(reviewId);

                            if (success) {
                                response.sendRedirect(returnUrl + "?deleted=true");
                                return;
                            } else {
                                response.sendRedirect(returnUrl + "?error=delete_failed");
                                return;
                            }
                        } else if ("approve".equals(action)) {
                            success = reviewService.approveReview(reviewId);

                            if (success) {
                                response.sendRedirect(returnUrl + "?approved=true");
                                return;
                            } else {
                                response.sendRedirect(returnUrl + "?error=approve_failed");
                                return;
                            }
                        } else if ("disapprove".equals(action)) {
                            success = reviewService.disapproveReview(reviewId);

                            if (success) {
                                response.sendRedirect(returnUrl + "?disapproved=true");
                                return;
                            } else {
                                response.sendRedirect(returnUrl + "?error=disapprove_failed");
                                return;
                            }
                        } else {
                            response.sendRedirect(returnUrl + "?error=invalid_action");
                            return;
                        }
                    } catch (Exception e) {
                        response.sendRedirect(returnUrl + "?error=exception&message=" + e.getMessage());
                        return;
                    }
                }
            } catch (NumberFormatException e) {
            }
        }

        if (reviewIdStr == null || reviewIdStr.isEmpty()) {
            response.sendRedirect(returnUrl + "?error=missing_id");
        } else if (action == null || action.isEmpty()) {
            response.sendRedirect(returnUrl + "?error=missing_action");
        } else {
            response.sendRedirect(returnUrl + "?error=operation_failed");
        }
    }
}
