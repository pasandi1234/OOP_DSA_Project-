package com.hsbt.servlet;

import com.hsbt.model.Payment;
import com.hsbt.model.CardPayment;
import com.hsbt.model.BankTransfer;
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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;


public class PaymentProcessingServlet extends HttpServlet {
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
        
        String bookingIdStr = request.getParameter("bookingId");
        
        if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                Booking booking = bookingService.getBookingById(bookingId);
                
                if (booking != null) {

                    Tutor tutor = tutorService.getTutorById(booking.getTutorId());
                    Student student = studentService.getStudentById(booking.getStudentId());
                    

                    request.setAttribute("booking", booking);
                    request.setAttribute("tutor", tutor);
                    request.setAttribute("student", student);
                    

                    request.getRequestDispatcher("/payment-form.jsp").forward(request, response);
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
        String paymentMethod = request.getParameter("paymentMethod");
        String amountStr = request.getParameter("amount");
        
        try {

            int bookingId = Integer.parseInt(bookingIdStr);
            double amount = Double.parseDouble(amountStr);
            

            Booking booking = bookingService.getBookingById(bookingId);
            
            if (booking == null) {
                request.setAttribute("error", "Invalid booking ID.");
                request.getRequestDispatcher("/payment-form.jsp").forward(request, response);
                return;
            }
            

            Tutor tutor = tutorService.getTutorById(booking.getTutorId());
            Student student = studentService.getStudentById(booking.getStudentId());
            
            if (tutor == null || student == null) {
                request.setAttribute("error", "Invalid tutor or student ID.");
                request.getRequestDispatcher("/payment-form.jsp").forward(request, response);
                return;
            }
            

            String transactionId = generateTransactionId();
            String currentDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            Payment payment;
            
            if ("card".equals(paymentMethod)) {

                String cardType = request.getParameter("cardType");
                String cardNumber = request.getParameter("cardNumber");
                String cardholderName = request.getParameter("cardholderName");
                String expiryDate = request.getParameter("expiryDate");
                String cvv = request.getParameter("cvv");
                

                if (cardNumber == null || cardNumber.length() < 13 || cardNumber.length() > 19) {
                    request.setAttribute("error", "Invalid card number.");
                    request.setAttribute("booking", booking);
                    request.setAttribute("tutor", tutor);
                    request.setAttribute("student", student);
                    request.getRequestDispatcher("/payment-form.jsp").forward(request, response);
                    return;
                }
                

                String lastFourDigits = cardNumber.substring(cardNumber.length() - 4);
                

                payment = new CardPayment(
                    0,
                    bookingId,
                    student.getId(),
                    tutor.getId(),
                    amount,
                    currentDate,
                    "Completed",
                    transactionId,
                    cardType,
                    lastFourDigits,
                    cardholderName,
                    expiryDate
                );
            } else if ("bank".equals(paymentMethod)) {

                String bankName = request.getParameter("bankName");
                String accountName = request.getParameter("accountName");
                String referenceNumber = request.getParameter("referenceNumber");
                String isInternationalStr = request.getParameter("isInternational");
                boolean isInternational = "on".equals(isInternationalStr);
                String transferMethod = request.getParameter("transferMethod");
                

                payment = new BankTransfer(
                    0,
                    bookingId,
                    student.getId(),
                    tutor.getId(),
                    amount,
                    currentDate,
                    "Pending",
                    transactionId,
                    bankName,
                    accountName,
                    referenceNumber,
                    isInternational,
                    transferMethod
                );
            } else {
                request.setAttribute("error", "Invalid payment method.");
                request.setAttribute("booking", booking);
                request.setAttribute("tutor", tutor);
                request.setAttribute("student", student);
                request.getRequestDispatcher("/payment-form.jsp").forward(request, response);
                return;
            }
            

            Payment processedPayment = paymentService.processPayment(payment);
            

            request.setAttribute("payment", processedPayment);
            request.setAttribute("booking", booking);
            request.setAttribute("tutor", tutor);
            request.setAttribute("student", student);
            

            request.getRequestDispatcher("/payment-confirmation.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format. Please check your inputs and try again.");
            request.getRequestDispatcher("/payment-form.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/payment-form.jsp").forward(request, response);
        }
    }
    

    private String generateTransactionId() {
        return "TXN" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}
