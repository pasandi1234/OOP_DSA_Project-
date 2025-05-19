package com.hsbt.servlet;
import com.hsbt.model.Tutor;
import com.hsbt.service.TutorSearchService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
public class TutorSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TutorSearchService searchService;
    @Override
    public void init() throws ServletException {
        super.init();
        searchService = TutorSearchService.getInstance();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchType = request.getParameter("searchType");
        String query = request.getParameter("query");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        String tutorType = request.getParameter("tutorType");
        String minExperienceStr = request.getParameter("minExperience");
        String minRatingStr = request.getParameter("minRating");

        if (query == null) {
            query = "";
        }
        List<Tutor> results = null;

        if ("name".equals(searchType)) {
            results = searchService.searchTutorsByName(query);
        } else if ("subject".equals(searchType)) {
            results = searchService.searchTutorsBySubject(query);
        } else if ("available".equals(searchType)) {
            results = searchService.searchAvailableTutors();
        } else if ("rating".equals(searchType)) {
            try {
                double minRating = Double.parseDouble(query);
                results = searchService.searchTutorsByMinRating(minRating);
            } catch (NumberFormatException e) {
                results = searchService.searchAvailableTutors();
            }
        } else if ("rate".equals(searchType)) {
            try {
                String[] parts = query.split("-");
                double minRate = Double.parseDouble(parts[0]);
                double maxRate = Double.parseDouble(parts[1]);
                results = searchService.searchTutorsByRateRange(minRate, maxRate);
            } catch (Exception e) {
                results = searchService.searchAvailableTutors();
            }
        } else if ("experience".equals(searchType)) {
            try {
                String[] parts = query.split("-");
                int minExperience = Integer.parseInt(parts[0]);
                int maxExperience = Integer.parseInt(parts[1]);
                results = searchService.searchTutorsByExperienceRange(minExperience, maxExperience);
            } catch (Exception e) {
                results = searchService.searchAvailableTutors();
            }
        } else if ("type".equals(searchType)) {
            results = searchService.searchTutorsByType(query);
        } else {
            results = searchService.searchAvailableTutors();
        }
        if (tutorType != null && !tutorType.isEmpty() && !"all".equals(tutorType)) {
            results = searchService.searchTutorsByType(tutorType);
        }

        if (minExperienceStr != null && !minExperienceStr.isEmpty()) {
            try {
                int minExperience = Integer.parseInt(minExperienceStr);
                List<Tutor> filteredResults = new ArrayList<>();

                for (Tutor tutor : results) {
                    if (tutor.getYearsOfExperience() >= minExperience) {
                        filteredResults.add(tutor);
                    }
                }

                results = filteredResults;
            } catch (NumberFormatException e) {
            }
        }

        if (minRatingStr != null && !minRatingStr.isEmpty()) {
            try {
                double minRating = Double.parseDouble(minRatingStr);
                List<Tutor> filteredResults = new ArrayList<>();

                for (Tutor tutor : results) {
                    if (tutor.getRating() >= minRating) {
                        filteredResults.add(tutor);
                    }
                }

                results = filteredResults;
            } catch (NumberFormatException e) {
            }
        }
        if (sortBy != null && sortOrder != null) {
            String strategyName = sortBy + "_" + sortOrder;
            results = searchService.sortTutors(results, strategyName);
        }
        request.setAttribute("tutors", results);
        request.getRequestDispatcher("/tutor-search-results.jsp").forward(request, response);
    }
}