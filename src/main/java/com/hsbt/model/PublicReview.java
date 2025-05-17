package com.hsbt.model;

public class PublicReview extends Review {
    private boolean isAnonymous;
    private int helpfulVotes;
    private int unhelpfulVotes;

    public PublicReview() {
        super();
        setReviewType("PUBLIC");
    }

    public PublicReview(int id, int studentId, int tutorId, int bookingId, 
                       double rating, String comment, String date, boolean isApproved,
                       boolean isAnonymous, int helpfulVotes, int unhelpfulVotes) {
        super(id, studentId, tutorId, bookingId, rating, comment, date, isApproved);
        this.isAnonymous = isAnonymous;
        this.helpfulVotes = helpfulVotes;
        this.unhelpfulVotes = unhelpfulVotes;
        setReviewType("PUBLIC");
    }

    public boolean isAnonymous() {
        return isAnonymous;
    }

    public void setAnonymous(boolean anonymous) {
        isAnonymous = anonymous;
    }

    public int getHelpfulVotes() {
        return helpfulVotes;
    }

    public void setHelpfulVotes(int helpfulVotes) {
        this.helpfulVotes = helpfulVotes;
    }

    public int getUnhelpfulVotes() {
        return unhelpfulVotes;
    }

    public void setUnhelpfulVotes(int unhelpfulVotes) {
        this.unhelpfulVotes = unhelpfulVotes;
    }

    public void incrementHelpfulVotes() {
        helpfulVotes++;
    }

    public void incrementUnhelpfulVotes() {
        unhelpfulVotes++;
    }
    

    public int getTotalVotes() {
        return helpfulVotes + unhelpfulVotes;
    }

    public int getHelpfulnessPercentage() {
        if (getTotalVotes() == 0) {
            return 0;
        }
        return (int) ((double) helpfulVotes / getTotalVotes() * 100);
    }

    @Override
    public String toFileString() {
        StringBuilder sb = new StringBuilder(super.toFileString());
        sb.append("|").append(isAnonymous ? "1" : "0").append("|");
        sb.append(helpfulVotes).append("|");
        sb.append(unhelpfulVotes);
        
        return sb.toString();
    }

    public static PublicReview fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 12) {
            throw new IllegalArgumentException("Invalid file string format for PublicReview");
        }
        
        int id = Integer.parseInt(parts[0]);
        int studentId = Integer.parseInt(parts[1]);
        int tutorId = Integer.parseInt(parts[2]);
        int bookingId = Integer.parseInt(parts[3]);
        double rating = Double.parseDouble(parts[4]);
        String comment = parts[5];
        String date = parts[6];
        boolean isApproved = "1".equals(parts[7]);
        
        boolean isAnonymous = "1".equals(parts[9]);
        int helpfulVotes = Integer.parseInt(parts[10]);
        int unhelpfulVotes = Integer.parseInt(parts[11]);
        
        return new PublicReview(id, studentId, tutorId, bookingId, rating, comment, date, isApproved,
                              isAnonymous, helpfulVotes, unhelpfulVotes);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append("Anonymous: ").append(isAnonymous ? "Yes" : "No").append("\n");
        sb.append("Helpful Votes: ").append(helpfulVotes).append("\n");
        sb.append("Unhelpful Votes: ").append(unhelpfulVotes).append("\n");
        sb.append("Helpfulness: ").append(getHelpfulnessPercentage()).append("%\n");
        
        return sb.toString();
    }
}
