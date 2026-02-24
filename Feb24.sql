-- All FidZulu users with their sessions (including users without sessions)
SELECT u.user_id,
       u.user_username,
       u.user_email,
       u.user_firstname,
       u.user_lastname,
       u.user_role,
       u.user_startdate,
       u.user_lastlogin,
       u.user_isactive,
       s.ses_token,
       s.ses_createdat,
       s.ses_expiresat,
       s.ses_eventtype,
       s.ses_caller_ip
FROM users u
LEFT JOIN sessions s
  ON u.user_id = s.user_id
ORDER BY u.user_id, s.ses_createdat DESC;


-- All FidZulu users with their sessions (including users without sessions) - only user_id, username, session token and session created date - using NVL to replace NULL session tokens with 'N/A'

SELECT u.user_id,
       u.user_username,
       NVL(s.ses_token, 'N/A') AS session_token,
         s.ses_createdat
FROM users u
LEFT JOIN sessions s
  ON u.user_id = s.user_id
ORDER BY u.user_id, s.ses_createdat DESC;

-- All FidZulu users with their sessions (including users without sessions) - only user_id, username, session token and session created date - using COALESCE instead of NVL

SELECT u.user_id,
       u.user_username,
       COALESCE(s.ses_token, 'N/A') AS session_token, s.ses_createdat
FROM users u
LEFT JOIN sessions s
  ON u.user_id = s.user_id
ORDER BY u.user_id, s.ses_createdat DESC;


---------------Working with the forbidden right join
-- All users with their accounts (including users without accounts)
SELECT u.user_id,
       u.user_username,
       a.acc_id,
       a.acc_startdate
FROM accounts a
RIGHT JOIN users u
  ON u.user_id = a.user_id
ORDER BY u.user_id;


-----------Working with multi joins
-- All accounts with their type and addresses (keeping accounts without addresses)
SELECT a.acc_id,
       at.type_name,
       ad.add_street,
       ad.add_city
FROM accounts a
INNER JOIN account_type at
  ON a.type_id = at.type_id
LEFT JOIN addresses ad
  ON a.acc_id = ad.acc_id
ORDER BY a.acc_id;