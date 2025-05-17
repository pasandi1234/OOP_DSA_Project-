<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Search Results</p>
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
        <div class="max-w-6xl mx-auto">
            <h2 class="text-2xl font-bold mb-6">Student Search Results</h2>
            
            <!-- Display error message if any -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <!-- Display success message if any -->
            <% if (request.getAttribute("message") != null) { %>
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <!-- Back to Search button -->
            <div class="mb-6">
                <a href="student-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Back to Search
                </a>
            </div>
            
            <!-- Student Results -->
            <div class="grid grid-cols-1 gap-6">
                <% 
                List<Student> students = (List<Student>) request.getAttribute("students");
                if (students != null && !students.isEmpty()) {
                    for (Student student : students) {
                %>
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="p-6 flex flex-col md:flex-row">
                        <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-24 h-24 md:mr-6 mb-4 md:mb-0 mx-auto md:mx-0">
                            <span class="text-blue-800 text-2xl font-bold"><%= student.getName().substring(0, 1) %></span>
                        </div>
                        <div class="flex-grow">
                            <div class="flex flex-col md:flex-row md:justify-between md:items-start">
                                <div>
                                    <h3 class="text-xl font-bold"><%= student.getName() %></h3>
                                    <p class="text-gray-600"><%= student.getEducationLevel() %></p>
                                    <p class="text-gray-600 mt-1">Preferred Subjects: 
                                        <% 
                                        String[] subjects = student.getPreferredSubjects();
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
                                    <p class="text-gray-600 mt-1">Preferred Days: 
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
                                    <p class="text-gray-600">Preferred Time: <%= student.getPreferredTimeSlot() %></p>
                                    <p class="<%= student.isActive() ? "text-green-600" : "text-red-600" %> font-medium">
                                        <%= student.isActive() ? "Active" : "Inactive" %>
                                    </p>
                                </div>
                                <div class="flex flex-col space-y-2 mt-4 md:mt-0">
                                    <a href="view-student?id=<%= student.getId() %>" class="bg-blue-600 hover:bg-blue-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        View Profile
                                    </a>
                                    <a href="update-student?id=<%= student.getId() %>" class="bg-yellow-500 hover:bg-yellow-600 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        Edit
                                    </a>
                                    <a href="delete-student?id=<%= student.getId() %>" class="bg-red-600 hover:bg-red-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300"
                                       onclick="return confirm('Are you sure you want to delete this student?')">
                                        Delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% 
                    }
                } else {
                %>
                <div class="bg-white rounded-lg shadow-md p-6 text-center">
                    <p class="text-gray-600">No students found matching your search criteria.</p>
                </div>
                <% } %>
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
