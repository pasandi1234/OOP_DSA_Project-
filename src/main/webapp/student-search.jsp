<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Students - EduBridge</title>
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
            <a href="student-registration.jsp" class="hover:underline font-medium">Register as Student</a>
            <a href="tutor-search.jsp" class="hover:underline font-medium">Search Tutors</a>
            <a href="student-search.jsp" class="hover:underline font-medium">Search Students</a>
            <a href="dashboard.jsp" class="hover:underline font-medium">Dashboard</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        <div class="max-w-6xl mx-auto">
            <h2 class="text-2xl font-bold text-center mb-6">Search for Students</h2>
            
            <!-- Search Form -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <form action="search-students" method="get" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <label for="searchType" class="block text-gray-700 font-medium mb-2">Search By</label>
                            <select id="searchType" name="searchType" 
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="name">Name</option>
                                <option value="subject">Preferred Subject</option>
                                <option value="all">All Students</option>
                            </select>
                        </div>
                        <div>
                            <label for="query" class="block text-gray-700 font-medium mb-2">Search Query</label>
                            <input type="text" id="query" name="query" placeholder="Enter search term..."
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <p id="queryHelp" class="text-sm text-gray-500 mt-1">Enter name or preferred subject</p>
                        </div>
                        <div class="flex items-end">
                            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg transition duration-300">
                                Search
                            </button>
                        </div>
                    </div>
                    
                    <div class="border-t border-gray-200 pt-4 mt-4">
                        <div class="flex items-center">
                            <input type="checkbox" id="activeOnly" name="activeOnly" value="true" checked
                                class="form-checkbox text-blue-600">
                            <label for="activeOnly" class="ml-2 text-gray-700">Show active students only</label>
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
            
            <!-- Sample Student Cards (These would be replaced by actual search results) -->
            <div class="grid grid-cols-1 gap-6">
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="p-6 flex flex-col md:flex-row">
                        <div class="flex-shrink-0 flex items-center justify-center bg-blue-100 rounded-full w-24 h-24 md:mr-6 mb-4 md:mb-0 mx-auto md:mx-0">
                            <span class="text-blue-800 text-2xl font-bold">DF</span>
                        </div>
                        <div class="flex-grow">
                            <div class="flex flex-col md:flex-row md:justify-between md:items-start">
                                <div>
                                    <h3 class="text-xl font-bold">Dinuli Ferdinando</h3>
                                    <p class="text-gray-600">Commerce Stream</p>
                                    <p class="text-gray-600 mt-1">Preferred Subjects: Accounting , Econ ,ICT</p>
                                    <p class="text-gray-600 mt-1">Preferred Days: Monday, Wednesday</p>
                                    <p class="text-gray-600">Preferred Time: Afternoon</p>
                                    <p class="text-green-600 font-medium">Active</p>
                                </div>
                                <div class="flex flex-col space-y-2 mt-4 md:mt-0">
                                    <a href="view-student?id=1" class="bg-blue-600 hover:bg-blue-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        View Profile
                                    </a>
                                    <a href="update-student?id=1" class="bg-yellow-500 hover:bg-yellow-600 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        Edit
                                    </a>
                                    <a href="delete-student?id=1" class="bg-red-600 hover:bg-red-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300"
                                       onclick="return confirm('Are you sure you want to delete this student?')">
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
                            <span class="text-blue-800 text-2xl font-bold">UD</span>
                        </div>
                        <div class="flex-grow">
                            <div class="flex flex-col md:flex-row md:justify-between md:items-start">
                                <div>
                                    <h3 class="text-xl font-bold">Upadya Diheli</h3>
                                    <p class="text-gray-600">Physical Science Stream</p>
                                    <p class="text-gray-600 mt-1">Preferred Subjects: Physics, Chemistry , Combined Maths</p>
                                    <p class="text-gray-600 mt-1">Preferred Days: Tuesday, Thursday</p>
                                    <p class="text-gray-600">Preferred Time: Evening</p>
                                    <p class="text-green-600 font-medium">Active</p>
                                </div>
                                <div class="flex flex-col space-y-2 mt-4 md:mt-0">
                                    <a href="view-student?id=2" class="bg-blue-600 hover:bg-blue-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        View Profile
                                    </a>
                                    <a href="update-student?id=2" class="bg-yellow-500 hover:bg-yellow-600 text-white text-center font-medium py-2 px-4 rounded transition duration-300">
                                        Edit
                                    </a>
                                    <a href="delete-student?id=2" class="bg-red-600 hover:bg-red-700 text-white text-center font-medium py-2 px-4 rounded transition duration-300"
                                       onclick="return confirm('Are you sure you want to delete this student?')">
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
                    queryInput.placeholder = 'e.g., Alice';
                    break;
                case 'subject':
                    queryHelp.textContent = 'Enter a preferred subject';
                    queryInput.placeholder = 'e.g., Mathematics';
                    break;
                case 'all':
                    queryHelp.textContent = 'No query needed, will show all students';
                    queryInput.placeholder = '';
                    break;
            }
        });
    </script>
</body>
</html>
