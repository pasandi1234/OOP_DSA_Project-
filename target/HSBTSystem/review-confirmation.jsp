<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Review" %>
<%@ page import="com.hsbt.model.PublicReview" %>
<%@ page import="com.hsbt.model.VerifiedReview" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="com.hsbt.model.Booking" %>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Review Submitted" />
    <jsp:param name="subtitle" value="Review Confirmation" />
</jsp:include>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
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
                <a href="tutor-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    Search Tutors
                </a>
            </div>
            <% } else {
                boolean isPublicReview = review instanceof PublicReview;
                boolean isVerifiedReview = review instanceof VerifiedReview;
            %>

            <div class="text-center mb-8">
                <div class="text-green-500 text-6xl mb-4">✓</div>
                <h2 class="text-2xl font-bold text-green-600">Review Submitted!</h2>
                <p class="text-gray-600 mt-2">Thank you for sharing your experience.</p>
                <% if (!review.isApproved()) { %>
                <p class="text-gray-600">Your review will be visible after approval.</p>
                <% } %>
            </div>

            <!-- Review Details -->
            <div class="bg-blue-50 p-6 rounded-lg mb-6">
                <h3 class="text-xl font-bold mb-4">Your Review</h3>

                <div class="mb-4">
                    <div class="text-yellow-400 text-xl">
                        <%= review.getStarRating() %>
                    </div>
                    <p class="text-gray-700 mt-2"><%= review.getComment() %></p>
                    <p class="text-gray-500 text-sm mt-2">Submitted on <%= review.getFormattedDate() %></p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4 pt-4 border-t border-blue-200">
                    <div>
                        <p class="font-medium">Review Type:</p>
                        <p class="text-gray-700 mb-2"><%= isPublicReview ? "Public Review" : (isVerifiedReview ? "Verified Review" : "Standard Review") %></p>

                        <% if (isPublicReview) {
                            PublicReview publicReview = (PublicReview) review;
                        %>
                        <p class="font-medium">Anonymous:</p>
                        <p class="text-gray-700 mb-2"><%= publicReview.isAnonymous() ? "Yes" : "No" %></p>
                        <% } %>

                        <% if (isVerifiedReview) {
                            VerifiedReview verifiedReview = (VerifiedReview) review;
                        %>
                        <p class="font-medium">Verification Method:</p>
                        <p class="text-gray-700 mb-2"><%= verifiedReview.getVerificationMethod() %></p>

                        <p class="font-medium">Verified By:</p>
                        <p class="text-gray-700 mb-2"><%= verifiedReview.getVerifiedBy() %></p>
                        <% } %>
                    </div>

                    <div>
                        <p class="font-medium">Status:</p>
                        <p class="text-gray-700 mb-2">
                            <span class="px-2 py-1 rounded-full text-xs font-semibold <%= review.isApproved() ? "bg-green-100 text-green-800" : "bg-yellow-100 text-yellow-800" %>">
                                <%= review.isApproved() ? "Approved" : "Pending Approval" %>
                            </span>
                        </p>

                        <p class="font-medium">Tutor:</p>
                        <p class="text-gray-700 mb-2"><%= tutor.getName() %></p>

                        <% if (booking != null) { %>
                        <p class="font-medium">Booking:</p>
                        <p class="text-gray-700 mb-2">#<%= booking.getId() %> - <%= booking.getSubject() %></p>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="text-center">
                <a href="view-review?id=<%= review.getId() %>" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                    View Review Details
                </a>
                <a href="view-tutor?id=<%= tutor.getId() %>" class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                    View Tutor Profile
                </a>
                <% if (booking != null) { %>
                <a href="view-booking?id=<%= booking.getId() %>" class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                    View Booking
                </a>
                <% } %>
            </div>
            <% } %>
        </div>
    </div>

<jsp:include page="includes/footer.jsp" />
