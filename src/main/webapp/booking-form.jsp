<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="com.hsbt.service.StudentManagementService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Tutor - EduBridge</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">EduBridge</h1>
            <p class="text-center mt-2">Book a Tutoring Session</p>
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
            <h2 class="text-2xl font-bold text-center mb-6">Book a Tutoring Session</h2>
            
            <% 

            Tutor tutor = (Tutor) request.getAttribute("tutor");
            
            if (tutor == null) {

            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                No tutor selected. Please select a tutor first.
            </div>
            <div class="text-center mt-6">
                <a href="tutor-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    Search Tutors
                </a>
            </div>
            <% } else { 

                StudentManagementService studentService = StudentManagementService.getInstance();
                List<Student> students = studentService.getAllStudents();
                

                LocalDate today = LocalDate.now();
                String todayStr = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                

                String error = (String) request.getAttribute("error");
                if (error != null && !error.isEmpty()) {
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= error %>
            </div>
            <% } %>
            

            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <h3 class="text-xl font-semibold mb-2">Selected Tutor</h3>
                <div class="flex flex-col md:flex-row items-center">
                    <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-24 h-24 md:mr-6 mb-4 md:mb-0">
                        <span class="text-blue-800 text-2xl font-bold"><%= tutor.getName().substring(0, 1) %></span>
                    </div>
                    <div>
                        <h4 class="text-lg font-bold"><%= tutor.getName() %></h4>
                        <p class="text-gray-600">Subjects: <%= String.join(", ", tutor.getSubjects()) %></p>
                        <p class="text-gray-600">Rating: <%= tutor.getRating() %>/5.0</p>
                        <p class="text-gray-600">Hourly Rate: $<%= String.format("%.2f", tutor.getHourlyRate()) %></p>
                        <p class="text-gray-600">Experience: <%= tutor.getYearsOfExperience() %> years</p>
                    </div>
                </div>
            </div>
            

            <form action="create-booking" method="post" class="space-y-6">

                <input type="hidden" name="tutorId" value="<%= tutor.getId() %>">
                

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label for="studentId" class="block text-gray-700 font-medium mb-2">Student</label>
                        <select id="studentId" name="studentId" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">Select Student</option>
                            <% for (Student student : students) { %>
                            <option value="<%= student.getId() %>"><%= student.getName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <label for="subject" class="block text-gray-700 font-medium mb-2">Subject</label>
                        <select id="subject" name="subject" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">Select Subject</option>
                            <% for (String subject : tutor.getSubjects()) { %>
                            <option value="<%= subject %>"><%= subject %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label for="date" class="block text-gray-700 font-medium mb-2">Date</label>
                        <input type="date" id="date" name="date" min="<%= todayStr %>" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label for="startTime" class="block text-gray-700 font-medium mb-2">Start Time</label>
                        <input type="time" id="startTime" name="startTime" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label for="endTime" class="block text-gray-700 font-medium mb-2">End Time</label>
                        <input type="time" id="endTime" name="endTime" required
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>
                

                <div class="border-t border-gray-200 pt-4">
                    <label class="block text-gray-700 font-medium mb-2">Booking Type</label>
                    <div class="flex space-x-4">
                        <label class="inline-flex items-center">
                            <input type="radio" name="bookingType" value="online" checked
                                class="form-radio text-blue-600" onclick="toggleBookingType('online')">
                            <span class="ml-2">Online Session</span>
                        </label>
                        <label class="inline-flex items-center">
                            <input type="radio" name="bookingType" value="inperson"
                                class="form-radio text-blue-600" onclick="toggleBookingType('inperson')">
                            <span class="ml-2">In-Person Session</span>
                        </label>
                    </div>
                </div>
                

                <div id="onlineDetails" class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-lg font-semibold mb-4">Online Session Details</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="platform" class="block text-gray-700 font-medium mb-2">Platform</label>
                            <select id="platform" name="platform"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="Zoom">Zoom</option>
                                <option value="Google Meet">Google Meet</option>
                                <option value="Microsoft Teams">Microsoft Teams</option>
                                <option value="Skype">Skype</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div>
                            <label for="meetingLink" class="block text-gray-700 font-medium mb-2">Meeting Link</label>
                            <input type="text" id="meetingLink" name="meetingLink" placeholder="https://..."
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="meetingId" class="block text-gray-700 font-medium mb-2">Meeting ID</label>
                            <input type="text" id="meetingId" name="meetingId" placeholder="Optional"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
                            <input type="text" id="password" name="password" placeholder="Optional"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>
                    <div class="mt-4">
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="recordingRequested" class="form-checkbox text-blue-600">
                            <span class="ml-2">Request session recording</span>
                        </label>
                    </div>
                </div>
                

                <div id="inPersonDetails" class="bg-blue-50 p-4 rounded-lg hidden">
                    <h3 class="text-lg font-semibold mb-4">In-Person Session Details</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="location" class="block text-gray-700 font-medium mb-2">Location Type</label>
                            <select id="location" name="location"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="Student's Home">Student's Home</option>
                                <option value="Tutor's Office">Tutor's Office</option>
                                <option value="Library">Library</option>
                                <option value="School">School</option>
                                <option value="Cafe">Cafe</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div>
                            <label for="address" class="block text-gray-700 font-medium mb-2">Address</label>
                            <input type="text" id="address" name="address" placeholder="Full address"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>
                    <div class="mt-4 grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="inline-flex items-center">
                                <input type="checkbox" name="materialsProvided" class="form-checkbox text-blue-600">
                                <span class="ml-2">Materials provided by tutor</span>
                            </label>
                        </div>
                        <div>
                            <label class="inline-flex items-center">
                                <input type="checkbox" name="travelFeeApplied" id="travelFeeApplied" class="form-checkbox text-blue-600" onchange="toggleTravelFee()">
                                <span class="ml-2">Travel fee applies</span>
                            </label>
                        </div>
                    </div>
                    <div id="travelFeeSection" class="mt-4 hidden">
                        <label for="travelFee" class="block text-gray-700 font-medium mb-2">Travel Fee ($)</label>
                        <input type="number" id="travelFee" name="travelFee" min="0" step="0.01" value="0"
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>
                

                <div>
                    <label for="notes" class="block text-gray-700 font-medium mb-2">Additional Notes</label>
                    <textarea id="notes" name="notes" rows="3" placeholder="Any special requests or information for the tutor"
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                </div>
                

                <div class="bg-yellow-50 p-4 rounded-lg">
                    <h3 class="text-lg font-semibold mb-2">Price Estimate</h3>
                    <p class="text-gray-700">Hourly Rate: $<%= String.format("%.2f", tutor.getHourlyRate()) %></p>
                    <p class="text-gray-700">Duration: <span id="durationText">0</span> hours</p>
                    <p class="text-gray-700">Base Price: $<span id="basePrice">0.00</span></p>
                    <p id="travelFeeText" class="text-gray-700 hidden">Travel Fee: $<span id="travelFeeAmount">0.00</span></p>
                    <p class="text-gray-700 font-bold">Total Estimated Price: $<span id="totalPrice">0.00</span></p>
                </div>
                
                <div class="text-center">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                        Book Session
                    </button>
                    <a href="tutor-search.jsp" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                        Cancel
                    </a>
                </div>
            </form>
            <% } %>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2025 EduBridge. All rights reserved.</p>
        </div>
    </footer>

    <script>

        function toggleBookingType(type) {
            if (type === 'online') {
                document.getElementById('onlineDetails').classList.remove('hidden');
                document.getElementById('inPersonDetails').classList.add('hidden');
                document.getElementById('travelFeeText').classList.add('hidden');
                updatePriceEstimate();
            } else {
                document.getElementById('onlineDetails').classList.add('hidden');
                document.getElementById('inPersonDetails').classList.remove('hidden');
                toggleTravelFee();
                updatePriceEstimate();
            }
        }
        

        function toggleTravelFee() {
            const travelFeeApplied = document.getElementById('travelFeeApplied').checked;
            const travelFeeSection = document.getElementById('travelFeeSection');
            const travelFeeText = document.getElementById('travelFeeText');
            
            if (travelFeeApplied) {
                travelFeeSection.classList.remove('hidden');
                travelFeeText.classList.remove('hidden');
            } else {
                travelFeeSection.classList.add('hidden');
                travelFeeText.classList.add('hidden');
            }
            
            updatePriceEstimate();
        }
        

        function updatePriceEstimate() {
            const hourlyRate = <%= tutor.getHourlyRate() %>;
            const startTime = document.getElementById('startTime').value;
            const endTime = document.getElementById('endTime').value;
            let duration = 0;
            
            if (startTime && endTime) {
                const start = new Date(`2000-01-01T${startTime}`);
                const end = new Date(`2000-01-01T${endTime}`);
                
                if (end > start) {
                    duration = (end - start) / (1000 * 60 * 60);
                }
            }
            
            const basePrice = hourlyRate * duration;
            let travelFee = 0;
            
            if (document.getElementById('travelFeeApplied') && document.getElementById('travelFeeApplied').checked) {
                travelFee = parseFloat(document.getElementById('travelFee').value) || 0;
            }
            
            const totalPrice = basePrice + travelFee;
            
            document.getElementById('durationText').textContent = duration.toFixed(1);
            document.getElementById('basePrice').textContent = basePrice.toFixed(2);
            document.getElementById('travelFeeAmount').textContent = travelFee.toFixed(2);
            document.getElementById('totalPrice').textContent = totalPrice.toFixed(2);
        }
        

        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('startTime').addEventListener('change', updatePriceEstimate);
            document.getElementById('endTime').addEventListener('change', updatePriceEstimate);
            
            if (document.getElementById('travelFee')) {
                document.getElementById('travelFee').addEventListener('input', updatePriceEstimate);
            }
        });
    </script>
</body>
</html>
