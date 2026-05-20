# MySQL-Project
📊 E-Learning Platform Purchase Analysis (MySQL Project)
📌 Project Overview

This project focuses on analyzing learner purchase data for an e-learning platform using MySQL. By leveraging SQL queries, joins, and aggregation techniques, the project uncovers valuable insights into sales trends, learner behavior, and course performance.

🎯 Objectives
Analyze learner purchase patterns
Identify top-performing courses and categories
Evaluate revenue distribution
Detect high-value customers
Highlight low-performing courses
🗂️ Database Structure

The analysis is based on three main tables:

Learners – Contains learner details (ID, name, country, etc.)
Courses – Stores course information (course name, category, price)
Purchases – Tracks transactions (learner ID, course ID, quantity, purchase date)
🛠️ Key SQL Concepts Used
INNER JOIN, LEFT JOIN, RIGHT JOIN
Aggregation functions (SUM, COUNT)
GROUP BY and ORDER BY
Subqueries
Filtering using WHERE and HAVING
🔍 Key Insights
📈 Sales Analysis
Identified top-selling courses based on total quantity purchased
Analyzed category-wise revenue to find high-performing segments
👥 Learner Behavior
Evaluated learner spending patterns
Identified high-value customers
Detected learners purchasing across multiple categories
⚠️ Performance Gaps
Found courses with no purchases indicating low demand
💡 Business Recommendations
🚀 Promote top-performing courses and categories through campaigns
💸 Improve low-performing course sales using discounts and offers
🎯 Target high-spending learners with personalized recommendations
🔄 Encourage cross-category learning for better engagement
📊 Sample Queries
-- Total spending by each learner
SELECT l.name, l.country,
       SUM(p.quantity * c.price) AS total_spent
FROM learners l
JOIN purchases p ON l.learner_id = p.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.name, l.country
ORDER BY total_spent DESC;
-- Top-selling courses
SELECT c.course_name,
       SUM(p.quantity) AS total_quantity
FROM courses c
JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.course_name
ORDER BY total_quantity DESC;

ER Diagram:
<img width="581" height="366" alt="ER_Diagram" src="https://github.com/user-attachments/assets/f16ce8f8-8bf3-4f9d-b0b0-ffe878b97ac7" />


📦 Project Outcome

This project demonstrates how SQL can transform raw data into actionable business insights, helping organizations make data-driven decisions to improve revenue and customer engagement.

🚀 Future Enhancements
Add visualization using Power BI / Tableau
Build a dashboard for real-time insights
Implement advanced analytics (RFM analysis, cohort analysis)
📎 Author

[Theepika S]
Data Analyst | SQL | Data Analytics
