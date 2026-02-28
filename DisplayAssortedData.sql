-- ============================================================
-- Question 1
-- Display USERID of users who have not made an order
-- ============================================================

SELECT USERID
FROM USERBASE

MINUS

SELECT USERID
FROM ORDERS;



-- ============================================================
-- Question 2
-- Display PRODUCTCODE of products that have no reviews
-- ============================================================

SELECT PRODUCTCODE
FROM PRODUCTLIST

MINUS

SELECT PRODUCTCODE
FROM REVIEWS;



-- ============================================================
-- Question 3
-- Display USERBASE with Adult or Minor column
-- ============================================================

SELECT 
    U.*,
    CASE
        WHEN MONTHS_BETWEEN(SYSDATE, BIRTHDAY)/12 >= 18 THEN 'Adult'
        ELSE 'Minor'
    END AS AGE_STATUS
FROM USERBASE U;



-- ============================================================
-- Question 4
-- Display PRODUCTLIST with On Sale or Base Price column
-- ============================================================

SELECT 
    P.*,
    CASE
        WHEN PRICE <= 20 THEN 'On Sale'
        ELSE 'Base Price'
    END AS PRICE_STATUS
FROM PRODUCTLIST P;



-- ============================================================
-- Question 5
-- Users who played GAME6 and have a profile image
-- ============================================================

SELECT DISTINCT UL.USERID
FROM USERLIBRARY UL
JOIN USERPROFILE UP
ON UL.USERID = UP.USERID
WHERE UL.PRODUCTCODE = 'GAME6'
AND UP.IMAGEFILE IS NOT NULL;



-- ============================================================
-- Question 6
-- PRODUCTCODE intersection of WISHLIST and REVIEWS
-- ============================================================

SELECT PRODUCTCODE
FROM WISHLIST
WHERE POSITION IN (1,2)

INTERSECT

SELECT PRODUCTCODE
FROM REVIEWS
WHERE RATING >= 3;



-- ============================================================
-- Question 7
-- Users sharing same birthday (self join)
-- ============================================================

SELECT DISTINCT
    A.USERNAME,
    A.BIRTHDAY
FROM USERBASE A
JOIN USERBASE B
ON A.BIRTHDAY = B.BIRTHDAY
AND A.USERID <> B.USERID;



-- ============================================================
-- Question 8
-- Cartesian Product USERLIBRARY and WISHLIST
-- ============================================================

SELECT *
FROM USERLIBRARY
CROSS JOIN WISHLIST;



-- ============================================================
-- Question 9
-- UNION ALL USERBASE and PRODUCTLIST
-- ============================================================

SELECT 
    TO_CHAR(USERID) AS ID,
    USERNAME AS NAME,
    TO_CHAR(BIRTHDAY) AS INFO
FROM USERBASE

UNION ALL

SELECT
    PRODUCTCODE AS ID,
    DESCRIPTION AS NAME,
    TO_CHAR(PRICE) AS INFO
FROM PRODUCTLIST;



-- ============================================================
-- Question 10
-- UNION ALL CHATLOG and USERPROFILE (corrected version)
-- ============================================================

SELECT 
    TO_CHAR(RECEIVERID) AS ID,
    CONTENT AS ACTIVITY,
    TO_CHAR(DATESENT,'YYYY-MM-DD') AS ACTIVITY_DATE
FROM CHATLOG

UNION ALL

SELECT
    TO_CHAR(USERID) AS ID,
    IMAGEFILE AS ACTIVITY,
    NULL AS ACTIVITY_DATE
FROM USERPROFILE;



-- ============================================================
-- Question 11
-- Users with no infractions
-- ============================================================

SELECT USERNAME
FROM USERBASE

MINUS

SELECT UB.USERNAME
FROM USERBASE UB
JOIN INFRACTIONS I
ON UB.USERID = I.USERID;



-- ============================================================
-- Question 12
-- COMMUNITYRULES not broken (corrected version)
-- ============================================================

SELECT TITLE, DESCRIPTION
FROM COMMUNITYRULES

MINUS

SELECT C.TITLE, C.DESCRIPTION
FROM COMMUNITYRULES C
JOIN INFRACTIONS I
ON C.RULENUM = I.RULENUM;



-- ============================================================
-- Question 13
-- Users who received penalties
-- ============================================================

SELECT DISTINCT
    UB.USERNAME,
    UB.EMAIL
FROM USERBASE UB
JOIN INFRACTIONS I
ON UB.USERID = I.USERID;



-- ============================================================
-- Question 14
-- Same dates for INFRACTION and USERSUPPORT
-- ============================================================

SELECT INFRACTIONDATE
FROM INFRACTIONS

INTERSECT

SELECT DATECREATED
FROM USERSUPPORT;



-- ============================================================
-- Question 15
-- Display COMMUNITYRULES TITLE and DESCRIPTION (corrected)
-- ============================================================

SELECT TITLE, DESCRIPTION
FROM COMMUNITYRULES;



-- ============================================================
-- Question 16
-- COMMUNITYRULES Bannable or Appealable
-- ============================================================

SELECT
    C.*,
    CASE
        WHEN SEVERITYPOINT >= 10 THEN 'Bannable'
        ELSE 'Appealable'
    END AS RULE_STATUS
FROM COMMUNITYRULES C;



-- ============================================================
-- Question 17
-- USERSUPPORT High Priority tickets
-- ============================================================

SELECT
    U.*,
    CASE
        WHEN STATUS <> 'CLOSED'
        AND DATEUPDATED < SYSDATE - 7
        THEN 'High Priority'
        ELSE 'Normal'
    END AS PRIORITY_STATUS
FROM USERSUPPORT U;



-- ============================================================
-- Question 18
-- Cartesian Product USERSUPPORT and INFRACTIONS
-- ============================================================

SELECT *
FROM USERSUPPORT
CROSS JOIN INFRACTIONS;



-- ============================================================
-- Question 19
-- CLOSED tickets with same DATEUPDATED
-- ============================================================

SELECT
    TICKETID,
    DATEUPDATED
FROM USERSUPPORT
WHERE STATUS = 'CLOSED';



-- ============================================================
-- Question 20
-- UNION ALL USERBASE and INFRACTIONS activity
-- ============================================================

SELECT
    TO_CHAR(USERID) AS ID,
    USERNAME AS ACTIVITY,
    TO_CHAR(BIRTHDAY,'YYYY-MM-DD') AS ACTIVITY_DATE
FROM USERBASE

UNION ALL

SELECT
    TO_CHAR(USERID) AS ID,
    'INFRACTION' AS ACTIVITY,
    TO_CHAR(INFRACTIONDATE,'YYYY-MM-DD') AS ACTIVITY_DATE
FROM INFRACTIONS;