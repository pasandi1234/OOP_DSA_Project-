package com.hsbt.model;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.Duration;


public class Booking {
    private int id;
    private int studentId;
    private int tutorId;
    private String subject;
    private String date;
    private String startTime;
    private String endTime;
    private double price;
    private String status;
    private String notes;
    private String bookingType;


    public Booking() {
        this.bookingType = "BASE";
    }


    public Booking(int id, int studentId, int tutorId, String subject, String date,
                  String startTime, String endTime, double price, String status, String notes) {
        this.id = id;
        this.studentId = studentId;
        this.tutorId = tutorId;
        this.subject = subject;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.price = price;
        this.status = status;
        this.notes = notes;
        this.bookingType = "BASE";
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public String getBookingType() {
        return bookingType;
    }
    
    protected void setBookingType(String bookingType) {
        this.bookingType = bookingType;
    }


    public double calculateDuration() {
        try {
            LocalTime start = LocalTime.parse(startTime);
            LocalTime end = LocalTime.parse(endTime);
            
            Duration duration = Duration.between(start, end);
            return duration.toMinutes() / 60.0;
        } catch (DateTimeParseException e) {
            return 0.0;
        }
    }
    

    public boolean isPast() {
        try {
            LocalDate bookingDate = LocalDate.parse(date);
            LocalDate today = LocalDate.now();
            
            if (bookingDate.isBefore(today)) {
                return true;
            } else if (bookingDate.isEqual(today)) {

                LocalTime end = LocalTime.parse(endTime);
                LocalTime now = LocalTime.now();
                return end.isBefore(now);
            }
            
            return false;
        } catch (DateTimeParseException e) {
            return false;
        }
    }
    

    public boolean isUpcoming() {
        return !isPast() && !"Cancelled".equals(status);
    }
    

    public String getFormattedDate() {
        try {
            LocalDate bookingDate = LocalDate.parse(date);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy");
            return bookingDate.format(formatter);
        } catch (DateTimeParseException e) {
            return date;
        }
    }
    

    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(id).append("|");
        sb.append(studentId).append("|");
        sb.append(tutorId).append("|");
        sb.append(subject).append("|");
        sb.append(date).append("|");
        sb.append(startTime).append("|");
        sb.append(endTime).append("|");
        sb.append(price).append("|");
        sb.append(status).append("|");
        sb.append(notes).append("|");
        sb.append(bookingType);
        
        return sb.toString();
    }
    

    public static Booking fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 11) {
            throw new IllegalArgumentException("Invalid file string format for Booking");
        }
        
        int id = Integer.parseInt(parts[0]);
        int studentId = Integer.parseInt(parts[1]);
        int tutorId = Integer.parseInt(parts[2]);
        String subject = parts[3];
        String date = parts[4];
        String startTime = parts[5];
        String endTime = parts[6];
        double price = Double.parseDouble(parts[7]);
        String status = parts[8];
        String notes = parts[9];
        String bookingType = parts[10];
        
        if ("ONLINE".equals(bookingType)) {
            return OnlineBooking.fromFileString(fileString);
        } else if ("INPERSON".equals(bookingType)) {
            return InPersonBooking.fromFileString(fileString);
        } else {
            return new Booking(id, studentId, tutorId, subject, date, startTime, endTime, price, status, notes);
        }
    }
    

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Booking ID: ").append(id).append("\n");
        sb.append("Student ID: ").append(studentId).append("\n");
        sb.append("Tutor ID: ").append(tutorId).append("\n");
        sb.append("Subject: ").append(subject).append("\n");
        sb.append("Date: ").append(getFormattedDate()).append("\n");
        sb.append("Time: ").append(startTime).append(" - ").append(endTime).append("\n");
        sb.append("Duration: ").append(calculateDuration()).append(" hours\n");
        sb.append("Price: Rs.").append(String.format("%.2f", price)).append("\n");
        sb.append("Status: ").append(status).append("\n");
        sb.append("Notes: ").append(notes).append("\n");
        sb.append("Type: ").append(bookingType).append("\n");
        
        return sb.toString();
    }
}
