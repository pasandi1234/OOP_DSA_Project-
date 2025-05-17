<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.*" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Find the perfect tutor for your educational needs</p>
        </div>
    </header>

    <nav class="bg-blue-800 text-white py-3">
        <div class="container mx-auto px-4 flex justify-center space-x-6">
            <a href="index.jsp" class="hover:underline font-medium">Home</a>
            <a href="tutor-registration.jsp" class="hover:underline font-medium">Register as Tutor</a>
            <a href="tutor-search.jsp" class="hover:underline font-medium">Search Tutors</a>
            <a href="dashboard.jsp" class="hover:underline font-medium">Dashboard</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-3xl mx-auto bg-white rounded-lg shadow-md p-8">
            <% 
            // Check if a message was provided
            String message = (String) request.getAttribute("message");
            if (message == null) {
                message = "Registration Successful!";
            }
            %>
            
            <div class="text-center mb-8">
                <div class="text-green-500 text-6xl mb-4">✓</div>
                <h2 class="text-2xl font-bold text-green-600"><%= message %></h2>
                <p class="text-gray-600 mt-2">Thank you for registering with the Home Tutor Search and Booking System.</p>
            </div>

            <% 
            // Get the tutor from the request
            Tutor tutor = (Tutor) request.getAttribute("tutor");
            if (tutor != null) {
                String tutorType = "Base Tutor";
                if (tutor instanceof OnlineTutor) {
                    tutorType = "Online Tutor";
                } else if (tutor instanceof InPersonTutor) {
                    tutorType = "In-Person Tutor";
                }
            %>
            
            <div class="bg-blue-50 p-6 rounded-lg">
                <h3 class="text-xl font-bold mb-4">Tutor Profile Details</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="font-medium">ID:</p>
                        <p class="text-gray-700 mb-2"><%= tutor.getId() %></p>
                        
                        <p class="font-medium">Name:</p>
                        <p class="text-gray-700 mb-2"><%= tutor.getName() %></p>
                        
                        <p class="font-medium">Email:</p>
                        <p class="text-gray-700 mb-2"><%= tutor.getEmail() %></p>
                        
                        <p class="font-medium">Phone:</p>
                        <p class="text-gray-700 mb-2"><%= tutor.getPhone() %></p>
                    </div>
                    
                    <div>
                        <p class="font-medium">Type:</p>
                        <p class="text-gray-700 mb-2"><%= tutorType %></p>
                        
                        <p class="font-medium">Subjects:</p>
                        <p class="text-gray-700 mb-2">
                            <% 
                            String[] subjects = tutor.getSubjects();
                            if (subjects != null && subjects.length > 0) {
                                for (int i = 0; i < subjects.length; i++) {
                                    out.print(subjects[i]);
                                    if (i < subjects.length - 1) {
                                        out.print(", ");
                                    }
                                }
                            } else {
                                out.print("None specified");
                            }
                            %>
                        </p>
                        
                        <p class="font-medium">Experience:</p>
                        <p class="text-gray-700 mb-2"><%= tutor.getYearsOfExperience() %> years</p>
                        
                        <p class="font-medium">Hourly Rate:</p>
                        <p class="text-gray-700 mb-2">$<%= tutor.getHourlyRate() %></p>
                    </div>
                </div>
                
                <% if (tutor instanceof OnlineTutor) { 
                    OnlineTutor onlineTutor = (OnlineTutor) tutor;
                %>
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">Online Tutoring Details</h4>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="font-medium">Platform:</p>
                            <p class="text-gray-700 mb-2"><%= onlineTutor.getPlatformPreference() %></p>
                            
                            <p class="font-medium">Time Zone:</p>
                            <p class="text-gray-700 mb-2"><%= onlineTutor.getTimeZone() %></p>
                        </div>
                        
                        <div>
                            <p class="font-medium">Has Webcam:</p>
                            <p class="text-gray-700 mb-2"><%= onlineTutor.hasWebcam() ? "Yes" : "No" %></p>
                            
                            <p class="font-medium">Provides Recordings:</p>
                            <p class="text-gray-700 mb-2"><%= onlineTutor.providesRecordings() ? "Yes" : "No" %></p>
                        </div>
                    </div>
                </div>
                <% } %>
                
                <% if (tutor instanceof InPersonTutor) { 
                    InPersonTutor inPersonTutor = (InPersonTutor) tutor;
                %>
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">In-Person Tutoring Details</h4>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="font-medium">Location:</p>
                            <p class="text-gray-700 mb-2"><%= inPersonTutor.getLocation() %></p>
                            
                            <p class="font-medium">Travel Radius:</p>
                            <p class="text-gray-700 mb-2"><%= inPersonTutor.getTravelRadius() %> km</p>
                        </div>
                        
                        <div>
                            <p class="font-medium">Travels to Student:</p>
                            <p class="text-gray-700 mb-2"><%= inPersonTutor.isTravelToStudent() ? "Yes" : "No" %></p>
                            
                            <p class="font-medium">Provides Learning Materials:</p>
                            <p class="text-gray-700 mb-2"><%= inPersonTutor.isProvidesLearningMaterials() ? "Yes" : "No" %></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
            
            <div class="mt-8 text-center">
                <a href="tutor-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300 inline-block">
                    Search Tutors
                </a>
                <a href="tutor-registration.jsp" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300 inline-block ml-4">
                    Register Another Tutor
                </a>
            </div>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
