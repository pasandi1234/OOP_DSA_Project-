package com.hsbt.model;

public class InPersonTutor extends Tutor {
    private String location;
    private int travelRadius;
    private boolean travelToStudent;
    private boolean providesLearningMaterials;

    public InPersonTutor() {
        super();
    }

    public InPersonTutor(int id, String name, String email, String phone, String[] subjects,
                        int yearsOfExperience, double hourlyRate, double rating, boolean available,
                        String location, int travelRadius, boolean travelToStudent, boolean providesLearningMaterials) {
        super(id, name, email, phone, subjects, yearsOfExperience, hourlyRate, rating, available);
        this.location = location;
        this.travelRadius = travelRadius;
        this.travelToStudent = travelToStudent;
        this.providesLearningMaterials = providesLearningMaterials;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getTravelRadius() {
        return travelRadius;
    }

    public void setTravelRadius(int travelRadius) {
        this.travelRadius = travelRadius;
    }

    public boolean isTravelToStudent() {
        return travelToStudent;
    }

    public void setTravelToStudent(boolean travelToStudent) {
        this.travelToStudent = travelToStudent;
    }

    public boolean isProvidesLearningMaterials() {
        return providesLearningMaterials;
    }

    public void setProvidesLearningMaterials(boolean providesLearningMaterials) {
        this.providesLearningMaterials = providesLearningMaterials;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append("Type: In-Person Tutor\n");
        sb.append("Location: ").append(location).append("\n");
        sb.append("Travel Radius: ").append(travelRadius).append(" km\n");
        sb.append("Travels to Student: ").append(travelToStudent ? "Yes" : "No").append("\n");
        sb.append("Provides Learning Materials: ").append(providesLearningMaterials ? "Yes" : "No").append("\n");
        
        return sb.toString();
    }

    @Override
    public String toFileString() {
        StringBuilder sb = new StringBuilder(super.toFileString());
        sb.delete(sb.length() - 4, sb.length());
        sb.append("INPERSON|");
        sb.append(location).append("|");
        sb.append(travelRadius).append("|");
        sb.append(travelToStudent ? "1" : "0").append("|");
        sb.append(providesLearningMaterials ? "1" : "0");
        
        return sb.toString();
    }

    public static InPersonTutor fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 14) {
            throw new IllegalArgumentException("Invalid file string format for InPersonTutor");
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
        
        String location = parts[10];
        int travelRadius = Integer.parseInt(parts[11]);
        boolean travelToStudent = "1".equals(parts[12]);
        boolean providesLearningMaterials = "1".equals(parts[13]);
        
        return new InPersonTutor(id, name, email, phone, subjects, yearsOfExperience, hourlyRate, rating, available,
                                location, travelRadius, travelToStudent, providesLearningMaterials);
    }
}
