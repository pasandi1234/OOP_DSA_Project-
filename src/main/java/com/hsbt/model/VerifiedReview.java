package com.hsbt.model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class VerifiedReview extends Review {
    private String verificationMethod;
    private String verificationDate;
    private String verifiedBy;
    private boolean hasAttachments;

    public VerifiedReview() {
        super();
        setReviewType("VERIFIED");
    }

    public VerifiedReview(int id, int studentId, int tutorId, int bookingId, 
                         double rating, String comment, String date, boolean isApproved,
                         String verificationMethod, String verificationDate, String verifiedBy,
                         boolean hasAttachments) {
        super(id, studentId, tutorId, bookingId, rating, comment, date, isApproved);
        this.verificationMethod = verificationMethod;
        this.verificationDate = verificationDate;
        this.verifiedBy = verifiedBy;
        this.hasAttachments = hasAttachments;
        setReviewType("VERIFIED");
    }

    public String getVerificationMethod() {
        return verificationMethod;
    }

    public void setVerificationMethod(String verificationMethod) {
        this.verificationMethod = verificationMethod;
    }

    public String getVerificationDate() {
        return verificationDate;
    }

    public void setVerificationDate(String verificationDate) {
        this.verificationDate = verificationDate;
    }

    public String getVerifiedBy() {
        return verifiedBy;
    }

    public void setVerifiedBy(String verifiedBy) {
        this.verifiedBy = verifiedBy;
    }

    public boolean hasAttachments() {
        return hasAttachments;
    }

    public void setHasAttachments(boolean hasAttachments) {
        this.hasAttachments = hasAttachments;
    }

    public String getFormattedVerificationDate() {
        try {
            LocalDate vDate = LocalDate.parse(verificationDate);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy");
            return vDate.format(formatter);
        } catch (DateTimeParseException e) {
            return verificationDate;
        }
    }

    @Override
    public String toFileString() {
        StringBuilder sb = new StringBuilder(super.toFileString());
        sb.append("|").append(verificationMethod).append("|");
        sb.append(verificationDate).append("|");
        sb.append(verifiedBy).append("|");
        sb.append(hasAttachments ? "1" : "0");
        
        return sb.toString();
    }

    public static VerifiedReview fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 13) {
            throw new IllegalArgumentException("Invalid file string format for VerifiedReview");
        }
        
        int id = Integer.parseInt(parts[0]);
        int studentId = Integer.parseInt(parts[1]);
        int tutorId = Integer.parseInt(parts[2]);
        int bookingId = Integer.parseInt(parts[3]);
        double rating = Double.parseDouble(parts[4]);
        String comment = parts[5];
        String date = parts[6];
        boolean isApproved = "1".equals(parts[7]);
        
        String verificationMethod = parts[9];
        String verificationDate = parts[10];
        String verifiedBy = parts[11];
        boolean hasAttachments = "1".equals(parts[12]);
        
        return new VerifiedReview(id, studentId, tutorId, bookingId, rating, comment, date, isApproved,
                                verificationMethod, verificationDate, verifiedBy, hasAttachments);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append("Verification Method: ").append(verificationMethod).append("\n");
        sb.append("Verification Date: ").append(getFormattedVerificationDate()).append("\n");
        sb.append("Verified By: ").append(verifiedBy).append("\n");
        sb.append("Has Attachments: ").append(hasAttachments ? "Yes" : "No").append("\n");
        
        return sb.toString();
    }
}
