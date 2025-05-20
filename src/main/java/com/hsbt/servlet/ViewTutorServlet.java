package com.hsbt.servlet;

import com.hsbt.model.Tutor;
import com.hsbt.service.TutorManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ViewTutorServlet extends HttpServlet {
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

                    request.getRequestDispatcher("/view-tutor.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {

            }
        }

        response.sendRedirect("tutor-search.jsp");
    }
}
