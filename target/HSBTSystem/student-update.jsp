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
    <title>Update Student - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Update Student Information</p>
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
            // If no student is provided, show an error message
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
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <h2 class="text-2xl font-bold text-center mb-6">Update Student Information</h2>
            
            <!-- Display error message if any -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="update-student" method="post" class="space-y-6">
                <!-- Hidden ID field -->
                <input type="hidden" name="id" value="<%= student.getId() %>">
                
                <!-- Personal Information Section -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Personal Information</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="name" class="block text-gray-700 font-medium mb-2">Full Name</label>
                            <input type="text" id="name" name="name" value="<%= student.getName() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="email" class="block text-gray-700 font-medium mb-2">Email Address</label>
                            <input type="email" id="email" name="email" value="<%= student.getEmail() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="phone" class="block text-gray-700 font-medium mb-2">Phone Number</label>
                            <input type="tel" id="phone" name="phone" value="<%= student.getPhone() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="address" class="block text-gray-700 font-medium mb-2">Address</label>
                            <input type="text" id="address" name="address" value="<%= student.getAddress() %>" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>
                </div>

                <!-- Educational Information Section -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Educational Information</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="educationLevel" class="block text-gray-700 font-medium mb-2">Education Level</label>
                            <select id="educationLevel" name="educationLevel" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">Select Education Level</option>
                                <option value="Elementary School" <%= "Elementary School".equals(student.getEducationLevel()) ? "selected" : "" %>>Elementary School</option>
                                <option value="Middle School" <%= "Middle School".equals(student.getEducationLevel()) ? "selected" : "" %>>Middle School</option>
                                <option value="High School" <%= "High School".equals(student.getEducationLevel()) ? "selected" : "" %>>High School</option>
                                <option value="College" <%= "College".equals(student.getEducationLevel()) ? "selected" : "" %>>College</option>
                                <option value="University" <%= "University".equals(student.getEducationLevel()) ? "selected" : "" %>>University</option>
                                <option value="Graduate" <%= "Graduate".equals(student.getEducationLevel()) ? "selected" : "" %>>Graduate</option>
                                <option value="Other" <%= "Other".equals(student.getEducationLevel()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div>
                            <label for="preferredSubjects" class="block text-gray-700 font-medium mb-2">Preferred Subjects (Select multiple)</label>
                            <select id="preferredSubjects" name="preferredSubjects" multiple required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" size="5">
                                <% 
                                String[] allSubjects = {"Mathematics", "Physics", "Chemistry", "Biology", "Computer Science", 
                                                      "English", "History", "Geography", "Foreign Languages", "Music", "Art"};
                                String[] studentSubjects = student.getPreferredSubjects();
                                
                                for (String subject : allSubjects) {
                                    boolean selected = false;
                                    if (studentSubjects != null) {
                                        for (String studentSubject : studentSubjects) {
                                            if (subject.equals(studentSubject)) {
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
                    </div>
                </div>

                <!-- Scheduling Preferences Section -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Scheduling Preferences</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-gray-700 font-medium mb-2">Preferred Days</label>
                            <div class="grid grid-cols-2 gap-2">
                                <% 
                                String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
                                String[] studentDays = student.getPreferredDays();
                                
                                for (String day : days) {
                                    boolean selected = false;
                                    if (studentDays != null) {
                                        for (String studentDay : studentDays) {
                                            if (day.equals(studentDay)) {
                                                selected = true;
                                                break;
                                            }
                                        }
                                    }
                                %>
                                <label class="inline-flex items-center">
                                    <input type="checkbox" name="preferredDays" value="<%= day %>" <%= selected ? "checked" : "" %>
                                        class="form-checkbox text-blue-600">
                                    <span class="ml-2"><%= day %></span>
                                </label>
                                <% } %>
                            </div>
                        </div>
                        <div>
                            <label for="preferredTimeSlot" class="block text-gray-700 font-medium mb-2">Preferred Time Slot</label>
                            <select id="preferredTimeSlot" name="preferredTimeSlot" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">Select Time Slot</option>
                                <option value="Morning" <%= "Morning".equals(student.getPreferredTimeSlot()) ? "selected" : "" %>>Morning (8 AM - 12 PM)</option>
                                <option value="Afternoon" <%= "Afternoon".equals(student.getPreferredTimeSlot()) ? "selected" : "" %>>Afternoon (12 PM - 4 PM)</option>
                                <option value="Evening" <%= "Evening".equals(student.getPreferredTimeSlot()) ? "selected" : "" %>>Evening (4 PM - 8 PM)</option>
                                <option value="Night" <%= "Night".equals(student.getPreferredTimeSlot()) ? "selected" : "" %>>Night (After 8 PM)</option>
                                <option value="Flexible" <%= "Flexible".equals(student.getPreferredTimeSlot()) ? "selected" : "" %>>Flexible</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Account Status Section -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Account Status</h3>
                    <div class="flex space-x-4">
                        <label class="inline-flex items-center">
                            <input type="radio" name="active" value="true" <%= student.isActive() ? "checked" : "" %>
                                class="form-radio text-blue-600">
                            <span class="ml-2">Active</span>
                        </label>
                        <label class="inline-flex items-center">
                            <input type="radio" name="active" value="false" <%= !student.isActive() ? "checked" : "" %>
                                class="form-radio text-blue-600">
                            <span class="ml-2">Inactive</span>
                        </label>
                    </div>
                </div>

                <div class="text-center">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                        Update Student
                    </button>
                    <a href="student-search.jsp" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
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
