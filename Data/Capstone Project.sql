# Module End Assignment: 
# “Analyzing E-Learning Platform Purchases using MySQL”
# Creating e-learning purchase data database
create database e_learning_purchase;
use e_learning_purchase;

# Creating learners table
create table learners(
learner_id int primary key,
full_name varchar(100) not null,
country varchar(100) not null
);

# Creating courses table
create table courses(
course_id int primary key,
course_name varchar(100) not null,
category varchar(100) not null,
unit_price decimal(10,2)
);

# Creating purchases table
create table purchases(
purchase_id int primary	key auto_increment,
learner_id int,
course_id int,
quantity int not null,                  
purchase_date date not null,
constraint fk_learner foreign key (learner_id) references learners(learner_id),
constraint fk_course foreign key (course_id) references courses(course_id)
);

#1. Create the database and schema. Populate the Schema:
#Inserting sample data into learners:
insert into learners (learner_id, full_name, country) values
(1, 'Arun Kumar', 'India'),
(2, 'Bala Mani', 'India'),
(3, 'Theepika S', 'USA'),
(4, 'Manoj kumar', 'UK'),
(5, 'Liu Jung', 'China');

#Inserting sample data into courses:
insert into courses (course_id, course_name, category, unit_price) values
(101, 'Data Analytics', 'Analytics', 45.50),
(102, 'Python Programming', 'Programming', 70.65),
(103, 'Software Testing', 'Automation', 59.99),
(104, 'Machine Learning Basics', 'AI', 95.50),
(105, 'Excel Advanced', 'Productivity', 38.70);

#Inserting sample data into purchase records:
insert into purchases (purchase_id, learner_id, course_id, quantity, purchase_date) values
(1001, 1, 101, 1, '2025-01-10'),
(1002, 2, 102, 1, '2025-01-12'),
(1003, 3, 103, 2, '2025-01-15'),
(1004, 1, 104, 1, '2025-02-01'),
(1005, 4, 101, 1, '2025-02-05'),
(1006, 5, 105, 3, '2025-02-10'),
(1007, 2, 103, 1, '2025-02-15'),
(1008, 3, 102, 2, '2025-02-20');

#2. Data Exploration Using Joins
#2a. Format currency values to 2 decimal places
#Use aliases for column names (e.g., AS total_revenue)
#Sort results appropriately (e.g., highest total_spent first).

select 
    l.full_name as learner_name, c.course_name,
    round(p.quantity * c.unit_price, 2) as total_amount,
    p.purchase_date
from learners l
join purchases p 
    on l.learner_id = p.learner_id
join courses c 
    on p.course_id = c.course_id
order by total_amount desc;

#2b. Use SQL INNER JOIN, LEFT JOIN, and RIGHT JOIN to:
#Combine learner, course, and purchase data.
#Display each learner’s purchase details (course name, category, quantity, total amount, and purchase date).

#1. Inner Join
select c.course_name, c.category, p.quantity, 
round(p.quantity * c.unit_price, 2) as total_amount, p.purchase_date 
from learners l
inner join purchases as p 
on l.learner_id = p.learner_id
inner join courses as c 
on p.course_id = c.course_id
order by total_amount desc;

#2. Left Join
select c.course_name, c.category, p.quantity, 
round(p.quantity * c.unit_price, 2) as total_amount, p.purchase_date 
from learners l
left join purchases as p 
on l.learner_id = p.learner_id
left join courses as c 
on p.course_id = c.course_id
order by total_amount desc;

#3. Right Join
select c.course_name, c.category, p.quantity, 
round(p.quantity * c.unit_price, 2) as total_amount, p.purchase_date 
from purchases p
right join learners as l 
on p.learner_id = l.learner_id
right join courses as c 
on p.course_id = c.course_id
order by total_amount desc;

#3. Analytical Queries
# Write SQL queries to answer the following questions:
# Q1. Display each learner’s total spending (quantity × unit_price) along with their country.
select l.full_name as learner_name, l.country,
round(sum(p.quantity * c.unit_price), 2) as total_spending
from learners l
left join purchases p 
on l.learner_id = p.learner_id
left join courses c 
on p.course_id = c.course_id
group by l.full_name, l.country
order by total_spending desc;

# Q2. Find the top 3 most purchased courses based on total quantity sold.
select 
c.course_name as course_name,
sum(p.quantity) as total_quantity_sold
from courses c
join purchases p 
on c.course_id = p.course_id
group by c.course_name
order by total_quantity_sold desc
limit 3;

# Q3. Show each course category’s total revenue and the number of unique learners who purchased from that category.
select 
c.category as category,
round(sum(p.quantity * c.unit_price), 2) as total_revenue,
count(distinct p.learner_id) as unique_learners
from courses c
join purchases p 
on c.course_id = p.course_id
group by c.category
order by total_revenue desc;

# Q4. List all learners who have purchased courses from more than one category.
select 
l.full_name as learner_name,
count(distinct c.category) as category_count
from learners l
join purchases p 
on l.learner_id = p.learner_id
join courses c 
on p.course_id = c.course_id
group by l.full_name
having count(distinct c.category) > 1;

# Q5. Identify courses that have not been purchased at all.
select c.course_name, c.category 
from courses as c
left join purchases p 
on c.course_id = p.course_id
where p.purchase_id is null;