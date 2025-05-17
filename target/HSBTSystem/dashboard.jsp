<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.service.TutorManagementService" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.util.stream.Collectors" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">System Dashboard</p>
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

    <%
    // Get tutor data
    TutorManagementService tutorService = TutorManagementService.getInstance();
    List<Tutor> tutors = tutorService.getAllTutors();
    
    // Calculate statistics
    int totalTutors = tutors.size();
    int availableTutors = 0;
    double avgRating = 0;
    double avgHourlyRate = 0;
    int totalExperience = 0;
    
    // Subject count map
    Map<String, Integer> subjectCounts = new HashMap<>();
    
    // Highest rated tutor
    Tutor highestRatedTutor = null;
    
    for (Tutor tutor : tutors) {
        if (tutor.isAvailable()) {
            availableTutors++;
        }
        
        avgRating += tutor.getRating();
        avgHourlyRate += tutor.getHourlyRate();
        totalExperience += tutor.getYearsOfExperience();
        
        if (highestRatedTutor == null || tutor.getRating() > highestRatedTutor.getRating()) {
            highestRatedTutor = tutor;
        }
        
        String[] subjects = tutor.getSubjects();
        if (subjects != null) {
            for (String subject : subjects) {
                subjectCounts.put(subject, subjectCounts.getOrDefault(subject, 0) + 1);
            }
        }
    }
    
    // Calculate averages
    if (totalTutors > 0) {
        avgRating /= totalTutors;
        avgHourlyRate /= totalTutors;
        totalExperience /= totalTutors;
    }
    
    // Find most popular subject
    String mostPopularSubject = "";
    int maxCount = 0;
    
    for (Map.Entry<String, Integer> entry : subjectCounts.entrySet()) {
        if (entry.getValue() > maxCount) {
            maxCount = entry.getValue();
            mostPopularSubject = entry.getKey();
        }
    }
    
    // Get recent tutors (last 5)
    List<Tutor> recentTutors = tutors.stream()
        .sorted(Comparator.comparingInt(Tutor::getId).reversed())
        .limit(5)
        .collect(Collectors.toList());
    %>

    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-lg font-semibold text-gray-700">Total Tutors</h3>
                <p class="text-3xl font-bold text-blue-600 mt-2"><%= totalTutors %></p>
                <p class="text-sm text-gray-500 mt-1"><%= availableTutors %> currently available</p>
            </div>
            
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-lg font-semibold text-gray-700">Average Rating</h3>
                <p class="text-3xl font-bold text-blue-600 mt-2"><%= String.format("%.1f", avgRating) %>/5</p>
                <p class="text-sm text-gray-500 mt-1">Across all tutors</p>
            </div>
            
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-lg font-semibold text-gray-700">Average Hourly Rate</h3>
                <p class="text-3xl font-bold text-blue-600 mt-2">$<%= String.format("%.2f", avgHourlyRate) %></p>
                <p class="text-sm text-gray-500 mt-1">Per hour of tutoring</p>
            </div>
            
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-lg font-semibold text-gray-700">Most Popular Subject</h3>
                <p class="text-3xl font-bold text-blue-600 mt-2"><%= mostPopularSubject.isEmpty() ? "N/A" : mostPopularSubject %></p>
                <p class="text-sm text-gray-500 mt-1"><%= maxCount %> tutors available</p>
            </div>
        </div>
        
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-xl font-semibold mb-4">Subject Distribution</h3>
                <div class="h-64">
                    <canvas id="subjectChart"></canvas>
                </div>
            </div>
            
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-xl font-semibold mb-4">Tutor Availability</h3>
                <div class="h-64">
                    <canvas id="availabilityChart"></canvas>
                </div>
            </div>
        </div>
        
        <div class="bg-white p-6 rounded-lg shadow-md mb-8">
            <h3 class="text-xl font-semibold mb-4">Recent Tutors</h3>
            
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white">
                    <thead>
                        <tr>
                            <th class="py-2 px-4 bg-gray-100 font-semibold text-left">ID</th>
                            <th class="py-2 px-4 bg-gray-100 font-semibold text-left">Name</th>
                            <th class="py-2 px-4 bg-gray-100 font-semibold text-left">Subjects</th>
                            <th class="py-2 px-4 bg-gray-100 font-semibold text-left">Rating</th>
                            <th class="py-2 px-4 bg-gray-100 font-semibold text-left">Hourly Rate</th>
                            <th class="py-2 px-4 bg-gray-100 font-semibold text-left">Status</th>
                            <th class="py-2 px-4 bg-gray-100 font-semibold text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Tutor tutor : recentTutors) { %>
                        <tr>
                            <td class="py-2 px-4 border-b"><%= tutor.getId() %></td>
                            <td class="py-2 px-4 border-b"><%= tutor.getName() %></td>
                            <td class="py-2 px-4 border-b">
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
                            </td>
                            <td class="py-2 px-4 border-b"><%= String.format("%.1f", tutor.getRating()) %>/5</td>
                            <td class="py-2 px-4 border-b">$<%= String.format("%.2f", tutor.getHourlyRate()) %></td>
                            <td class="py-2 px-4 border-b">
                                <span class="<%= tutor.isAvailable() ? "text-green-600" : "text-red-600" %> font-medium">
                                    <%= tutor.isAvailable() ? "Available" : "Unavailable" %>
                                </span>
                            </td>
                            <td class="py-2 px-4 border-b">
                                <a href="view-tutor?id=<%= tutor.getId() %>" class="text-blue-600 hover:underline mr-2">View</a>
                                <a href="update-tutor?id=<%= tutor.getId() %>" class="text-yellow-600 hover:underline mr-2">Edit</a>
                                <a href="delete-tutor?id=<%= tutor.getId() %>" class="text-red-600 hover:underline"
                                   onclick="return confirm('Are you sure you want to delete this tutor?')">Delete</a>
                            </td>
                        </tr>
                        <% } %>
                        
                        <% if (recentTutors.isEmpty()) { %>
                        <tr>
                            <td colspan="7" class="py-4 px-4 text-center text-gray-500">No tutors found</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="text-center">
            <a href="tutor-registration.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300 inline-block">
                Register New Tutor
            </a>
            <a href="tutor-search.jsp" class="bg-green-600 hover:bg-green-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300 inline-block ml-4">
                Search Tutors
            </a>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Subject distribution chart
        const subjectCtx = document.getElementById('subjectChart').getContext('2d');
        const subjectChart = new Chart(subjectCtx, {
            type: 'bar',
            data: {
                labels: [
                    <% 
                    boolean first = true;
                    for (Map.Entry<String, Integer> entry : subjectCounts.entrySet()) {
                        if (!first) {
                            out.print(", ");
                        }
                        out.print("'" + entry.getKey() + "'");
                        first = false;
                    }
                    %>
                ],
                datasets: [{
                    label: 'Number of Tutors',
                    data: [
                        <% 
                        first = true;
                        for (Map.Entry<String, Integer> entry : subjectCounts.entrySet()) {
                            if (!first) {
                                out.print(", ");
                            }
                            out.print(entry.getValue());
                            first = false;
                        }
                        %>
                    ],
                    backgroundColor: 'rgba(59, 130, 246, 0.6)',
                    borderColor: 'rgba(59, 130, 246, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0
                        }
                    }
                }
            }
        });
        
        // Availability chart
        const availabilityCtx = document.getElementById('availabilityChart').getContext('2d');
        const availabilityChart = new Chart(availabilityCtx, {
            type: 'pie',
            data: {
                labels: ['Available', 'Unavailable'],
                datasets: [{
                    data: [<%= availableTutors %>, <%= totalTutors - availableTutors %>],
                    backgroundColor: [
                        'rgba(52, 211, 153, 0.8)',
                        'rgba(239, 68, 68, 0.8)'
                    ],
                    borderColor: [
                        'rgba(52, 211, 153, 1)',
                        'rgba(239, 68, 68, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });
    </script>
</body>
</html>
