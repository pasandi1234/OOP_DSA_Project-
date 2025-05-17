package com.hsbt.config;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.File;

/**
 * Centralized configuration for database file paths.
 * This class provides a single location for all database file paths used in the application.
 */
public class DatabaseConfig {

    // Base directory for all database files
    private static final String BASE_DIR = "C:\\Users\\User\\Downloads\\HSBTSystem_final\\HSBTSystem\\src\\main\\webapp\\Database";

    // File paths for different database files
    private static final String TUTORS_FILE = "tutors.txt";
    private static final String STUDENTS_FILE = "students.txt";
    private static final String BOOKINGS_FILE = "bookings.txt";
    private static final String PAYMENTS_FILE = "payments.txt";
    private static final String REVIEWS_FILE = "reviews.txt";
    private static final String CONFIG_FILE = "config.txt";

    /**
     * Get the full path to the tutors database file.
     * @return The full path to the tutors file
     */
    public static String getTutorsFilePath() {
        return Paths.get(BASE_DIR, TUTORS_FILE).toString();
    }

    /**
     * Get the full path to the students database file.
     * @return The full path to the students file
     */
    public static String getStudentsFilePath() {
        return Paths.get(BASE_DIR, STUDENTS_FILE).toString();
    }

    /**
     * Get the full path to the bookings database file.
     * @return The full path to the bookings file
     */
    public static String getBookingsFilePath() {
        return Paths.get(BASE_DIR, BOOKINGS_FILE).toString();
    }

    /**
     * Get the full path to the payments database file.
     * @return The full path to the payments file
     */
    public static String getPaymentsFilePath() {
        return Paths.get(BASE_DIR, PAYMENTS_FILE).toString();
    }

    /**
     * Get the full path to the reviews database file.
     * @return The full path to the reviews file
     */
    public static String getReviewsFilePath() {
        return Paths.get(BASE_DIR, REVIEWS_FILE).toString();
    }

    /**
     * Get the full path to the config file.
     * @return The full path to the config file
     */
    public static String getConfigFilePath() {
        return Paths.get(BASE_DIR, CONFIG_FILE).toString();
    }

    /**
     * Get the base directory for all database files.
     * @return The base directory path
     */
    public static String getBaseDirPath() {
        return BASE_DIR;
    }

    /**
     * Gets the path to the webapp directory.
     *
     * @return The path to the webapp directory
     */
    public static String getWebappPath() {
        try {
            // Get the current working directory
            String currentDir = System.getProperty("user.dir");

            // Check if we're in a development or production environment
            File webappDir = new File(currentDir + "/src/main/webapp/");
            if (webappDir.exists()) {
                return currentDir + "/src/main/webapp/";
            }

            // If not in development, try production path
            webappDir = new File(currentDir + "/webapp/");
            if (webappDir.exists()) {
                return currentDir + "/webapp/";
            }

            // Default to current directory
            return currentDir + "/";
        } catch (Exception e) {
            System.err.println("Error determining webapp path: " + e.getMessage());
            return "";
        }
    }

    /**
     * Ensures that all database directories exist.
     * Creates them if they don't exist.
     */
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
