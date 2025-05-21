package com.hsbt.servlet;
import com.hsbt.model.OnlineTutor;
import com.hsbt.model.InPersonTutor;
import com.hsbt.model.Tutor;
import com.hsbt.service.TutorManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
public class TutorUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TutorManagementService tutorService;
    @Override
    public void init() throws ServletException {
        super.init();
        tutorService = TutorManagementService.getInstance();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                Tutor tutor = tutorService.getTutorById(id);

                if (tutor != null) {
                    request.setAttribute("tutor", tutor);
                    request.getRequestDispatcher("/tutor-update.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
            }
        }
        response.sendRedirect("tutor-search.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        int id = 0;

        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("tutor-search.jsp");
            return;
        }
        Tutor existingTutor = tutorService.getTutorById(id);

        if (existingTutor == null) {
            response.sendRedirect("tutor-search.jsp");
            return;
        }
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String[] subjectsArray = request.getParameterValues("subjects");
        String experienceStr = request.getParameter("experience");
        String hourlyRateStr = request.getParameter("hourlyRate");
        String availableStr = request.getParameter("available");

        if (subjectsArray == null) {
            subjectsArray = new String[0];
        }

        int experience = 0;
        double hourlyRate = 0.0;
        boolean available = true;

        try {
            experience = Integer.parseInt(experienceStr);
            hourlyRate = Double.parseDouble(hourlyRateStr);
            available = "true".equals(availableStr);
        } catch (NumberFormatException e) {
            experience = existingTutor.getYearsOfExperience();
            hourlyRate = existingTutor.getHourlyRate();
            available = existingTutor.isAvailable();
        }

        Tutor updatedTutor = null;

        if (existingTutor instanceof OnlineTutor) {
            String platform = request.getParameter("platform");
            String timezone = request.getParameter("timezone");
            boolean hasWebcam = "true".equals(request.getParameter("webcam"));
            boolean providesRecordings = "true".equals(request.getParameter("recordings"));

            updatedTutor = new OnlineTutor(
                id,
                name,
                email,
                phone,
                subjectsArray,
                experience,
                hourlyRate,
                existingTutor.getRating(),
                available,
                platform,
                hasWebcam,
                providesRecordings,
                timezone
            );
        } else if (existingTutor instanceof InPersonTutor) {
            String location = request.getParameter("location");
            String travelRadiusStr = request.getParameter("travelRadius");
            boolean travelToStudent = "true".equals(request.getParameter("travelToStudent"));
            boolean providesLearningMaterials = "true".equals(request.getParameter("materials"));

            int travelRadius = 0;
            try {
                travelRadius = Integer.parseInt(travelRadiusStr);
            } catch (NumberFormatException e) {
                travelRadius = ((InPersonTutor) existingTutor).getTravelRadius();
            }

            updatedTutor = new InPersonTutor(
                id,
                name,
                email,
                phone,
                subjectsArray,
                experience,
                hourlyRate,
                existingTutor.getRating(),
                available,
                location,
                travelRadius,
                travelToStudent,
                providesLearningMaterials
            );
        } else {
            updatedTutor = new Tutor(
                id,
                name,
                email,
                phone,
                subjectsArray,
                experience,
                hourlyRate,
                existingTutor.getRating(),
                available
            );
        }
        boolean success = tutorService.updateTutor(updatedTutor);

        if (success) {
            request.setAttribute("tutor", updatedTutor);
            request.setAttribute("message", "Tutor updated successfully.");
            request.getRequestDispatcher("/tutor-success.jsp").forward(request, response);
        } else {
            request.setAttribute("tutor", existingTutor);
            request.setAttribute("error", "Failed to update tutor. Please try again.");
            request.getRequestDispatcher("/tutor-update.jsp").forward(request, response);
        }
    }
}
