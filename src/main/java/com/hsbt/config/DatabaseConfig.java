package com.hsbt.config;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.File;

public class DatabaseConfig {
    private static final String BASE_DIR = "C:\\Users\\User\\Downloads\\HSBTSystem_final\\HSBTSystem\\src\\main\\webapp\\Database";
    private static final String TUTORS_FILE = "tutors.txt";
    private static final String STUDENTS_FILE = "students.txt";
    private static final String BOOKINGS_FILE = "bookings.txt";
    private static final String PAYMENTS_FILE = "payments.txt";
    private static final String REVIEWS_FILE = "reviews.txt";
    private static final String CONFIG_FILE = "config.txt";
    
    public static String getTutorsFilePath() {
        return Paths.get(BASE_DIR, TUTORS_FILE).toString();
    }
    public static String getStudentsFilePath() {
        return Paths.get(BASE_DIR, STUDENTS_FILE).toString();
    }
    public static String getBookingsFilePath() {
        return Paths.get(BASE_DIR, BOOKINGS_FILE).toString();
    }
    public static String getPaymentsFilePath() {
        return Paths.get(BASE_DIR, PAYMENTS_FILE).toString();
    }
    public static String getReviewsFilePath() {
        return Paths.get(BASE_DIR, REVIEWS_FILE).toString();
    }
    public static String getConfigFilePath() {
        return Paths.get(BASE_DIR, CONFIG_FILE).toString();
    }
    public static String getBaseDirPath() {
        return BASE_DIR;
    }
    public static String getWebappPath() {
        try {
            String currentDir = System.getProperty("user.dir");
            File webappDir = new File(currentDir + "/src/main/webapp/");
            if (webappDir.exists()) {
                return currentDir + "/src/main/webapp/";
            }
            webappDir = new File(currentDir + "/webapp/");
            if (webappDir.exists()) {
                return currentDir + "/webapp/";
            }
            return currentDir + "/";
        } catch (Exception e) {
            System.err.println("Error determining webapp path: " + e.getMessage());
            return "";
        }
    }
    public static void ensureDirectoriesExist() {
        File baseDir = new File(BASE_DIR);
        if (!baseDir.exists()) {
            boolean created = baseDir.mkdirs();
            if (created) {
                System.out.println("Created database directory: " + BASE_DIR);
            } else {
                System.err.println("Failed to create database directory: " + BASE_DIR);
            }
        }
    }
}
