package com.hsbt.model;

public class OnlineTutor extends Tutor {
    private String platformPreference;
    private boolean hasWebcam;
    private boolean providesRecordings;
    private String timeZone;

    public OnlineTutor() {
        super();
    }

    public OnlineTutor(int id, String name, String email, String phone, String[] subjects,
                      int yearsOfExperience, double hourlyRate, double rating, boolean available,
                      String platformPreference, boolean hasWebcam, boolean providesRecordings, String timeZone) {
        super(id, name, email, phone, subjects, yearsOfExperience, hourlyRate, rating, available);
        this.platformPreference = platformPreference;
        this.hasWebcam = hasWebcam;
        this.providesRecordings = providesRecordings;
        this.timeZone = timeZone;
    }

    public String getPlatformPreference() {
        return platformPreference;
    }

    public void setPlatformPreference(String platformPreference) {
        this.platformPreference = platformPreference;
    }

    public boolean hasWebcam() {
        return hasWebcam;
    }

    public void setHasWebcam(boolean hasWebcam) {
        this.hasWebcam = hasWebcam;
    }

    public boolean providesRecordings() {
        return providesRecordings;
    }

    public void setProvidesRecordings(boolean providesRecordings) {
        this.providesRecordings = providesRecordings;
    }

    public String getTimeZone() {
        return timeZone;
    }

    public void setTimeZone(String timeZone) {
        this.timeZone = timeZone;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append("Type: Online Tutor\n");
        sb.append("Platform: ").append(platformPreference).append("\n");
        sb.append("Webcam: ").append(hasWebcam ? "Yes" : "No").append("\n");
        sb.append("Provides Recordings: ").append(providesRecordings ? "Yes" : "No").append("\n");
        sb.append("Time Zone: ").append(timeZone).append("\n");
        
        return sb.toString();
    }

    @Override
    public String toFileString() {
        StringBuilder sb = new StringBuilder(super.toFileString());
        sb.delete(sb.length() - 4, sb.length());
        sb.append("ONLINE|");
        sb.append(platformPreference).append("|");
        sb.append(hasWebcam ? "1" : "0").append("|");
        sb.append(providesRecordings ? "1" : "0").append("|");
        sb.append(timeZone);
        
        return sb.toString();
    }

    public static OnlineTutor fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 14) {
            throw new IllegalArgumentException("Invalid file string format for OnlineTutor");
        }
        
        int id = Integer.parseInt(parts[0]);
        String name = parts[1];
        String email = parts[2];
        String phone = parts[3];
        String[] subjects = parts[4].isEmpty() ? new String[0] : parts[4].split(",");
        int yearsOfExperience = Integer.parseInt(parts[5]);
        double hourlyRate = Double.parseDouble(parts[6]);
        double rating = Double.parseDouble(parts[7]);
        boolean available = "1".equals(parts[8]);
        
        String platformPreference = parts[10];
        boolean hasWebcam = "1".equals(parts[11]);
        boolean providesRecordings = "1".equals(parts[12]);
        String timeZone = parts[13];
        
        return new OnlineTutor(id, name, email, phone, subjects, yearsOfExperience, hourlyRate, rating, available,
                              platformPreference, hasWebcam, providesRecordings, timeZone);
    }
}
