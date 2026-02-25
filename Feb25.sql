-- All products with more than 10 reviews, ordered by the number of reviews in descending order
SELECT p.prod_id,
       p.prod_name,
       (SELECT COUNT(*) FROM reviews r WHERE r.prod_id = p.prod_id) AS review_count
FROM products p
WHERE (SELECT COUNT(*) FROM reviews r WHERE r.prod_id = p.prod_id) > 10
ORDER BY review_count DESC;



-- All FidZulu users with their sessions (including users without sessions) - using LEFT JOIN to include all users and their session details if available
SELECT p.cat_id   AS parent_id,
       p.cat_name AS parent_name,
       c.cat_id   AS child_id,
       c.cat_name AS child_name
FROM categories p
LEFT JOIN categories c ON c.cat_parentid = p.cat_id
WHERE p.cat_parentid IS NULL
ORDER BY p.cat_name, c.cat_name;


-- All FidZulu users with their sessions (including users without sessions) - using LEFT JOIN to include all users and their session details if available
SELECT u.user_id,
       u.user_username,
       u.user_email,
       u.user_role
FROM users u
WHERE u.user_id IN (SELECT s.user_id 
                     FROM sessions s
                     WHERE s.ses_expiresat > (SYSDATE - TO_DATE('1970-01-01', 'YYYY-MM-DD')) * 24 * 60 * 60 * 1000)
ORDER BY u.user_username;