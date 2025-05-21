/**
 * Global Dark Mode Script
 * This script is designed to be included in every JSP file
 * to ensure dark mode is applied consistently across the entire site
 */

(function() {
    // Check if dark mode is enabled in local storage
    function isDarkModeEnabled() {
        // If no preference is set, default to dark mode
        if (localStorage.getItem('darkMode') === null) {
            return true;
        }
        return localStorage.getItem('darkMode') === 'enabled';
    }

    // Apply dark mode to the page
    function applyDarkMode() {
        document.documentElement.classList.add('dark-mode-html');
        document.body.classList.add('dark-mode');
        
        // Apply to all elements with specific classes
        document.querySelectorAll('.bg-white, .bg-gray-100, .bg-gray-200, .bg-gray-300, .max-w-4xl, .max-w-6xl, .max-w-3xl, .rounded-lg').forEach(el => {
            el.style.backgroundColor = '#000000';
            el.style.color = '#ffc107';
            if (el.style.borderColor) {
                el.style.borderColor = '#333333';
            }
        });
        
        // Apply to all tables
        document.querySelectorAll('table').forEach(table => {
            table.style.color = '#ffc107';
            table.style.borderColor = '#ffc107';
        });
        
        // Apply to all table headers
        document.querySelectorAll('table thead').forEach(thead => {
            thead.style.backgroundColor = '#000000';
            thead.style.borderBottom = '2px solid #ffc107';
        });
        
        // Apply to all table rows
        document.querySelectorAll('table tbody tr').forEach(tr => {
            tr.style.backgroundColor = '#000000';
            tr.style.borderBottom = '1px solid #333333';
        });
        
        // Apply to all links
        document.querySelectorAll('a').forEach(a => {
            a.style.color = '#ffc107';
        });
        
        // Apply to all buttons
        document.querySelectorAll('button, .btn, a.bg-blue-600, a.bg-green-600, a.bg-red-600, a.bg-yellow-600, a.bg-purple-600, a.bg-gray-600, .bg-blue-600').forEach(btn => {
            btn.style.backgroundColor = '#000000';
            btn.style.borderColor = '#ffc107';
            btn.style.color = '#ffc107';
        });
        
        // Apply to header
        document.querySelectorAll('header').forEach(header => {
            header.style.backgroundColor = '#000000';
            header.style.color = '#ffc107';
        });
        
        // Apply to navigation
        document.querySelectorAll('nav').forEach(nav => {
            nav.style.backgroundColor = '#000000';
        });
        
        document.querySelectorAll('nav a').forEach(a => {
            a.style.color = '#ffc107';
        });
        
        // Apply to footer
        document.querySelectorAll('footer').forEach(footer => {
            footer.style.backgroundColor = '#000000';
            footer.style.color = '#ffc107';
            footer.style.borderTop = '1px solid #333333';
        });
        
        // Apply to inputs
        document.querySelectorAll('input, textarea, select').forEach(input => {
            input.style.backgroundColor = '#000000';
            input.style.borderColor = '#ffc107';
            input.style.color = '#ffc107';
        });
    }

    // Create dark mode toggle button
    function createDarkModeToggle() {
        if (!document.getElementById('darkModeToggle')) {
            const darkModeToggle = document.createElement('button');
            darkModeToggle.id = 'darkModeToggle';
            darkModeToggle.style.position = 'fixed';
            darkModeToggle.style.top = '20px';
            darkModeToggle.style.right = '20px';
            darkModeToggle.style.zIndex = '9999';
            darkModeToggle.style.width = '40px';
            darkModeToggle.style.height = '40px';
            darkModeToggle.style.borderRadius = '50%';
            darkModeToggle.style.display = 'flex';
            darkModeToggle.style.alignItems = 'center';
            darkModeToggle.style.justifyContent = 'center';
            darkModeToggle.style.cursor = 'pointer';
            darkModeToggle.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.3)';
            darkModeToggle.style.transition = 'all 0.3s ease';
            
            if (isDarkModeEnabled()) {
                darkModeToggle.style.backgroundColor = '#000000';
                darkModeToggle.style.color = '#ffc107';
                darkModeToggle.style.border = '2px solid #ffc107';
                darkModeToggle.innerHTML = '<i class="fas fa-sun" style="font-size: 20px;"></i>';
                darkModeToggle.title = 'Switch to Light Mode';
            } else {
                darkModeToggle.style.backgroundColor = '#ffffff';
                darkModeToggle.style.color = '#333333';
                darkModeToggle.style.border = '2px solid #333333';
                darkModeToggle.innerHTML = '<i class="fas fa-moon" style="font-size: 20px;"></i>';
                darkModeToggle.title = 'Switch to Dark Mode';
            }
            
            darkModeToggle.addEventListener('click', function() {
                if (isDarkModeEnabled()) {
                    localStorage.setItem('darkMode', 'disabled');
                    location.reload();
                } else {
                    localStorage.setItem('darkMode', 'enabled');
                    location.reload();
                }
            });
            
            document.body.appendChild(darkModeToggle);
        }
    }

    // Apply dark mode on page load
    if (isDarkModeEnabled()) {
        // Apply immediately
        document.documentElement.classList.add('dark-mode-html');
        
        // Apply when DOM is ready
        document.addEventListener('DOMContentLoaded', function() {
            applyDarkMode();
            createDarkModeToggle();
        });
    } else {
        // Create toggle button when DOM is ready
        document.addEventListener('DOMContentLoaded', function() {
            createDarkModeToggle();
        });
    }
})();
