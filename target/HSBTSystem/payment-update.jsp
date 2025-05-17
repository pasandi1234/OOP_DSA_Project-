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
    <title>Update Payment - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Update Payment</p>
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
            <h2 class="text-2xl font-bold text-center mb-6">Update Payment</h2>
            
            <% 
            // Get the payment, booking, tutor, and student from the request
            Payment payment = (Payment) request.getAttribute("payment");
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
            
            <% if (payment == null || booking == null || tutor == null || student == null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                Payment information is incomplete. Please try again.
            </div>
            <div class="text-center mt-6">
                <a href="payment-history" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    View All Payments
                </a>
            </div>
            <% } else { 
                boolean isCardPayment = payment instanceof CardPayment;
                boolean isBankTransfer = payment instanceof BankTransfer;
                CardPayment cardPayment = isCardPayment ? (CardPayment) payment : null;
                BankTransfer bankTransfer = isBankTransfer ? (BankTransfer) payment : null;
            %>
            
            <!-- Payment Information -->
            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <h3 class="text-xl font-semibold mb-2">Payment #<%= payment.getId() %></h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="font-medium">Amount:</p>
                        <p class="text-gray-700 mb-2">$<%= String.format("%.2f", payment.getAmount()) %></p>
                    </div>
                    <div>
                        <p class="font-medium">Date:</p>
                        <p class="text-gray-700 mb-2"><%= payment.getFormattedDate() %></p>
                    </div>
                    <div>
                        <p class="font-medium">Booking:</p>
                        <p class="text-gray-700 mb-2">#<%= booking.getId() %> - <%= booking.getSubject() %></p>
                    </div>
                    <div>
                        <p class="font-medium">Payment Type:</p>
                        <p class="text-gray-700 mb-2"><%= isCardPayment ? "Credit/Debit Card" : (isBankTransfer ? "Bank Transfer" : "Other") %></p>
                    </div>
                </div>
            </div>
            
            <!-- Update Form -->
            <form action="update-payment" method="post" class="space-y-6">
                <!-- Hidden ID field -->
                <input type="hidden" name="id" value="<%= payment.getId() %>">
                
                <!-- Common Payment Fields -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label for="status" class="block text-gray-700 font-medium mb-2">Status</label>
                        <select id="status" name="status" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="Pending" <%= "Pending".equals(payment.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="Completed" <%= "Completed".equals(payment.getStatus()) ? "selected" : "" %>>Completed</option>
                            <option value="Failed" <%= "Failed".equals(payment.getStatus()) ? "selected" : "" %>>Failed</option>
                            <option value="Refunded" <%= "Refunded".equals(payment.getStatus()) ? "selected" : "" %>>Refunded</option>
                        </select>
                    </div>
                    <div>
                        <label for="transactionId" class="block text-gray-700 font-medium mb-2">Transaction ID</label>
                        <input type="text" id="transactionId" name="transactionId" value="<%= payment.getTransactionId() %>" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>
                
                <% if (isCardPayment) { %>
                <!-- Card Payment Details -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-lg font-semibold mb-4">Card Details</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="cardType" class="block text-gray-700 font-medium mb-2">Card Type</label>
                            <select id="cardType" name="cardType" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="Visa" <%= "Visa".equals(cardPayment.getCardType()) ? "selected" : "" %>>Visa</option>
                                <option value="Mastercard" <%= "Mastercard".equals(cardPayment.getCardType()) ? "selected" : "" %>>Mastercard</option>
                                <option value="American Express" <%= "American Express".equals(cardPayment.getCardType()) ? "selected" : "" %>>American Express</option>
                                <option value="Discover" <%= "Discover".equals(cardPayment.getCardType()) ? "selected" : "" %>>Discover</option>
                            </select>
                        </div>
                        <div>
                            <label for="cardholderName" class="block text-gray-700 font-medium mb-2">Cardholder Name</label>
                            <input type="text" id="cardholderName" name="cardholderName" value="<%= cardPayment.getCardholderName() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="expiryDate" class="block text-gray-700 font-medium mb-2">Expiry Date</label>
                            <input type="text" id="expiryDate" name="expiryDate" value="<%= cardPayment.getExpiryDate() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label class="block text-gray-700 font-medium mb-2">Card Number (Last 4 Digits)</label>
                            <p class="text-gray-700">**** **** **** <%= cardPayment.getLastFourDigits() %></p>
                            <input type="hidden" name="lastFourDigits" value="<%= cardPayment.getLastFourDigits() %>">
                        </div>
                    </div>
                </div>
                <% } else if (isBankTransfer) { %>
                <!-- Bank Transfer Details -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-lg font-semibold mb-4">Bank Transfer Details</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="bankName" class="block text-gray-700 font-medium mb-2">Bank Name</label>
                            <input type="text" id="bankName" name="bankName" value="<%= bankTransfer.getBankName() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="accountName" class="block text-gray-700 font-medium mb-2">Account Name</label>
                            <input type="text" id="accountName" name="accountName" value="<%= bankTransfer.getAccountName() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="referenceNumber" class="block text-gray-700 font-medium mb-2">Reference Number</label>
                            <input type="text" id="referenceNumber" name="referenceNumber" value="<%= bankTransfer.getReferenceNumber() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="transferMethod" class="block text-gray-700 font-medium mb-2">Transfer Method</label>
                            <select id="transferMethod" name="transferMethod" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="ACH" <%= "ACH".equals(bankTransfer.getTransferMethod()) ? "selected" : "" %>>ACH</option>
                                <option value="Wire Transfer" <%= "Wire Transfer".equals(bankTransfer.getTransferMethod()) ? "selected" : "" %>>Wire Transfer</option>
                                <option value="SWIFT" <%= "SWIFT".equals(bankTransfer.getTransferMethod()) ? "selected" : "" %>>SWIFT</option>
                                <option value="Other" <%= "Other".equals(bankTransfer.getTransferMethod()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                    </div>
                    <div class="mt-4">
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="isInternational" <%= bankTransfer.isInternational() ? "checked" : "" %> class="form-checkbox text-blue-600">
                            <span class="ml-2">International Transfer</span>
                        </label>
                    </div>
                </div>
                <% } %>
                
                <div class="text-center">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                        Update Payment
                    </button>
                    <a href="view-payment?id=<%= payment.getId() %>" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
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
</body>
</html>
