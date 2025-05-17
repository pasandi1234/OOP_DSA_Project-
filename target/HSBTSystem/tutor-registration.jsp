<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Registration - Home Tutor Search and Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="bg-blue-600 text-white py-6">
        <div class="container mx-auto px-4">
            <h1 class="text-3xl font-bold text-center">Home Tutor Search and Booking System</h1>
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
        <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
            <h2 class="text-2xl font-bold text-center mb-6">Tutor Registration</h2>
            
            <form action="register-tutor" method="post" class="space-y-6">
                <!-- Personal Information Section -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Personal Information</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="name" class="block text-gray-700 font-medium mb-2">Full Name</label>
                            <input type="text" id="name" name="name" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="email" class="block text-gray-700 font-medium mb-2">Email Address</label>
                            <input type="email" id="email" name="email" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="phone" class="block text-gray-700 font-medium mb-2">Phone Number</label>
                            <input type="tel" id="phone" name="phone" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>
                </div>

                <!-- Professional Information Section -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Professional Information</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="subjects" class="block text-gray-700 font-medium mb-2">Subjects (Select multiple)</label>
                            <select id="subjects" name="subjects" multiple required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" size="5">
                                <option value="Mathematics">Mathematics</option>
                                <option value="Physics">Physics</option>
                                <option value="Chemistry">Chemistry</option>
                                <option value="Biology">Biology</option>
                                <option value="Computer Science">Computer Science</option>
                                <option value="English">English</option>
                                <option value="History">History</option>
                                <option value="Geography">Geography</option>
                                <option value="Foreign Languages">Foreign Languages</option>
                                <option value="Music">Music</option>
                                <option value="Art">Art</option>
                            </select>
                            <p class="text-sm text-gray-500 mt-1">Hold Ctrl (or Cmd) to select multiple subjects</p>
                        </div>
                        <div>
                            <div class="mb-4">
                                <label for="experience" class="block text-gray-700 font-medium mb-2">Years of Experience</label>
                                <input type="number" id="experience" name="experience" min="0" required
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label for="hourlyRate" class="block text-gray-700 font-medium mb-2">Hourly Rate ($)</label>
                                <input type="number" id="hourlyRate" name="hourlyRate" min="0" step="0.01" required
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tutor Type Section -->
                <div class="bg-blue-50 p-4 rounded-lg">
                    <h3 class="text-xl font-semibold mb-4">Tutor Type</h3>
                    <div class="flex flex-col space-y-2">
                        <label class="inline-flex items-center">
                            <input type="radio" name="tutorType" value="online" checked
                                class="form-radio text-blue-600" onclick="showTutorTypeFields('online')">
                            <span class="ml-2">Online Tutor</span>
                        </label>
                        <label class="inline-flex items-center">
                            <input type="radio" name="tutorType" value="inperson"
                                class="form-radio text-blue-600" onclick="showTutorTypeFields('inperson')">
                            <span class="ml-2">In-Person Tutor</span>
                        </label>
                        <label class="inline-flex items-center">
                            <input type="radio" name="tutorType" value="both"
                                class="form-radio text-blue-600" onclick="showTutorTypeFields('both')">
                            <span class="ml-2">Both Online and In-Person</span>
                        </label>
                    </div>

                    <!-- Online Tutor Fields -->
                    <div id="onlineFields" class="mt-4 p-4 border border-blue-200 rounded-lg">
                        <h4 class="font-medium mb-3">Online Tutoring Details</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="platform" class="block text-gray-700 font-medium mb-2">Preferred Platform</label>
                                <select id="platform" name="platform"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="Zoom">Zoom</option>
                                    <option value="Google Meet">Google Meet</option>
                                    <option value="Microsoft Teams">Microsoft Teams</option>
                                    <option value="Skype">Skype</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div>
                                <label for="timezone" class="block text-gray-700 font-medium mb-2">Time Zone</label>
                                <select id="timezone" name="timezone"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="GMT-12">GMT-12</option>
                                    <option value="GMT-11">GMT-11</option>
                                    <option value="GMT-10">GMT-10</option>
                                    <option value="GMT-9">GMT-9</option>
                                    <option value="GMT-8">GMT-8</option>
                                    <option value="GMT-7">GMT-7</option>
                                    <option value="GMT-6">GMT-6</option>
                                    <option value="GMT-5">GMT-5</option>
                                    <option value="GMT-4">GMT-4</option>
                                    <option value="GMT-3">GMT-3</option>
                                    <option value="GMT-2">GMT-2</option>
                                    <option value="GMT-1">GMT-1</option>
                                    <option value="GMT" selected>GMT</option>
                                    <option value="GMT+1">GMT+1</option>
                                    <option value="GMT+2">GMT+2</option>
                                    <option value="GMT+3">GMT+3</option>
                                    <option value="GMT+4">GMT+4</option>
                                    <option value="GMT+5">GMT+5</option>
                                    <option value="GMT+6">GMT+6</option>
                                    <option value="GMT+7">GMT+7</option>
                                    <option value="GMT+8">GMT+8</option>
                                    <option value="GMT+9">GMT+9</option>
                                    <option value="GMT+10">GMT+10</option>
                                    <option value="GMT+11">GMT+11</option>
                                    <option value="GMT+12">GMT+12</option>
                                </select>
                            </div>
                            <div class="col-span-1 md:col-span-2">
                                <div class="flex space-x-4">
                                    <label class="inline-flex items-center">
                                        <input type="checkbox" name="webcam" value="true"
                                            class="form-checkbox text-blue-600">
                                        <span class="ml-2">Has Webcam</span>
                                    </label>
                                    <label class="inline-flex items-center">
                                        <input type="checkbox" name="recordings" value="true"
                                            class="form-checkbox text-blue-600">
                                        <span class="ml-2">Provides Recordings</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- In-Person Tutor Fields -->
                    <div id="inpersonFields" class="mt-4 p-4 border border-blue-200 rounded-lg hidden">
                        <h4 class="font-medium mb-3">In-Person Tutoring Details</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="location" class="block text-gray-700 font-medium mb-2">Primary Location</label>
                                <input type="text" id="location" name="location"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label for="travelRadius" class="block text-gray-700 font-medium mb-2">Travel Radius (km)</label>
                                <input type="number" id="travelRadius" name="travelRadius" min="0"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div class="col-span-1 md:col-span-2">
                                <div class="flex space-x-4">
                                    <label class="inline-flex items-center">
                                        <input type="checkbox" name="travelToStudent" value="true"
                                            class="form-checkbox text-blue-600">
                                        <span class="ml-2">Willing to travel to student's location</span>
                                    </label>
                                    <label class="inline-flex items-center">
                                        <input type="checkbox" name="materials" value="true"
                                            class="form-checkbox text-blue-600">
                                        <span class="ml-2">Provides learning materials</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-lg transition duration-300">
                        Register as Tutor
                    </button>
                </div>
            </form>
        </div>
    </div>

    <footer class="bg-gray-800 text-white py-6 mt-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2023 Home Tutor Search and Booking System. All rights reserved.</p>
        </div>
    </footer>

    <script>
        function showTutorTypeFields(type) {
            const onlineFields = document.getElementById('onlineFields');
            const inpersonFields = document.getElementById('inpersonFields');
            
            if (type === 'online') {
                onlineFields.classList.remove('hidden');
                inpersonFields.classList.add('hidden');
            } else if (type === 'inperson') {
                onlineFields.classList.add('hidden');
                inpersonFields.classList.remove('hidden');
            } else if (type === 'both') {
                onlineFields.classList.remove('hidden');
                inpersonFields.classList.remove('hidden');
            }
        }
    </script>
</body>
</html>
