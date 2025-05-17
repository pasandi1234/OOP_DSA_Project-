<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Student" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Student Profile</p>
        </div>
    </header>

    <nav class="bg-blue-800 text-white py-3">
        <div class="container mx-auto px-4 flex justify-center space-x-6">
            <a href="index.jsp" class="hover:underline font-medium">Home</a>
            <a href="tutor-registration.jsp" class="hover:underline font-medium">Register as Tutor</a>
            <a href="student-registration.jsp" class="hover:underline font-medium">Register as Student</a>
            <a href="tutor-search.jsp" class="hover:underline font-medium">Search Tutors</a>
            <a href="student-search.jsp" class="hover:underline font-medium">Search Students</a>
            <a href="dashboard.jsp" class="hover:underline font-medium">Dashboard</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <% 
        // Get the student from the request
        Student student = (Student) request.getAttribute("student");
        
        if (student == null) {
            // If no student is found, show an error message
        %>
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                Student not found. Please try again.
            </div>
            <div class="text-center mt-6">
                <a href="student-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    Back to Search
                </a>
            </div>
        </div>
        <% } else { %>
        <div class="max-w-4xl mx-auto">
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <div class="p-6">
                    <div class="flex flex-col md:flex-row">
                        <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-32 h-32 md:mr-8 mb-4 md:mb-0 mx-auto md:mx-0">
                            <span class="text-blue-800 text-4xl font-bold"><%= student.getName().substring(0, 1) %></span>
                        </div>
                        <div class="flex-grow text-center md:text-left">
                            <h2 class="text-2xl font-bold"><%= student.getName() %></h2>
                            <p class="text-gray-600 text-lg"><%= student.getEducationLevel() %></p>
                            <p class="<%= student.isActive() ? "text-green-600" : "text-red-600" %> font-medium mt-2">
                                <%= student.isActive() ? "Active" : "Inactive" %>
                            </p>
                        </div>
                    </div>
                    
                    <div class="mt-8 grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="bg-blue-50 p-4 rounded-lg">
                            <h3 class="text-xl font-semibold mb-4">Contact Information</h3>
                            <p><span class="font-medium">Email:</span> <%= student.getEmail() %></p>
                            <p><span class="font-medium">Phone:</span> <%= student.getPhone() %></p>
                            <p><span class="font-medium">Address:</span> <%= student.getAddress() %></p>
                        </div>
                        
                        <div class="bg-blue-50 p-4 rounded-lg">
                            <h3 class="text-xl font-semibold mb-4">Educational Details</h3>
                            <p><span class="font-medium">Education Level:</span> <%= student.getEducationLevel() %></p>
                            <p><span class="font-medium">Student ID:</span> <%= student.getId() %></p>
                        </div>
                        
                        <div class="bg-blue-50 p-4 rounded-lg md:col-span-2">
                            <h3 class="text-xl font-semibold mb-4">Preferred Subjects</h3>
                            <div class="flex flex-wrap gap-2">
                                <% 
                                String[] subjects = student.getPreferredSubjects();
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
                        
                        <div class="bg-blue-50 p-4 rounded-lg md:col-span-2">
                            <h3 class="text-xl font-semibold mb-4">Scheduling Preferences</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <p><span class="font-medium">Preferred Days:</span></p>
                                    <div class="flex flex-wrap gap-2 mt-2">
                                        <% 
                                        String[] days = student.getPreferredDays();
                                        if (days != null && days.length > 0) {
                                            for (String day : days) {
                                        %>
                                        <span class="bg-green-200 text-green-800 px-3 py-1 rounded-full"><%= day %></span>
                                        <% 
                                            }
                                        } else {
                                        %>
                                        <p class="text-gray-600">No preferred days specified</p>
                                        <% } %>
                                    </div>
                                </div>
                                <div>
                                    <p><span class="font-medium">Preferred Time Slot:</span></p>
                                    <div class="mt-2">
                                        <span class="bg-purple-200 text-purple-800 px-3 py-1 rounded-full"><%= student.getPreferredTimeSlot() %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-8 flex flex-col md:flex-row justify-center md:justify-end space-y-4 md:space-y-0 md:space-x-4">
                        <a href="update-student?id=<%= student.getId() %>" class="bg-yellow-500 hover:bg-yellow-600 text-white text-center font-medium py-2 px-6 rounded transition duration-300">
                            Edit Profile
                        </a>
                        <a href="delete-student?id=<%= student.getId() %>" class="bg-red-600 hover:bg-red-700 text-white text-center font-medium py-2 px-6 rounded transition duration-300"
                           onclick="return confirm('Are you sure you want to delete this student?')">
                            Delete Profile
                        </a>
                        <a href="student-search.jsp" class="bg-gray-600 hover:bg-gray-700 text-white text-center font-medium py-2 px-6 rounded transition duration-300">
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
