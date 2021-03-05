-- Exercise 1 
-- Find Earliest Date A User Joined
SELECT 
    DATE_FORMAT(created_at, "%M %D %Y") AS earliest_date
FROM users
ORDER BY created_at ASC
LIMIT 1;

-- Exercise 2
-- Find email of the first (earliest) user
SELECT *
FROM users
WHERE created_at = (SELECT MIN(created_at) FROM users);

-- Exercise 3
-- Users according to the month they joined
-- Descending order based off month joined
SELECT 
    MONTHNAME(created_at) AS month,
    COUNT(*) as count
FROM users
GROUP BY month
ORDER BY count DESC, month DESC;

-- Exercise 4
-- Count number of users with yahoo emails
SELECT
    COUNT(*) as yahoo_users
FROM users
WHERE email LIKE '%@yahoo.com';

-- Exercise 5
-- Calculate total number of userse for each email host
SELECT 
    CASE
        WHEN email LIKE '%@gmail.com' THEN 'gmail'
        WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
        WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
        ELSE 'other'
    END AS 'provider',
    COUNT(email) as total_users
FROM users
GROUP BY provider
ORDER BY total_users DESC;

-- Exercise 5 using regex
-- LIKE is supposedly faster than REGEXP according to stackoverflow

-- SELECT 
--     CASE
--         WHEN email REGEXP '@gmail.com$' THEN 'gmail'
--         WHEN email REGEXP '@yahoo.com$' THEN 'yahoo'
--         WHEN email REGEXP '@hotmail.com$' THEN 'hotmail'
--         ELSE 'other'
--     END AS 'provider',
--     COUNT(email) as total_users
-- FROM users
-- GROUP BY provider
-- ORDER BY total_users DESC;