package com.hsbt.servlet;

import com.hsbt.model.Payment;
import com.hsbt.model.Booking;
import com.hsbt.model.Tutor;
import com.hsbt.model.Student;
import com.hsbt.service.PaymentManagementService;
import com.hsbt.service.BookingManagementService;
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


public class PaymentListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaymentManagementService paymentService;
    private BookingManagementService bookingService;
    private TutorManagementService tutorService;
    private StudentManagementService studentService;


    @Override
    public void init() throws ServletException {
        super.init();
        paymentService = PaymentManagementService.getInstance();
        bookingService = BookingManagementService.getInstance();
        tutorService = TutorManagementService.getInstance();
        studentService = StudentManagementService.getInstance();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        String status = request.getParameter("status");
        String studentIdStr = request.getParameter("studentId");
        String tutorIdStr = request.getParameter("tutorId");
        String bookingIdStr = request.getParameter("bookingId");
        
        List<Payment> payments;
        
        if (status != null && !status.isEmpty()) {
            payments = paymentService.getPaymentsByStatus(status);
            request.setAttribute("selectedStatus", status);
        } else if (studentIdStr != null && !studentIdStr.isEmpty()) {
            try {
                int studentId = Integer.parseInt(studentIdStr);
                payments = paymentService.getPaymentsByStudentId(studentId);
                

                Student student = studentService.getStudentById(studentId);
                request.setAttribute("selectedStudent", student);
            } catch (NumberFormatException e) {

                payments = paymentService.getAllPayments();
            }
        } else if (tutorIdStr != null && !tutorIdStr.isEmpty()) {
            try {
                int tutorId = Integer.parseInt(tutorIdStr);
                payments = paymentService.getPaymentsByTutorId(tutorId);
                

                Tutor tutor = tutorService.getTutorById(tutorId);
                request.setAttribute("selectedTutor", tutor);
            } catch (NumberFormatException e) {

                payments = paymentService.getAllPayments();
            }
        } else if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                payments = paymentService.getPaymentsByBookingId(bookingId);
                

                Booking booking = bookingService.getBookingById(bookingId);
                request.setAttribute("selectedBooking", booking);
            } catch (NumberFormatException e) {

                payments = paymentService.getAllPayments();
            }
        } else {

            payments = paymentService.getAllPayments();
        }
        

        Map<Integer, Booking> bookings = new HashMap<>();
        Map<Integer, Tutor> tutors = new HashMap<>();
        Map<Integer, Student> students = new HashMap<>();
        
        for (Payment payment : payments) {

            if (!bookings.containsKey(payment.getBookingId())) {
                Booking booking = bookingService.getBookingById(payment.getBookingId());
                if (booking != null) {
                    bookings.put(payment.getBookingId(), booking);
                }
            }
            

            if (!tutors.containsKey(payment.getTutorId())) {
                Tutor tutor = tutorService.getTutorById(payment.getTutorId());
                if (tutor != null) {
                    tutors.put(payment.getTutorId(), tutor);
                }
            }
            

            if (!students.containsKey(payment.getStudentId())) {
                Student student = studentService.getStudentById(payment.getStudentId());
                if (student != null) {
                    students.put(payment.getStudentId(), student);
                }
            }
        }
        

        request.setAttribute("payments", payments);
        request.setAttribute("bookings", bookings);
        request.setAttribute("tutors", tutors);
        request.setAttribute("students", students);
        

        request.getRequestDispatcher("/payment-history.jsp").forward(request, response);
    }
}
