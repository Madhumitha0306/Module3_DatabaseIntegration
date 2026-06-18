-- hands_on_3

-- task 1
select s.student_id, s.first_name, s.last_name
from students s
join enrollments e on s.student_id = e.student_id
group by s.student_id, s.first_name, s.last_name
having count(e.course_id) >
(
    select avg(course_count)
    from
    (
        select count(course_id) as course_count
        from enrollments
        group by student_id
    ) as avg_table
);

select course_name from courses c where not exists (select * from enrollments e where e.course_id = c.course_id and e.grade <> 'A');

select p.* from professors p
where salary = (select max(salary)from professors p2 where p2.department_id = p.department_id);

select dept_name, avg_salary from (
    select d.dept_name,
           avg(p.salary) as avg_salary from departments d join professors p on d.department_id = p.department_id group by d.department_id, d.dept_name
) as dept_avg where avg_salary > 85000;

-- task 2
create view vw_student_enrollment_summary as
select
concat(s.first_name,' ',s.last_name) as student_name,
d.dept_name,
count(e.course_id) as courses_enrolled,
avg(
case
when e.grade='A' then 4
when e.grade='B' then 3
when e.grade='C' then 2
when e.grade='D' then 1
else 0
end
) as gpa
from students s
join departments d
on s.department_id=d.department_id
left join enrollments e
on s.student_id=e.student_id
group by s.student_id,d.dept_name;

create view vw_course_stats as
select
c.course_name,
c.course_code,
count(e.student_id) as total_enrollments,
round(
avg(
case
when e.grade='A' then 4
when e.grade='B' then 3
when e.grade='C' then 2
when e.grade='D' then 1
else 0
end
),2) as avg_gpa
from courses c
left join enrollments e
on c.course_id=e.course_id
group by c.course_id,c.course_name,c.course_code;

select *
from vw_student_enrollment_summary
where gpa > 3;

update vw_student_enrollment_summary
set dept_name='Mechanical'
where student_name='Arjun Mehta';

create view vw_cs_students as
select *
from students
where department_id = 1
with check option;

-- task 3

delimiter $$

create procedure sp_enroll_student
(
in p_student_id int,
in p_course_id int,
in p_enrollment_date date
)
begin

if exists
(
select *
from enrollments
where student_id=p_student_id
and course_id=p_course_id
)
then
signal sqlstate '45000'
set message_text='Student already enrolled';
else

insert into enrollments
(student_id,course_id,enrollment_date)
values
(p_student_id,p_course_id,p_enrollment_date);

end if;

end $$

delimiter ;
start transaction;

update students
set department_id = 2
where student_id = 1;

commit;
start transaction;

update students
set department_id = 999
where student_id = 1;

rollback;

start transaction;

insert into enrollments
(student_id,course_id,enrollment_date,grade)
values
(1,3,'2024-01-01','A');

savepoint sp1;

insert into enrollments
(student_id,course_id,enrollment_date,grade)
values
(999,1,'2024-01-01','A');

rollback to sp1;

commit;




