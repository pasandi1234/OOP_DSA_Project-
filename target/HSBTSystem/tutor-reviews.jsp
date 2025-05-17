<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Review" %>
<%@ page import="com.hsbt.model.PublicReview" %>
<%@ page import="com.hsbt.model.VerifiedReview" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Reviews - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Tutor Reviews</p>
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
            <a href="payment-history" class="hover:underline font-medium">Payment History</a>
            <a href="review-list" class="hover:underline font-medium">Reviews</a>
            <a href="dashboard.jsp" class="hover:underline font-medium">Dashboard</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-4xl mx-auto">
            <% 
            // Get success/error messages if any
            String deleted = request.getParameter("deleted");
            String approved = request.getParameter("approved");
            String disapproved = request.getParameter("disapproved");
            String error = request.getParameter("error");
            
            if (deleted != null && deleted.equals("true")) {
            %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                Review deleted successfully.
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
            
            if (error != null && error.equals("true")) {
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                An error occurred while processing your request.
            </div>
            <% } %>
            
            <% 
            // Get the tutor and reviews from the request
            Tutor tutor = (Tutor) request.getAttribute("tutor");
            List<Review> reviews = (List<Review>) request.getAttribute("reviews");
            Map<Integer, Student> students = (Map<Integer, Student>) request.getAttribute("students");
            
            if (tutor == null) {
                // If tutor is missing, show an error message
            %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                Tutor information is missing. Please try again.
            </div>
            <div class="text-center mt-6">
                <a href="tutor-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    Search Tutors
                </a>
            </div>
            <% } else { %>
            
            <!-- Tutor Information -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <div class="flex flex-col md:flex-row items-center md:items-start">
                    <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-24 h-24 md:mr-6 mb-4 md:mb-0">
                        <span class="text-blue-800 text-3xl font-bold"><%= tutor.getName().substring(0, 1) %></span>
                    </div>
                    <div class="flex-grow text-center md:text-left">
                        <h2 class="text-2xl font-bold"><%= tutor.getName() %></h2>
                        <p class="text-gray-600"><%= tutor.getSubjects() %></p>
                        <div class="flex items-center mt-2 justify-center md:justify-start">
                            <div class="text-yellow-400 text-xl">
                                <%= tutor.getStarRating() %>
                            </div>
                            <span class="ml-2 text-gray-600"><%= tutor.getRating() %>/5</span>
                            <span class="ml-2 text-gray-500">(<%= reviews.size() %> reviews)</span>
                        </div>
                        <p class="mt-2"><%= tutor.getYearsOfExperience() %> years experience | $<%= tutor.getHourlyRate() %>/hour</p>
                        <div class="mt-4">
                            <a href="view-tutor?id=<%= tutor.getId() %>" class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                                View Profile
                            </a>
                            <a href="submit-review?tutorId=<%= tutor.getId() %>" class="bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded transition duration-300 ml-2">
                                Write a Review
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reviews Section -->
            <h3 class="text-xl font-bold mb-4">Reviews for <%= tutor.getName() %></h3>
            
            <% if (reviews == null || reviews.isEmpty()) { %>
            <div class="bg-white rounded-lg shadow-md p-6 text-center">
                <p class="text-gray-600">No reviews found for this tutor.</p>
                <a href="submit-review?tutorId=<%= tutor.getId() %>" class="inline-block mt-4 bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded transition duration-300">
                    Be the First to Write a Review
                </a>
            </div>
            <% } else { %>
            
            <!-- Review Cards -->
            <div class="space-y-6">
                <% 
                for (Review review : reviews) {
                    boolean isPublicReview = review instanceof PublicReview;
                    boolean isVerifiedReview = review instanceof VerifiedReview;
                    
                    // Get the student who wrote the review
                    Student student = students.get(review.getStudentId());
                    if (student == null) continue;
                    
                    // For anonymous public reviews
                    boolean isAnonymous = isPublicReview && ((PublicReview) review).isAnonymous();
                    
                    // Get helpful/unhelpful votes for public reviews
                    int helpfulVotes = 0;
                    int unhelpfulVotes = 0;
                    int helpfulnessPercentage = 0;
                    
                    if (isPublicReview) {
                        PublicReview publicReview = (PublicReview) review;
                        helpfulVotes = publicReview.getHelpfulVotes();
                        unhelpfulVotes = publicReview.getUnhelpfulVotes();
                        helpfulnessPercentage = publicReview.getHelpfulnessPercentage();
                    }
                %>
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-4">
                            <div class="flex items-center">
                                <% if (isAnonymous) { %>
                                <div class="flex-shrink-0 flex items-center justify-center bg-gray-200 rounded-full w-10 h-10 mr-4">
                                    <i class="fas fa-user-secret text-gray-500"></i>
                                </div>
                                <div>
                                    <p class="font-medium text-gray-700">Anonymous</p>
                                <% } else { %>
                                <div class="flex-shrink-0 flex items-center justify-center bg-purple-100 rounded-full w-10 h-10 mr-4">
                                    <span class="text-purple-800 font-bold"><%= student.getName().substring(0, 1) %></span>
                                </div>
                                <div>
                                    <p class="font-medium text-gray-700"><%= student.getName() %></p>
                                <% } %>
                                    <p class="text-gray-500 text-sm"><%= review.getFormattedDate() %></p>
                                </div>
                            </div>
                            <div class="flex items-center">
                                <div class="text-yellow-400 text-lg">
                                    <%= review.getStarRating() %>
                                </div>
                                <span class="ml-1 text-gray-600"><%= review.getRating() %>/5</span>
                            </div>
                        </div>
                        
                        <div class="prose max-w-none mb-4">
                            <p class="text-gray-800"><%= review.getComment() %></p>
                        </div>
                        
                        <% if (isVerifiedReview) { 
                            VerifiedReview verifiedReview = (VerifiedReview) review;
                        %>
                        <div class="flex items-center text-green-600 text-sm mb-4">
                            <i class="fas fa-check-circle mr-1"></i>
                            <span>Verified <%= verifiedReview.getVerificationMethod() %></span>
                        </div>
                        <% } %>
                        
                        <% if (isPublicReview && (helpfulVotes > 0 || unhelpfulVotes > 0)) { %>
                        <div class="mt-4 pt-4 border-t border-gray-200">
                            <div class="flex items-center justify-between">
                                <div class="text-sm text-gray-500">
                                    <%= helpfulVotes %> out of <%= helpfulVotes + unhelpfulVotes %> people found this review helpful
                                </div>
                                <div class="flex space-x-2">
                                    <form action="view-review" method="post" class="inline">
                                        <input type="hidden" name="id" value="<%= review.getId() %>">
                                        <input type="hidden" name="voteType" value="helpful">
                                        <button type="submit" class="text-sm text-gray-500 hover:text-gray-700">
                                            <i class="fas fa-thumbs-up mr-1"></i> Helpful (<%= helpfulVotes %>)
                                        </button>
                                    </form>
                                    <form action="view-review" method="post" class="inline">
                                        <input type="hidden" name="id" value="<%= review.getId() %>">
                                        <input type="hidden" name="voteType" value="unhelpful">
                                        <button type="submit" class="text-sm text-gray-500 hover:text-gray-700">
                                            <i class="fas fa-thumbs-down mr-1"></i> Not Helpful (<%= unhelpfulVotes %>)
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="mt-2">
                                <div class="w-full bg-gray-200 rounded-full h-1.5">
                                    <div class="bg-green-600 h-1.5 rounded-full" style="width: <%= helpfulnessPercentage %>%"></div>
                                </div>
                            </div>
                        </div>
                        <% } else if (isPublicReview) { %>
                        <div class="mt-4 pt-4 border-t border-gray-200">
                            <div class="flex justify-end space-x-2">
                                <form action="view-review" method="post" class="inline">
                                    <input type="hidden" name="id" value="<%= review.getId() %>">
                                    <input type="hidden" name="voteType" value="helpful">
                                    <button type="submit" class="text-sm text-gray-500 hover:text-gray-700">
                                        <i class="fas fa-thumbs-up mr-1"></i> Helpful
                                    </button>
                                </form>
                                <form action="view-review" method="post" class="inline">
                                    <input type="hidden" name="id" value="<%= review.getId() %>">
                                    <input type="hidden" name="voteType" value="unhelpful">
                                    <button type="submit" class="text-sm text-gray-500 hover:text-gray-700">
                                        <i class="fas fa-thumbs-down mr-1"></i> Not Helpful
                                    </button>
                                </form>
                            </div>
                        </div>
                        <% } %>
                        
                        <div class="mt-4 flex justify-end">
                            <a href="view-review?id=<%= review.getId() %>" class="text-blue-600 hover:underline text-sm">
                                View Details
                            </a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
            
            <div class="text-center mt-8">
                <a href="submit-review?tutorId=<%= tutor.getId() %>" class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                    Write a Review
                </a>
                <a href="tutor-search.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300 inline-block ml-4">
                    Back to Tutor Search
                </a>
            </div>
            <% } %>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
