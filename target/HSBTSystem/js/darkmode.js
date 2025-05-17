/**
 * Dark mode functionality for the Home Tutor Search and Booking System
 * Implements a dark mode with yellow accent colors and black background
 */

// Check if dark mode is enabled in local storage
function isDarkModeEnabled() {
    // If no preference is set, default to dark mode
    if (localStorage.getItem('darkMode') === null) {
        return true;
    }
    return localStorage.getItem('darkMode') === 'enabled';
}

// Enable dark mode
function enableDarkMode() {
    document.documentElement.classList.add('dark-mode-html');
    document.body.classList.add('dark-mode');
    localStorage.setItem('darkMode', 'enabled');
    updateDarkModeToggle(true);

    // Apply to all iframes
    applyDarkModeToFrames();

    // Apply to all elements with class bg-white or bg-gray-100
    document.querySelectorAll('.bg-white, .bg-gray-100, .bg-gray-200, .bg-gray-300').forEach(el => {
        el.style.backgroundColor = '#000000';
        el.style.color = '#ffc107';
    });
}

// Disable dark mode
function disableDarkMode() {
    document.documentElement.classList.remove('dark-mode-html');
    document.body.classList.remove('dark-mode');
    localStorage.setItem('darkMode', 'disabled');
    updateDarkModeToggle(false);

    // Apply to all iframes
    applyDarkModeToFrames();

    // Reset inline styles
    document.querySelectorAll('.bg-white, .bg-gray-100, .bg-gray-200, .bg-gray-300').forEach(el => {
        el.style.backgroundColor = '';
        el.style.color = '';
    });
}

// Update the dark mode toggle button
function updateDarkModeToggle(isDark) {
    const darkModeToggle = document.getElementById('darkModeToggle');
    if (darkModeToggle) {
        if (isDark) {
            darkModeToggle.innerHTML = '<i class="fas fa-sun" style="font-size: 20px;"></i>';
            darkModeToggle.title = 'Switch to Light Mode';
            darkModeToggle.setAttribute('aria-label', 'Switch to Light Mode');
        } else {
            darkModeToggle.innerHTML = '<i class="fas fa-moon" style="font-size: 20px;"></i>';
            darkModeToggle.title = 'Switch to Dark Mode';
            darkModeToggle.setAttribute('aria-label', 'Switch to Dark Mode');
        }
    }
}

// Toggle dark mode
function toggleDarkMode() {
    if (isDarkModeEnabled()) {
        disableDarkMode();
    } else {
        enableDarkMode();
    }
}

// Apply dark mode to all frames and iframes
function applyDarkModeToFrames() {
    const frames = document.querySelectorAll('iframe');
    frames.forEach(frame => {
        try {
            if (frame.contentDocument) {
                if (isDarkModeEnabled()) {
                    if (frame.contentDocument.documentElement) {
                        frame.contentDocument.documentElement.classList.add('dark-mode-html');
                    }
                    if (frame.contentDocument.body) {
                        frame.contentDocument.body.classList.add('dark-mode');

                        // Apply to all elements with class bg-white or bg-gray-100 in the iframe
                        frame.contentDocument.querySelectorAll('.bg-white, .bg-gray-100, .bg-gray-200, .bg-gray-300').forEach(el => {
                            el.style.backgroundColor = '#000000';
                            el.style.color = '#ffc107';
                        });
                    }
                } else {
                    if (frame.contentDocument.documentElement) {
                        frame.contentDocument.documentElement.classList.remove('dark-mode-html');
                    }
                    if (frame.contentDocument.body) {
                        frame.contentDocument.body.classList.remove('dark-mode');

                        // Reset inline styles in the iframe
                        frame.contentDocument.querySelectorAll('.bg-white, .bg-gray-100, .bg-gray-200, .bg-gray-300').forEach(el => {
                            el.style.backgroundColor = '';
                            el.style.color = '';
                        });
                    }
                }
            }
        } catch (e) {
            // Ignore cross-origin frame errors
        }
    });
}

// Initialize dark mode based on user preference
document.addEventListener('DOMContentLoaded', function() {
    // Create dark mode toggle button if it doesn't exist
    if (!document.getElementById('darkModeToggle')) {
        const darkModeToggle = document.createElement('button');
        darkModeToggle.id = 'darkModeToggle';
        darkModeToggle.className = 'fixed top-4 right-4 z-50 bg-white text-gray-800 rounded-full w-12 h-12 flex items-center justify-center shadow-lg transition duration-300 focus:outline-none';
        darkModeToggle.style.border = '2px solid #333';
        darkModeToggle.addEventListener('click', function() {
            toggleDarkMode();
            // Broadcast dark mode change to other tabs/windows
            localStorage.setItem('darkModeTimestamp', Date.now().toString());
        });
        darkModeToggle.setAttribute('aria-label', 'Toggle Dark Mode');

        document.body.appendChild(darkModeToggle);
    }

    // Initialize dark mode based on user preference (default to dark mode)
    if (isDarkModeEnabled()) {
        enableDarkMode();
    } else {
        disableDarkMode();
    }

    // Apply dark mode to frames
    applyDarkModeToFrames();

    // Listen for dark mode changes from other tabs/windows
    window.addEventListener('storage', function(event) {
        if (event.key === 'darkMode') {
            if (event.newValue === 'enabled') {
                enableDarkMode();
            } else {
                disableDarkMode();
            }
            applyDarkModeToFrames();
        }
    });

    // Apply dark mode on page load
    document.body.style.visibility = 'hidden';
    setTimeout(function() {
        if (isDarkModeEnabled()) {
            document.documentElement.classList.add('dark-mode-html');
            document.body.classList.add('dark-mode');

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
        }
        document.body.style.visibility = 'visible';
    }, 10);
});
