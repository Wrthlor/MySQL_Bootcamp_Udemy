-- Challenge 1 - Finding 5 oldest users
SELECT * 
FROM users 
ORDER BY created_at ASC
LIMIT 5;

-- Challenge 2 - Most popular registration calendar day
SELECT 
    DAYNAME(created_at) AS day,
    count(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2; -- We discover there's 2 days with highest creation count

-- Challenge 3 - Users who've never posted a photo
SELECT username
FROM users
LEFT JOIN photos   
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Challenge 4 - Who had the most likes in a single photo?
SELECT 
    username,
    photos.id,
    photos.image_url,
    COUNT(likes.photo_id) AS totalLikes
FROM photos
INNER JOIN likes
    ON photos.id = likes.photo_id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY totalLikes DESC
LIMIT 1;

-- Challenge 5 - How many times does the average user post?
-- Total number of photos divided by total number of users
SELECT (
    (SELECT COUNT(*) FROM photos) /
    (SELECT COUNT(*) FROM users)
) AS avg;

SELECT
    users.id,
    users.username,
    IFNULL(AVG(photos.user_id), 0) as "average posts"
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
GROUP BY users.id;

-- Challenge 6 - What are the top 5 most commonly used hashtags?
SELECT
    tags.tag_name,
    COUNT(photo_tags.tag_id) AS tag_count
FROM tags
INNER JOIN photo_tags
    ON tags.id = photo_tags.tag_id
GROUP BY photo_tags.tag_id
ORDER BY tag_count DESC
LIMIT 5;

-- Challenge 7 - Find users who've liked every single photo on site
SELECT
    users.username,
    COUNT(*) AS total_likes
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes = (
    SELECT COUNT(*) FROM photos
);