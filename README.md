# 🎓 KUET Career Club Website

A full-stack web application built for the KUET Career Club — connecting students, alumni, and companies through job postings, career resources, blog articles, and collaboration opportunities.

-----

## 🛠️ Tech Stack

|Layer       |Technology                                      |
|------------|------------------------------------------------|
|Frontend    |ASP.NET Web Forms, Bootstrap 5, CSS3, JavaScript|
|Backend     |C# (ASP.NET Code-Behind)                        |
|Database    |SQL Server                                      |
|Architecture|Master Page (Site.master) pattern               |
|IDE         |Visual Studio                                   |

-----

## 📁 Project Structure
Club_Website/
│
├── home.aspx / .cs              # Homepage with stats, job carousel, events
├── register.aspx / .cs          # User registration with password hashing
├── login.aspx / .cs             # User login with session & cookie support
├── logout.aspx / .cs            # Session clear and redirect
├── forgot-password.aspx / .cs   # Password reset request
├── reset-password.aspx / .cs    # Password update with token validation
│
├── jobs.aspx / .cs              # Job board with search & filter
├── jobdetails.aspx / .cs        # Full job details by ID
├── post-job.aspx / .cs          # Job posting form for companies/alumni
├── apply.aspx / .cs             # Job application form for students
│
├── students.aspx / .cs          # Current club members listing
├── alumni.aspx / .cs            # KUET alumni listing
├── companies.aspx / .cs         # Partner companies listing
│
├── blogs.aspx / .cs             # Blog listing with search & category filter
├── article.aspx / .cs           # Full article view by slug
│
├── collaborate.aspx / .cs       # Collaboration request form
├── contact.aspx / .cs           # Contact form
├── feedback.aspx / .cs          # Feedback form
├── support.aspx / .cs           # Support request form
│
├── faq.aspx / .cs               # Frequently Asked Questions
├── help.aspx / .cs              # Help page
├── privacy.aspx / .cs           # Privacy Policy
├── terms.aspx / .cs             # Terms of Service
├── refund.aspx / .cs            # Refund Policy
│
├── admin/                       # Admin panel (session-protected)
│
├── App_Code/                    # Shared helper classes (e.g. PasswordHelper)
├── App_Data/                    # App data files
├── db/migrations/               # SQL database migration scripts
├── images/                      # Static image assets
├── Uploads/                     # User-uploaded files
│
├── Site.master / .cs            # Master page (shared navbar & footer)
├── style.css                    # Global stylesheet
├── script.js                    # Global JavaScript
└── Web.config                   # App configuration & DB connection string

-----

## ✨ Features

### 🏠 Home Page

- Scrolling marquee for live announcements
- Animated statistics counter (students, alumni, jobs, events) using JavaScript requestAnimationFrame
- Live job carousel auto-fetched from the database, auto-scrolling every 4.2 seconds
- Career Counselling section with Book Mock Interview and Career Path Planning modals
- Upcoming Events section with event registration via ASP.NET UpdatePanel (no full page reload)

### 🔐 Authentication

- Register — form data saved to SQL Server with password hashed using salt via PasswordHelper class
- Login — credential validation with Session storage; “Remember Me” saves email in cookie for 7 days; automatic password hash upgrade for legacy plain-text accounts
- Forgot Password — email-based reset link generation
- Reset Password — token-validated password update
- Logout — full session clear

### 💼 Jobs

- Job Board — keyword search + department + job type filters using parameterized SQL queries (SQL Injection protected); color-coded badges (green = Full-Time, blue = Internship, yellow = Part-Time); sorted newest first
- Job Details — full job info loaded by job ID from URL query string
- Post a Job — form for companies/alumni to add new listings
- Apply — student application form linked to job ID and user account

### 👥 People

- Students — current club members fetched from database
- Alumni — KUET graduates who can post jobs and mentor students
- Companies — partner organizations

### 📝 Blogs & Articles

- Blog listing — live keyword search with AutoPostBack; category filter buttons (All, Software Engineering, Interview Prep, Higher Education) using CommandArgument in C#; “No match found” panel shown/hidden from code-behind
- Article page — full article content loaded dynamically by slug from URL
- Sidebar Quick Links for fast category navigation

### 🤝 Collaborate

- Partnership request form for companies and alumni (mentorship, corporate drives, R&D sponsorships)

### 📬 Communication

- Contact, Feedback, Support — all forms save messages to database for admin review

### 🛡️ Admin Panel

- Protected pages under /admin/ folder
- Session-based access control — unauthorized users are redirected
- Manage users, jobs, blogs, and events

-----

## 🗄️ Database

- SQL Server database with tables for Users, Jobs, Applications, Articles, Events, Contacts, Feedback, and more
- Schema managed through migration scripts in db/migrations/
- Connection string stored securely in Web.config
- All queries use parameterized commands to prevent SQL Injection

-----

## 🚀 How to Run Locally

1. Clone the repository
   
     git clone https://github.com/Aurin-662/Club_Website.git
   1. Open in Visual Studio
- Open the folder as a Website project in Visual Studio
1. Set up the database
- Create a SQL Server database
- Run the migration scripts from db/migrations/ in order
1. Update connection string
- Open Web.config
- Update the connectionString value with your SQL Server details
1. Run the project
- Press F5 or click Start in Visual Studio
- The site will open at localhost in your browser

-----

## 👤 Author

**KUET Career Club Website**  
Web Programming Laboratory
Aurin Farzana | Roll : 2207107  
Khulna University of Engineering & Technology (KUET)


## Notes

- Developed for academic and learning purposes.
- Started as a static HTML/CSS/JavaScript website before being migrated to ASP.NET Web Forms.