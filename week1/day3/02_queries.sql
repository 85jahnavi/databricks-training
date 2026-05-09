-- 1. Students and Their Enrolled Courses

SELECT s.student_id,s.student_name,c.course_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id;


-- 2. Courses With No Students Enrolled

SELECT c.course_id, c.course_name
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


-- 3. Instructors and Courses They Teach

SELECT i.instructor_id,i.instructor_name,c.course_name
FROM instructors i
LEFT JOIN courses c
ON i.instructor_id = c.instructor_id;


-- 4. Courses Without Assigned Instructors

SELECT course_id,course_name
FROM courses
WHERE instructor_id IS NULL;


-- 5. Students and Enrollment Information Using RIGHT JOIN

SELECT s.student_id,s.student_name,e.enrollment_id,e.course_id,e.enrollment_date
FROM enrollments e
RIGHT JOIN students s
ON e.student_id = s.student_id;


-- 6. Students Not Enrolled in Any Course

SELECT s.student_id,s.student_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;


-- 7. FULL OUTER JOIN Between Students and Enrollments

SELECT s.student_id,s.student_name,e.enrollment_id,e.course_id,e.enrollment_date
FROM students s
FULL OUTER JOIN enrollments e
ON s.student_id = e.student_id;


-- 8. Courses Never Appearing in Enrollments

SELECT c.course_id,c.course_name
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
WHERE e.course_id IS NULL;


-- 9. FULL OUTER JOIN Between Instructors and Courses

SELECT i.instructor_id,i.instructor_name,c.course_id,c.course_name
FROM instructors i
FULL OUTER JOIN courses c
ON i.instructor_id = c.instructor_id;


-- 10. Student, Course, and Instructor Report

SELECT s.student_name, c.course_name, i.instructor_name
FROM students s
FULL OUTER JOIN enrollments e
ON s.student_id = e.student_id
FULL OUTER JOIN courses c
ON e.course_id = c.course_id
FULL OUTER JOIN instructors i
ON c.instructor_id = i.instructor_id;


-- Bonus Challenge — Every Student and Every Course

SELECT s.student_name,c.course_name
FROM students s
CROSS JOIN courses c;