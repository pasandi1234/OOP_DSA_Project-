<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Home" />
    <jsp:param name="subtitle" value="Find the perfect tutor for your educational needs" />
</jsp:include>

    <div class="container mx-auto px-4 py-8">
        <div class="text-center py-8">
            <h2 class="text-3xl font-bold mb-4">Connecting Students with Expert Tutors</h2>
            <p class="text-lg text-gray-600 mb-8 max-w-3xl mx-auto">
                Whether you're looking for help with mathematics, science, languages, or any other subject,
                our platform makes it easy to find and book qualified tutors.
            </p>
            <div class="flex flex-wrap justify-center gap-4">
                <a href="tutor-registration.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                    Register as Tutor
                </a>
                <a href="student-registration.jsp" class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                    Register as Student
                </a>
                <a href="tutor-search.jsp" class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                    Find a Tutor
                </a>
                <a href="booking-history" class="bg-yellow-600 hover:bg-yellow-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                    Manage Bookings
                </a>
                <a href="payment-history" class="bg-red-600 hover:bg-red-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                    View Payments
                </a>
                <a href="review-list" class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                    View Reviews
                </a>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 my-12">
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-xl font-bold text-blue-600 mb-3">Find the Perfect Tutor</h3>
                <p class="text-gray-700">
                    Search for tutors based on subject expertise, rating, price, and availability.
                    Our advanced search system helps you find the perfect match for your learning needs.
                </p>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-xl font-bold text-blue-600 mb-3">Online & In-Person Options</h3>
                <p class="text-gray-700">
                    Choose between online tutoring sessions from the comfort of your home
                    or in-person sessions at a location convenient for you.
                </p>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-xl font-bold text-blue-600 mb-3">Secure Booking & Payment</h3>
                <p class="text-gray-700">
                    Book tutoring sessions with ease and make secure payments through our platform.
                    No more hassle with scheduling or payment arrangements.
                </p>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-xl font-bold text-blue-600 mb-3">Verified Reviews</h3>
                <p class="text-gray-700">
                    Read authentic reviews from other students to help you make informed
                    decisions about which tutor to choose.
                </p>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-xl font-bold text-blue-600 mb-3">Flexible Scheduling</h3>
                <p class="text-gray-700">
                    Book sessions at times that work for you. Our system helps you
                    find tutors available when you need them.
                </p>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h3 class="text-xl font-bold text-blue-600 mb-3">Premium Benefits</h3>
                <p class="text-gray-700">
                    Upgrade to a premium membership for discounts on bookings,
                    priority scheduling, and access to exclusive tutors.
                </p>
            </div>
        </div>
    </div>

    <div class="bg-blue-50 py-12">
        <div class="container mx-auto px-4">
            <h2 class="text-2xl font-bold text-center mb-8">How It Works</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <div class="text-center">
                    <div class="bg-blue-600 text-white w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-4 text-xl font-bold">1</div>
                    <h3 class="text-xl font-bold mb-2">Register</h3>
                    <p class="text-gray-700">Create an account as a tutor to get started.</p>
                </div>
                <div class="text-center">
                    <div class="bg-blue-600 text-white w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-4 text-xl font-bold">2</div>
                    <h3 class="text-xl font-bold mb-2">Search</h3>
                    <p class="text-gray-700">Find tutors based on subject, price, rating, and availability.</p>
                </div>
                <div class="text-center">
                    <div class="bg-blue-600 text-white w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-4 text-xl font-bold">3</div>
                    <h3 class="text-xl font-bold mb-2">Book</h3>
                    <p class="text-gray-700">Schedule a session at a time that works for you.</p>
                </div>
                <div class="text-center">
                    <div class="bg-blue-600 text-white w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-4 text-xl font-bold">4</div>
                    <h3 class="text-xl font-bold mb-2">Learn</h3>
                    <p class="text-gray-700">Attend your session and improve your knowledge.</p>
                </div>
            </div>
        </div>
    </div>

<jsp:include page="includes/footer.jsp" />
