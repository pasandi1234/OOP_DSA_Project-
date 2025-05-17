<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.config.DatabaseConfig" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Configuration - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Database Configuration</p>
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
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <h2 class="text-2xl font-bold mb-6">Database Configuration</h2>
            <p class="mb-6">This page displays the file paths for the data files used by the application.</p>

            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                <h3 class="text-lg font-semibold mb-2">Base Directory</h3>
                <p class="font-mono text-sm break-all"><%= DatabaseConfig.getBaseDirPath() %></p>
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full bg-white border border-gray-300">
                    <thead>
                        <tr>
                            <th class="py-3 px-4 bg-gray-100 font-semibold text-left border-b">Data Type</th>
                            <th class="py-3 px-4 bg-gray-100 font-semibold text-left border-b">URL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="py-3 px-4 border-b">Tutors</td>
                            <td class="py-3 px-4 border-b font-mono text-sm"><%= DatabaseConfig.getTutorsFilePath() %></td>
                        </tr>
                        <tr>
                            <td class="py-3 px-4 border-b">Students</td>
                            <td class="py-3 px-4 border-b font-mono text-sm"><%= DatabaseConfig.getStudentsFilePath() %></td>
                        </tr>
                        <tr>
                            <td class="py-3 px-4 border-b">Bookings</td>
                            <td class="py-3 px-4 border-b font-mono text-sm"><%= DatabaseConfig.getBookingsFilePath() %></td>
                        </tr>
                        <tr>
                            <td class="py-3 px-4 border-b">Reviews</td>
                            <td class="py-3 px-4 border-b font-mono text-sm"><%= DatabaseConfig.getReviewsFilePath() %></td>
                        </tr>
                        <tr>
                            <td class="py-3 px-4 border-b">Config</td>
                            <td class="py-3 px-4 border-b font-mono text-sm"><%= DatabaseConfig.getConfigFilePath() %></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="mt-8">
                <h3 class="text-xl font-bold mb-4">Database Structure</h3>
                <p class="mb-4">The application uses text files to store data in a structured format. Each line in a file represents a record, with fields separated by the '|' character.</p>

                <div class="bg-gray-100 p-4 rounded-lg">
                    <h4 class="font-bold mb-2">Tutor Record Format:</h4>
                    <p class="font-mono text-sm">id|name|email|phone|subjects|yearsOfExperience|hourlyRate|rating|available|type|[type-specific fields]</p>

                    <h4 class="font-bold mt-4 mb-2">Example Online Tutor:</h4>
                    <p class="font-mono text-sm break-all">1|John Smith|john.smith@email.com|123-456-7890|Mathematics,Calculus,Algebra|5|25.0|4.5|1|ONLINE|Zoom|1|1|GMT-5</p>

                    <h4 class="font-bold mt-4 mb-2">Example In-Person Tutor:</h4>
                    <p class="font-mono text-sm break-all">3|Michael Brown|michael.b@email.com|345-678-9012|English,Literature,Writing|6|28.0|4.2|1|INPERSON|New York|15|1|1</p>
                </div>
            </div>

            <div class="mt-8 text-center">
                <a href="index.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    Back to Home
                </a>
            </div>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
