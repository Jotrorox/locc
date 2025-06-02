// Mobile menu functionality
function initMobileMenu() {
    const mobileToggle = document.querySelector('.mobile-menu-toggle');
    const navLinks = document.querySelector('.nav-links');
    
    if (!mobileToggle || !navLinks) return;
    
    let isMenuOpen = false;
    
    // Initially hide nav links on mobile
    if (window.innerWidth <= 768) {
        navLinks.style.display = 'none';
    }
    
    mobileToggle.addEventListener('click', () => {
        isMenuOpen = !isMenuOpen;
        
        if (isMenuOpen) {
            navLinks.style.display = 'flex';
            navLinks.style.animation = 'slideDownFade 0.3s ease-out forwards';
            mobileToggle.setAttribute('aria-expanded', 'true');
        } else {
            navLinks.style.animation = 'slideUpFade 0.3s ease-in forwards';
            mobileToggle.setAttribute('aria-expanded', 'false');
            setTimeout(() => {
                if (!isMenuOpen) navLinks.style.display = 'none';
            }, 300);
        }
    });
    
    // Close menu when clicking on nav links
    navLinks.addEventListener('click', (e) => {
        if (e.target.tagName === 'A' && window.innerWidth <= 768) {
            isMenuOpen = false;
            navLinks.style.animation = 'slideUpFade 0.3s ease-in forwards';
            mobileToggle.setAttribute('aria-expanded', 'false');
            setTimeout(() => {
                navLinks.style.display = 'none';
            }, 300);
        }
    });
    
    // Handle window resize
    window.addEventListener('resize', () => {
        if (window.innerWidth > 768) {
            navLinks.style.display = 'flex';
            navLinks.style.animation = 'none';
            isMenuOpen = false;
            mobileToggle.setAttribute('aria-expanded', 'false');
        } else if (!isMenuOpen) {
            navLinks.style.display = 'none';
        }
    });
}

// Add mobile menu animations to CSS
function addMobileMenuStyles() {
    if (document.querySelector('#mobile-menu-styles')) return;
    
    const style = document.createElement('style');
    style.id = 'mobile-menu-styles';
    style.textContent = `
        @keyframes slideDownFade {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes slideUpFade {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(-10px);
            }
        }
    `;
    document.head.appendChild(style);
}

// Scroll animations
function initScrollAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    // Observe elements for animation
    const animateElements = document.querySelectorAll('.feature, .install-option, .usage-example, .language-category');
    animateElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
}

// Enhanced smooth scrolling with offset for sticky header
function smoothScrollToSection(target) {
    const element = document.querySelector(target);
    if (!element) return;
    
    const headerHeight = document.querySelector('.header').offsetHeight;
    const elementPosition = element.offsetTop - headerHeight - 20;
    
    window.scrollTo({
        top: elementPosition,
        behavior: 'smooth'
    });
}

// Copy to clipboard functionality
function copyToClipboard(text) {
    navigator.clipboard.writeText(text).then(function() {
        // Show temporary feedback
        const event = new Event('clipboard-copy');
        document.dispatchEvent(event);
        
        // Optional: Show a temporary success message
        showToast('Copied to clipboard!');
    }, function(err) {
        console.error('Could not copy text: ', err);
        showToast('Failed to copy to clipboard');
    });
}

// Simple toast notification
function showToast(message) {
    // Remove any existing toast
    const existingToast = document.querySelector('.toast');
    if (existingToast) {
        existingToast.remove();
    }
    
    // Create new toast
    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.textContent = message;
    toast.style.cssText = `
        position: fixed;
        top: 2rem;
        right: 2rem;
        background: var(--accent-green);
        color: var(--bg-primary);
        padding: 1rem 1.5rem;
        border-radius: 8px;
        font-weight: 600;
        z-index: 1000;
        animation: slideIn 0.3s ease-out;
    `;
    
    // Add CSS animation
    if (!document.querySelector('#toast-styles')) {
        const style = document.createElement('style');
        style.id = 'toast-styles';
        style.textContent = `
            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
            @keyframes slideOut {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(100%);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    }
    
    document.body.appendChild(toast);
    
    // Auto remove after 3 seconds
    setTimeout(() => {
        toast.style.animation = 'slideOut 0.3s ease-in';
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

// Smooth scrolling for anchor links
document.addEventListener('DOMContentLoaded', function() {
    // Initialize mobile menu
    addMobileMenuStyles();
    initMobileMenu();
    
    // Initialize scroll animations
    initScrollAnimations();
    
    // Smooth scrolling for navigation links
    const navLinks = document.querySelectorAll('a[href^="#"]');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            smoothScrollToSection('#' + targetId);
        });
    });
    
    // Add scroll effect to header
    const header = document.querySelector('.header');
    let lastScrollY = window.scrollY;
    
    window.addEventListener('scroll', () => {
        const currentScrollY = window.scrollY;
        
        if (currentScrollY > 100) {
            header.style.background = 'rgba(26, 26, 26, 0.95)';
            header.style.backdropFilter = 'blur(10px)';
        } else {
            header.style.background = 'var(--bg-secondary)';
            header.style.backdropFilter = 'none';
        }
        
        lastScrollY = currentScrollY;
    });
    
    // Terminal typing animation on scroll
    const terminal = document.querySelector('.terminal-body');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateTerminal();
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });
    
    if (terminal) {
        observer.observe(terminal);
    }
    
    // Initialize scroll animations
    initScrollAnimations();
});

// Terminal typing animation
function animateTerminal() {
    const lines = document.querySelectorAll('.terminal-line');
    lines.forEach((line, index) => {
        line.style.opacity = '0';
        line.style.transform = 'translateY(10px)';
        line.style.transition = 'all 0.5s ease';
        
        setTimeout(() => {
            line.style.opacity = '1';
            line.style.transform = 'translateY(0)';
        }, index * 200);
    });
}

// Add some interactive effects
document.addEventListener('DOMContentLoaded', function() {
    // Add hover effects to feature cards
    const features = document.querySelectorAll('.feature');
    features.forEach(feature => {
        feature.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-10px) scale(1.02)';
        });
        
        feature.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });
    
    // Add hover effects to language tags
    const tags = document.querySelectorAll('.tag');
    tags.forEach(tag => {
        tag.addEventListener('mouseenter', function() {
            this.style.background = 'var(--accent-cyan)';
            this.style.color = 'var(--bg-primary)';
            this.style.transform = 'scale(1.05)';
        });
        
        tag.addEventListener('mouseleave', function() {
            this.style.background = 'var(--bg-tertiary)';
            this.style.color = 'var(--text-primary)';
            this.style.transform = 'scale(1)';
        });
    });
});

// Add a simple particle effect to the hero section (optional)
document.addEventListener('DOMContentLoaded', function() {
    createFloatingParticles();
});

function createFloatingParticles() {
    const hero = document.querySelector('.hero');
    if (!hero) return;
    
    for (let i = 0; i < 20; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';
        particle.style.cssText = `
            position: absolute;
            width: 2px;
            height: 2px;
            background: var(--accent-cyan);
            border-radius: 50%;
            opacity: 0.3;
            animation: float ${3 + Math.random() * 4}s ease-in-out infinite;
            left: ${Math.random() * 100}%;
            top: ${Math.random() * 100}%;
            animation-delay: ${Math.random() * 2}s;
        `;
        
        hero.style.position = 'relative';
        hero.style.overflow = 'hidden';
        hero.appendChild(particle);
    }
    
    // Add floating animation
    if (!document.querySelector('#particle-styles')) {
        const style = document.createElement('style');
        style.id = 'particle-styles';
        style.textContent = `
            @keyframes float {
                0%, 100% {
                    transform: translateY(0px) rotate(0deg);
                    opacity: 0.3;
                }
                50% {
                    transform: translateY(-20px) rotate(180deg);
                    opacity: 0.6;
                }
            }
        `;
        document.head.appendChild(style);
    }
}

// Initialize mobile menu and add styles on DOM content loaded
document.addEventListener('DOMContentLoaded', function() {
    initMobileMenu();
    addMobileMenuStyles();
});
