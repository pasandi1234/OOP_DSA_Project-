package com.hsbt.service;

import com.hsbt.model.Review;
import com.hsbt.model.PublicReview;
import com.hsbt.model.VerifiedReview;
import com.hsbt.model.Tutor;
import com.hsbt.model.Student;
import com.hsbt.model.Booking;
import com.hsbt.config.DatabaseConfig;
import com.hsbt.util.FileIOUtil;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ReviewManagementService {
    private List<Review> reviews;
    private static ReviewManagementService instance;
    private int nextId;
    private String reviewsFilePath;
    private TutorManagementService tutorService;
    private StudentManagementService studentService;
    private BookingManagementService bookingService;

    private ReviewManagementService() {
        reviews = new ArrayList<>();
        nextId = 1;

        DatabaseConfig.ensureDirectoriesExist();

        reviewsFilePath = DatabaseConfig.getReviewsFilePath();

        tutorService = TutorManagementService.getInstance();
        studentService = StudentManagementService.getInstance();
        bookingService = BookingManagementService.getInstance();

        loadReviews();
    }

    public static synchronized ReviewManagementService getInstance() {
        if (instance == null) {
            instance = new ReviewManagementService();
        }
        return instance;
    }

    public Review submitReview(Review review) {

        if (review.getId() <= 0) {
            review.setId(nextId++);
        }

        reviews.add(review);

        if (review.isApproved()) {
            updateTutorRating(review.getTutorId());
        }
        saveReviews();
        
        return review;
    }

    public Review getReviewById(int id) {
        for (Review review : reviews) {
            if (review.getId() == id) {
                return review;
            }
        }
        return null;
    }

    public boolean updateReview(Review review) {
        for (int i = 0; i < reviews.size(); i++) {
            if (reviews.get(i).getId() == review.getId()) {
                reviews.set(i, review);

                if (review.isApproved()) {
                    updateTutorRating(review.getTutorId());
                }
                
                saveReviews();
                return true;
            }
        }
        return false;
    }

    public boolean deleteReview(int id) {
        Review review = getReviewById(id);
        if (review != null) {
            int tutorId = review.getTutorId();
            boolean wasApproved = review.isApproved();
            
            reviews.removeIf(r -> r.getId() == id);

            if (wasApproved) {
                updateTutorRating(tutorId);
            }
            
            saveReviews();
            return true;
        }
        return false;
    }

    public boolean approveReview(int id) {
        Review review = getReviewById(id);
        if (review != null && !review.isApproved()) {
            review.setApproved(true);
            updateTutorRating(review.getTutorId());
            saveReviews();
            return true;
        }
        return false;
    }

    public boolean disapproveReview(int id) {
        Review review = getReviewById(id);
        if (review != null && review.isApproved()) {
            review.setApproved(false);
            updateTutorRating(review.getTutorId());
            saveReviews();
            return true;
        }
        return false;
    }

    public boolean voteHelpful(int id) {
        Review review = getReviewById(id);
        if (review != null && review instanceof PublicReview) {
            PublicReview publicReview = (PublicReview) review;
            publicReview.incrementHelpfulVotes();
            saveReviews();
            return true;
        }
        return false;
    }

    public boolean voteUnhelpful(int id) {
        Review review = getReviewById(id);
        if (review != null && review instanceof PublicReview) {
            PublicReview publicReview = (PublicReview) review;
            publicReview.incrementUnhelpfulVotes();
            saveReviews();
            return true;
        }
        return false;
    }

    public List<Review> getAllReviews() {
        return new ArrayList<>(reviews);
    }

    public List<Review> getApprovedReviews() {
        return reviews.stream()
                .filter(Review::isApproved)
                .collect(Collectors.toList());
    }

    public List<Review> getPendingReviews() {
        return reviews.stream()
                .filter(r -> !r.isApproved())
                .collect(Collectors.toList());
    }

    public List<Review> getReviewsByTutorId(int tutorId) {
        return reviews.stream()
                .filter(r -> r.getTutorId() == tutorId)
                .collect(Collectors.toList());
    }

    public List<Review> getApprovedReviewsByTutorId(int tutorId) {
        return reviews.stream()
                .filter(r -> r.getTutorId() == tutorId && r.isApproved())
                .collect(Collectors.toList());
    }

    public List<Review> getReviewsByStudentId(int studentId) {
        return reviews.stream()
                .filter(r -> r.getStudentId() == studentId)
                .collect(Collectors.toList());
    }

    public List<Review> getReviewsByBookingId(int bookingId) {
        return reviews.stream()
                .filter(r -> r.getBookingId() == bookingId)
                .collect(Collectors.toList());
    }

    public List<Review> getReviewsByType(String reviewType) {
        return reviews.stream()
                .filter(r -> r.getReviewType().equals(reviewType))
                .collect(Collectors.toList());
    }

    public boolean hasStudentReviewedBooking(int studentId, int bookingId) {
        return reviews.stream()
                .anyMatch(r -> r.getStudentId() == studentId && r.getBookingId() == bookingId);
    }

    private void updateTutorRating(int tutorId) {
        List<Review> approvedReviews = getApprovedReviewsByTutorId(tutorId);
        
        if (approvedReviews.isEmpty()) {
            return;
        }
        
        double totalRating = 0.0;
        for (Review review : approvedReviews) {
            totalRating += review.getRating();
        }
        
        double averageRating = totalRating / approvedReviews.size();

        averageRating = Math.round(averageRating * 10.0) / 10.0;
        
        Tutor tutor = tutorService.getTutorById(tutorId);
        if (tutor != null) {
            tutor.setRating(averageRating);
            tutorService.updateTutor(tutor);
        }
    }

    private void loadReviews() {
        try {
            if (!FileIOUtil.fileExists(reviewsFilePath)) {
                createSampleReviews();
                return;
            }

            List<String> lines = FileIOUtil.readLinesFromFile(reviewsFilePath);

            reviews.clear();

            for (String line : lines) {
                try {
                    Review review = Review.fromFileString(line);
                    reviews.add(review);

                    if (review.getId() >= nextId) {
                        nextId = review.getId() + 1;
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing review: " + e.getMessage());
                }
            }

            if (reviews.isEmpty()) {
                createSampleReviews();
            }
        } catch (Exception e) {
            System.err.println("Error loading reviews: " + e.getMessage());
            createSampleReviews();
        }
    }

    private void saveReviews() {
        try {

            List<String> lines = new ArrayList<>();

            for (Review review : reviews) {
                String line = review.toFileString();
                if (line != null) {
                    lines.add(line);
                }
            }

            FileIOUtil.writeLinesToFile(reviewsFilePath, lines);

        } catch (Exception e) {
            System.err.println("Error saving reviews: " + e.getMessage());
        }
    }

    private void createSampleReviews() {

        List<Tutor> tutors = tutorService.getAllTutors();
        List<Student> students = studentService.getAllStudents();
        List<Booking> bookings = bookingService.getAllBookings();
        
        if (tutors.isEmpty() || students.isEmpty() || bookings.isEmpty()) {
            return; // Can't create sample reviews without tutors, students, and bookings
        }

        LocalDate today = LocalDate.now();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        PublicReview publicReview1 = new PublicReview(
            nextId++,
            students.get(0).getId(),
            tutors.get(0).getId(),
            bookings.get(0).getId(),
            4.5,
            "Great tutor! Very knowledgeable and patient. Explained complex concepts in a way that was easy to understand.",
            today.minusDays(7).format(dateFormatter),
            true,
            false,
            5,
            1
        );
        reviews.add(publicReview1);

        PublicReview publicReview2 = new PublicReview(
            nextId++,
            students.get(1).getId(),
            tutors.get(1).getId(),
            bookings.get(1).getId(),
            4.0,
            "Excellent teaching style. Explains concepts clearly and provides good examples.",
            today.minusDays(14).format(dateFormatter),
            true,
            true,
            3,
            0
        );
        reviews.add(publicReview2);

        VerifiedReview verifiedReview1 = new VerifiedReview(
            nextId++,
            students.get(0).getId(),
            tutors.get(2).getId(),
            bookings.get(2).getId(),
            5.0,
            "Best tutor I've ever had. Highly recommended! Very thorough and patient.",
            today.minusDays(21).format(dateFormatter),
            true,
            "Booking Confirmation",
            today.minusDays(20).format(dateFormatter),
            "System",
            false
        );
        reviews.add(verifiedReview1);

        PublicReview pendingReview = new PublicReview(
            nextId++,
            students.get(1).getId(),
            tutors.get(0).getId(),
            bookings.get(3).getId(),
            3.5,
            "Good tutor but sometimes goes too fast. Needs to check for understanding more often.",
            today.format(dateFormatter),
            false,
            false,
            0,
            0
        );
        reviews.add(pendingReview);

        for (Tutor tutor : tutors) {
            updateTutorRating(tutor.getId());
        }

        saveReviews();
    }
}
