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
    <title>Registration Successful - EduBridge</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">EduBridge</h1>
            <p class="text-center mt-2">Find the perfect tutor for your educational needs</p>
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
        <div class="max-w-3xl mx-auto bg-white rounded-lg shadow-md p-8">
            <%
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
            Student student = (Student) request.getAttribute("student");
            if (student != null) {
            %>
            
            <div class="bg-blue-50 p-6 rounded-lg">
                <h3 class="text-xl font-bold mb-4">Student Profile Details</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="font-medium">ID:</p>
                        <p class="text-gray-700 mb-2"><%= student.getId() %></p>
                        
                        <p class="font-medium">Name:</p>
                        <p class="text-gray-700 mb-2"><%= student.getName() %></p>
                        
                        <p class="font-medium">Email:</p>
                        <p class="text-gray-700 mb-2"><%= student.getEmail() %></p>
                        
                        <p class="font-medium">Phone:</p>
                        <p class="text-gray-700 mb-2"><%= student.getPhone() %></p>
                    </div>
                    
                    <div>
                        <p class="font-medium">Address:</p>
                        <p class="text-gray-700 mb-2"><%= student.getAddress() %></p>
                        
                        <p class="font-medium">Education Level:</p>
                        <p class="text-gray-700 mb-2"><%= student.getEducationLevel() %></p>
                        
                        <p class="font-medium">Status:</p>
                        <p class="text-gray-700 mb-2"><%= student.isActive() ? "Active" : "Inactive" %></p>
                    </div>
                </div>
                
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">Preferred Subjects</h4>
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
                
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <h4 class="font-medium mb-2">Scheduling Preferences</h4>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p class="font-medium">Preferred Days:</p>
                            <p class="text-gray-700 mb-2">
                                <% 
                                String[] days = student.getPreferredDays();
                                if (days != null && days.length > 0) {
                                    for (int i = 0; i < days.length; i++) {
                                        out.print(days[i]);
                                        if (i < days.length - 1) {
                                            out.print(", ");
                                        }
                                    }
                                } else {
                                    out.print("None specified");
                                }
                                %>
                            </p>
                        </div>
                        
                        <div>
                            <p class="font-medium">Preferred Time Slot:</p>
                            <p class="text-gray-700 mb-2"><%= student.getPreferredTimeSlot() %></p>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            
            <div class="mt-8 text-center">
                <a href="tutor-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300 inline-block">
                    Search Tutors
                </a>
                <a href="student-registration.jsp" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300 inline-block ml-4">
                    Register Another Student
                </a>
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
