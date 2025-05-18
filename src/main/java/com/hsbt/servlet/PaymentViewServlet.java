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


public class PaymentViewServlet extends HttpServlet {
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
        

        String paymentIdStr = request.getParameter("id");
        
        if (paymentIdStr != null && !paymentIdStr.isEmpty()) {
            try {
                int paymentId = Integer.parseInt(paymentIdStr);
                Payment payment = paymentService.getPaymentById(paymentId);
                
                if (payment != null) {

                    Booking booking = bookingService.getBookingById(payment.getBookingId());
                    Tutor tutor = tutorService.getTutorById(payment.getTutorId());
                    Student student = studentService.getStudentById(payment.getStudentId());
                    

                    request.setAttribute("payment", payment);
                    request.setAttribute("booking", booking);
                    request.setAttribute("tutor", tutor);
                    request.setAttribute("student", student);
                    
                    request.getRequestDispatcher("/payment-details.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {

            }
        }
        

        response.sendRedirect("payment-history");
    }
}
