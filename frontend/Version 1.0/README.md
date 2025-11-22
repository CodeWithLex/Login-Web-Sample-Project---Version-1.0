# Sample Login Project - Frontend

## 📁 Project Structure

```
Version 1.0/
├── css/
│   ├── base.css         # Base styles (shared across all pages)
│   ├── form.css         # Form styles (login & register pages)
│   ├── welcome.css      # Welcome page specific styles
│   └── dashboard.css    # Dashboard page specific styles
├── welcome.html         # Welcome/loading page
├── index.html           # Login page
├── register.html        # Registration page
├── dashboard.html       # Dashboard page
├── style.css            # Legacy file (can be removed)
└── README.md            # This file
```

## 🎨 CSS Architecture

### **base.css** - Foundation Styles
- CSS variables and root settings
- Animated gradient background
- Body and layout base styles
- Background title text
- Utility classes (error, helper, muted)
- Responsive breakpoints

### **form.css** - Form Components
- Card container with animations
- Form layouts and inputs
- Password toggle functionality
- Checkbox styles
- Primary and secondary buttons
- Used by: `index.html`, `register.html`

### **welcome.css** - Welcome Page
- Welcome container animations
- Loading dots animation
- Progress bar
- Welcome-specific typography
- Used by: `welcome.html`

### **dashboard.css** - Dashboard Page
- Dashboard container styles
- Logout button
- Dashboard-specific layouts
- Used by: `dashboard.html`

## 📄 Pages Overview

### 1. **welcome.html** - Welcome/Loading Page
- Entry point of the application
- Shows a beautiful loading animation with "Welcome to My Sample Page"
- Automatically redirects to the login page after 3 seconds
- Features:
  - Animated welcome title
  - Loading dots animation
  - Progress bar
  - Smooth transitions

### 2. **index.html** - Login Page
- Main login page
- Features:
  - Email and password fields with validation
  - Show/hide password toggle
  - Remember me checkbox
  - Responsive design with animated gradient background
  - Error handling and feedback messages
  - Link to create account page

### 3. **register.html** - Registration Page
- Account creation page with the same styling as login page
- Features:
  - Email field with validation
  - Password field with strength requirements (minimum 6 characters)
  - Confirm password field
  - Show/hide password toggles for both fields
  - Password match validation
  - Success redirect to login page
  - Link back to login page

### 4. **dashboard.html** - Dashboard Page
- Logged-in user dashboard
- Shows welcome message and user email
- Logout functionality

## Usage Flow

1. **Start**: Open `welcome.html` to see the loading screen
2. **Login**: After 3 seconds, redirected to `index.html` (login page)
3. **Register**: Click "Create account" to go to `register.html`
4. **Dashboard**: After successful login, redirected to `dashboard.html`

## 🎯 CSS Best Practices Implemented

### Separation of Concerns
- **Base styles** are separated from page-specific styles
- **Shared components** (forms) have their own stylesheet
- **Page-specific styles** are modular and independent

### Benefits
✅ **Better Organization** - Easy to find and modify styles
✅ **Maintainability** - Changes to one page won't affect others
✅ **Performance** - Load only necessary CSS per page
✅ **Scalability** - Easy to add new pages with consistent styling
✅ **Reusability** - Common components can be reused

### Styling Features
- Animated gradient background
- Modern card-based layout
- Smooth animations and transitions
- Responsive design for mobile devices
- Professional color scheme
- Modular CSS architecture

## Backend Integration

- Login API: `http://localhost:8081/login-backend/api/login`
- Register API: `http://localhost:8081/login-backend/api/register`

Make sure your backend server is running on port 8081 before testing.
