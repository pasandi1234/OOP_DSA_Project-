package com.hsbt.model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class Review {
    private int id;
    private int studentId;
    private int tutorId;
    private int bookingId;
    private double rating;
    private String comment;
    private String date;
    private boolean isApproved;
    private String reviewType;

    public Review() {
        this.reviewType = "BASE";
    }

    public Review(int id, int studentId, int tutorId, int bookingId, 
                 double rating, String comment, String date, boolean isApproved) {
        this.id = id;
        this.studentId = studentId;
        this.tutorId = tutorId;
        this.bookingId = bookingId;
        this.rating = rating;
        this.comment = comment;
        this.date = date;
        this.isApproved = isApproved;
        this.reviewType = "BASE";
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

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public boolean isApproved() {
        return isApproved;
    }

    public void setApproved(boolean approved) {
        isApproved = approved;
    }
    
    public String getReviewType() {
        return reviewType;
    }
    
    protected void setReviewType(String reviewType) {
        this.reviewType = reviewType;
    }

    public String getFormattedDate() {
        try {
            LocalDate reviewDate = LocalDate.parse(date);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy");
            return reviewDate.format(formatter);
        } catch (DateTimeParseException e) {
            return date;
        }
    }

    public String getStarRating() {
        StringBuilder stars = new StringBuilder();
        int fullStars = (int) rating;
        boolean halfStar = rating - fullStars >= 0.5;

        for (int i = 0; i < fullStars; i++) {
            stars.append("★");
        }
        
        if (halfStar) {
            stars.append("★");
            fullStars++;
        }

        for (int i = fullStars; i < 5; i++) {
            stars.append("☆");
        }
        
        return stars.toString();
    }

    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(id).append("|");
        sb.append(studentId).append("|");
        sb.append(tutorId).append("|");
        sb.append(bookingId).append("|");
        sb.append(rating).append("|");
        sb.append(comment).append("|");
        sb.append(date).append("|");
        sb.append(isApproved ? "1" : "0").append("|");
        sb.append(reviewType);
        
        return sb.toString();
    }

    public static Review fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 9) {
            throw new IllegalArgumentException("Invalid file string format for Review");
        }
        
        int id = Integer.parseInt(parts[0]);
        int studentId = Integer.parseInt(parts[1]);
        int tutorId = Integer.parseInt(parts[2]);
        int bookingId = Integer.parseInt(parts[3]);
        double rating = Double.parseDouble(parts[4]);
        String comment = parts[5];
        String date = parts[6];
        boolean isApproved = "1".equals(parts[7]);
        String reviewType = parts[8];
        
        if ("PUBLIC".equals(reviewType)) {
            return PublicReview.fromFileString(fileString);
        } else if ("VERIFIED".equals(reviewType)) {
            return VerifiedReview.fromFileString(fileString);
        } else {
            Review review = new Review(id, studentId, tutorId, bookingId, rating, comment, date, isApproved);
            review.setReviewType(reviewType);
            return review;
        }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Review ID: ").append(id).append("\n");
        sb.append("Student ID: ").append(studentId).append("\n");
        sb.append("Tutor ID: ").append(tutorId).append("\n");
        sb.append("Booking ID: ").append(bookingId).append("\n");
        sb.append("Rating: ").append(rating).append("/5\n");
        sb.append("Comment: ").append(comment).append("\n");
        sb.append("Date: ").append(date).append("\n");
        sb.append("Approved: ").append(isApproved ? "Yes" : "No").append("\n");
        sb.append("Review Type: ").append(reviewType).append("\n");
        
        return sb.toString();
    }
}
