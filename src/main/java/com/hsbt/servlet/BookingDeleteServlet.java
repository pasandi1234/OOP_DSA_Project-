package com.hsbt.servlet;

import com.hsbt.service.BookingManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class BookingDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingManagementService bookingService;


    @Override
    public void init() throws ServletException {
        super.init();
        bookingService = BookingManagementService.getInstance();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        String bookingIdStr = request.getParameter("id");
        String action = request.getParameter("action");
        
        if (bookingIdStr != null && !bookingIdStr.isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                boolean success = false;
                
                if ("delete".equals(action)) {

                    success = bookingService.deleteBooking(bookingId);
                    if (success) {
                        request.setAttribute("message", "Booking deleted successfully.");
                    } else {
                        request.setAttribute("error", "Failed to delete booking.");
                    }
                } else if ("cancel".equals(action)) {

                    success = bookingService.cancelBooking(bookingId);
                    if (success) {
                        request.setAttribute("message", "Booking cancelled successfully.");
                    } else {
                        request.setAttribute("error", "Failed to cancel booking.");
                    }
                } else {
                    request.setAttribute("error", "Invalid action specified.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid booking ID format.");
            }
        } else {
            request.setAttribute("error", "No booking ID provided.");
        }
        

        request.getRequestDispatcher("/booking-history").forward(request, response);
    }
}
