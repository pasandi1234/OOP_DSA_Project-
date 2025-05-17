<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Review" %>
<%@ page import="com.hsbt.model.PublicReview" %>
<%@ page import="com.hsbt.model.VerifiedReview" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="com.hsbt.model.Booking" %>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Update Review" />
    <jsp:param name="subtitle" value="Update Review" />
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
            <h2 class="text-2xl font-bold mb-6">Update Review</h2>

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
            // Get the review, tutor, student, and booking from the request
            Review review = (Review) request.getAttribute("review");
            Tutor tutor = (Tutor) request.getAttribute("tutor");
            Student student = (Student) request.getAttribute("student");
            Booking booking = (Booking) request.getAttribute("booking");

            if (review == null || tutor == null || student == null) {
                // If any of the required objects is missing, show an error message
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                Review information is incomplete. Please try again.
            </div>
            <div class="text-center mt-6">
                <a href="review-list" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    View All Reviews
                </a>
            </div>
            <% } else {
                boolean isPublicReview = review instanceof PublicReview;
                boolean isVerifiedReview = review instanceof VerifiedReview;
                PublicReview publicReview = isPublicReview ? (PublicReview) review : null;
                VerifiedReview verifiedReview = isVerifiedReview ? (VerifiedReview) review : null;
            %>

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

            <!-- Review Update Form -->
            <form action="update-review" method="post" class="space-y-6">
                <!-- Hidden fields -->
                <input type="hidden" name="id" value="<%= review.getId() %>">

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
                    <input type="hidden" id="ratingInput" name="rating" value="<%= review.getRating() %>">
                    <p class="text-sm text-gray-500 mt-1">Click on a star to rate</p>
                </div>

                <!-- Comment -->
                <div>
                    <label for="comment" class="block text-gray-700 font-medium mb-2">Review Comment</label>
                    <textarea id="comment" name="comment" rows="5" required
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"><%= review.getComment() %></textarea>
                </div>

                <!-- Approval Status -->
                <div>
                    <label class="inline-flex items-center">
                        <input type="checkbox" name="isApproved" <%= review.isApproved() ? "checked" : "" %> class="form-checkbox text-blue-600">
                        <span class="ml-2">Approved for Public Display</span>
                    </label>
                    <p class="text-sm text-gray-500 mt-1">Only approved reviews are visible to users and affect tutor ratings</p>
                </div>

                <% if (isPublicReview) { %>
                <!-- Public Review Specific Fields -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-lg font-semibold mb-4">Public Review Settings</h3>

                    <div>
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="isAnonymous" <%= publicReview.isAnonymous() ? "checked" : "" %> class="form-checkbox text-blue-600">
                            <span class="ml-2">Post Anonymously</span>
                        </label>
                        <p class="text-sm text-gray-500 mt-1">Your name will not be displayed with the review</p>
                    </div>

                    <div class="mt-4">
                        <p class="text-gray-700 font-medium">Helpfulness Votes</p>
                        <p class="text-gray-600">Helpful: <%= publicReview.getHelpfulVotes() %></p>
                        <p class="text-gray-600">Unhelpful: <%= publicReview.getUnhelpfulVotes() %></p>
                        <% if (publicReview.getTotalVotes() > 0) { %>
                        <div class="mt-2">
                            <div class="w-full bg-gray-200 rounded-full h-2.5">
                                <div class="bg-green-600 h-2.5 rounded-full" style="width: <%= publicReview.getHelpfulnessPercentage() %>%"></div>
                            </div>
                            <p class="text-xs text-gray-500 mt-1"><%= publicReview.getHelpfulnessPercentage() %>% of users found this review helpful</p>
                        </div>
                        <% } %>
                    </div>
                </div>
                <% } %>

                <% if (isVerifiedReview) { %>
                <!-- Verified Review Specific Fields -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-lg font-semibold mb-4">Verification Details</h3>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="verificationMethod" class="block text-gray-700 font-medium mb-2">Verification Method</label>
                            <input type="text" id="verificationMethod" name="verificationMethod" value="<%= verifiedReview.getVerificationMethod() %>"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>

                        <div>
                            <label for="verifiedBy" class="block text-gray-700 font-medium mb-2">Verified By</label>
                            <input type="text" id="verifiedBy" name="verifiedBy" value="<%= verifiedReview.getVerifiedBy() %>"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <div class="mt-4">
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="hasAttachments" <%= verifiedReview.hasAttachments() ? "checked" : "" %> class="form-checkbox text-blue-600">
                            <span class="ml-2">Has Attachments</span>
                        </label>
                    </div>

                    <div class="mt-4">
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="updateVerificationDate" class="form-checkbox text-blue-600">
                            <span class="ml-2">Update Verification Date to Today</span>
                        </label>
                        <p class="text-sm text-gray-500 mt-1">Current verification date: <%= verifiedReview.getFormattedVerificationDate() %></p>
                    </div>
                </div>
                <% } %>

                <div class="text-center">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                        Update Review
                    </button>
                    <a href="view-review?id=<%= review.getId() %>" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                        Cancel
                    </a>
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
            const initialRating = parseFloat(ratingInput.value);

            // Set initial rating
            updateStars(initialRating);

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
                    const currentRating = parseFloat(ratingInput.value);
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
