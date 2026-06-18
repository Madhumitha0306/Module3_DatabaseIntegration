-- hands_on_4
-- task 1
use college_db
explain select s.student_id, s.first_name, s.last_name, c.course_name from enrollments e join students s on s.student_id = e.student_id join courses c on c.course_id = e.course_id where s.enrollment_year = 2022;
-- task 2

create index idx_students_enrollment_year on students(enrollment_year)
create unique index idx_enrollments_student_course on enrollments(student_id, course_id)
create index idx_courses_course_code on courses(course_code)
explain select s.student_id, s.first_name, s.last_name, c.course_name
from enrollments e join students s on s.student_id = e.student_id join courses c on c.course_id = e.course_id where s.enrollment_year = 2022;

create index idx_enrollments_grade on enrollments(grade);

-- task 3

