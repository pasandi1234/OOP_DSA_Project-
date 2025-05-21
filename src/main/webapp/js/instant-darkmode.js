/**
 * Instant dark mode application
 * This script applies dark mode immediately before the page renders
 * to prevent flash of unstyled content (FOUC)
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

    // Apply dark mode immediately
    if (isDarkModeEnabled()) {
        document.documentElement.classList.add('dark-mode-html');

        // Create and inject a style element to apply dark mode immediately
        const style = document.createElement('style');
        style.textContent = `
            .dark-mode-html body {
                background-color: #121212 !important;
                color: #ffc107 !important;
            }
            .dark-mode-html header {
                background-color: #000000 !important;
            }
            .dark-mode-html header h1,
            .dark-mode-html header p {
                color: #ffc107 !important;
            }
            .dark-mode-html nav {
                background-color: #000000 !important;
            }
            .dark-mode-html nav a {
                color: #ffc107 !important;
            }
            .dark-mode-html .bg-white,
            .dark-mode-html .bg-gray-100,
            .dark-mode-html .bg-gray-200,
            .dark-mode-html .bg-gray-300,
            .dark-mode-html .container .bg-white,
            .dark-mode-html .max-w-4xl,
            .dark-mode-html .max-w-6xl,
            .dark-mode-html .max-w-3xl,
            .dark-mode-html .rounded-lg {
                background-color: #000000 !important;
                color: #ffc107 !important;
                border-color: #333333 !important;
            }
            .dark-mode-html a {
                color: #ffc107 !important;
            }
            .dark-mode-html table {
                color: #ffc107 !important;
                border-color: #ffc107 !important;
            }
            .dark-mode-html table thead {
                background-color: #000000 !important;
                border-bottom: 2px solid #ffc107 !important;
            }
            .dark-mode-html table tbody tr {
                background-color: #000000 !important;
                border-bottom: 1px solid #333333 !important;
            }
            .dark-mode-html input,
            .dark-mode-html textarea,
            .dark-mode-html select {
                background-color: #000000 !important;
                border: 1px solid #ffc107 !important;
                color: #ffc107 !important;
            }
            .dark-mode-html button,
            .dark-mode-html .btn,
            .dark-mode-html a.bg-blue-600,
            .dark-mode-html a.bg-green-600,
            .dark-mode-html a.bg-red-600,
            .dark-mode-html a.bg-yellow-600,
            .dark-mode-html a.bg-purple-600,
            .dark-mode-html a.bg-gray-600,
            .dark-mode-html .bg-blue-600 {
                background-color: #000000 !important;
                border: 2px solid #ffc107 !important;
                color: #ffc107 !important;
            }
            .dark-mode-html footer {
                background-color: #000000 !important;
                color: #ffc107 !important;
                border-top: 1px solid #333333 !important;
            }
        `;
        document.head.appendChild(style);

        // Add event listener to apply dark mode to the body as soon as it's available
        document.addEventListener('DOMContentLoaded', function() {
            document.body.classList.add('dark-mode');

            // Apply dark mode to specific elements that might not be caught by CSS
            const applyDarkModeDirectly = function() {
                // Apply to all elements with class bg-white or bg-gray-100
                document.querySelectorAll('.bg-white, .bg-gray-100, .bg-gray-200, .bg-gray-300').forEach(el => {
                    el.style.backgroundColor = '#000000';
                    el.style.color = '#ffc107';
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
            };

            // Apply immediately
            applyDarkModeDirectly();

            // Apply again after a short delay to catch any dynamically loaded content
            setTimeout(applyDarkModeDirectly, 500);
        });
    }
})();
