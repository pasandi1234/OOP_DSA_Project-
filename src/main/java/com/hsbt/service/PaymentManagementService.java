package com.hsbt.service;

import com.hsbt.model.Payment;
import com.hsbt.model.CardPayment;
import com.hsbt.model.BankTransfer;
import com.hsbt.model.Booking;
import com.hsbt.config.DatabaseConfig;
import com.hsbt.util.FileIOUtil;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


public class PaymentManagementService {
    private List<Payment> payments;
    private static PaymentManagementService instance;
    private int nextId;
    private String paymentsFilePath;
    private BookingManagementService bookingService;


    private PaymentManagementService() {
        payments = new ArrayList<>();
        nextId = 1;
        DatabaseConfig.ensureDirectoriesExist();
        paymentsFilePath = DatabaseConfig.getPaymentsFilePath();
        bookingService = BookingManagementService.getInstance();
        loadPayments();
    }


    public static synchronized PaymentManagementService getInstance() {
        if (instance == null) {
            instance = new PaymentManagementService();
        }
        return instance;
    }


    public Payment processPayment(Payment payment) {

        if (payment.getId() <= 0) {
            payment.setId(nextId++);
        }
        payments.add(payment);
        
        if ("Completed".equals(payment.getStatus())) {
            Booking booking = bookingService.getBookingById(payment.getBookingId());
            if (booking != null && !"Completed".equals(booking.getStatus()) && !"Cancelled".equals(booking.getStatus())) {
                booking.setStatus("Confirmed");
                bookingService.updateBooking(booking);
            }
        }
        

        savePayments();
        return payment;
    }


    public Payment getPaymentById(int id) {
        for (Payment payment : payments) {
            if (payment.getId() == id) {
                return payment;
            }
        }
        return null;
    }


    public boolean updatePayment(Payment payment) {
        for (int i = 0; i < payments.size(); i++) {
            if (payments.get(i).getId() == payment.getId()) {
                payments.set(i, payment);
                

                if ("Completed".equals(payment.getStatus())) {
                    Booking booking = bookingService.getBookingById(payment.getBookingId());
                    if (booking != null && !"Completed".equals(booking.getStatus()) && !"Cancelled".equals(booking.getStatus())) {
                        booking.setStatus("Confirmed");
                        bookingService.updateBooking(booking);
                    }
                } else if ("Failed".equals(payment.getStatus()) || "Refunded".equals(payment.getStatus())) {
                    Booking booking = bookingService.getBookingById(payment.getBookingId());
                    if (booking != null && "Confirmed".equals(booking.getStatus())) {
                        booking.setStatus("Pending");
                        bookingService.updateBooking(booking);
                    }
                }
                
                savePayments();
                return true;
            }
        }
        return false;
    }


    public boolean deletePayment(int id) {
        for (int i = 0; i < payments.size(); i++) {
            if (payments.get(i).getId() == id) {
                payments.remove(i);
                savePayments();
                return true;
            }
        }
        return false;
    }
    

    public boolean refundPayment(int id) {
        Payment payment = getPaymentById(id);
        if (payment != null && payment.isRefundable()) {
            payment.setStatus("Refunded");
            

            Booking booking = bookingService.getBookingById(payment.getBookingId());
            if (booking != null && "Confirmed".equals(booking.getStatus())) {
                booking.setStatus("Cancelled");
                bookingService.updateBooking(booking);
            }
            
            savePayments();
            return true;
        }
        return false;
    }


    public List<Payment> getAllPayments() {
        return new ArrayList<>(payments);
    }
    

    public List<Payment> getPaymentsByBookingId(int bookingId) {
        return payments.stream()
                .filter(p -> p.getBookingId() == bookingId)
                .collect(Collectors.toList());
    }
    

    public List<Payment> getPaymentsByStudentId(int studentId) {
        return payments.stream()
                .filter(p -> p.getStudentId() == studentId)
                .collect(Collectors.toList());
    }
    

    public List<Payment> getPaymentsByTutorId(int tutorId) {
        return payments.stream()
                .filter(p -> p.getTutorId() == tutorId)
                .collect(Collectors.toList());
    }
    

    public List<Payment> getPaymentsByStatus(String status) {
        return payments.stream()
                .filter(p -> p.getStatus().equals(status))
                .collect(Collectors.toList());
    }
    

    public List<Payment> getPaymentsByDate(String date) {
        return payments.stream()
                .filter(p -> p.getDate().equals(date))
                .collect(Collectors.toList());
    }


    private void loadPayments() {
        try {
            if (!FileIOUtil.fileExists(paymentsFilePath)) {

                createSamplePayments();
                return;
            }

            List<String> lines = FileIOUtil.readLinesFromFile(paymentsFilePath);
            payments.clear();


            for (String line : lines) {
                try {
                    Payment payment = Payment.fromFileString(line);
                    payments.add(payment);


                    if (payment.getId() >= nextId) {
                        nextId = payment.getId() + 1;
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing payment: " + e.getMessage());
                }
            }

            if (payments.isEmpty()) {
                createSamplePayments();
            }
        } catch (Exception e) {
            System.err.println("Error loading payments: " + e.getMessage());
            createSamplePayments();
        }
    }


    private void savePayments() {
        try {

            List<String> lines = new ArrayList<>();


            for (Payment payment : payments) {
                String line = payment.toFileString();
                if (line != null) {
                    lines.add(line);
                }
            }


            FileIOUtil.writeLinesToFile(paymentsFilePath, lines);
        } catch (Exception e) {
            System.err.println("Error saving payments: " + e.getMessage());
        }
    }


    private void createSamplePayments() {

        List<Booking> bookings = bookingService.getAllBookings();
        if (bookings.isEmpty()) {
            return;
        }
        

        LocalDate today = LocalDate.now();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        

        CardPayment cardPayment = new CardPayment(
            nextId++,
            bookings.get(0).getId(),
            bookings.get(0).getStudentId(),
            bookings.get(0).getTutorId(),
            bookings.get(0).getPrice(),
            today.minusDays(1).format(dateFormatter),
            "Completed",
            "CARD123456",
            "Visa",
            "4321",
            "John Smith",
            "12/25"
        );
        payments.add(cardPayment);
        

        BankTransfer bankTransfer = new BankTransfer(
            nextId++,
            bookings.get(1).getId(),
            bookings.get(1).getStudentId(),
            bookings.get(1).getTutorId(),
            bookings.get(1).getPrice(),
            today.format(dateFormatter),
            "Pending",
            "BANK789012",
            "First Bank",
            "Emily Johnson",
            "REF123456",
            false,
            "ACH"
        );
        payments.add(bankTransfer);
        

        savePayments();
    }
}
