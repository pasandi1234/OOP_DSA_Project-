package com.hsbt.model;


public class OnlineBooking extends Booking {
    private String platform;
    private String meetingLink;
    private String meetingId;
    private String password;
    private boolean recordingRequested;


    public OnlineBooking() {
        super();
        setBookingType("ONLINE");
    }


    public OnlineBooking(int id, int studentId, int tutorId, String subject, String date,
                        String startTime, String endTime, double price, String status, String notes,
                        String platform, String meetingLink, String meetingId, String password,
                        boolean recordingRequested) {
        super(id, studentId, tutorId, subject, date, startTime, endTime, price, status, notes);
        this.platform = platform;
        this.meetingLink = meetingLink;
        this.meetingId = meetingId;
        this.password = password;
        this.recordingRequested = recordingRequested;
        setBookingType("ONLINE");
    }


    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public String getMeetingLink() {
        return meetingLink;
    }

    public void setMeetingLink(String meetingLink) {
        this.meetingLink = meetingLink;
    }

    public String getMeetingId() {
        return meetingId;
    }

    public void setMeetingId(String meetingId) {
        this.meetingId = meetingId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isRecordingRequested() {
        return recordingRequested;
    }

    public void setRecordingRequested(boolean recordingRequested) {
        this.recordingRequested = recordingRequested;
    }


    @Override
    public String toFileString() {
        StringBuilder sb = new StringBuilder(super.toFileString());
        sb.append("|").append(platform).append("|");
        sb.append(meetingLink).append("|");
        sb.append(meetingId).append("|");
        sb.append(password).append("|");
        sb.append(recordingRequested ? "1" : "0");
        
        return sb.toString();
    }
    

    public static OnlineBooking fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 16) {
            throw new IllegalArgumentException("Invalid file string format for OnlineBooking");
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
        
        String platform = parts[11];
        String meetingLink = parts[12];
        String meetingId = parts[13];
        String password = parts[14];
        boolean recordingRequested = "1".equals(parts[15]);
        
        return new OnlineBooking(id, studentId, tutorId, subject, date, startTime, endTime, price, status, notes,
                               platform, meetingLink, meetingId, password, recordingRequested);
    }
    

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append("Platform: ").append(platform).append("\n");
        sb.append("Meeting Link: ").append(meetingLink).append("\n");
        sb.append("Meeting ID: ").append(meetingId).append("\n");
        sb.append("Password: ").append(password).append("\n");
        sb.append("Recording Requested: ").append(recordingRequested ? "Yes" : "No").append("\n");
        
        return sb.toString();
    }
}
