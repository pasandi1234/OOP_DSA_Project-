<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Review" %>
<%@ page import="com.hsbt.model.PublicReview" %>
<%@ page import="com.hsbt.model.VerifiedReview" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="com.hsbt.model.Booking" %>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Review Details" />
    <jsp:param name="subtitle" value="Review Details" />
</jsp:include>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <%

            String message = request.getParameter("updated");
            String voted = request.getParameter("voted");
            String approved = request.getParameter("approved");
            String disapproved = request.getParameter("disapproved");
            String error = request.getParameter("error");

            if (message != null && message.equals("true")) {
            %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                Review updated successfully.
            </div>
            <% }

            if (voted != null && voted.equals("true")) {
            %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                Thank you for your feedback on this review.
            </div>
            <% }

            if (approved != null && approved.equals("true")) {
            %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                Review approved successfully.
            </div>
            <% }

            if (disapproved != null && disapproved.equals("true")) {
            %>
            <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded mb-4">
                Review disapproved successfully.
            </div>
            <% }

            if (error != null) {
                String errorMessage = "An error occurred while processing your request.";

                if (error.equals("missing_id")) {
                    errorMessage = "Review ID is missing. Please try again.";
                } else if (error.equals("missing_action")) {
                    errorMessage = "Action is missing. Please try again.";
                } else if (error.equals("operation_failed")) {
                    errorMessage = "The operation failed. Please try again.";
                } else if (error.equals("delete_failed")) {
                    errorMessage = "Failed to delete the review. Please try again.";
                } else if (error.equals("approve_failed")) {
                    errorMessage = "Failed to approve the review. Please try again.";
                } else if (error.equals("disapprove_failed")) {
                    errorMessage = "Failed to disapprove the review. Please try again.";
                } else if (error.equals("invalid_action")) {
                    errorMessage = "Invalid action specified. Please try again.";
                } else if (error.equals("exception")) {
                    String message = request.getParameter("message");
                    errorMessage = "An error occurred: " + (message != null ? message : "Unknown error");
                }
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= errorMessage %>
            </div>
            <% } %>

            <%

            Review review = (Review) request.getAttribute("review");
            Tutor tutor = (Tutor) request.getAttribute("tutor");
            Student student = (Student) request.getAttribute("student");
            Booking booking = (Booking) request.getAttribute("booking");

            if (review == null || tutor == null || student == null) {

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

            <h2 class="text-2xl font-bold mb-6">Review #<%= review.getId() %></h2>


            <div class="mb-6">
                <span class="px-3 py-1 rounded-full text-sm font-semibold <%= review.isApproved() ? "bg-green-100 text-green-800" : "bg-yellow-100 text-yellow-800" %>">
                    <%= review.isApproved() ? "Approved" : "Pending Approval" %>
                </span>

                <span class="px-3 py-1 rounded-full text-sm font-semibold bg-purple-100 text-purple-800 ml-2">
                    <%= isPublicReview ? "Public Review" : (isVerifiedReview ? "Verified Review" : "Standard Review") %>
                </span>

                <% if (isPublicReview && publicReview.isAnonymous()) { %>
                <span class="px-3 py-1 rounded-full text-sm font-semibold bg-gray-100 text-gray-800 ml-2">
                    Anonymous
                </span>
                <% } %>
            </div>

            <!-- Review Content -->
            <div class="bg-blue-50 p-6 rounded-lg mb-6">
                <div class="flex items-center mb-4">
                    <div class="text-yellow-400 text-2xl">
                        <%= review.getStarRating() %>
                    </div>
                    <span class="ml-2 text-gray-700 font-medium"><%= review.getRating() %>/5</span>
                </div>

                <div class="prose max-w-none">
                    <p class="text-gray-800 text-lg"><%= review.getComment() %></p>
                </div>

                <div class="mt-4 text-gray-500 text-sm">
                    <p>Submitted on <%= review.getFormattedDate() %></p>
                    <% if (isVerifiedReview) { %>
                    <p>Verified on <%= verifiedReview.getFormattedVerificationDate() %></p>
                    <% } %>
                </div>

                <% if (isPublicReview) { %>
                <div class="mt-4 pt-4 border-t border-blue-200">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-600">Was this review helpful?</p>
                        </div>
                        <div class="flex space-x-2">
                            <form action="view-review" method="post" class="inline">
                                <input type="hidden" name="id" value="<%= review.getId() %>">
                                <input type="hidden" name="voteType" value="helpful">
                                <button type="submit" class="bg-green-100 hover:bg-green-200 text-green-800 px-3 py-1 rounded-full transition duration-300">
                                    <i class="fas fa-thumbs-up mr-1"></i> Yes (<%= publicReview.getHelpfulVotes() %>)
                                </button>
                            </form>
                            <form action="view-review" method="post" class="inline">
                                <input type="hidden" name="id" value="<%= review.getId() %>">
                                <input type="hidden" name="voteType" value="unhelpful">
                                <button type="submit" class="bg-red-100 hover:bg-red-200 text-red-800 px-3 py-1 rounded-full transition duration-300">
                                    <i class="fas fa-thumbs-down mr-1"></i> No (<%= publicReview.getUnhelpfulVotes() %>)
                                </button>
                            </form>
                        </div>
                    </div>
                    <% if (publicReview.getTotalVotes() > 0) { %>
                    <div class="mt-2">
                        <div class="w-full bg-gray-200 rounded-full h-2.5">
                            <div class="bg-green-600 h-2.5 rounded-full" style="width: <%= publicReview.getHelpfulnessPercentage() %>%"></div>
                        </div>
                        <p class="text-xs text-gray-500 mt-1"><%= publicReview.getHelpfulnessPercentage() %>% of users found this review helpful</p>
                    </div>
                    <% } %>
                </div>
                <% } %>
            </div>


            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Tutor</h3>
                    <div class="flex items-center">
                        <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-12 h-12 mr-4">
                            <span class="text-blue-800 text-xl font-bold"><%= tutor.getName().substring(0, 1) %></span>
                        </div>
                        <div>
                            <p class="font-bold"><%= tutor.getName() %></p>
                            <p class="text-gray-600"><%= tutor.getSubjects() %></p>
                            <div class="flex items-center mt-1">
                                <div class="text-yellow-400 text-sm">
                                    <%= tutor.getStarRating() %>
                                </div>
                                <span class="ml-1 text-gray-600"><%= tutor.getRating() %>/5</span>
                            </div>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="view-tutor?id=<%= tutor.getId() %>" class="text-blue-600 hover:underline">View Tutor Profile</a>
                    </div>
                </div>

                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Student</h3>
                    <% if (isPublicReview && publicReview.isAnonymous()) { %>
                    <p class="text-gray-600 italic">Anonymous Student</p>
                    <% } else { %>
                    <div class="flex items-center">
                        <div class="flex-shrink-0 flex items-center justify-center bg-purple-100 rounded-full w-12 h-12 mr-4">
                            <span class="text-purple-800 text-xl font-bold"><%= student.getName().substring(0, 1) %></span>
                        </div>
                        <div>
                            <p class="font-bold"><%= student.getName() %></p>
                            <p class="text-gray-600"><%= student.getEmail() %></p>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="view-student?id=<%= student.getId() %>" class="text-blue-600 hover:underline">View Student Profile</a>
                    </div>
                    <% } %>
                </div>
            </div>

            <% if (booking != null) { %>

            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <h3 class="text-xl font-semibold mb-4">Booking Information</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p><span class="font-medium">Subject:</span> <%= booking.getSubject() %></p>
                        <p><span class="font-medium">Date:</span> <%= booking.getFormattedDate() %></p>
                        <p><span class="font-medium">Time:</span> <%= booking.getStartTime() %> - <%= booking.getEndTime() %></p>
                    </div>
                    <div>
                        <p><span class="font-medium">Status:</span> <%= booking.getStatus() %></p>
                        <p><span class="font-medium">Type:</span> <%= booking.getBookingType() %></p>
                    </div>
                </div>
                <div class="mt-4">
                    <a href="view-booking?id=<%= booking.getId() %>" class="text-blue-600 hover:underline">View Booking Details</a>
                </div>
            </div>
            <% } %>

            <% if (isVerifiedReview) { %>
            <!-- Verification Details -->
            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <h3 class="text-xl font-semibold mb-4">Verification Details</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p><span class="font-medium">Verification Method:</span> <%= verifiedReview.getVerificationMethod() %></p>
                        <p><span class="font-medium">Verification Date:</span> <%= verifiedReview.getFormattedVerificationDate() %></p>
                    </div>
                    <div>
                        <p><span class="font-medium">Verified By:</span> <%= verifiedReview.getVerifiedBy() %></p>
                        <p><span class="font-medium">Has Attachments:</span> <%= verifiedReview.hasAttachments() ? "Yes" : "No" %></p>
                    </div>
                </div>
            </div>
            <% } %>


            <div class="flex flex-wrap justify-center gap-4">
                <a href="review-list" class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Back to Reviews
                </a>

                <a href="update-review?id=<%= review.getId() %>" class="bg-yellow-500 hover:bg-yellow-600 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Edit Review
                </a>

                <% if (!review.isApproved()) { %>
                <a href="delete-review?id=<%= review.getId() %>&action=approve&returnUrl=view-review?id=<%= review.getId() %>" class="bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Approve Review
                </a>
                <% } else { %>
                <a href="delete-review?id=<%= review.getId() %>&action=disapprove&returnUrl=view-review?id=<%= review.getId() %>" class="bg-yellow-600 hover:bg-yellow-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Disapprove Review
                </a>
                <% } %>

                <a href="delete-review?id=<%= review.getId() %>&action=delete&returnUrl=review-list" class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded transition duration-300"
                   onclick="return confirm('Are you sure you want to delete this review? This action cannot be undone.')">
                    Delete Review
                </a>

                <a href="tutor-reviews?id=<%= tutor.getId() %>" class="bg-purple-600 hover:bg-purple-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    View All Reviews for This Tutor
                </a>
            </div>
            <% } %>
        </div>
    </div>


    <div class="fixed bottom-6 right-6 z-50">
        <div class="relative group">
            <button class="bg-blue-600 hover:bg-blue-700 text-white rounded-full w-14 h-14 flex items-center justify-center shadow-lg transition duration-300 focus:outline-none" id="inquiryButton">
                <i class="fas fa-ellipsis-v text-xl"></i>
            </button>
            <div class="absolute bottom-16 right-0 bg-white rounded-lg shadow-xl p-2 w-48 hidden transition-all duration-300" id="inquiryMenu">
                <a href="update-review?id=<%= review != null ? review.getId() : "" %>" class="flex items-center px-4 py-2 text-gray-700 hover:bg-blue-100 rounded-lg transition duration-300">
                    <i class="fas fa-edit mr-2"></i> Edit Review
                </a>
                <% if (review != null && !review.isApproved()) { %>
                <a href="delete-review?id=<%= review.getId() %>&action=approve&returnUrl=view-review?id=<%= review.getId() %>" class="flex items-center px-4 py-2 text-gray-700 hover:bg-green-100 rounded-lg transition duration-300">
                    <i class="fas fa-check mr-2"></i> Approve Review
                </a>
                <% } else if (review != null) { %>
                <a href="delete-review?id=<%= review.getId() %>&action=disapprove&returnUrl=view-review?id=<%= review.getId() %>" class="flex items-center px-4 py-2 text-gray-700 hover:bg-yellow-100 rounded-lg transition duration-300">
                    <i class="fas fa-times mr-2"></i> Disapprove Review
                </a>
                <% } %>
                <a href="delete-review?id=<%= review != null ? review.getId() : "" %>&action=delete&returnUrl=review-list" class="flex items-center px-4 py-2 text-gray-700 hover:bg-red-100 rounded-lg transition duration-300"
                   onclick="return confirm('Are you sure you want to delete this review? This action cannot be undone.')">
                    <i class="fas fa-trash-alt mr-2"></i> Delete Review
                </a>
            </div>
        </div>
    </div>

    <script>

        document.addEventListener('DOMContentLoaded', function() {
            const inquiryButton = document.getElementById('inquiryButton');
            const inquiryMenu = document.getElementById('inquiryMenu');

            inquiryButton.addEventListener('click', function() {
                inquiryMenu.classList.toggle('hidden');
            });


            document.addEventListener('click', function(event) {
                if (!inquiryButton.contains(event.target) && !inquiryMenu.contains(event.target)) {
                    inquiryMenu.classList.add('hidden');
                }
            });
        });
    </script>
<jsp:include page="includes/footer.jsp" />
