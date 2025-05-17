<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="com.hsbt.model.Booking" %>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Submit Review" />
    <jsp:param name="subtitle" value="Submit Review" />
    <jsp:param name="extraHead" value="
        <style>
            .star-rating {
                font-size: 1.5rem;
                color: #d1d5db;
                cursor: pointer;
            }
            .star-rating .star {
                display: inline-block;
                transition: color 0.2s;
            }
            .star-rating .star.active {
                color: #fbbf24;
            }
            body.dark-mode .star-rating {
                color: #4b5563;
            }
            body.dark-mode .star-rating .star.active {
                color: #ffc107;
            }
        </style>
    " />
</jsp:include>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <h2 class="text-2xl font-bold mb-6">Submit a Review</h2>

            <%
            // Get error message if any
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= error %>
            </div>
            <% } %>

            <%
            // Get the tutor, student, and booking from the request
            Tutor tutor = (Tutor) request.getAttribute("tutor");
            Student student = (Student) request.getAttribute("student");
            Booking booking = (Booking) request.getAttribute("booking");

            if (tutor == null) {
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                Tutor information is missing. Please try again.
            </div>
            <div class="text-center mt-6">
                <a href="tutor-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    Search Tutors
                </a>
            </div>
            <% } else if (student == null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                Student information is missing. Please try again.
            </div>
            <div class="text-center mt-6">
                <a href="student-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    Search Students
                </a>
            </div>
            <% } else { %>

            <!-- Tutor Information -->
            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <h3 class="text-xl font-semibold mb-2">Tutor Information</h3>
                <div class="flex items-center">
                    <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-16 h-16 mr-4">
                        <span class="text-blue-800 text-2xl font-bold"><%= tutor.getName().substring(0, 1) %></span>
                    </div>
                    <div>
                        <p class="font-bold text-lg"><%= tutor.getName() %></p>
                        <p class="text-gray-600"><%= tutor.getSubjects() %></p>
                        <div class="flex items-center mt-1">
                            <div class="text-yellow-400 text-sm">
                                <%= tutor.getStarRating() %>
                            </div>
                            <span class="ml-1 text-gray-600"><%= tutor.getRating() %>/5</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Student Information -->
            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <h3 class="text-xl font-semibold mb-2">Student Information</h3>
                <div class="flex items-center">
                    <div class="flex-shrink-0 flex items-center justify-center bg-purple-100 rounded-full w-16 h-16 mr-4">
                        <span class="text-purple-800 text-2xl font-bold"><%= student.getName().substring(0, 1) %></span>
                    </div>
                    <div>
                        <p class="font-bold text-lg"><%= student.getName() %></p>
                        <p class="text-gray-600"><%= student.getEmail() %></p>
                    </div>
                </div>
            </div>

            <% if (booking != null) { %>
            <!-- Booking Information -->
            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <h3 class="text-xl font-semibold mb-2">Booking Information</h3>
                <p><span class="font-medium">Subject:</span> <%= booking.getSubject() %></p>
                <p><span class="font-medium">Date:</span> <%= booking.getFormattedDate() %></p>
                <p><span class="font-medium">Time:</span> <%= booking.getStartTime() %> - <%= booking.getEndTime() %></p>
                <p><span class="font-medium">Type:</span> <%= booking.getBookingType() %></p>
            </div>
            <% } %>

            <!-- Review Form -->
            <form action="submit-review" method="post" class="space-y-6">
                <!-- Hidden fields -->
                <input type="hidden" name="tutorId" value="<%= tutor.getId() %>">
                <input type="hidden" name="studentId" value="<%= student != null ? student.getId() : "" %>">
                <% if (booking != null) { %>
                <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
                <% } %>

                <!-- Rating -->
                <div>
                    <label class="block text-gray-700 font-medium mb-2">Rating</label>
                    <div class="star-rating" id="starRating">
                        <span class="star" data-value="1"><i class="fas fa-star"></i></span>
                        <span class="star" data-value="2"><i class="fas fa-star"></i></span>
                        <span class="star" data-value="3"><i class="fas fa-star"></i></span>
                        <span class="star" data-value="4"><i class="fas fa-star"></i></span>
                        <span class="star" data-value="5"><i class="fas fa-star"></i></span>
                    </div>
                    <input type="hidden" id="ratingInput" name="rating" value="5">
                    <p class="text-sm text-gray-500 mt-1">Click on a star to rate</p>
                </div>

                <!-- Comment -->
                <div>
                    <label for="comment" class="block text-gray-700 font-medium mb-2">Your Review</label>
                    <textarea id="comment" name="comment" rows="5" required
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                        placeholder="Share your experience with this tutor..."></textarea>
                </div>

                <!-- Review Type -->
                <div>
                    <label class="block text-gray-700 font-medium mb-2">Review Type</label>
                    <div class="flex space-x-4">
                        <label class="inline-flex items-center">
                            <input type="radio" name="reviewType" value="public" checked
                                class="form-radio text-blue-600">
                            <span class="ml-2">Public Review</span>
                        </label>
                        <% if (booking != null) { %>
                        <label class="inline-flex items-center">
                            <input type="radio" name="reviewType" value="verified"
                                class="form-radio text-blue-600">
                            <span class="ml-2">Verified Review (Based on Booking)</span>
                        </label>
                        <% } %>
                    </div>
                </div>

                <!-- Anonymous Option (for public reviews) -->
                <div>
                    <label class="inline-flex items-center">
                        <input type="checkbox" name="isAnonymous" class="form-checkbox text-blue-600">
                        <span class="ml-2">Post Anonymously</span>
                    </label>
                    <p class="text-sm text-gray-500 mt-1">Your name will not be displayed with the review</p>
                </div>

                <div class="text-center">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                        Submit Review
                    </button>
                    <% if (booking != null) { %>
                    <a href="view-booking?id=<%= booking.getId() %>" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                        Cancel
                    </a>
                    <% } else { %>
                    <a href="view-tutor?id=<%= tutor.getId() %>" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                        Cancel
                    </a>
                    <% } %>
                </div>
            </form>
            <% } %>
        </div>
    </div>

    <script>
        // Star rating functionality
        document.addEventListener('DOMContentLoaded', function() {
            const stars = document.querySelectorAll('.star');
            const ratingInput = document.getElementById('ratingInput');

            // Set initial rating (5 stars)
            updateStars(5);

            stars.forEach(star => {
                star.addEventListener('click', function() {
                    const value = parseInt(this.getAttribute('data-value'));
                    ratingInput.value = value;
                    updateStars(value);
                });

                star.addEventListener('mouseover', function() {
                    const value = parseInt(this.getAttribute('data-value'));
                    highlightStars(value);
                });

                star.addEventListener('mouseout', function() {
                    const currentRating = parseInt(ratingInput.value);
                    updateStars(currentRating);
                });
            });

            function updateStars(value) {
                stars.forEach(star => {
                    const starValue = parseInt(star.getAttribute('data-value'));
                    if (starValue <= value) {
                        star.classList.add('active');
                    } else {
                        star.classList.remove('active');
                    }
                });
            }

            function highlightStars(value) {
                stars.forEach(star => {
                    const starValue = parseInt(star.getAttribute('data-value'));
                    if (starValue <= value) {
                        star.classList.add('active');
                    } else {
                        star.classList.remove('active');
                    }
                });
            }
        });
    </script>
<jsp:include page="includes/footer.jsp" />
