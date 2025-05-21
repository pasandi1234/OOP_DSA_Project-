<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.OnlineTutor" %>
<%@ page import="com.hsbt.model.InPersonTutor" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - EduBridge</title>
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
            <a href="tutor-search.jsp" class="hover:underline font-medium">Search Tutors</a>
            <a href="dashboard.jsp" class="hover:underline font-medium">Dashboard</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-6xl mx-auto">
            <h2 class="text-2xl font-bold mb-6">Search Results</h2>

            <!-- Sorting Controls -->
            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <form action="search-tutors" method="get" class="flex flex-wrap items-end gap-4">
                    <!-- Preserve the current search parameters -->
                    <input type="hidden" name="searchType" value="<%= request.getParameter("searchType") != null ? request.getParameter("searchType") : "available" %>">
                    <input type="hidden" name="query" value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
                    <% if (request.getParameter("tutorType") != null) { %>
                    <input type="hidden" name="tutorType" value="<%= request.getParameter("tutorType") %>">
                    <% } %>
                    <% if (request.getParameter("minExperience") != null) { %>
                    <input type="hidden" name="minExperience" value="<%= request.getParameter("minExperience") %>">
                    <% } %>
                    <% if (request.getParameter("minRating") != null) { %>
                    <input type="hidden" name="minRating" value="<%= request.getParameter("minRating") %>">
                    <% } %>

                    <div>
                        <label for="sortBy" class="block text-gray-700 font-medium mb-2">Sort By</label>
                        <select id="sortBy" name="sortBy"
                            class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="rating" <%= "rating".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Rating</option>
                            <option value="rate" <%= "rate".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Hourly Rate</option>
                            <option value="experience" <%= "experience".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Years of Experience</option>
                        </select>
                    </div>

                    <div>
                        <label for="sortOrder" class="block text-gray-700 font-medium mb-2">Sort Order</label>
                        <select id="sortOrder" name="sortOrder"
                            class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="desc" <%= "desc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Descending (High to Low)</option>
                            <option value="asc" <%= "asc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Ascending (Low to High)</option>
                        </select>
                    </div>

                    <div>
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                            Apply Sorting
                        </button>
                    </div>

                    <div class="ml-auto">
                        <a href="advanced-tutor-search.jsp" class="bg-purple-600 hover:bg-purple-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                            Advanced Search
                        </a>
                    </div>
                </form>
            </div>

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
                <a href="tutor-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Back to Search
                </a>
            </div>

            <!-- Tutor Results -->
            <div class="grid grid-cols-1 gap-6">
                <%
                List<Tutor> tutors = (List<Tutor>) request.getAttribute("tutors");
                if (tutors != null && !tutors.isEmpty()) {
                    for (Tutor tutor : tutors) {
                        String tutorType = "Base Tutor";
                        String typeSpecificInfo = "";

                        if (tutor instanceof OnlineTutor) {
                            OnlineTutor onlineTutor = (OnlineTutor) tutor;
                            tutorType = "Online Tutor";
                            typeSpecificInfo = "<p><span class=\"font-medium\">Platform:</span> " + onlineTutor.getPlatformPreference() + "</p>";
                        } else if (tutor instanceof InPersonTutor) {
                            InPersonTutor inPersonTutor = (InPersonTutor) tutor;
                            tutorType = "In-Person Tutor";
                            typeSpecificInfo = "<p><span class=\"font-medium\">Location:</span> " + inPersonTutor.getLocation() + "</p>";
                        }
                %>
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="p-6 flex flex-col md:flex-row">
                        <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-24 h-24 md:mr-6 mb-4 md:mb-0 mx-auto md:mx-0">
                            <span class="text-blue-800 text-2xl font-bold"><%= tutor.getName().substring(0, 1) %></span>
                        </div>
                        <div class="flex-grow">
                            <div class="flex flex-col md:flex-row md:justify-between md:items-start">
                                <div>
                                    <h3 class="text-xl font-bold"><%= tutor.getName() %></h3>
                                    <p class="text-gray-600">
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
                                            out.print("No subjects specified");
                                        }
                                        %>
                                    </p>
                                    <div class="flex items-center mt-1">
                                        <div class="text-yellow-400">
                                            <%= tutor.getStarRating() %>
                                        </div>
                                        <span class="ml-1 text-gray-600"><%= tutor.getRating() %>/5</span>
                                    </div>
                                    <p class="text-gray-600 mt-1"><%= tutor.getYearsOfExperience() %> years experience | $<%= tutor.getHourlyRate() %>/hour</p>
                                    <p class="<%= tutor.isAvailable() ? "text-green-600" : "text-red-600" %> font-medium">
                                        <%= tutor.isAvailable() ? "Available" : "Unavailable" %>
                                    </p>
                                    <p class="mt-2"><span class="font-medium">Type:</span> <%= tutorType %></p>
                                    <%= typeSpecificInfo %>
                                </div>
                                <div class="flex flex-col space-y-2 mt-4 md:mt-0">
                                    <a href="view-tutor?id=<%= tutor.getId() %>" class="bg-blue-600 hover:bg-blue-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        View Profile
                                    </a>
                                    <a href="create-booking?tutorId=<%= tutor.getId() %>" class="bg-green-600 hover:bg-green-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        Book Now
                                    </a>
                                    <a href="update-tutor?id=<%= tutor.getId() %>" class="bg-yellow-500 hover:bg-yellow-600 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        Edit
                                    </a>
                                    <a href="delete-tutor?id=<%= tutor.getId() %>" class="bg-red-600 hover:bg-red-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300"
                                       onclick="return confirm('Are you sure you want to delete this tutor?')">
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
                    <p class="text-gray-600">No tutors found matching your search criteria.</p>
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
