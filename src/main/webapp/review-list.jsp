<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.model.Review" %>
<%@ page import="com.hsbt.model.PublicReview" %>
<%@ page import="com.hsbt.model.VerifiedReview" %>
<%@ page import="com.hsbt.model.Tutor" %>
<%@ page import="com.hsbt.model.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Review List" />
    <jsp:param name="subtitle" value="Review Management" />
</jsp:include>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-6xl mx-auto">
            <h2 class="text-2xl font-bold mb-6">Review Management</h2>

            <%

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


            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <form action="review-list" method="get" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <label for="status" class="block text-gray-700 font-medium mb-2">Filter By Status</label>
                            <select id="status" name="status"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">All Statuses</option>
                                <option value="approved" <%= "approved".equals(request.getAttribute("selectedStatus")) ? "selected" : "" %>>Approved</option>
                                <option value="pending" <%= "pending".equals(request.getAttribute("selectedStatus")) ? "selected" : "" %>>Pending Approval</option>
                            </select>
                        </div>

                        <div>
                            <label for="tutorId" class="block text-gray-700 font-medium mb-2">Filter By Tutor</label>
                            <select id="tutorId" name="tutorId"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">All Tutors</option>
                                <%
                                Map<Integer, Tutor> tutors = (Map<Integer, Tutor>) request.getAttribute("tutors");
                                Tutor selectedTutor = (Tutor) request.getAttribute("selectedTutor");

                                if (tutors != null) {
                                    for (Tutor tutor : tutors.values()) {
                                %>
                                <option value="<%= tutor.getId() %>" <%= (selectedTutor != null && selectedTutor.getId() == tutor.getId()) ? "selected" : "" %>><%= tutor.getName() %></option>
                                <%
                                    }
                                }
                                %>
                            </select>
                        </div>

                        <div>
                            <label for="studentId" class="block text-gray-700 font-medium mb-2">Filter By Student</label>
                            <select id="studentId" name="studentId"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">All Students</option>
                                <%
                                Map<Integer, Student> students = (Map<Integer, Student>) request.getAttribute("students");
                                Student selectedStudent = (Student) request.getAttribute("selectedStudent");

                                if (students != null) {
                                    for (Student student : students.values()) {
                                %>
                                <option value="<%= student.getId() %>" <%= (selectedStudent != null && selectedStudent.getId() == student.getId()) ? "selected" : "" %>><%= student.getName() %></option>
                                <%
                                    }
                                }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="type" class="block text-gray-700 font-medium mb-2">Filter By Review Type</label>
                            <select id="type" name="type"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">All Types</option>
                                <option value="public" <%= "public".equals(request.getAttribute("selectedType")) ? "selected" : "" %>>Public Reviews</option>
                                <option value="verified" <%= "verified".equals(request.getAttribute("selectedType")) ? "selected" : "" %>>Verified Reviews</option>
                            </select>
                        </div>
                    </div>

                    <div class="flex justify-center">
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded transition duration-300">
                            Apply Filters
                        </button>
                    </div>
                </form>
            </div>


            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <%
                List<Review> reviews = (List<Review>) request.getAttribute("reviews");

                if (reviews == null || reviews.isEmpty()) {
                %>
                <div class="p-6 text-center">
                    <p class="text-gray-600">No reviews found.</p>
                </div>
                <% } else { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rating</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Comment</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tutor</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <%
                            for (Review review : reviews) {
                                boolean isPublicReview = review instanceof PublicReview;
                                boolean isVerifiedReview = review instanceof VerifiedReview;

                                Tutor tutor = tutors.get(review.getTutorId());
                                Student student = students.get(review.getStudentId());

                                if (tutor == null || student == null) {
                                    continue; // Skip if tutor or student not found
                                }


                                boolean isAnonymous = isPublicReview && ((PublicReview) review).isAnonymous();


                                String comment = review.getComment();
                                if (comment.length() > 50) {
                                    comment = comment.substring(0, 47) + "...";
                                }
                            %>
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= review.getId() %></td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-yellow-400 text-sm">
                                        <%= review.getStarRating() %>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= comment %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= review.getDate() %></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <a href="view-tutor?id=<%= tutor.getId() %>" class="text-blue-600 hover:underline"><%= tutor.getName() %></a>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <% if (isAnonymous) { %>
                                    <span class="italic">Anonymous</span>
                                    <% } else { %>
                                    <a href="view-student?id=<%= student.getId() %>" class="text-blue-600 hover:underline"><%= student.getName() %></a>
                                    <% } %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full <%= review.isApproved() ? "bg-green-100 text-green-800" : "bg-yellow-100 text-yellow-800" %>">
                                        <%= review.isApproved() ? "Approved" : "Pending" %>
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <%= isPublicReview ? "Public" : (isVerifiedReview ? "Verified" : "Standard") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <a href="view-review?id=<%= review.getId() %>" class="text-blue-600 hover:text-blue-900 mr-3">View</a>
                                    <a href="update-review?id=<%= review.getId() %>" class="text-yellow-600 hover:text-yellow-900 mr-3">Edit</a>

                                    <% if (!review.isApproved()) { %>
                                    <a href="delete-review?id=<%= review.getId() %>&action=approve&returnUrl=review-list" class="text-green-600 hover:text-green-900 mr-3">Approve</a>
                                    <% } else { %>
                                    <a href="delete-review?id=<%= review.getId() %>&action=disapprove&returnUrl=review-list" class="text-yellow-600 hover:text-yellow-900 mr-3">Disapprove</a>
                                    <% } %>

                                    <a href="delete-review?id=<%= review.getId() %>&action=delete&returnUrl=review-list" class="text-red-600 hover:text-red-900"
                                       onclick="return confirm('Are you sure you want to delete this review? This action cannot be undone.')">Delete</a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </div>
        </div>
    </div>

<jsp:include page="includes/footer.jsp" />
