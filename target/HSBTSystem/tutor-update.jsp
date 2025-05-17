<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.OnlineTutor" %>
<%@ page import="com.hsbt.model.InPersonTutor" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Tutor - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Update Tutor Information</p>
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
        <% 
        // Get the tutor from the request
        Tutor tutor = (Tutor) request.getAttribute("tutor");
        
        if (tutor == null) {
            // If no tutor is provided, show an error message
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
            // Determine tutor type
            String tutorType = "base";
            OnlineTutor onlineTutor = null;
            InPersonTutor inPersonTutor = null;
            
            if (tutor instanceof OnlineTutor) {
                tutorType = "online";
                onlineTutor = (OnlineTutor) tutor;
            } else if (tutor instanceof InPersonTutor) {
                tutorType = "inperson";
                inPersonTutor = (InPersonTutor) tutor;
            }
        %>
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <h2 class="text-2xl font-bold text-center mb-6">Update Tutor Information</h2>
            
            <!-- Display error message if any -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="update-tutor" method="post" class="space-y-6">
                <!-- Hidden ID field -->
                <input type="hidden" name="id" value="<%= tutor.getId() %>">
                
                <!-- Personal Information Section -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Personal Information</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="name" class="block text-gray-700 font-medium mb-2">Full Name</label>
                            <input type="text" id="name" name="name" value="<%= tutor.getName() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="email" class="block text-gray-700 font-medium mb-2">Email Address</label>
                            <input type="email" id="email" name="email" value="<%= tutor.getEmail() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="phone" class="block text-gray-700 font-medium mb-2">Phone Number</label>
                            <input type="tel" id="phone" name="phone" value="<%= tutor.getPhone() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>
                </div>

                <!-- Professional Information Section -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Professional Information</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="subjects" class="block text-gray-700 font-medium mb-2">Subjects (Select multiple)</label>
                            <select id="subjects" name="subjects" multiple required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" size="5">
                                <% 
                                String[] allSubjects = {"Mathematics", "Physics", "Chemistry", "Biology", "Computer Science", 
                                                      "English", "History", "Geography", "Foreign Languages", "Music", "Art"};
                                String[] tutorSubjects = tutor.getSubjects();
                                
                                for (String subject : allSubjects) {
                                    boolean selected = false;
                                    if (tutorSubjects != null) {
                                        for (String tutorSubject : tutorSubjects) {
                                            if (subject.equals(tutorSubject)) {
                                                selected = true;
                                                break;
                                            }
                                        }
                                    }
                                %>
                                <option value="<%= subject %>" <%= selected ? "selected" : "" %>><%= subject %></option>
                                <% } %>
                            </select>
                            <p class="text-sm text-gray-500 mt-1">Hold Ctrl (or Cmd) to select multiple subjects</p>
                        </div>
                        <div>
                            <div class="mb-4">
                                <label for="experience" class="block text-gray-700 font-medium mb-2">Years of Experience</label>
                                <input type="number" id="experience" name="experience" min="0" value="<%= tutor.getYearsOfExperience() %>" required
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label for="hourlyRate" class="block text-gray-700 font-medium mb-2">Hourly Rate ($)</label>
                                <input type="number" id="hourlyRate" name="hourlyRate" min="0" step="0.01" value="<%= tutor.getHourlyRate() %>" required
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div class="mt-4">
                                <label class="block text-gray-700 font-medium mb-2">Availability</label>
                                <div class="flex space-x-4">
                                    <label class="inline-flex items-center">
                                        <input type="radio" name="available" value="true" <%= tutor.isAvailable() ? "checked" : "" %>
                                            class="form-radio text-blue-600">
                                        <span class="ml-2">Available</span>
                                    </label>
                                    <label class="inline-flex items-center">
                                        <input type="radio" name="available" value="false" <%= !tutor.isAvailable() ? "checked" : "" %>
                                            class="form-radio text-blue-600">
                                        <span class="ml-2">Unavailable</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tutor Type Specific Fields -->
                <% if ("online".equals(tutorType) && onlineTutor != null) { %>
                <!-- Online Tutor Fields -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Online Tutoring Details</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="platform" class="block text-gray-700 font-medium mb-2">Preferred Platform</label>
                            <select id="platform" name="platform"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="Zoom" <%= "Zoom".equals(onlineTutor.getPlatformPreference()) ? "selected" : "" %>>Zoom</option>
                                <option value="Google Meet" <%= "Google Meet".equals(onlineTutor.getPlatformPreference()) ? "selected" : "" %>>Google Meet</option>
                                <option value="Microsoft Teams" <%= "Microsoft Teams".equals(onlineTutor.getPlatformPreference()) ? "selected" : "" %>>Microsoft Teams</option>
                                <option value="Skype" <%= "Skype".equals(onlineTutor.getPlatformPreference()) ? "selected" : "" %>>Skype</option>
                                <option value="Other" <%= !"Zoom".equals(onlineTutor.getPlatformPreference()) && 
                                                          !"Google Meet".equals(onlineTutor.getPlatformPreference()) && 
                                                          !"Microsoft Teams".equals(onlineTutor.getPlatformPreference()) && 
                                                          !"Skype".equals(onlineTutor.getPlatformPreference()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div>
                            <label for="timezone" class="block text-gray-700 font-medium mb-2">Time Zone</label>
                            <select id="timezone" name="timezone"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <% 
                                String[] timeZones = {"GMT-12", "GMT-11", "GMT-10", "GMT-9", "GMT-8", "GMT-7", "GMT-6", "GMT-5", 
                                                     "GMT-4", "GMT-3", "GMT-2", "GMT-1", "GMT", "GMT+1", "GMT+2", "GMT+3", 
                                                     "GMT+4", "GMT+5", "GMT+6", "GMT+7", "GMT+8", "GMT+9", "GMT+10", "GMT+11", "GMT+12"};
                                for (String tz : timeZones) {
                                %>
                                <option value="<%= tz %>" <%= tz.equals(onlineTutor.getTimeZone()) ? "selected" : "" %>><%= tz %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-span-1 md:col-span-2">
                            <div class="flex space-x-4">
                                <label class="inline-flex items-center">
                                    <input type="checkbox" name="webcam" value="true" <%= onlineTutor.hasWebcam() ? "checked" : "" %>
                                        class="form-checkbox text-blue-600">
                                    <span class="ml-2">Has Webcam</span>
                                </label>
                                <label class="inline-flex items-center">
                                    <input type="checkbox" name="recordings" value="true" <%= onlineTutor.providesRecordings() ? "checked" : "" %>
                                        class="form-checkbox text-blue-600">
                                    <span class="ml-2">Provides Recordings</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <% } else if ("inperson".equals(tutorType) && inPersonTutor != null) { %>
                <!-- In-Person Tutor Fields -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">In-Person Tutoring Details</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="location" class="block text-gray-700 font-medium mb-2">Primary Location</label>
                            <input type="text" id="location" name="location" value="<%= inPersonTutor.getLocation() %>"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="travelRadius" class="block text-gray-700 font-medium mb-2">Travel Radius (km)</label>
                            <input type="number" id="travelRadius" name="travelRadius" min="0" value="<%= inPersonTutor.getTravelRadius() %>"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div class="col-span-1 md:col-span-2">
                            <div class="flex space-x-4">
                                <label class="inline-flex items-center">
                                    <input type="checkbox" name="travelToStudent" value="true" <%= inPersonTutor.isTravelToStudent() ? "checked" : "" %>
                                        class="form-checkbox text-blue-600">
                                    <span class="ml-2">Willing to travel to student's location</span>
                                </label>
                                <label class="inline-flex items-center">
                                    <input type="checkbox" name="materials" value="true" <%= inPersonTutor.isProvidesLearningMaterials() ? "checked" : "" %>
                                        class="form-checkbox text-blue-600">
                                    <span class="ml-2">Provides learning materials</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>

                <div class="text-center">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                        Update Tutor
                    </button>
                    <a href="tutor-search.jsp" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                        Cancel
                    </a>
                </div>
            </form>
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
