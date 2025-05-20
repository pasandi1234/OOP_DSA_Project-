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


public class BookingUpdateServlet extends HttpServlet {
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
                    

                    request.getRequestDispatcher("/booking-update.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {

            }
        }
        

        response.sendRedirect("booking-history");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        String bookingIdStr = request.getParameter("id");
        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String status = request.getParameter("status");
        String notes = request.getParameter("notes");
        
        try {

            int bookingId = Integer.parseInt(bookingIdStr);
            

            Booking booking = bookingService.getBookingById(bookingId);
            
            if (booking == null) {
                request.setAttribute("error", "Booking not found.");
                request.getRequestDispatcher("/booking-history").forward(request, response);
                return;
            }
            

            if (!date.equals(booking.getDate()) || !startTime.equals(booking.getStartTime()) || !endTime.equals(booking.getEndTime())) {
                if (!bookingService.isTutorAvailable(booking.getTutorId(), date, startTime, endTime)) {
                    request.setAttribute("error", "Tutor is not available at the selected time.");
                    request.setAttribute("booking", booking);
                    request.getRequestDispatcher("/booking-update.jsp").forward(request, response);
                    return;
                }
            }
            

            double price = booking.getPrice();
            if (!startTime.equals(booking.getStartTime()) || !endTime.equals(booking.getEndTime())) {
                double hours = calculateHours(startTime, endTime);
                price = bookingService.calculateBookingPrice(booking.getTutorId(), hours);
            }
            

            booking.setDate(date);
            booking.setStartTime(startTime);
            booking.setEndTime(endTime);
            booking.setStatus(status);
            booking.setNotes(notes);
            booking.setPrice(price);
            

            if (booking instanceof OnlineBooking) {
                OnlineBooking onlineBooking = (OnlineBooking) booking;
                

                String platform = request.getParameter("platform");
                String meetingLink = request.getParameter("meetingLink");
                String meetingId = request.getParameter("meetingId");
                String password = request.getParameter("password");
                String recordingRequestedStr = request.getParameter("recordingRequested");
                boolean recordingRequested = "on".equals(recordingRequestedStr);
                

                onlineBooking.setPlatform(platform);
                onlineBooking.setMeetingLink(meetingLink);
                onlineBooking.setMeetingId(meetingId);
                onlineBooking.setPassword(password);
                onlineBooking.setRecordingRequested(recordingRequested);
            } else if (booking instanceof InPersonBooking) {
                InPersonBooking inPersonBooking = (InPersonBooking) booking;
                

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
                

                inPersonBooking.setLocation(location);
                inPersonBooking.setAddress(address);
                inPersonBooking.setMaterialsProvided(materialsProvided);
                inPersonBooking.setTravelFeeApplied(travelFeeApplied);
                inPersonBooking.setTravelFee(travelFee);
            }
            

            boolean success = bookingService.updateBooking(booking);
            
            if (success) {

                Tutor tutor = tutorService.getTutorById(booking.getTutorId());
                Student student = studentService.getStudentById(booking.getStudentId());
                

                request.setAttribute("booking", booking);
                request.setAttribute("tutor", tutor);
                request.setAttribute("student", student);
                request.setAttribute("message", "Booking updated successfully.");
                

                request.getRequestDispatcher("/booking-details.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to update booking.");
                request.getRequestDispatcher("/booking-update.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format. Please check your inputs and try again.");
            request.getRequestDispatcher("/booking-update.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/booking-update.jsp").forward(request, response);
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
