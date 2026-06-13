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