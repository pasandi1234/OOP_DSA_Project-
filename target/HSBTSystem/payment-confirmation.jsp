<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Payment" %>
<%@ page import="com.hsbt.model.CardPayment" %>
<%@ page import="com.hsbt.model.BankTransfer" %>
<%@ page import="com.hsbt.model.Booking" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Confirmation - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Payment Confirmation</p>
        </div>
    </header>

    <nav class="bg-blue-800 text-white py-3">
        <div class="container mx-auto px-4 flex justify-center space-x-6">
            <a href="index.jsp" class="hover:underline font-medium">Home</a>
            <a href="tutor-registration.jsp" class="hover:underline font-medium">Register as Tutor</a>
            <a href="student-registration.jsp" class="hover:underline font-medium">Register as Student</a>
            <a href="tutor-search.jsp" class="hover:underline font-medium">Search Tutors</a>
            <a href="advanced-tutor-search.jsp" class="hover:underline font-medium">Advanced Search</a>
            <a href="student-search.jsp" class="hover:underline font-medium">Search Students</a>
            <a href="booking-history" class="hover:underline font-medium">Booking History</a>
            <a href="payment-history" class="hover:underline font-medium">Payment History</a>
            <a href="dashboard.jsp" class="hover:underline font-medium">Dashboard</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <% 
            // Get the payment, booking, tutor, and student from the request
            Payment payment = (Payment) request.getAttribute("payment");
            Booking booking = (Booking) request.getAttribute("booking");
            Tutor tutor = (Tutor) request.getAttribute("tutor");
            Student student = (Student) request.getAttribute("student");
            
            if (payment == null || booking == null || tutor == null || student == null) {
                // If any of the required objects is missing, show an error message
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                Payment information is incomplete. Please try again.
            </div>
            <div class="text-center mt-6">
                <a href="booking-history" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    View Bookings
                </a>
            </div>
            <% } else { 
                boolean isCardPayment = payment instanceof CardPayment;
                boolean isBankTransfer = payment instanceof BankTransfer;
                String statusColor = "gray";
                if ("Completed".equals(payment.getStatus())) {
                    statusColor = "green";
                } else if ("Pending".equals(payment.getStatus())) {
                    statusColor = "yellow";
                } else if ("Failed".equals(payment.getStatus())) {
                    statusColor = "red";
                } else if ("Refunded".equals(payment.getStatus())) {
                    statusColor = "blue";
                }
            %>
            
            <div class="text-center mb-8">
                <div class="text-green-500 text-6xl mb-4">✓</div>
                <h2 class="text-2xl font-bold text-green-600">Payment Processed!</h2>
                <p class="text-gray-600 mt-2">Your payment has been processed successfully.</p>
                <p class="text-gray-600">Payment ID: <%= payment.getId() %></p>
                <p class="text-gray-600">Transaction ID: <%= payment.getTransactionId() %></p>
                <div class="mt-2">
                    <span class="bg-<%= statusColor %>-100 text-<%= statusColor %>-800 px-3 py-1 rounded-full font-medium">
                        <%= payment.getStatus() %>
                    </span>
                </div>
            </div>
            
            <!-- Payment Details -->
            <div class="bg-blue-50 p-6 rounded-lg mb-6">
                <h3 class="text-xl font-bold mb-4">Payment Details</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="font-medium">Amount:</p>
                        <p class="text-gray-700 mb-2">$<%= String.format("%.2f", payment.getAmount()) %></p>
                        
                        <p class="font-medium">Date:</p>
                        <p class="text-gray-700 mb-2"><%= payment.getFormattedDate() %></p>
                        
                        <p class="font-medium">Payment Method:</p>
                        <p class="text-gray-700 mb-2"><%= isCardPayment ? "Credit/Debit Card" : (isBankTransfer ? "Bank Transfer" : "Other") %></p>
                    </div>
                    
                    <div>
                        <p class="font-medium">Booking ID:</p>
                        <p class="text-gray-700 mb-2"><%= payment.getBookingId() %></p>
                        
                        <p class="font-medium">Student:</p>
                        <p class="text-gray-700 mb-2"><%= student.getName() %></p>
                        
                        <p class="font-medium">Tutor:</p>
                        <p class="text-gray-700 mb-2"><%= tutor.getName() %></p>
                    </div>
                </div>
                
                <% if (isCardPayment) { 
                    CardPayment cardPayment = (CardPayment) payment;
                %>
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">Card Details</h4>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="font-medium">Card Type:</p>
                            <p class="text-gray-700 mb-2"><%= cardPayment.getCardType() %></p>
                        </div>
                        
                        <div>
                            <p class="font-medium">Card Number:</p>
                            <p class="text-gray-700 mb-2">**** **** **** <%= cardPayment.getLastFourDigits() %></p>
                        </div>
                        
                        <div>
                            <p class="font-medium">Cardholder:</p>
                            <p class="text-gray-700 mb-2"><%= cardPayment.getCardholderName() %></p>
                        </div>
                    </div>
                </div>
                <% } else if (isBankTransfer) { 
                    BankTransfer bankTransfer = (BankTransfer) payment;
                %>
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">Bank Transfer Details</h4>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="font-medium">Bank Name:</p>
                            <p class="text-gray-700 mb-2"><%= bankTransfer.getBankName() %></p>
                        </div>
                        
                        <div>
                            <p class="font-medium">Account Name:</p>
                            <p class="text-gray-700 mb-2"><%= bankTransfer.getAccountName() %></p>
                        </div>
                        
                        <div>
                            <p class="font-medium">Reference Number:</p>
                            <p class="text-gray-700 mb-2"><%= bankTransfer.getReferenceNumber() %></p>
                        </div>
                        
                        <div>
                            <p class="font-medium">Transfer Method:</p>
                            <p class="text-gray-700 mb-2"><%= bankTransfer.getTransferMethod() %></p>
                        </div>
                        
                        <div>
                            <p class="font-medium">International:</p>
                            <p class="text-gray-700 mb-2"><%= bankTransfer.isInternational() ? "Yes" : "No" %></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            
            <!-- Booking Information -->
            <div class="bg-blue-50 p-6 rounded-lg mb-6">
                <h3 class="text-xl font-bold mb-4">Booking Information</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="font-medium">Subject:</p>
                        <p class="text-gray-700 mb-2"><%= booking.getSubject() %></p>
                        
                        <p class="font-medium">Date:</p>
                        <p class="text-gray-700 mb-2"><%= booking.getFormattedDate() %></p>
                        
                        <p class="font-medium">Time:</p>
                        <p class="text-gray-700 mb-2"><%= booking.getStartTime() %> - <%= booking.getEndTime() %></p>
                    </div>
                    
                    <div>
                        <p class="font-medium">Status:</p>
                        <p class="text-gray-700 mb-2"><%= booking.getStatus() %></p>
                        
                        <p class="font-medium">Session Type:</p>
                        <p class="text-gray-700 mb-2"><%= "ONLINE".equals(booking.getBookingType()) ? "Online" : "In-Person" %></p>
                    </div>
                </div>
            </div>
            
            <div class="text-center">
                <a href="payment-history" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                    View All Payments
                </a>
                <a href="view-payment?id=<%= payment.getId() %>" class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                    View Payment Details
                </a>
                <a href="view-booking?id=<%= booking.getId() %>" class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                    View Booking
                </a>
            </div>
            <% } %>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
