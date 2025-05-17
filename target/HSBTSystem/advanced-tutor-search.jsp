<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.hsbt.sorting.TutorSortingStrategy" %>
<%@ page import="com.hsbt.sorting.TutorSortingStrategyFactory" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced Tutor Search - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
            <p class="text-center mt-2">Advanced Tutor Search & Sorting</p>
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
            <a href="dashboard.jsp" class="hover:underline font-medium">Dashboard</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-6xl mx-auto">
            <h2 class="text-2xl font-bold text-center mb-6">Advanced Tutor Search & Sorting</h2>
            
            <!-- Search Form -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <form action="search-tutors" method="get" class="space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Basic Search Section -->
                        <div class="space-y-4">
                            <h3 class="text-xl font-semibold">Basic Search</h3>
                            
                            <div>
                                <label for="searchType" class="block text-gray-700 font-medium mb-2">Search By</label>
                                <select id="searchType" name="searchType" 
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="name">Name</option>
                                    <option value="subject">Subject</option>
                                    <option value="available">Available Tutors</option>
                                    <option value="rating">Minimum Rating</option>
                                    <option value="rate">Hourly Rate Range</option>
                                    <option value="experience">Experience Range</option>
                                    <option value="type">Tutor Type</option>
                                </select>
                            </div>
                            
                            <div>
                                <label for="query" class="block text-gray-700 font-medium mb-2">Search Query</label>
                                <input type="text" id="query" name="query" placeholder="Enter search term..."
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <p id="queryHelp" class="text-sm text-gray-500 mt-1">Enter name, subject, or other search criteria</p>
                            </div>
                        </div>
                        
                        <!-- Sorting Section -->
                        <div class="space-y-4">
                            <h3 class="text-xl font-semibold">Sorting Options</h3>
                            
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
                                    <option value="desc">Descending (High to Low)</option>
                                    <option value="asc">Ascending (Low to High)</option>
                                </select>
                            </div>
                            
                            <div class="pt-4">
                                <p class="text-gray-700 font-medium mb-2">Available Sorting Strategies:</p>
                                <div class="grid grid-cols-1 sm:grid-cols-2 gap-2 mt-2">
                                    <% 
                                    List<TutorSortingStrategy> strategies = TutorSortingStrategyFactory.getAllStrategies();
                                    for (TutorSortingStrategy strategy : strategies) {
                                    %>
                                    <div class="bg-blue-50 p-2 rounded text-sm">
                                        <%= strategy.getStrategyDescription() %>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Advanced Filters Section -->
                    <div class="pt-4 border-t border-gray-200">
                        <h3 class="text-xl font-semibold mb-4">Advanced Filters</h3>
                        
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div>
                                <label for="tutorType" class="block text-gray-700 font-medium mb-2">Tutor Type</label>
                                <select id="tutorType" name="tutorType" 
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="all">All Types</option>
                                    <option value="online">Online Only</option>
                                    <option value="inperson">In-Person Only</option>
                                </select>
                            </div>
                            
                            <div>
                                <label for="minExperience" class="block text-gray-700 font-medium mb-2">Minimum Experience (Years)</label>
                                <input type="number" id="minExperience" name="minExperience" min="0" max="50" value="0"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            
                            <div>
                                <label for="minRating" class="block text-gray-700 font-medium mb-2">Minimum Rating</label>
                                <input type="number" id="minRating" name="minRating" min="0" max="5" step="0.1" value="0"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                    </div>
                    
                    <div class="flex justify-center pt-4">
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-8 rounded-lg transition duration-300">
                            Search Tutors
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Search Tips Section -->
            <div class="bg-blue-50 rounded-lg p-6">
                <h3 class="text-xl font-semibold mb-4">Search & Sorting Tips</h3>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <h4 class="font-bold text-blue-800 mb-2">Search Tips</h4>
                        <ul class="list-disc pl-5 space-y-1">
                            <li>Use <strong>Subject</strong> search to find tutors who teach specific subjects</li>
                            <li>Use <strong>Rating</strong> search to find tutors with a minimum rating</li>
                            <li>Use <strong>Hourly Rate Range</strong> to find tutors within your budget (format: min-max, e.g., 20-50)</li>
                            <li>Use <strong>Experience Range</strong> to find tutors with specific years of experience (format: min-max, e.g., 3-10)</li>
                            <li>Use <strong>Tutor Type</strong> to filter by online or in-person tutors</li>
                        </ul>
                    </div>
                    
                    <div>
                        <h4 class="font-bold text-blue-800 mb-2">Sorting Tips</h4>
                        <ul class="list-disc pl-5 space-y-1">
                            <li>Sort by <strong>Rating</strong> to find the highest-rated tutors</li>
                            <li>Sort by <strong>Hourly Rate</strong> to find the most affordable tutors</li>
                            <li>Sort by <strong>Experience</strong> to find the most experienced tutors</li>
                            <li>Use <strong>Ascending</strong> order for lowest-to-highest sorting</li>
                            <li>Use <strong>Descending</strong> order for highest-to-lowest sorting</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
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
                case 'experience':
                    queryHelp.textContent = 'Enter experience range in years (min-max)';
                    queryInput.placeholder = 'e.g., 3-10';
                    break;
                case 'type':
                    queryHelp.textContent = 'Enter tutor type (online, inperson, or both)';
                    queryInput.placeholder = 'e.g., online';
                    break;
            }
        });
    </script>
</body>
</html>
