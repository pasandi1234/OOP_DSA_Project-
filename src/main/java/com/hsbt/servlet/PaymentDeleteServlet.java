package com.hsbt.servlet;

import com.hsbt.service.PaymentManagementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class PaymentDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaymentManagementService paymentService;


    @Override
    public void init() throws ServletException {
        super.init();
        paymentService = PaymentManagementService.getInstance();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        String paymentIdStr = request.getParameter("id");
        String action = request.getParameter("action"); // "delete" or "refund"
        
        if (paymentIdStr != null && !paymentIdStr.isEmpty()) {
            try {
                int paymentId = Integer.parseInt(paymentIdStr);
                boolean success = false;
                
                if ("delete".equals(action)) {

                    success = paymentService.deletePayment(paymentId);
                    if (success) {
                        request.setAttribute("message", "Payment deleted successfully.");
                    } else {
                        request.setAttribute("error", "Failed to delete payment.");
                    }
                } else if ("refund".equals(action)) {

                    success = paymentService.refundPayment(paymentId);
                    if (success) {
                        request.setAttribute("message", "Payment refunded successfully.");
                    } else {
                        request.setAttribute("error", "Failed to refund payment. Only completed payments can be refunded.");
                    }
                } else {
                    request.setAttribute("error", "Invalid action specified.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid payment ID format.");
            }
        } else {
            request.setAttribute("error", "No payment ID provided.");
        }
        

        request.getRequestDispatcher("/payment-history").forward(request, response);
    }
}
