package com.hsbt.model;
import java.util.Arrays;
public class Student {
    private int id;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String[] preferredSubjects;
    private String educationLevel;
    private String[] preferredDays;
    private String preferredTimeSlot;
    private boolean active;
    public Student() {
    }
    public Student(int id, String name, String email, String phone, String address, 
                  String[] preferredSubjects, String educationLevel, String[] preferredDays, 
                  String preferredTimeSlot, boolean active) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.preferredSubjects = preferredSubjects;
        this.educationLevel = educationLevel;
        this.preferredDays = preferredDays;
        this.preferredTimeSlot = preferredTimeSlot;
        this.active = active;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String[] getPreferredSubjects() {
        return preferredSubjects;
    }
    public void setPreferredSubjects(String[] preferredSubjects) {
        this.preferredSubjects = preferredSubjects;
    }
    public String getEducationLevel() {
        return educationLevel;
    }
    public void setEducationLevel(String educationLevel) {
        this.educationLevel = educationLevel;
    }
    public String[] getPreferredDays() {
        return preferredDays;
    }
    public void setPreferredDays(String[] preferredDays) {
        this.preferredDays = preferredDays;
    }
    public String getPreferredTimeSlot() {
        return preferredTimeSlot;
    }
    public void setPreferredTimeSlot(String preferredTimeSlot) {
        this.preferredTimeSlot = preferredTimeSlot;
    }
    public boolean isActive() {
        return active;
    }
    public void setActive(boolean active) {
        this.active = active;
    }
    public boolean isInterestedInSubject(String subject) {
        if (preferredSubjects == null) {
            return false;
        }
        for (String s : preferredSubjects) {
            if (s.equalsIgnoreCase(subject)) {
                return true;
            }
        }
        return false;
    }
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Student ID: ").append(id).append("\n");
        sb.append("Name: ").append(name).append("\n");
        sb.append("Email: ").append(email).append("\n");
        sb.append("Phone: ").append(phone).append("\n");
        sb.append("Address: ").append(address).append("\n");
        sb.append("Preferred Subjects: ");
        if (preferredSubjects != null) {
            for (int i = 0; i < preferredSubjects.length; i++) {
                sb.append(preferredSubjects[i]);
                if (i < preferredSubjects.length - 1) {
                    sb.append(", ");
                }
            }
        } 
        sb.append("\n");
        sb.append("Education Level: ").append(educationLevel).append("\n");
        sb.append("Preferred Days: ");
        
        if (preferredDays != null) {
            for (int i = 0; i < preferredDays.length; i++) {
                sb.append(preferredDays[i]);
                if (i < preferredDays.length - 1) {
                    sb.append(", ");
                }
            }
        }
        
        sb.append("\n");
        sb.append("Preferred Time Slot: ").append(preferredTimeSlot).append("\n");
        sb.append("Active: ").append(active ? "Yes" : "No").append("\n");
        
        return sb.toString();
    }
    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(id).append("|");
        sb.append(name).append("|");
        sb.append(email).append("|");
        sb.append(phone).append("|");
        sb.append(address).append("|");
        if (preferredSubjects != null && preferredSubjects.length > 0) {
            for (int i = 0; i < preferredSubjects.length; i++) {
                sb.append(preferredSubjects[i]);
                if (i < preferredSubjects.length - 1) {
                    sb.append(",");
                }
            }
        }
        
        sb.append("|");
        sb.append(educationLevel).append("|");
        if (preferredDays != null && preferredDays.length > 0) {
            for (int i = 0; i < preferredDays.length; i++) {
                sb.append(preferredDays[i]);
                if (i < preferredDays.length - 1) {
                    sb.append(",");
                }
            }
        }
        
        sb.append("|");
        sb.append(preferredTimeSlot).append("|");
        sb.append(active ? "1" : "0");
        
        return sb.toString();
    }
    public static Student fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 10) {
            throw new IllegalArgumentException("Invalid file string format for Student");
        }
        
        int id = Integer.parseInt(parts[0]);
        String name = parts[1];
        String email = parts[2];
        String phone = parts[3];
        String address = parts[4];
        String[] preferredSubjects = parts[5].isEmpty() ? new String[0] : parts[5].split(",");
        String educationLevel = parts[6];
        String[] preferredDays = parts[7].isEmpty() ? new String[0] : parts[7].split(",");
        String preferredTimeSlot = parts[8];
        boolean active = "1".equals(parts[9]);
        
        return new Student(id, name, email, phone, address, preferredSubjects, 
                          educationLevel, preferredDays, preferredTimeSlot, active);
    }
}
