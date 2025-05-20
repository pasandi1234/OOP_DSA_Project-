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
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class BookingListServlet extends HttpServlet {
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
        

        String filter = request.getParameter("filter");
        String studentIdStr = request.getParameter("studentId");
        String tutorIdStr = request.getParameter("tutorId");
        

        if (filter == null || filter.isEmpty()) {
            filter = "all";
        }
        

        List<Booking> bookings;
        
        if ("upcoming".equals(filter)) {
            bookings = bookingService.getUpcomingBookings();
        } else if ("past".equals(filter)) {
            bookings = bookingService.getPastBookings();
        } else {
            bookings = bookingService.getAllBookings();
        }
        

        if (studentIdStr != null && !studentIdStr.isEmpty()) {
            try {
                int studentId = Integer.parseInt(studentIdStr);
                bookings = bookingService.getBookingsByStudentId(studentId);
                

                Student student = studentService.getStudentById(studentId);
                request.setAttribute("selectedStudent", student);
            } catch (NumberFormatException e) {

            }
        }
        
        if (tutorIdStr != null && !tutorIdStr.isEmpty()) {
            try {
                int tutorId = Integer.parseInt(tutorIdStr);
                bookings = bookingService.getBookingsByTutorId(tutorId);
                

                Tutor tutor = tutorService.getTutorById(tutorId);
                request.setAttribute("selectedTutor", tutor);
            } catch (NumberFormatException e) {

            }
        }
        

        Map<Integer, Tutor> tutors = new HashMap<>();
        Map<Integer, Student> students = new HashMap<>();
        
        for (Booking booking : bookings) {

            if (!tutors.containsKey(booking.getTutorId())) {
                Tutor tutor = tutorService.getTutorById(booking.getTutorId());
                if (tutor != null) {
                    tutors.put(booking.getTutorId(), tutor);
                }
            }
            

            if (!students.containsKey(booking.getStudentId())) {
                Student student = studentService.getStudentById(booking.getStudentId());
                if (student != null) {
                    students.put(booking.getStudentId(), student);
                }
            }
        }
        

        request.setAttribute("bookings", bookings);
        request.setAttribute("tutors", tutors);
        request.setAttribute("students", students);
        request.setAttribute("filter", filter);
        

        request.getRequestDispatcher("/booking-history.jsp").forward(request, response);
    }
}
