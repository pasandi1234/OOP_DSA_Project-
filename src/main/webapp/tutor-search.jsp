<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduBridge</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">EduBridge</h1>
            <p class="text-center mt-2">Find the perfect tutor for your educational needs</p>
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
        <div class="max-w-6xl mx-auto">
            <h2 class="text-2xl font-bold text-center mb-6">Search for Tutors</h2>

            <!-- Search Form -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <form action="search-tutors" method="get" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <label for="searchType" class="block text-gray-700 font-medium mb-2">Search By</label>
                            <select id="searchType" name="searchType"
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="name">Name</option>
                                <option value="subject">Subject</option>
                                <option value="available">Available Tutors</option>
                                <option value="rating">Minimum Rating</option>
                                <option value="rate">Hourly Rate Range</option>
                            </select>
                        </div>
                        <div>
                            <label for="query" class="block text-gray-700 font-medium mb-2">Search Query</label>
                            <input type="text" id="query" name="query" placeholder="Enter search term..."
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <p id="queryHelp" class="text-sm text-gray-500 mt-1">Enter name, subject, minimum rating (0-5), or rate range (e.g., 20-50)</p>
                        </div>
                        <div class="flex items-end">
                            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg transition duration-300">
                                Search
                            </button>
                        </div>
                    </div>

                    <div class="border-t border-gray-200 pt-4 mt-4">
                        <h3 class="font-medium mb-2">Sort Results</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="sortBy" class="block text-gray-700 font-medium mb-2">Sort By</label>
                                <select id="sortBy" name="sortBy"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="rating">Rating</option>
                                    <option value="rate">Hourly Rate</option>
                                    <option value="experience">Years of Experience</option>
                                </select>
                            </div>
                            <div>
                                <label for="sortOrder" class="block text-gray-700 font-medium mb-2">Sort Order</label>
                                <select id="sortOrder" name="sortOrder"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="desc">Highest to Lowest</option>
                                    <option value="asc">Lowest to Highest</option>
                                </select>
                            </div>
                        </div>

                        <div class="text-center mt-6">
                            <a href="advanced-tutor-search.jsp" class="text-blue-600 hover:text-blue-800 font-medium">
                                Need more options? Try our Advanced Search & Sorting
                            </a>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Display error message if any -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- Display success message if any -->
            <% if (request.getAttribute("message") != null) { %>
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>

            <!-- Sample Tutor Cards (These would be replaced by actual search results) -->
            <div class="grid grid-cols-1 gap-6">
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="p-6 flex flex-col md:flex-row">
                        <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-24 h-24 md:mr-6 mb-4 md:mb-0 mx-auto md:mx-0">
                            <span class="text-blue-800 text-2xl font-bold">MM</span>
                        </div>
                        <div class="flex-grow">
                            <div class="flex flex-col md:flex-row md:justify-between md:items-start">
                                <div>
                                    <h3 class="text-xl font-bold">Minadi Mallikarachchi</h3>
                                    <p class="text-gray-600">Geography,History</p>
                                    <div class="flex items-center mt-1">
                                        <div class="text-yellow-400">★★★★☆</div>
                                        <span class="ml-1 text-gray-600">4.2/5</span>
                                    </div>
                                    <p class="text-gray-600 mt-1">5 years experience | Rs.2500/hour</p>
                                    <p class="text-green-600 font-medium">Available</p>
                                    <p class="mt-2"><span class="font-medium">Type:</span> Online Tutor</p>
                                    <p><span class="font-medium">Platform:</span> Zoom</p>
                                </div>
                                <div class="flex flex-col space-y-2 mt-4 md:mt-0">
                                    <a href="view-tutor?id=1" class="bg-blue-600 hover:bg-blue-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        View Profile
                                    </a>
                                    <a href="update-tutor?id=1" class="bg-yellow-500 hover:bg-yellow-600 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        Edit
                                    </a>
                                    <a href="delete-tutor?id=1" class="bg-red-600 hover:bg-red-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300"
                                       onclick="return confirm('Are you sure you want to delete this tutor?')">
                                        Delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="p-6 flex flex-col md:flex-row">
                        <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-24 h-24 md:mr-6 mb-4 md:mb-0 mx-auto md:mx-0">
                            <span class="text-blue-800 text-2xl font-bold">PK</span>
                        </div>
                        <div class="flex-grow">
                            <div class="flex flex-col md:flex-row md:justify-between md:items-start">
                                <div>
                                    <h3 class="text-xl font-bold">Pasandi Amanya Kahatapitiya</h3>
                                    <p class="text-gray-600">Physics, Chemistry, Biology</p>
                                    <div class="flex items-center mt-1">
                                        <div class="text-yellow-400">★★★★★</div>
                                        <span class="ml-1 text-gray-600">4.8/5</span>
                                    </div>
                                    <p class="text-gray-600 mt-1">8 years experience | Rs.3000/hour</p>
                                    <p class="text-green-600 font-medium">Available</p>
                                    <p class="mt-2"><span class="font-medium">Type:</span> Online Tutor</p>
                                    <p><span class="font-medium">Platform:</span> Zoom</p>
                                </div>
                                <div class="flex flex-col space-y-2 mt-4 md:mt-0">
                                    <a href="view-tutor?id=2" class="bg-blue-600 hover:bg-blue-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        View Profile
                                    </a>
                                    <a href="update-tutor?id=2" class="bg-yellow-500 hover:bg-yellow-600 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        Edit
                                    </a>
                                    <a href="delete-tutor?id=2" class="bg-red-600 hover:bg-red-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300"
                                       onclick="return confirm('Are you sure you want to delete this tutor?')">
                                        Delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2025 EduBridge. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Update help text based on search type
        document.getElementById('searchType').addEventListener('change', function() {
            const searchType = this.value;
            const queryHelp = document.getElementById('queryHelp');
            const queryInput = document.getElementById('query');

            switch(searchType) {
                case 'name':
                    queryHelp.textContent = 'Enter full or partial name';
                    queryInput.placeholder = 'e.g., John';
                    break;
                case 'subject':
                    queryHelp.textContent = 'Enter a subject';
                    queryInput.placeholder = 'e.g., Mathematics';
                    break;
                case 'available':
                    queryHelp.textContent = 'No query needed, will show all available tutors';
                    queryInput.placeholder = '';
                    break;
                case 'rating':
                    queryHelp.textContent = 'Enter minimum rating (0-5)';
                    queryInput.placeholder = 'e.g., 4.5';
                    break;
                case 'rate':
                    queryHelp.textContent = 'Enter hourly rate range (min-max)';
                    queryInput.placeholder = 'e.g., 20-50';
                    break;
            }
        });
    </script>
</body>
</html>
