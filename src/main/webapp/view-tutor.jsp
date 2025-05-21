<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.OnlineTutor" %>
<%@ page import="com.hsbt.model.InPersonTutor" %>
<%@ page import="com.hsbt.model.Review" %>
<%@ page import="com.hsbt.model.PublicReview" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="com.hsbt.service.TutorManagementService" %>
<%@ page import="com.hsbt.service.ReviewManagementService" %>
<%@ page import="com.hsbt.service.StudentManagementService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Profile - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Tutor Profile</p>
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
            <a href="review-list" class="hover:underline font-medium">Reviews</a>
            <a href="dashboard.jsp" class="hover:underline font-medium">Dashboard</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <%
        String idStr = request.getParameter("id");
        Tutor tutor = null;

        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                TutorManagementService tutorService = TutorManagementService.getInstance();
                tutor = tutorService.getTutorById(id);
            } catch (NumberFormatException e) {
            }
        }

        if (tutor == null) {
        %>
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                Tutor not found. Please try again.
            </div>
            <div class="text-center mt-6">
                <a href="tutor-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    Back to Search
                </a>
            </div>
        </div>
        <% } else {
            String tutorType = "Base Tutor";
            if (tutor instanceof OnlineTutor) {
                tutorType = "Online Tutor";
            } else if (tutor instanceof InPersonTutor) {
                tutorType = "In-Person Tutor";
            }
        %>
        <div class="max-w-4xl mx-auto">
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <div class="p-6">
                    <div class="flex flex-col md:flex-row">
                        <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-32 h-32 md:mr-8 mb-4 md:mb-0 mx-auto md:mx-0">
                            <span class="text-blue-800 text-4xl font-bold"><%= tutor.getName().substring(0, 1) %></span>
                        </div>
                        <div class="flex-grow text-center md:text-left">
                            <h2 class="text-2xl font-bold"><%= tutor.getName() %></h2>
                            <p class="text-gray-600 text-lg"><%= tutorType %></p>
                            <div class="flex items-center mt-2 justify-center md:justify-start">
                                <div class="text-yellow-400 text-xl">
                                    <%= tutor.getStarRating() %>
                                </div>
                                <span class="ml-2 text-gray-600"><%= tutor.getRating() %>/5</span>
                                <a href="tutor-reviews?id=<%= tutor.getId() %>" class="ml-2 text-blue-600 hover:underline text-sm">
                                    View All Reviews
                                </a>
                            </div>
                            <p class="<%= tutor.isAvailable() ? "text-green-600" : "text-red-600" %> font-medium mt-2">
                                <%= tutor.isAvailable() ? "Available for Booking" : "Currently Unavailable" %>
                            </p>
                        </div>
                    </div>

                    <div class="mt-8 grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="bg-blue-50 p-4 rounded-lg">
                            <h3 class="text-xl font-semibold mb-4">Contact Information</h3>
                            <p><span class="font-medium">Email:</span> <%= tutor.getEmail() %></p>
                            <p><span class="font-medium">Phone:</span> <%= tutor.getPhone() %></p>
                        </div>

                        <div class="bg-blue-50 p-4 rounded-lg">
                            <h3 class="text-xl font-semibold mb-4">Professional Details</h3>
                            <p><span class="font-medium">Experience:</span> <%= tutor.getYearsOfExperience() %> years</p>
                            <p><span class="font-medium">Hourly Rate:</span> $<%= tutor.getHourlyRate() %></p>
                        </div>

                        <div class="bg-blue-50 p-4 rounded-lg md:col-span-2">
                            <h3 class="text-xl font-semibold mb-4">Subjects</h3>
                            <div class="flex flex-wrap gap-2">
                                <%
                                String[] subjects = tutor.getSubjects();
                                if (subjects != null && subjects.length > 0) {
                                    for (String subject : subjects) {
                                %>
                                <span class="bg-blue-200 text-blue-800 px-3 py-1 rounded-full"><%= subject %></span>
                                <%
                                    }
                                } else {
                                %>
                                <p class="text-gray-600">No subjects specified</p>
                                <% } %>
                            </div>
                        </div>

                        <% if (tutor instanceof OnlineTutor) {
                            OnlineTutor onlineTutor = (OnlineTutor) tutor;
                        %>
                        <div class="bg-blue-50 p-4 rounded-lg md:col-span-2">
                            <h3 class="text-xl font-semibold mb-4">Online Tutoring Details</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <p><span class="font-medium">Platform:</span> <%= onlineTutor.getPlatformPreference() %></p>
                                    <p><span class="font-medium">Time Zone:</span> <%= onlineTutor.getTimeZone() %></p>
                                </div>
                                <div>
                                    <p><span class="font-medium">Has Webcam:</span> <%= onlineTutor.hasWebcam() ? "Yes" : "No" %></p>
                                    <p><span class="font-medium">Provides Recordings:</span> <%= onlineTutor.providesRecordings() ? "Yes" : "No" %></p>
                                </div>
                            </div>
                        </div>
                        <% } %>

                        <% if (tutor instanceof InPersonTutor) {
                            InPersonTutor inPersonTutor = (InPersonTutor) tutor;
                        %>
                        <div class="bg-blue-50 p-4 rounded-lg md:col-span-2">
                            <h3 class="text-xl font-semibold mb-4">In-Person Tutoring Details</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <p><span class="font-medium">Location:</span> <%= inPersonTutor.getLocation() %></p>
                                    <p><span class="font-medium">Travel Radius:</span> <%= inPersonTutor.getTravelRadius() %> km</p>
                                </div>
                                <div>
                                    <p><span class="font-medium">Travels to Student:</span> <%= inPersonTutor.isTravelToStudent() ? "Yes" : "No" %></p>
                                    <p><span class="font-medium">Provides Learning Materials:</span> <%= inPersonTutor.isProvidesLearningMaterials() ? "Yes" : "No" %></p>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <div class="mt-8">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-xl font-semibold">Reviews</h3>
                            <a href="tutor-reviews?id=<%= tutor.getId() %>" class="text-blue-600 hover:underline">View All Reviews</a>
                        </div>

                        <%
                        ReviewManagementService reviewService = ReviewManagementService.getInstance();
                        StudentManagementService studentService = StudentManagementService.getInstance();
                        List<Review> reviews = reviewService.getApprovedReviewsByTutorId(tutor.getId());

                        Map<Integer, Student> studentMap = new HashMap<>();
                        for (Review review : reviews) {
                            Student student = studentService.getStudentById(review.getStudentId());
                            if (student != null) {
                                studentMap.put(student.getId(), student);
                            }
                        }

                        if (reviews.isEmpty()) {
                        %>
                        <div class="bg-blue-50 p-6 rounded-lg text-center">
                            <p class="text-gray-600">No reviews yet.</p>
                            <a href="submit-review?tutorId=<%= tutor.getId() %>" class="inline-block mt-4 bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                                Be the First to Write a Review
                            </a>
                        </div>
                        <% } else {
                            int displayCount = Math.min(reviews.size(), 3);
                            for (int i = 0; i < displayCount; i++) {
                                Review review = reviews.get(i);
                                boolean isPublicReview = review instanceof PublicReview;
                                boolean isAnonymous = isPublicReview && ((PublicReview) review).isAnonymous();
                                Student student = studentMap.get(review.getStudentId());

                                if (student == null) continue;
                        %>
                        <div class="bg-blue-50 p-4 rounded-lg mb-4">
                            <div class="flex items-center justify-between mb-2">
                                <div class="flex items-center">
                                    <% if (isAnonymous) { %>
                                    <div class="flex-shrink-0 flex items-center justify-center bg-gray-200 rounded-full w-8 h-8 mr-3">
                                        <i class="fas fa-user-secret text-gray-500 text-sm"></i>
                                    </div>
                                    <div>
                                        <p class="font-medium text-gray-700">Anonymous</p>
                                    <% } else { %>
                                    <div class="flex-shrink-0 flex items-center justify-center bg-purple-100 rounded-full w-8 h-8 mr-3">
                                        <span class="text-purple-800 font-bold"><%= student.getName().substring(0, 1) %></span>
                                    </div>
                                    <div>
                                        <p class="font-medium text-gray-700"><%= student.getName() %></p>
                                    <% } %>
                                        <p class="text-gray-500 text-xs"><%= review.getFormattedDate() %></p>
                                    </div>
                                </div>
                                <div class="text-yellow-400">
                                    <%= review.getStarRating() %>
                                </div>
                            </div>
                            <p class="text-gray-700 mt-2"><%= review.getComment() %></p>
                            <div class="mt-2 text-right">
                                <a href="view-review?id=<%= review.getId() %>" class="text-blue-600 hover:underline text-sm">
                                    View Details
                                </a>
                            </div>
                        </div>
                        <% }
                           if (reviews.size() > 3) {
                        %>
                        <div class="text-center mt-4">
                            <a href="tutor-reviews?id=<%= tutor.getId() %>" class="text-blue-600 hover:underline">
                                View All <%= reviews.size() %> Reviews
                            </a>
                        </div>
                        <% }
                        } %>
                    </div>

                    <div class="mt-8 flex flex-col md:flex-row justify-center md:justify-end space-y-4 md:space-y-0 md:space-x-4">
                        <% if (tutor.isAvailable()) { %>
                        <a href="create-booking?tutorId=<%= tutor.getId() %>" class="bg-green-600 hover:bg-green-700 text-white text-center font-medium py-2 px-6 rounded transition duration-300">
                            Book Now
                        </a>
                        <% } %>
                        <a href="submit-review?tutorId=<%= tutor.getId() %>" class="bg-purple-600 hover:bg-purple-700 text-white text-center font-medium py-2 px-6 rounded transition duration-300">
                            Write a Review
                        </a>
                        <a href="update-tutor?id=<%= tutor.getId() %>" class="bg-yellow-500 hover:bg-yellow-600 text-white text-center font-medium py-2 px-6 rounded transition duration-300">
                            Edit Profile
                        </a>
                        <a href="delete-tutor?id=<%= tutor.getId() %>" class="bg-red-600 hover:bg-red-700 text-white text-center font-medium py-2 px-6 rounded transition duration-300"
                           onclick="return confirm('Are you sure you want to delete this tutor?')">
                            Delete Profile
                        </a>
                        <a href="tutor-search.jsp" class="bg-gray-600 hover:bg-gray-700 text-white text-center font-medium py-2 px-6 rounded transition duration-300">
                            Back to Search
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
