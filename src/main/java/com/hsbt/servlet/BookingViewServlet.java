package com.hsbt.servlet;

import com.hsbt.model.Booking;
import com.hsbt.model.Tutor;
import com.hsbt.model.Student;
import com.hsbt.service.BookingManagementService;
import com.hsbt.service.TutorManagementService;
import com.hsbt.service.StudentManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class BookingViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingManagementService bookingService;
    private TutorManagementService tutorService;
    private StudentManagementService studentService;


    @Override
    public void init() throws ServletException {
        super.init();
        bookingService = BookingManagementService.getInstance();
        tutorService = TutorManagementService.getInstance();
        studentService = StudentManagementService.getInstance();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        String bookingIdStr = request.getParameter("id");
        
        if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                Booking booking = bookingService.getBookingById(bookingId);
                
                if (booking != null) {

                    Tutor tutor = tutorService.getTutorById(booking.getTutorId());
                    Student student = studentService.getStudentById(booking.getStudentId());
                    

                    request.setAttribute("booking", booking);
                    request.setAttribute("tutor", tutor);
                    request.setAttribute("student", student);
                    

                    request.getRequestDispatcher("/booking-details.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {

            }
        }
        

        response.sendRedirect("booking-history");
    }
}
