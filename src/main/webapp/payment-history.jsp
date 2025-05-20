<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Payment" %>
<%@ page import="com.hsbt.model.CardPayment" %>
<%@ page import="com.hsbt.model.BankTransfer" %>
<%@ page import="com.hsbt.model.Booking" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment History - EduBridge</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">EduBridge</h1>
            <p class="text-center mt-2">Payment History</p>
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
        <div class="max-w-6xl mx-auto">
            <h2 class="text-2xl font-bold mb-6">Payment History</h2>
            
            <% 
            // Get success/error messages if any
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");
            
            if (message != null && !message.isEmpty()) {
            %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                <%= message %>
            </div>
            <% } 
            
            if (error != null && !error.isEmpty()) {
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= error %>
            </div>
            <% } %>
            
            <!-- Filter Controls -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <form action="payment-history" method="get" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <label for="status" class="block text-gray-700 font-medium mb-2">Filter By Status</label>
                            <select id="status" name="status" 
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">All Statuses</option>
                                <option value="Pending" <%= "Pending".equals(request.getAttribute("selectedStatus")) ? "selected" : "" %>>Pending</option>
                                <option value="Completed" <%= "Completed".equals(request.getAttribute("selectedStatus")) ? "selected" : "" %>>Completed</option>
                                <option value="Failed" <%= "Failed".equals(request.getAttribute("selectedStatus")) ? "selected" : "" %>>Failed</option>
                                <option value="Refunded" <%= "Refunded".equals(request.getAttribute("selectedStatus")) ? "selected" : "" %>>Refunded</option>
                            </select>
                        </div>
                        
                        <div>
                            <label for="studentId" class="block text-gray-700 font-medium mb-2">Filter By Student</label>
                            <select id="studentId" name="studentId" 
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">All Students</option>
                                <% 
                                Map<Integer, Student> students = (Map<Integer, Student>) request.getAttribute("students");
                                Student selectedStudent = (Student) request.getAttribute("selectedStudent");
                                
                                if (students != null) {
                                    for (Student student : students.values()) {
                                %>
                                <option value="<%= student.getId() %>" <%= (selectedStudent != null && selectedStudent.getId() == student.getId()) ? "selected" : "" %>><%= student.getName() %></option>
                                <% 
                                    }
                                }
                                %>
                            </select>
                        </div>
                        
                        <div>
                            <label for="tutorId" class="block text-gray-700 font-medium mb-2">Filter By Tutor</label>
                            <select id="tutorId" name="tutorId" 
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">All Tutors</option>
                                <% 
                                Map<Integer, Tutor> tutors = (Map<Integer, Tutor>) request.getAttribute("tutors");
                                Tutor selectedTutor = (Tutor) request.getAttribute("selectedTutor");
                                
                                if (tutors != null) {
                                    for (Tutor tutor : tutors.values()) {
                                %>
                                <option value="<%= tutor.getId() %>" <%= (selectedTutor != null && selectedTutor.getId() == tutor.getId()) ? "selected" : "" %>><%= tutor.getName() %></option>
                                <% 
                                    }
                                }
                                %>
                            </select>
                        </div>
                    </div>
                    
                    <div class="flex justify-center">
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded transition duration-300">
                            Apply Filters
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Payments List -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <% 
                List<Payment> payments = (List<Payment>) request.getAttribute("payments");
                Map<Integer, Booking> bookings = (Map<Integer, Booking>) request.getAttribute("bookings");
                
                if (payments == null || payments.isEmpty()) {
                %>
                <div class="p-6 text-center">
                    <p class="text-gray-600">No payments found.</p>
                </div>
                <% } else { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Booking</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tutor</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% 
                            for (Payment payment : payments) {
                                Tutor tutor = tutors.get(payment.getTutorId());
                                Student student = students.get(payment.getStudentId());
                                Booking booking = bookings.get(payment.getBookingId());
                                
                                if (tutor == null || student == null || booking == null) {
                                    continue; // Skip if tutor, student, or booking not found
                                }
                                
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
                                
                                boolean isCardPayment = payment instanceof CardPayment;
                                boolean isBankTransfer = payment instanceof BankTransfer;
                            %>
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= payment.getId() %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= payment.getFormattedDate() %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">$<%= String.format("%.2f", payment.getAmount()) %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <a href="view-booking?id=<%= booking.getId() %>" class="text-blue-600 hover:underline">#<%= booking.getId() %></a>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= student.getName() %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= tutor.getName() %></td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-<%= statusColor %>-100 text-<%= statusColor %>-800">
                                        <%= payment.getStatus() %>
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <%= isCardPayment ? "Card" : (isBankTransfer ? "Bank" : "Other") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <a href="view-payment?id=<%= payment.getId() %>" class="text-blue-600 hover:text-blue-900 mr-3">View</a>
                                    
                                    <% if (payment.isRefundable()) { %>
                                    <a href="update-payment?id=<%= payment.getId() %>" class="text-yellow-600 hover:text-yellow-900 mr-3">Edit</a>
                                    
                                    <a href="delete-payment?id=<%= payment.getId() %>&action=refund" class="text-blue-600 hover:text-blue-900 mr-3"
                                       onclick="return confirm('Are you sure you want to refund this payment?')">Refund</a>
                                    <% } %>
                                    
                                    <a href="delete-payment?id=<%= payment.getId() %>&action=delete" class="text-red-600 hover:text-red-900"
                                       onclick="return confirm('Are you sure you want to delete this payment? This action cannot be undone.')">Delete</a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2025 EduBridge. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
