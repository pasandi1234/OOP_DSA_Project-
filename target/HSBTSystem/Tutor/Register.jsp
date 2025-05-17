<%--
  Created by IntelliJ IDEA.
  User: Venura
  Date: 12/05/2025
  Time: 13:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="${pageContext.request.contextPath}/js/global-darkmode.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global-darkmode.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Management System</title>
    <style>
        :root {
            --primary: #4a6fa5;
            --secondary: #166088;
            --light: #f8f9fa;
            --dark: #343a40;
            --success: #28a745;
            --warning: #ffc107;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .navbar {
            background-color: var(--primary);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 1.5rem;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .nav-links a:hover {
            background-color: var(--secondary);
        }
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: var(--secondary);
        }
        .btn-success {
            background-color: var(--success);
        }
        .btn-warning {
            background-color: var(--warning);
            color: var(--dark);
        }
        .form-group {
            margin-bottom: 1rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        input, select, textarea {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }
        .search-bar {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .search-bar input {
            flex: 1;
        }
        .tutor-card {
            display: flex;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 1rem;
        }
        .tutor-avatar {
            width: 100px;
            height: 100px;
            background-color: #eee;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: #666;
        }
        .tutor-info {
            flex: 1;
            padding: 1rem;
        }
        .tutor-name {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .tutor-subject {
            color: var(--secondary);
            margin-bottom: 0.5rem;
        }
        .tutor-rating {
            color: var(--warning);
            margin-bottom: 0.5rem;
        }
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="logo">TutorTree</div>
    <div class="nav-links">
        <a href="#register">Register Tutor</a>
        <a href="#search">Search Tutors</a>
        <a href="#dashboard">Dashboard</a>
    </div>
</nav>

<div class="container">
    <!-- Content will be loaded here based on navigation -->
    <div id="content">
        <!-- Default dashboard content -->
        <h1>Welcome to Tutor Management System</h1>
        <p>Use the navigation above to manage tutors, search for expertise, or update records.</p>
    </div>
</div>

<script>
    // This would be replaced with actual routing in a real application
    document.querySelectorAll('.nav-links a').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const page = this.getAttribute('href').substring(1);
            loadPage(page);
        });
    });

    function loadPage(page) {
        const contentDiv = document.getElementById('content');

        if (page === 'register') {
            contentDiv.innerHTML = `
                    <h1>Register New Tutor</h1>
                    <div class="card">
                        <form id="tutorForm">
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <input type="text" id="name" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="tel" id="phone">
                            </div>
                            <div class="form-group">
                                <label for="subject">Subject Expertise</label>
                                <select id="subject" required>
                                    <option value="">Select Subject</option>
                                    <option value="Mathematics">Mathematics</option>
                                    <option value="Physics">Physics</option>
                                    <option value="Chemistry">Chemistry</option>
                                    <option value="Biology">Biology</option>
                                    <option value="Computer Science">Computer Science</option>
                                    <option value="English">English</option>
                                    <option value="History">History</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="experience">Years of Experience</label>
                                <input type="number" id="experience" min="0" required>
                            </div>
                            <div class="form-group">
                                <label for="rating">Rating (1-5)</label>
                                <input type="number" id="rating" min="1" max="5" step="0.1" required>
                            </div>
                            <div class="form-group">
                                <label for="availability">Availability</label>
                                <select id="availability" required>
                                    <option value="Full-time">Full-time</option>
                                    <option value="Part-time">Part-time</option>
                                    <option value="Weekends">Weekends only</option>
                                    <option value="Evenings">Evenings only</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="bio">Bio/Description</label>
                                <textarea id="bio" rows="4"></textarea>
                            </div>
                            <button type="submit" class="btn btn-success">Register Tutor</button>
                        </form>
                    </div>
                `;
        } else if (page === 'search') {
            contentDiv.innerHTML = `
                    <h1>Search Tutors</h1>
                    <div class="card">
                        <div class="search-bar">
                            <input type="text" id="searchQuery" placeholder="Search by name or subject...">
                            <button class="btn" onclick="searchTutors()">Search</button>
                        </div>
                        <div id="searchResults">
                            <!-- Sample tutor cards -->
                            <div class="tutor-card">
                                <div class="tutor-avatar">JD</div>
                                <div class="tutor-info">
                                    <div class="tutor-name">John Doe</div>
                                    <div class="tutor-subject">Mathematics</div>
                                    <div class="tutor-rating">★★★★☆ (4.2)</div>
                                    <div>5 years experience | Available: Full-time</div>
                                    <div class="action-buttons">
                                        <button class="btn" onclick="viewProfile('1')">View Profile</button>
                                        <button class="btn btn-warning" onclick="editTutor('1')">Edit</button>
                                        <button class="btn btn-danger" onclick="deleteTutor('1')">Delete</button>
                                    </div>
                                </div>
                            </div>
                            <div class="tutor-card">
                                <div class="tutor-avatar">AS</div>
                                <div class="tutor-info">
                                    <div class="tutor-name">Alice Smith</div>
                                    <div class="tutor-subject">Computer Science</div>
                                    <div class="tutor-rating">★★★★★ (4.9)</div>
                                    <div>8 years experience | Available: Part-time</div>
                                    <div class="action-buttons">
                                        <button class="btn" onclick="viewProfile('2')">View Profile</button>
                                        <button class="btn btn-warning" onclick="editTutor('2')">Edit</button>
                                        <button class="btn btn-danger" onclick="deleteTutor('2')">Delete</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
        } else if (page === 'dashboard') {
            contentDiv.innerHTML = `
                    <h1>Dashboard</h1>
                    <div class="card">
                        <h2>System Overview</h2>
                        <p>Total Tutors: 24</p>
                        <p>Most Popular Subject: Mathematics (8 tutors)</p>
                        <p>Highest Rated Tutor: Alice Smith (4.9)</p>
                    </div>
                    <div class="card">
                        <h2>Recent Additions</h2>
                        <div class="tutor-card">
                            <div class="tutor-avatar">MB</div>
                            <div class="tutor-info">
                                <div class="tutor-name">Michael Brown</div>
                                <div class="tutor-subject">Physics</div>
                                <div class="tutor-rating">★★★☆☆ (3.7)</div>
                                <div>2 years experience | Available: Weekends</div>
                            </div>
                        </div>
                    </div>
                `;
        }
    }

    // Sample functions that would be implemented in a real application
    function searchTutors() {
        // BST traversal search would be implemented here
        alert('Search functionality would traverse the BST to find matching tutors');
    }

    function viewProfile(id) {
        // Display tutor profile page
        const contentDiv = document.getElementById('content');
        contentDiv.innerHTML = `
                <h1>Tutor Profile</h1>
                <div class="card">
                    <div style="display: flex; gap: 2rem;">
                        <div class="tutor-avatar" style="width: 150px; height: 150px;">JD</div>
                        <div>
                            <h2>John Doe</h2>
                            <p><strong>Email:</strong> john.doe@example.com</p>
                            <p><strong>Phone:</strong> (555) 123-4567</p>
                            <p><strong>Subject:</strong> Mathematics</p>
                            <p><strong>Experience:</strong> 5 years</p>
                            <p><strong>Rating:</strong> ★★★★☆ (4.2)</p>
                            <p><strong>Availability:</strong> Full-time</p>
                        </div>
                    </div>
                    <div style="margin-top: 1.5rem;">
                        <h3>Bio</h3>
                        <p>John is a passionate mathematics tutor with 5 years of experience teaching high school and college students. He specializes in algebra, calculus, and geometry.</p>
                    </div>
                    <div class="action-buttons" style="margin-top: 1.5rem;">
                        <button class="btn btn-warning" onclick="editTutor('1')">Edit Profile</button>
                        <button class="btn" onclick="loadPage('search')">Back to Search</button>
                    </div>
                </div>
            `;
    }

    function editTutor(id) {
        // Load edit form with tutor data
        const contentDiv = document.getElementById('content');
        contentDiv.innerHTML = `
                <h1>Edit Tutor Profile</h1>
                <div class="card">
                    <form id="editTutorForm">
                        <div class="form-group">
                            <label for="editName">Full Name</label>
                            <input type="text" id="editName" value="John Doe" required>
                        </div>
                        <div class="form-group">
                            <label for="editEmail">Email</label>
                            <input type="email" id="editEmail" value="john.doe@example.com" required>
                        </div>
                        <div class="form-group">
                            <label for="editPhone">Phone</label>
                            <input type="tel" id="editPhone" value="(555) 123-4567">
                        </div>
                        <div class="form-group">
                            <label for="editSubject">Subject Expertise</label>
                            <select id="editSubject" required>
                                <option value="Mathematics" selected>Mathematics</option>
                                <option value="Physics">Physics</option>
                                <option value="Chemistry">Chemistry</option>
                                <option value="Biology">Biology</option>
                                <option value="Computer Science">Computer Science</option>
                                <option value="English">English</option>
                                <option value="History">History</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="editExperience">Years of Experience</label>
                            <input type="number" id="editExperience" min="0" value="5" required>
                        </div>
                        <div class="form-group">
                            <label for="editRating">Rating (1-5)</label>
                            <input type="number" id="editRating" min="1" max="5" step="0.1" value="4.2" required>
                        </div>
                        <div class="form-group">
                            <label for="editAvailability">Availability</label>
                            <select id="editAvailability" required>
                                <option value="Full-time" selected>Full-time</option>
                                <option value="Part-time">Part-time</option>
                                <option value="Weekends">Weekends only</option>
                                <option value="Evenings">Evenings only</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="editBio">Bio/Description</label>
                            <textarea id="editBio" rows="4">John is a passionate mathematics tutor with 5 years of experience teaching high school and college students. He specializes in algebra, calculus, and geometry.</textarea>
                        </div>
                        <div class="action-buttons">
                            <button type="submit" class="btn btn-success">Save Changes</button>
                            <button type="button" class="btn" onclick="viewProfile('1')">Cancel</button>
                        </div>
                    </form>
                </div>
            `;
    }

    function deleteTutor(id) {
        // BST delete operation would be implemented here
        if (confirm('Are you sure you want to delete this tutor?')) {
            alert('Tutor would be removed from the BST');
            loadPage('search');
        }
    }

    // Load dashboard by default
    loadPage('dashboard');
</script>
</body>
</html>
