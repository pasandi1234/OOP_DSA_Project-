package com.hsbt.servlet;

import com.hsbt.service.TutorManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TutorDeleteServlet extends HttpServlet {
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
                boolean success = tutorService.deleteTutor(id);

                if (success) {
                    request.setAttribute("message", "Tutor deleted successfully.");
                } else {
                    request.setAttribute("error", "Failed to delete tutor. Tutor not found.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid tutor ID format.");
            }
        } else {
            request.setAttribute("error", "No tutor ID provided.");
        }

        request.getRequestDispatcher("/tutor-search.jsp").forward(request, response);
    }
}
