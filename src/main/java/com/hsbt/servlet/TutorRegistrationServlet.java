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

public class TutorRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TutorManagementService tutorService;

    @Override
    public void init() throws ServletException {
        super.init();
        tutorService = TutorManagementService.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String[] subjectsArray = request.getParameterValues("subjects");
        String experienceStr = request.getParameter("experience");
        String hourlyRateStr = request.getParameter("hourlyRate");
        String tutorType = request.getParameter("tutorType");

        if (subjectsArray == null) {
            subjectsArray = new String[0];
        }

        int experience = 0;
        double hourlyRate = 0.0;

        try {
            experience = Integer.parseInt(experienceStr);
            hourlyRate = Double.parseDouble(hourlyRateStr);
        } catch (NumberFormatException e) {

        }

        Tutor tutor = null;

        if ("online".equals(tutorType) || "both".equals(tutorType)) {
            String platform = request.getParameter("platform");
            String timezone = request.getParameter("timezone");
            boolean hasWebcam = "true".equals(request.getParameter("webcam"));
            boolean providesRecordings = "true".equals(request.getParameter("recordings"));

            tutor = new OnlineTutor(0, name, email, phone, subjectsArray, experience, hourlyRate,
                    0.0, true, platform, hasWebcam, providesRecordings, timezone);
        } else if ("inperson".equals(tutorType) || "both".equals(tutorType)) {
            String location = request.getParameter("location");
            String travelRadiusStr = request.getParameter("travelRadius");
            boolean travelToStudent = "true".equals(request.getParameter("travelToStudent"));
            boolean providesLearningMaterials = "true".equals(request.getParameter("materials"));

            int travelRadius = 0;
            try {
                travelRadius = Integer.parseInt(travelRadiusStr);
            } catch (NumberFormatException e) {
            }

            tutor = new InPersonTutor(0, name, email, phone,subjectsArray, experience, hourlyRate,
                0.0, true, location, travelRadius, travelToStudent, providesLearningMaterials);
        } else {
            tutor = new Tutor(0, name, email, phone, subjectsArray, experience, hourlyRate, 0.0, true);
        }

        Tutor registeredTutor = tutorService.registerTutor(tutor);

        request.setAttribute("tutor", registeredTutor);

        request.getRequestDispatcher("/tutor-success.jsp").forward(request, response);
    }
}
