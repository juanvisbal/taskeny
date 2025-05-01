import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "skipLink", 
    "focusable", 
    "announcer", 
    "modal"
  ]

  connect() {
    // Set up trap focus for modals
    if (this.hasModalTarget) {
      this.setupModalAccessibility()
    }
    
    // Set up keyboard navigation for interactive elements
    this.setupKeyboardNavigation()
  }
  
  // Handles the skip link functionality
  skipToContent(event) {
    event.preventDefault()
    const mainContent = document.getElementById('main-content')
    if (mainContent) {
      mainContent.setAttribute('tabindex', '-1')
      mainContent.focus()
      // Remove tabindex after focus to prevent odd keyboard navigation
      setTimeout(() => {
        mainContent.removeAttribute('tabindex')
      }, 100)
    }
  }
  
  // Announce messages to screen readers
  announce(message, priority = 'polite') {
    if (this.hasAnnouncerTarget) {
      const announcer = this.announcerTarget
      announcer.setAttribute('aria-live', priority)
      announcer.textContent = message
      
      // Clear after a delay
      setTimeout(() => {
        announcer.textContent = ''
      }, 3000)
    }
  }
  
  // Setup modal accessibility
  setupModalAccessibility() {
    this.modalTarget.addEventListener('keydown', this.handleModalKeydown.bind(this))
  }
  
  handleModalKeydown(event) {
    // Close modal on ESC key
    if (event.key === 'Escape') {
      this.closeModal()
    }
    
    // Trap focus within modal
    if (event.key === 'Tab') {
      this.trapFocus(event)
    }
  }
  
  trapFocus(event) {
    const focusableElements = this.modalTarget.querySelectorAll(
      'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
    )
    
    const firstElement = focusableElements[0]
    const lastElement = focusableElements[focusableElements.length - 1]
    
    if (event.shiftKey && document.activeElement === firstElement) {
      event.preventDefault()
      lastElement.focus()
    } else if (!event.shiftKey && document.activeElement === lastElement) {
      event.preventDefault()
      firstElement.focus()
    }
  }
  
  // Enhanced keyboard navigation
  setupKeyboardNavigation() {
    if (this.hasFocusableTarget) {
      this.focusableTargets.forEach(element => {
        if (element.tagName !== 'BUTTON' && element.tagName !== 'A' && element.tagName !== 'INPUT') {
          element.setAttribute('tabindex', '0')
          element.addEventListener('keydown', (event) => {
            if (event.key === 'Enter' || event.key === ' ') {
              event.preventDefault()
              element.click()
            }
          })
        }
      })
    }
  }
  
  closeModal() {
    // Implementation depends on how modals are handled in your application
    this.modalTarget.classList.add('hidden')
    this.announce('Modal closed')
  }
}