package com.hsbt.model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;


public class Payment {
    private int id;
    private int bookingId;
    private int studentId;
    private int tutorId;
    private double amount;
    private String date; // Format: yyyy-MM-dd
    private String status; // "Pending", "Completed", "Refunded", "Failed"
    private String transactionId;
    private String paymentType; // "CARD", "BANK", "BASE"


    public Payment() {
        this.paymentType = "BASE";
    }


    public Payment(int id, int bookingId, int studentId, int tutorId, 
                  double amount, String date, String status, String transactionId) {
        this.id = id;
        this.bookingId = bookingId;
        this.studentId = studentId;
        this.tutorId = tutorId;
        this.amount = amount;
        this.date = date;
        this.status = status;
        this.transactionId = transactionId;
        this.paymentType = "BASE";
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getTutorId() {
        return tutorId;
    }

    public void setTutorId(int tutorId) {
        this.tutorId = tutorId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }
    
    public String getPaymentType() {
        return paymentType;
    }
    
    protected void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }
    

    public String getFormattedDate() {
        try {
            LocalDate paymentDate = LocalDate.parse(date);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy");
            return paymentDate.format(formatter);
        } catch (DateTimeParseException e) {
            return date;
        }
    }
    

    public boolean isRefundable() {
        return "Completed".equals(status);
    }
    

    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(id).append("|");
        sb.append(bookingId).append("|");
        sb.append(studentId).append("|");
        sb.append(tutorId).append("|");
        sb.append(amount).append("|");
        sb.append(date).append("|");
        sb.append(status).append("|");
        sb.append(transactionId).append("|");
        sb.append(paymentType);
        
        return sb.toString();
    }
    

    public static Payment fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 9) {
            throw new IllegalArgumentException("Invalid file string format for Payment");
        }
        
        int id = Integer.parseInt(parts[0]);
        int bookingId = Integer.parseInt(parts[1]);
        int studentId = Integer.parseInt(parts[2]);
        int tutorId = Integer.parseInt(parts[3]);
        double amount = Double.parseDouble(parts[4]);
        String date = parts[5];
        String status = parts[6];
        String transactionId = parts[7];
        String paymentType = parts[8];
        
        if ("CARD".equals(paymentType)) {
            return CardPayment.fromFileString(fileString);
        } else if ("BANK".equals(paymentType)) {
            return BankTransfer.fromFileString(fileString);
        } else {
            Payment payment = new Payment(id, bookingId, studentId, tutorId, amount, date, status, transactionId);
            payment.setPaymentType(paymentType);
            return payment;
        }
    }


    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Payment ID: ").append(id).append("\n");
        sb.append("Booking ID: ").append(bookingId).append("\n");
        sb.append("Student ID: ").append(studentId).append("\n");
        sb.append("Tutor ID: ").append(tutorId).append("\n");
        sb.append("Amount: $").append(String.format("%.2f", amount)).append("\n");
        sb.append("Date: ").append(getFormattedDate()).append("\n");
        sb.append("Status: ").append(status).append("\n");
        sb.append("Transaction ID: ").append(transactionId).append("\n");
        sb.append("Payment Type: ").append(paymentType).append("\n");
        
        return sb.toString();
    }
}
