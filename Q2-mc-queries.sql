/* FIT9132 2019 S2 Assignment 3 Q2 ANSWERS

   Student Name:Xujie Yuan
    Student ID:29994675

   Comments to your marker:
   
*/
SELECT
    *
FROM
    resort;
/* (i)*/

SELECT
    resort_name,
    resort_street_address
    || ' '
    || town_name
    || ' '
    || resort_pcode AS "RRSORT ADDRESS",
    manager_name,
    manager_phone
FROM
    resort    r
    JOIN town      t
    ON r.town_id = t.town_id
    JOIN manager   m
    ON r.manager_id = m.manager_id
WHERE
    resort_star_rating IS NULL
    AND resort_livein_manager = 'Y'
ORDER BY
    resort_pcode DESC,
    resort_name;

/* (ii)*/

SELECT
    r.resort_id,
    resort_name,
    resort_street_address,
    town_name,
    town_state,
    resort_pcode,
    TO_CHAR(SUM(booking_charge), '$99999.99') AS "TOTAL_BOOKING_CHARGES"
FROM
    resort    r
    JOIN town      t
    ON r.town_id = t.town_id
    JOIN cabin     c
    ON r.resort_id = c.resort_id
    JOIN booking   b
    ON c.cabin_no = b.cabin_no
       AND c.resort_id = b.resort_id
GROUP BY
    r.resort_id,
    resort_name,
    resort_street_address,
    town_name,
    town_state,
    resort_pcode
HAVING
    SUM(booking_charge) > (
        SELECT
            AVG(SUM(booking_charge))
        FROM
            resort    r
            JOIN cabin     c
            ON r.resort_id = c.resort_id
            JOIN booking   b
            ON c.cabin_no = b.cabin_no
               AND c.resort_id = b.resort_id
        GROUP BY
            r.resort_id
    )
ORDER BY
    r.resort_id;

/* (iii)*/

SELECT DISTINCT
    review_id,
    g.guest_no,
    guest_name,
    r.resort_id,
    resort_name,
    review_comment,
    TO_CHAR(review_date, 'DD-MM-YYYY') AS date_reviewed
FROM
    resort   re
    JOIN review   r
    ON re.resort_id = r.resort_id
    JOIN guest    g
    ON r.guest_no = g.guest_no
WHERE
    r.review_date < ALL (
        SELECT
            booking_to
        FROM
            booking
        WHERE
            guest_no = g.guest_no
    )
    OR r.resort_id NOT IN (
        SELECT
            resort_id
        FROM
            booking
        WHERE
            guest_no = g.guest_no
    )
ORDER BY
    date_reviewed;

/* (iv)*/

SELECT
    r.resort_id,
    resort_name,
    'Has '
    || (
        SELECT
            COUNT(cabin_no)
            || ' cabins in total with '
        FROM
            cabin
        WHERE
            resort_id = r.resort_id
    )
    || COUNT(cabin_no)
    || ' having more that 2 bedrooms' AS accomodation_available
FROM
    resort   r
    JOIN cabin    c
    ON r.resort_id = c.resort_id
WHERE
    cabin_bedrooms > 2
GROUP BY
    r.resort_id,
    resort_name
ORDER BY
    resort_name;
 
/* (v)*/

SELECT
    r.resort_id,
    r.resort_name,
    CASE
        WHEN r.resort_livein_manager = 'N' THEN
            'NO'
        ELSE
            'YES'
    END AS live_in_manager,
    CASE
        WHEN r.resort_star_rating IS NULL THEN
            'No Ratings'
        ELSE
            TO_CHAR(r.resort_star_rating, 9.9)
    END AS star_rating,
    m.manager_name,
    m.manager_phone,
    COUNT(booking_id)
FROM
    resort    r
    JOIN manager   m
    ON r.manager_id = m.manager_id
    JOIN booking   b
    ON b.resort_id = r.resort_id
GROUP BY
    r.resort_id,
    r.resort_name,
    CASE
            WHEN r.resort_livein_manager = 'N' THEN
                'NO'
            ELSE
                'YES'
        END,
    CASE
            WHEN r.resort_star_rating IS NULL THEN
                'No Ratings'
            ELSE
                TO_CHAR(r.resort_star_rating, 9.9)
        END,
    m.manager_name,
    m.manager_phone
HAVING
    COUNT(booking_id) = (
        SELECT
            MAX(COUNT(booking_id))
        FROM
            booking
        GROUP BY
            resort_id
    )
ORDER BY
    resort_id;


/* (vi)*/

SELECT
    resort_id,
    resort_name,
    poi_name,
    poi_street_address,
    poi_town,
    poi_state,
    poi_opening_time,
    TO_CHAR(geodistance(poi_lat, poi_long, resort_lat, resort_long), '990.0') AS seperation_in_kms
FROM
    (
        SELECT
            poi_name,
            poi_street_address,
            town_name    AS poi_town,
            town_state   AS poi_state,
            nvl(TO_CHAR(poi_open_time, 'HH:MI AM'), 'Not Applicable') AS poi_opening_time
            ,
            town_lat     AS poi_lat,
            town_long    AS poi_long
        FROM
            point_of_interest   p
            JOIN town                t
            ON p.town_id = t.town_id
    ),
    (
        SELECT
            r.resort_id,
            r.resort_name,
            town_lat    AS resort_lat,
            town_long   AS resort_long
        FROM
            resort   r
            JOIN town     t
            ON r.town_id = t.town_id
    )
WHERE
    geodistance(poi_lat, poi_long, resort_lat, resort_long) <= 100
ORDER BY
    resort_name,
    seperation_in_kms;