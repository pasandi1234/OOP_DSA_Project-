<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Booking" %>
<%@ page import="com.hsbt.model.OnlineBooking" %>
<%@ page import="com.hsbt.model.InPersonBooking" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="com.hsbt.service.ReviewManagementService" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details - EduBridge</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">EduBridge</h1>
            <p class="text-center mt-2">Booking Details</p>
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
            <a href="dashboard.jsp" class="hover:underline font-medium">Dashboard</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <%

            Booking booking = (Booking) request.getAttribute("booking");
            Tutor tutor = (Tutor) request.getAttribute("tutor");
            Student student = (Student) request.getAttribute("student");


            String message = (String) request.getAttribute("message");
            if (message != null && !message.isEmpty()) {
            %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                <%= message %>
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
            <% } else { %>

            <h2 class="text-2xl font-bold mb-6">Booking #<%= booking.getId() %></h2>


            <div class="mb-6">
                <%
                String statusColor = "gray";
                if ("Confirmed".equals(booking.getStatus())) {
                    statusColor = "green";
                } else if ("Pending".equals(booking.getStatus())) {
                    statusColor = "yellow";
                } else if ("Completed".equals(booking.getStatus())) {
                    statusColor = "blue";
                } else if ("Cancelled".equals(booking.getStatus())) {
                    statusColor = "red";
                }
                %>
                <span class="bg-<%= statusColor %>-100 text-<%= statusColor %>-800 px-3 py-1 rounded-full font-medium">
                    <%= booking.getStatus() %>
                </span>

                <% if (booking.isPast()) { %>
                <span class="bg-gray-100 text-gray-800 px-3 py-1 rounded-full font-medium ml-2">
                    Past
                </span>
                <% } else { %>
                <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full font-medium ml-2">
                    Upcoming
                </span>
                <% } %>

                <span class="bg-purple-100 text-purple-800 px-3 py-1 rounded-full font-medium ml-2">
                    <%= "ONLINE".equals(booking.getBookingType()) ? "Online" : "In-Person" %>
                </span>
            </div>


            <div class="bg-blue-50 p-6 rounded-lg mb-6">
                <h3 class="text-xl font-bold mb-4">Session Details</h3>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="font-medium">Subject:</p>
                        <p class="text-gray-700 mb-2"><%= booking.getSubject() %></p>

                        <p class="font-medium">Date:</p>
                        <p class="text-gray-700 mb-2"><%= booking.getFormattedDate() %></p>

                        <p class="font-medium">Time:</p>
                        <p class="text-gray-700 mb-2"><%= booking.getStartTime() %> - <%= booking.getEndTime() %></p>

                        <p class="font-medium">Duration:</p>
                        <p class="text-gray-700 mb-2"><%= String.format("%.1f", booking.calculateDuration()) %> hours</p>
                    </div>

                    <div>
                        <p class="font-medium">Price:</p>
                        <p class="text-gray-700 mb-2">Rs.<%= String.format("%.2f", booking.getPrice()) %></p>

                        <% if (booking instanceof InPersonBooking) {
                            InPersonBooking inPersonBooking = (InPersonBooking) booking;
                            if (inPersonBooking.isTravelFeeApplied()) {
                        %>
                        <p class="font-medium">Travel Fee:</p>
                        <p class="text-gray-700 mb-2">Rs.<%= String.format("%.2f", inPersonBooking.getTravelFee()) %></p>

                        <p class="font-medium">Total Price:</p>
                        <p class="text-gray-700 mb-2">Rs.<%= String.format("%.2f", inPersonBooking.getTotalPrice()) %></p>
                        <% }
                        } %>
                    </div>
                </div>

                <% if (booking instanceof OnlineBooking) {
                    OnlineBooking onlineBooking = (OnlineBooking) booking;
                %>
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">Online Session Details</h4>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="font-medium">Platform:</p>
                            <p class="text-gray-700 mb-2"><%= onlineBooking.getPlatform() %></p>

                            <% if (onlineBooking.getMeetingLink() != null && !onlineBooking.getMeetingLink().isEmpty()) { %>
                            <p class="font-medium">Meeting Link:</p>
                            <p class="text-gray-700 mb-2"><a href="<%= onlineBooking.getMeetingLink() %>" target="_blank" class="text-blue-600 hover:underline"><%= onlineBooking.getMeetingLink() %></a></p>
                            <% } %>
                        </div>

                        <div>
                            <% if (onlineBooking.getMeetingId() != null && !onlineBooking.getMeetingId().isEmpty()) { %>
                            <p class="font-medium">Meeting ID:</p>
                            <p class="text-gray-700 mb-2"><%= onlineBooking.getMeetingId() %></p>
                            <% } %>

                            <% if (onlineBooking.getPassword() != null && !onlineBooking.getPassword().isEmpty()) { %>
                            <p class="font-medium">Password:</p>
                            <p class="text-gray-700 mb-2"><%= onlineBooking.getPassword() %></p>
                            <% } %>

                            <p class="font-medium">Recording Requested:</p>
                            <p class="text-gray-700 mb-2"><%= onlineBooking.isRecordingRequested() ? "Yes" : "No" %></p>
                        </div>
                    </div>
                </div>
                <% } else if (booking instanceof InPersonBooking) {
                    InPersonBooking inPersonBooking = (InPersonBooking) booking;
                %>
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">In-Person Session Details</h4>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="font-medium">Location:</p>
                            <p class="text-gray-700 mb-2"><%= inPersonBooking.getLocation() %></p>

                            <p class="font-medium">Address:</p>
                            <p class="text-gray-700 mb-2"><%= inPersonBooking.getAddress() %></p>
                        </div>

                        <div>
                            <p class="font-medium">Materials Provided:</p>
                            <p class="text-gray-700 mb-2"><%= inPersonBooking.isMaterialsProvided() ? "Yes" : "No" %></p>

                            <p class="font-medium">Travel Fee Applied:</p>
                            <p class="text-gray-700 mb-2"><%= inPersonBooking.isTravelFeeApplied() ? "Yes" : "No" %></p>
                        </div>
                    </div>
                </div>
                <% } %>

                <% if (booking.getNotes() != null && !booking.getNotes().isEmpty()) { %>
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">Additional Notes</h4>
                    <p class="text-gray-700"><%= booking.getNotes() %></p>
                </div>
                <% } %>
            </div>


            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-lg font-semibold mb-2">Tutor Information</h3>
                    <p><span class="font-medium">Name:</span> <%= tutor.getName() %></p>
                    <p><span class="font-medium">Email:</span> <%= tutor.getEmail() %></p>
                    <p><span class="font-medium">Phone:</span> <%= tutor.getPhone() %></p>
                    <p><span class="font-medium">Rating:</span> <%= tutor.getRating() %>/5.0</p>
                    <p><span class="font-medium">Experience:</span> <%= tutor.getYearsOfExperience() %> years</p>
                    <div class="mt-2">
                        <a href="view-tutor?id=<%= tutor.getId() %>" class="text-blue-600 hover:underline">View Tutor Profile</a>
                    </div>
                </div>

                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-lg font-semibold mb-2">Student Information</h3>
                    <p><span class="font-medium">Name:</span> <%= student.getName() %></p>
                    <p><span class="font-medium">Email:</span> <%= student.getEmail() %></p>
                    <p><span class="font-medium">Phone:</span> <%= student.getPhone() %></p>
                    <p><span class="font-medium">Education Level:</span> <%= student.getEducationLevel() %></p>
                    <div class="mt-2">
                        <a href="view-student?id=<%= student.getId() %>" class="text-blue-600 hover:underline">View Student Profile</a>
                    </div>
                </div>
            </div>


            <div class="flex flex-wrap justify-center gap-4">
                <a href="booking-history" class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Back to Bookings
                </a>

                <% if (!booking.isPast() && !"Cancelled".equals(booking.getStatus())) { %>
                <a href="process-payment?bookingId=<%= booking.getId() %>" class="bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Pay Now
                </a>

                <a href="update-booking?id=<%= booking.getId() %>" class="bg-yellow-500 hover:bg-yellow-600 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Update Booking
                </a>

                <a href="delete-booking?id=<%= booking.getId() %>&action=cancel" class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded transition duration-300"
                   onclick="return confirm('Are you sure you want to cancel this booking?')">
                    Cancel Booking
                </a>
                <% } %>

                <% if ("Completed".equals(booking.getStatus())) {

                    ReviewManagementService reviewService = ReviewManagementService.getInstance();
                    boolean hasReviewed = reviewService.hasStudentReviewedBooking(student.getId(), booking.getId());

                    if (!hasReviewed) {
                %>
                <a href="submit-review?bookingId=<%= booking.getId() %>&tutorId=<%= tutor.getId() %>&studentId=<%= student.getId() %>" class="bg-purple-600 hover:bg-purple-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Write a Review
                </a>
                <% } else { %>
                <span class="bg-gray-200 text-gray-700 font-medium py-2 px-4 rounded cursor-not-allowed">
                    Already Reviewed
                </span>
                <% }
                } %>

                <a href="delete-booking?id=<%= booking.getId() %>&action=delete" class="bg-gray-600 hover:bg-gray-700 text-white font-medium py-2 px-4 rounded transition duration-300"
                   onclick="return confirm('Are you sure you want to delete this booking? This action cannot be undone.')">
                    Delete Booking
                </a>
            </div>
            <% } %>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2025 EduBridge. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
