<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Booking" %>
<%@ page import="com.hsbt.model.OnlineBooking" %>
<%@ page import="com.hsbt.model.InPersonBooking" %>
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
    <title>Payment Processing - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Payment Processing</p>
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
            <h2 class="text-2xl font-bold text-center mb-6">Payment Processing</h2>
            
            <% 
            // Get the booking, tutor, and student from the request
            Booking booking = (Booking) request.getAttribute("booking");
            Tutor tutor = (Tutor) request.getAttribute("tutor");
            Student student = (Student) request.getAttribute("student");
            
            // Get error message if any
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= error %>
            </div>
            <% } %>
            
            <% if (booking == null || tutor == null || student == null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                Booking information is incomplete. Please try again.
            </div>
            <div class="text-center mt-6">
                <a href="booking-history" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    View All Bookings
                </a>
            </div>
            <% } else { 
                // Calculate the amount to pay
                double amount = booking.getPrice();
                if (booking instanceof InPersonBooking) {
                    InPersonBooking inPersonBooking = (InPersonBooking) booking;
                    if (inPersonBooking.isTravelFeeApplied()) {
                        amount = inPersonBooking.getTotalPrice();
                    }
                }
            %>
            
            <!-- Booking Information -->
            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <h3 class="text-xl font-semibold mb-2">Booking #<%= booking.getId() %></h3>
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
                        <p class="font-medium">Tutor:</p>
                        <p class="text-gray-700 mb-2"><%= tutor.getName() %></p>
                        
                        <p class="font-medium">Student:</p>
                        <p class="text-gray-700 mb-2"><%= student.getName() %></p>
                        
                        <p class="font-medium">Session Type:</p>
                        <p class="text-gray-700 mb-2"><%= "ONLINE".equals(booking.getBookingType()) ? "Online" : "In-Person" %></p>
                    </div>
                </div>
                
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">Payment Summary</h4>
                    <p class="text-gray-700">Base Price: $<%= String.format("%.2f", booking.getPrice()) %></p>
                    
                    <% if (booking instanceof InPersonBooking) { 
                        InPersonBooking inPersonBooking = (InPersonBooking) booking;
                        if (inPersonBooking.isTravelFeeApplied()) {
                    %>
                    <p class="text-gray-700">Travel Fee: $<%= String.format("%.2f", inPersonBooking.getTravelFee()) %></p>
                    <% } 
                    } %>
                    
                    <p class="text-gray-700 font-bold">Total Amount: $<%= String.format("%.2f", amount) %></p>
                </div>
            </div>
            
            <!-- Payment Form -->
            <form action="process-payment" method="post" class="space-y-6">
                <!-- Hidden fields -->
                <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
                <input type="hidden" name="amount" value="<%= amount %>">
                
                <!-- Payment Method Selection -->
                <div>
                    <label class="block text-gray-700 font-medium mb-2">Payment Method</label>
                    <div class="flex space-x-4">
                        <label class="inline-flex items-center">
                            <input type="radio" name="paymentMethod" value="card" checked
                                class="form-radio text-blue-600" onclick="togglePaymentMethod('card')">
                            <span class="ml-2">Credit/Debit Card</span>
                        </label>
                        <label class="inline-flex items-center">
                            <input type="radio" name="paymentMethod" value="bank"
                                class="form-radio text-blue-600" onclick="togglePaymentMethod('bank')">
                            <span class="ml-2">Bank Transfer</span>
                        </label>
                    </div>
                </div>
                
                <!-- Card Payment Details -->
                <div id="cardDetails" class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-lg font-semibold mb-4">Card Details</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="cardType" class="block text-gray-700 font-medium mb-2">Card Type</label>
                            <select id="cardType" name="cardType" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="Visa">Visa</option>
                                <option value="Mastercard">Mastercard</option>
                                <option value="American Express">American Express</option>
                                <option value="Discover">Discover</option>
                            </select>
                        </div>
                        <div>
                            <label for="cardNumber" class="block text-gray-700 font-medium mb-2">Card Number</label>
                            <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="cardholderName" class="block text-gray-700 font-medium mb-2">Cardholder Name</label>
                            <input type="text" id="cardholderName" name="cardholderName" placeholder="John Smith" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="expiryDate" class="block text-gray-700 font-medium mb-2">Expiry Date</label>
                            <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="cvv" class="block text-gray-700 font-medium mb-2">CVV</label>
                            <input type="text" id="cvv" name="cvv" placeholder="123" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>
                </div>
                
                <!-- Bank Transfer Details -->
                <div id="bankDetails" class="bg-blue-50 p-4 rounded-lg hidden">
                    <h3 class="text-lg font-semibold mb-4">Bank Transfer Details</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="bankName" class="block text-gray-700 font-medium mb-2">Bank Name</label>
                            <input type="text" id="bankName" name="bankName" placeholder="First Bank"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="accountName" class="block text-gray-700 font-medium mb-2">Account Name</label>
                            <input type="text" id="accountName" name="accountName" placeholder="John Smith"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="referenceNumber" class="block text-gray-700 font-medium mb-2">Reference Number</label>
                            <input type="text" id="referenceNumber" name="referenceNumber" placeholder="REF123456"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="transferMethod" class="block text-gray-700 font-medium mb-2">Transfer Method</label>
                            <select id="transferMethod" name="transferMethod"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="ACH">ACH</option>
                                <option value="Wire Transfer">Wire Transfer</option>
                                <option value="SWIFT">SWIFT</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                    </div>
                    <div class="mt-4">
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="isInternational" class="form-checkbox text-blue-600">
                            <span class="ml-2">International Transfer</span>
                        </label>
                    </div>
                </div>
                
                <div class="text-center">
                    <button type="submit" class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                        Process Payment
                    </button>
                    <a href="view-booking?id=<%= booking.getId() %>" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                        Cancel
                    </a>
                </div>
            </form>
            <% } %>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Toggle between card and bank transfer payment methods
        function togglePaymentMethod(method) {
            if (method === 'card') {
                document.getElementById('cardDetails').classList.remove('hidden');
                document.getElementById('bankDetails').classList.add('hidden');
                
                // Make card fields required
                document.getElementById('cardNumber').required = true;
                document.getElementById('cardholderName').required = true;
                document.getElementById('expiryDate').required = true;
                document.getElementById('cvv').required = true;
                
                // Make bank fields not required
                document.getElementById('bankName').required = false;
                document.getElementById('accountName').required = false;
                document.getElementById('referenceNumber').required = false;
            } else {
                document.getElementById('cardDetails').classList.add('hidden');
                document.getElementById('bankDetails').classList.remove('hidden');
                
                // Make card fields not required
                document.getElementById('cardNumber').required = false;
                document.getElementById('cardholderName').required = false;
                document.getElementById('expiryDate').required = false;
                document.getElementById('cvv').required = false;
                
                // Make bank fields required
                document.getElementById('bankName').required = true;
                document.getElementById('accountName').required = true;
                document.getElementById('referenceNumber').required = true;
            }
        }
    </script>
</body>
</html>
