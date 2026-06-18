-- hands_on_2
-- task 1

INSERT INTO departments (dept_name, hod_name, budget) VALUES
  ('Computer Science', 'Dr. Ramesh Kumar', 850000.00),
  ('Electronics', 'Dr. Priya Nair', 620000.00),
  ('Mechanical', 'Dr. Suresh Iyer', 540000.00),
  ('Civil', 'Dr. Ananya Sharma', 430000.00);
  INSERT INTO students (first_name, last_name, email, date_of_birth, department_id, 
enrollment_year) VALUES
  ('Arjun',  'Mehta',    'arjun.mehta@college.edu',    '2003-04-12', 1, 2022),
  ('Priya',  'Suresh',   'priya.suresh@college.edu',   '2003-07-25', 1, 2022),
  ('Rohan',  'Verma',    'rohan.verma@college.edu',    '2002-11-08', 2, 2021),
  ('Sneha',  'Patel',    'sneha.patel@college.edu',    '2004-01-30', 3, 2023),
  ('Vikram', 'Das',      'vikram.das@college.edu',     '2003-09-14', 1, 2022),
  ('Kavya',  'Menon',    'kavya.menon@college.edu',    '2002-05-17', 2, 2021),
  ('Aditya', 'Singh',    'aditya.singh@college.edu',   '2004-03-22', 4, 2023),
  ('Deepika','Rao',      'deepika.rao@college.edu',    '2003-08-09', 1, 2022);

INSERT INTO courses (course_name, course_code, credits, department_id) VALUES
  ('Data Structures & Algorithms', 'CS101', 4, 1),
  ('Database Management Systems',  'CS102', 3, 1),
  ('Object Oriented Programming',  'CS103', 4, 1),
  ('Circuit Theory',               'EC101', 3, 2),
  ('Thermodynamics',               'ME101', 3, 3);

INSERT INTO enrollments (student_id, course_id, enrollment_date, grade) VALUES
  (1, 1, '2022-07-01', 'A'), (1, 2, '2022-07-01', 'B'),
  (2, 1, '2022-07-01', 'B'), (2, 3, '2022-07-01', 'A'),
  (3, 4, '2021-07-01', 'A'), (4, 5, '2023-07-01', NULL),
  (5, 1, '2022-07-01', 'C'), (5, 2, '2022-07-01', 'A'),
  (6, 4, '2021-07-01', 'B'), (7, 5, '2023-07-01', NULL),
  (8, 1, '2022-07-01', 'A'), (8, 3, '2022-07-01', 'B');

INSERT INTO professors (prof_name, email, department_id, salary) VALUES
  ('Dr. Anand Krishnan',  'anand.k@college.edu',   1, 95000.00),
  ('Dr. Meena Pillai',    'meena.p@college.edu',   1, 88000.00),
  ('Dr. Sunil Rajan',     'sunil.r@college.edu',   2, 82000.00),
  ('Dr. Latha Gopal',     'latha.g@college.edu',   3, 79000.00),
  ('Dr. Kartik Bose',     'kartik.b@college.edu',  4, 76000.00);
  
 insert into students (first_name,last_name,email,date_of_birth,department_id,enrollment_year) values('arun','kumar','arun.kumar@college.edu','2004-05-15',1,2023),('priya','sharma','priya.sharma@college.edu','2004-08-20',2,2023);
update enrollments set grade='B' where student_id=5 and course_id=1;
delete from enrollments where grade is null;
set sql_safe_updates =0
select count(*) as total_students from students;

-- task 2

select count(*) as total_enrollments from enrollments;
select * from enrollments

select * from students where enrollment_year=2022 order by last_name;

-- task 3
select * from courses where credits > 3 order by credits desc;

select enrollment_year, count(*) as total_students from students group by enrollment_year;

select concat(s.first_name,' ',s.last_name) as student_name, d.dept_name from students s inner join departments d on s.department_id=d.department_id;

select concat(s.first_name,' ',s.last_name) as student_name, c.course_name from enrollments e inner join students s on e.student_id=s.student_id inner join courses c on e.course_id=c.course_id;

select s.student_id, s.first_name, s.last_name from students s left join enrollments e on s.student_id=e.student_id where e.student_id is null;

select c.course_name, count(e.student_id) as enrollment_count from courses c left join enrollments e on c.course_id=e.course_id group by c.course_id,c.course_name;

select d.dept_name, p.prof_name, p.salary from departments d left join professors p on d.department_id=p.department_id;

-- task 4

select c.course_name, count(e.student_id) as enrollment_count from courses c left join enrollments e on c.course_id=e.course_id group by c.course_id,c.course_name;

select d.dept_name,
round(avg(p.salary),2) as average_salary from departments d inner join professors p on d.department_id=p.department_id group by d.dept_name;
select * from departments where budget > 600000;

select grade, count(*) as grade_count from enrollments e inner join courses c on e.course_id=c.course_id where c.course_code='CS101' group by grade;

select d.dept_name, count(s.student_id) as total_students
from departments d inner join students s on d.department_id=s.department_id group by d.department_id,d.dept_name having count(s.student_id) > 2;