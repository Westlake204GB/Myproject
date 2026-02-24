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