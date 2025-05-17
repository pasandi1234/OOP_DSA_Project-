package com.hsbt.model;

public class Tutor {
    private int id;
    private String name;
    private String email;
    private String phone;
    private String[] subjects;
    private int yearsOfExperience;
    private double hourlyRate;
    private double rating;
    private boolean available;

    public Tutor() {
    }

    public Tutor(int id, String name, String email, String phone, String[] subjects,
                int yearsOfExperience, double hourlyRate, double rating, boolean available) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.subjects = subjects;
        this.yearsOfExperience = yearsOfExperience;
        this.hourlyRate = hourlyRate;
        this.rating = rating;
        this.available = available;
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

    public String[] getSubjects() {
        return subjects;
    }

    public void setSubjects(String[] subjects) {
        this.subjects = subjects;
    }

    public int getYearsOfExperience() {
        return yearsOfExperience;
    }

    public void setYearsOfExperience(int yearsOfExperience) {
        this.yearsOfExperience = yearsOfExperience;
    }

    public double getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(double hourlyRate) {
        this.hourlyRate = hourlyRate;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
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

    public boolean teachesSubject(String subject) {
        if (subjects == null) {
            return false;
        }

        for (String s : subjects) {
            if (s.equalsIgnoreCase(subject)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Tutor ID: ").append(id).append("\n");
        sb.append("Name: ").append(name).append("\n");
        sb.append("Email: ").append(email).append("\n");
        sb.append("Phone: ").append(phone).append("\n");
        sb.append("Subjects: ");

        if (subjects != null) {
            for (int i = 0; i < subjects.length; i++) {
                sb.append(subjects[i]);
                if (i < subjects.length - 1) {
                    sb.append(", ");
                }
            }
        }

        sb.append("\n");
        sb.append("Experience: ").append(yearsOfExperience).append(" years\n");
        sb.append("Hourly Rate: $").append(hourlyRate).append("\n");
        sb.append("Rating: ").append(rating).append("/5\n");
        sb.append("Available: ").append(available ? "Yes" : "No").append("\n");

        return sb.toString();
    }

    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(id).append("|");
        sb.append(name).append("|");
        sb.append(email).append("|");
        sb.append(phone).append("|");

        if (subjects != null && subjects.length > 0) {
            for (int i = 0; i < subjects.length; i++) {
                sb.append(subjects[i]);
                if (i < subjects.length - 1) {
                    sb.append(",");
                }
            }
        }

        sb.append("|");
        sb.append(yearsOfExperience).append("|");
        sb.append(hourlyRate).append("|");
        sb.append(rating).append("|");
        sb.append(available ? "1" : "0").append("|");
        sb.append("BASE");

        return sb.toString();
    }

    public static Tutor fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 10) {
            throw new IllegalArgumentException("Invalid file string format for Tutor");
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

        return new Tutor(id, name, email, phone, subjects, yearsOfExperience, hourlyRate, rating, available);
    }
}
