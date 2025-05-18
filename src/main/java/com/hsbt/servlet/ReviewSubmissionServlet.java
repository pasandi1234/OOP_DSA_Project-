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
import java.util.List;

public class ReviewSubmissionServlet extends HttpServlet {
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

        String bookingIdStr = request.getParameter("bookingId");
        String tutorIdStr = request.getParameter("tutorId");
        String studentIdStr = request.getParameter("studentId");

        if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                Booking booking = bookingService.getBookingById(bookingId);

                if (booking != null) {

                    if (!"Completed".equals(booking.getStatus())) {
                        request.setAttribute("error", "You can only review completed bookings.");
                        request.getRequestDispatcher("/booking-history").forward(request, response);
                        return;
                    }

                    if (reviewService.hasStudentReviewedBooking(booking.getStudentId(), bookingId)) {
                        request.setAttribute("error", "You have already reviewed this booking.");
                        request.getRequestDispatcher("/booking-history").forward(request, response);
                        return;
                    }

                    Tutor tutor = tutorService.getTutorById(booking.getTutorId());
                    Student student = studentService.getStudentById(booking.getStudentId());

                    request.setAttribute("booking", booking);
                    request.setAttribute("tutor", tutor);
                    request.setAttribute("student", student);

                    request.getRequestDispatcher("/review-form.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {

            }
        } else if (tutorIdStr != null && !tutorIdStr.isEmpty()) {
            try {
                int tutorId = Integer.parseInt(tutorIdStr);
                Tutor tutor = tutorService.getTutorById(tutorId);

                if (tutor != null) {

                    Student student = null;
                    if (studentIdStr != null && !studentIdStr.isEmpty()) {
                        try {
                            int studentId = Integer.parseInt(studentIdStr);
                            student = studentService.getStudentById(studentId);
                        } catch (NumberFormatException e) {

                        }
                    }

                    if (student == null) {

                        List<Student> students = studentService.getAllStudents();
                        student = students.isEmpty() ? null : students.get(0);
                    }

                    request.setAttribute("tutor", tutor);
                    request.setAttribute("student", student);

                    request.getRequestDispatcher("/review-form.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {

            }
        }

        response.sendRedirect("booking-history");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingIdStr = request.getParameter("bookingId");
        String tutorIdStr = request.getParameter("tutorId");
        String studentIdStr = request.getParameter("studentId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");
        String reviewType = request.getParameter("reviewType");
        String isAnonymousStr = request.getParameter("isAnonymous");

        try {

            if (tutorIdStr == null || tutorIdStr.isEmpty() ||
                studentIdStr == null || studentIdStr.isEmpty() ||
                ratingStr == null || ratingStr.isEmpty()) {
                request.setAttribute("error", "Missing required parameters. Please try again.");
                request.getRequestDispatcher("/review-form.jsp").forward(request, response);
                return;
            }

            int tutorId = Integer.parseInt(tutorIdStr);
            int studentId = Integer.parseInt(studentIdStr);
            double rating = Double.parseDouble(ratingStr);
            int bookingId = 0;

            if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
                bookingId = Integer.parseInt(bookingIdStr);
            }

            Tutor tutor = tutorService.getTutorById(tutorId);
            Student student = studentService.getStudentById(studentId);

            if (tutor == null || student == null) {
                request.setAttribute("error", "Invalid tutor or student ID.");
                request.getRequestDispatcher("/review-form.jsp").forward(request, response);
                return;
            }

            Booking booking = null;
            if (bookingId > 0) {
                booking = bookingService.getBookingById(bookingId);
                if (booking == null) {
                    request.setAttribute("error", "Invalid booking ID.");
                    request.getRequestDispatcher("/review-form.jsp").forward(request, response);
                    return;
                }

                if (reviewService.hasStudentReviewedBooking(studentId, bookingId)) {
                    request.setAttribute("error", "You have already reviewed this booking.");
                    request.getRequestDispatcher("/review-form.jsp").forward(request, response);
                    return;
                }
            }

            String currentDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            Review review;

            if ("verified".equals(reviewType)) {

                review = new VerifiedReview(
                    0,
                    studentId,
                    tutorId,
                    bookingId,
                    rating,
                    comment,
                    currentDate,
                    true,
                    "Booking Confirmation",
                    currentDate,
                    "System",
                    false
                );
            } else {

                boolean isAnonymous = "on".equals(isAnonymousStr);

                review = new PublicReview(
                    0,
                    studentId,
                    tutorId,
                    bookingId,
                    rating,
                    comment,
                    currentDate,
                    false,
                    isAnonymous,
                    0,
                    0
                );
            }

            Review submittedReview = reviewService.submitReview(review);

            request.setAttribute("review", submittedReview);
            request.setAttribute("tutor", tutor);
            request.setAttribute("student", student);
            if (booking != null) {
                request.setAttribute("booking", booking);
            }

            request.getRequestDispatcher("/review-confirmation.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format. Please check your inputs and try again.");
            request.getRequestDispatcher("/review-form.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/review-form.jsp").forward(request, response);
        }
    }
}
