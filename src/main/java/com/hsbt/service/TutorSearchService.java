package com.hsbt.service;
import com.hsbt.model.Tutor;
import com.hsbt.sorting.TutorSortingStrategy;
import com.hsbt.sorting.TutorSortingStrategyFactory;
import java.util.ArrayList;
import java.util.List;
import java.util.Comparator;
public class TutorSearchService {
    private TutorManagementService tutorManagementService;
    private static TutorSearchService instance;
    private TutorSearchService() {
        tutorManagementService = TutorManagementService.getInstance();
    }
    public static synchronized TutorSearchService getInstance() {
        if (instance == null) {
            instance = new TutorSearchService();
        }
        return instance;
    }
    public List<Tutor> searchTutorsBySubject(String subject) {
        return tutorManagementService.searchTutorsBySubject(subject);
    }
    public List<Tutor> searchTutorsByName(String name) {
        return tutorManagementService.searchTutorsByName(name);
    }

    public List<Tutor> searchAvailableTutors() {
        List<Tutor> allTutors = tutorManagementService.getAllTutors();
        List<Tutor> availableTutors = new ArrayList<>();

        for (Tutor tutor : allTutors) {
            if (tutor.isAvailable()) {
                availableTutors.add(tutor);
            }
        }

        return availableTutors;
    }
    public List<Tutor> searchTutorsByRateRange(double minRate, double maxRate) {
        List<Tutor> allTutors = tutorManagementService.getAllTutors();
        List<Tutor> matchingTutors = new ArrayList<>();

        for (Tutor tutor : allTutors) {
            double rate = tutor.getHourlyRate();
            if (rate >= minRate && rate <= maxRate) {
                matchingTutors.add(tutor);
            }
        }

        return matchingTutors;
    }
    public List<Tutor> searchTutorsByMinRating(double minRating) {
        List<Tutor> allTutors = tutorManagementService.getAllTutors();
        List<Tutor> matchingTutors = new ArrayList<>();

        for (Tutor tutor : allTutors) {
            if (tutor.getRating() >= minRating) {
                matchingTutors.add(tutor);
            }
        }
        return matchingTutors;
    }
    public List<Tutor> sortTutorsByRateAsc(List<Tutor> tutors) {
        List<Tutor> sortedTutors = new ArrayList<>(tutors);
        sortedTutors.sort(Comparator.comparingDouble(Tutor::getHourlyRate));
        return sortedTutors;
    }
    public List<Tutor> sortTutorsByRateDesc(List<Tutor> tutors) {
        List<Tutor> sortedTutors = new ArrayList<>(tutors);
        sortedTutors.sort(Comparator.comparingDouble(Tutor::getHourlyRate).reversed());
        return sortedTutors;
    }
    public List<Tutor> sortTutorsByRatingAsc(List<Tutor> tutors) {
        List<Tutor> sortedTutors = new ArrayList<>(tutors);
        sortedTutors.sort(Comparator.comparingDouble(Tutor::getRating));
        return sortedTutors;
    }
    public List<Tutor> sortTutorsByRatingDesc(List<Tutor> tutors) {
        List<Tutor> sortedTutors = new ArrayList<>(tutors);
        sortedTutors.sort(Comparator.comparingDouble(Tutor::getRating).reversed());
        return sortedTutors;
    }
    public List<Tutor> sortTutorsByExperienceAsc(List<Tutor> tutors) {
        List<Tutor> sortedTutors = new ArrayList<>(tutors);
        sortedTutors.sort(Comparator.comparingInt(Tutor::getYearsOfExperience));
        return sortedTutors;
    }
    public List<Tutor> sortTutorsByExperienceDesc(List<Tutor> tutors) {
        List<Tutor> sortedTutors = new ArrayList<>(tutors);
        sortedTutors.sort(Comparator.comparingInt(Tutor::getYearsOfExperience).reversed());
        return sortedTutors;
    }
    public List<Tutor> sortTutors(List<Tutor> tutors, String strategyName) {
        TutorSortingStrategy strategy = TutorSortingStrategyFactory.getStrategy(strategyName);

        if (strategy == null) {
            strategy = TutorSortingStrategyFactory.getDefaultStrategy();
        }

        return strategy.sort(tutors);
    }
    public List<TutorSortingStrategy> getAllSortingStrategies() {
        return TutorSortingStrategyFactory.getAllStrategies();
    }
    public List<Tutor> searchTutorsByExperienceRange(int minExperience, int maxExperience) {
        List<Tutor> allTutors = tutorManagementService.getAllTutors();
        List<Tutor> matchingTutors = new ArrayList<>();

        for (Tutor tutor : allTutors) {
            int experience = tutor.getYearsOfExperience();
            if (experience >= minExperience && experience <= maxExperience) {
                matchingTutors.add(tutor);
            }
        }
        return matchingTutors;
    }
    public List<Tutor> searchTutorsByType(String type) {
        List<Tutor> allTutors = tutorManagementService.getAllTutors();
        List<Tutor> matchingTutors = new ArrayList<>();

        for (Tutor tutor : allTutors) {
            String tutorType = tutor.getClass().getSimpleName();

            if ("online".equalsIgnoreCase(type) && "OnlineTutor".equals(tutorType)) {
                matchingTutors.add(tutor);
            } else if ("inperson".equalsIgnoreCase(type) && "InPersonTutor".equals(tutorType)) {
                matchingTutors.add(tutor);
            } else if ("both".equalsIgnoreCase(type) || "all".equalsIgnoreCase(type)) {
                matchingTutors.add(tutor);
            }
        }
        return matchingTutors;
    }
}
