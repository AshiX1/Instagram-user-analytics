-- Identify the five oldest users 
select * from users
order by created_at asc
limit 5;

--  Identify users who have never posted a single photo on Instagram.
select u.id, u.username from users u 
left join  photos p on u.id = p.user_id
where p.id is null;

-- User with most likes

-- SELECT u.username, l.photo_id, l.total_likes
-- FROM users u
-- JOIN (
--     SELECT photo_id, COUNT(photo_id) AS total_likes
--     FROM likes
--     GROUP BY photo_id
--     ORDER BY total_likes DESC
--     LIMIT 1
-- ) l ON u.id = (SELECT user_id FROM likes WHERE photo_id = l.photo_id LIMIT 1);
SELECT u.username, l.photo_id, l.total_likes
FROM users u
JOIN (
    SELECT photo_id, COUNT(photo_id) AS total_likes, user_id
    FROM likes
    GROUP BY photo_id, user_id
    ORDER BY total_likes DESC
    LIMIT 1
) l ON u.id = l.user_id;


-- The top five most commonly used hashtags on the platform.
select t.tag_name, pt.occurrence
from tags t
join (select tag_id,count(tag_id) occurrence 
from photo_tags 
group by tag_id 
order by occurrence desc
limit 1) pt
on t.id = pt.tag_id;

-- The day of the week when most users register on Instagram
select dayname(created_at) day_name ,count(*) registered_num 
from users
group by day_name
order by registered_num desc
;