package com.hsbt.servlet;

import com.hsbt.model.Booking;
import com.hsbt.model.OnlineBooking;
import com.hsbt.model.InPersonBooking;
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


public class BookingCreationServlet extends HttpServlet {
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
        

        String tutorIdStr = request.getParameter("tutorId");
        
        if (tutorIdStr != null && !tutorIdStr.isEmpty()) {
            try {
                int tutorId = Integer.parseInt(tutorIdStr);
                Tutor tutor = tutorService.getTutorById(tutorId);
                
                if (tutor != null) {

                    request.setAttribute("tutor", tutor);
                    

                    request.getRequestDispatcher("/booking-form.jsp").forward(request, response);
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
        

        String tutorIdStr = request.getParameter("tutorId");
        String studentIdStr = request.getParameter("studentId");
        String subject = request.getParameter("subject");
        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String bookingType = request.getParameter("bookingType");
        String notes = request.getParameter("notes");
        
        try {

            int tutorId = Integer.parseInt(tutorIdStr);
            int studentId = Integer.parseInt(studentIdStr);
            

            Tutor tutor = tutorService.getTutorById(tutorId);
            Student student = studentService.getStudentById(studentId);
            
            if (tutor == null || student == null) {
                request.setAttribute("error", "Invalid tutor or student ID.");
                request.getRequestDispatcher("/booking-form.jsp").forward(request, response);
                return;
            }
            

            if (!bookingService.isTutorAvailable(tutorId, date, startTime, endTime)) {
                request.setAttribute("error", "Tutor is not available at the selected time.");
                request.setAttribute("tutor", tutor);
                request.getRequestDispatcher("/booking-form.jsp").forward(request, response);
                return;
            }
            

            double hours = calculateHours(startTime, endTime);
            double price = bookingService.calculateBookingPrice(tutorId, hours);
            

            Booking booking;
            
            if ("online".equals(bookingType)) {

                String platform = request.getParameter("platform");
                String meetingLink = request.getParameter("meetingLink");
                String meetingId = request.getParameter("meetingId");
                String password = request.getParameter("password");
                String recordingRequestedStr = request.getParameter("recordingRequested");
                boolean recordingRequested = "on".equals(recordingRequestedStr);
                

                booking = new OnlineBooking(
                    0,
                    studentId,
                    tutorId,
                    subject,
                    date,
                    startTime,
                    endTime,
                    price,
                    "Pending",
                    notes,
                    platform,
                    meetingLink,
                    meetingId,
                    password,
                    recordingRequested
                );
            } else {

                String location = request.getParameter("location");
                String address = request.getParameter("address");
                String materialsProvidedStr = request.getParameter("materialsProvided");
                boolean materialsProvided = "on".equals(materialsProvidedStr);
                String travelFeeAppliedStr = request.getParameter("travelFeeApplied");
                boolean travelFeeApplied = "on".equals(travelFeeAppliedStr);
                double travelFee = 0.0;
                
                if (travelFeeApplied) {
                    try {
                        travelFee = Double.parseDouble(request.getParameter("travelFee"));
                    } catch (NumberFormatException e) {

                    }
                }
                

                booking = new InPersonBooking(
                    0,
                    studentId,
                    tutorId,
                    subject,
                    date,
                    startTime,
                    endTime,
                    price,
                    "Pending",
                    notes,
                    location,
                    address,
                    materialsProvided,
                    travelFeeApplied,
                    travelFee
                );
            }
            

            Booking createdBooking = bookingService.createBooking(booking);
            

            request.setAttribute("booking", createdBooking);
            request.setAttribute("tutor", tutor);
            request.setAttribute("student", student);
            

            request.getRequestDispatcher("/booking-confirmation.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format. Please check your inputs and try again.");
            request.getRequestDispatcher("/booking-form.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/booking-form.jsp").forward(request, response);
        }
    }
    

    private double calculateHours(String startTime, String endTime) {
        try {
            String[] startParts = startTime.split(":");
            String[] endParts = endTime.split(":");
            
            int startHour = Integer.parseInt(startParts[0]);
            int startMinute = Integer.parseInt(startParts[1]);
            int endHour = Integer.parseInt(endParts[0]);
            int endMinute = Integer.parseInt(endParts[1]);
            
            double startTimeDecimal = startHour + (startMinute / 60.0);
            double endTimeDecimal = endHour + (endMinute / 60.0);
            
            return endTimeDecimal - startTimeDecimal;
        } catch (Exception e) {
            return 0.0;
        }
    }
}
