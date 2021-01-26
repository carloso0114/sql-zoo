-- List the teachers who have NULL for their department.
SELECT name 
FROM teacher 
WHERE dept IS NULL
-- Note the INNER JOIN misses the teachers with no department and the departments with no teacher.
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

-- Use a different JOIN so that all teachers are listed.
SELECT teacher.name, dept.name 
FROM teacher LEFT Join dept ON (teacher.dept = dept.id)

-- Use a different JOIN so that all departments are listed.
SELECT teacher.name, dept.name 
FROM teacher RIGHT JOIN dept ON (teacher.dept = dept.id)

-- Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
SELECT name, COALESCE(mobile, '07986 444 2266') 
FROM teacher

-- Use the COALESCE functiON and a LEFT JOIN to print the teacher name and department name. Use the string 'NONe' WHERE there is no department.
SELECT teacher.name, COALESCE(dept.name, 'None') 
FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id)

-- Use COUNT to show the number of teachers and the number of mobile phONes.
SELECT count(teacher.name), count(mobile) 
FROM teacher

-- Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
SELECT dept.name, count(teacher.id) 
FROM teacher RIGHT JOIN dept ON ( teacher.dept = dept.id) GROUP BY dept.name

-- Use CASE to show the name of each teacher followed BY 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT teacher.name, 
CASE 
    WHEN (teacher.dept = 1 OR teacher.dept = 2)
       THEN 'Sci'
       ELSE 'Art'
       END
FROM teacher

-- Use CASE to show the name of each teacher followed BY 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'NONe' otherwise.
SELECT teacher.name, 
CASE WHEN teacher.dept = 1 or teacher.dept = 2
THEN 'Sci'
WHEN teacher.dept = 3
THEN 'Art'
ELSE 'None'
END
FROM teacher
