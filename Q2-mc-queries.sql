---------------------------------------------------------------------------------------------------
-- Q2. SQL Queries (40 marks)
---------------------------------------------------------------------------------------------------
/*
(i) Show the resort and managers details for those resorts which do not currently have a resort star
rating and which have a live in manager. The output must list the resort name, the resort address as
a single column called  'RESORT ADDRESS' (made up of  street address, town name and post code), the
managers name and the managers phone number. The output must be ordered by resort postcode descending,
where two resorts are in the same post code order them by the resort name. Your output must have the
form shown below (your data will clearly be different). [4 marks]
*/
SELECT
           r.resort_name
         , r.resort_street_address
                      || ' '
                      || t.town_name
                      || ' '
                      || r.resort_pcode AS "RESORT ADDRESS"
         , m.manager_name
         , m.manager_phone
FROM
           resort r
           INNER JOIN
                      town t
                      ON
                                 t.town_id = r.town_id
           INNER JOIN
                      manager m
                      ON
                                 r.manager_id = m.manager_id
WHERE
           r.resort_star_rating IS NULL
           AND resort_livein_manager  = 'Y'
ORDER BY
           r.resort_pcode DESC
         , r.resort_name
;

/*
(ii) Show those resorts which have charged more in booking charges than the average booking charge
made by all resorts. The output must list the resort id, resort name, resort street address, resort
town, resort state, resort postcode and total booking charges in a column called "total_booking_charges'.
The output must be ordered by resort_id. Your output must have the form shown below (your data will
clearly be different). [6 marks]
*/
SELECT
           resort.resort_id
         , resort.resort_name
         , resort.resort_street_address
         , town.town_name
         , town.town_state
         , resort.resort_pcode
         , to_char(SUM(booking.booking_charge), '$999999.99') AS "TOTAL_BOOKING_CHARGES"
FROM
           resort
           INNER JOIN
                      booking
                      ON
                                 resort.resort_id = booking.resort_id
           INNER JOIN
                      town
                      ON
                                 resort.town_id = town.town_id
GROUP BY
           resort.resort_id
         , resort.resort_name
         , resort.resort_street_address
         , town.town_name
         , town.town_state
         , resort.resort_pcode
HAVING
           SUM(booking.booking_charge) >
           (
                    SELECT
                             AVG(SUM(booking_charge))
                    FROM
                             booking
                    GROUP BY
                             resort_id
           )
ORDER BY
           resort_id
;

/*
(iii) Reviews which are provided by guests were intended to be a review by a guest who has completed
their stay at the resort (ie. the review is entered after they have left the resort). Unfortunately,
the current Monash Cabins system allows guests, once registered  in the system, to add a review for a
resort even if they have not stayed at the resort (they may have a future booking or may not even have
a booking for the resort they are rating with their review). To assess the issues with the current review
data provide a list of all invalid reviews (ie. reviews made by a guest who has not completed their stay
at the resort they are reviewing or a guest who does not have any booking for the resort they are reviewing). The output should list the review id, guest no and name, resort id and name, review comment and the date the review was completed. The output must be in ascending  date reviewed order. Your output must have the form shown below (your data will clearly be different).
In arriving at your solution you may assume that there have been no booking cancellations and that no
guest left the resort before their booking to date. [6 marks]
*/
SELECT
           v.review_id
         , g.guest_no
         , g.guest_name
         , r.resort_id
         , r.resort_name
         , v.review_comment
         , to_char(v.review_date, 'DD-Mon-yyyy') as date_reviewed
FROM
           review v
           INNER JOIN
                      guest g
                      ON
                                 g.guest_no = v.guest_no
           INNER JOIN
                      resort r
                      ON
                                 r.resort_id = v.resort_id
WHERE
           (
                      g.guest_no
                    , r.resort_id
           )
           NOT IN
           (
                      SELECT DISTINCT
                                 b.guest_no
                               , b.resort_id
                      FROM
                                 guest g
                                 INNER JOIN
                                            booking b
                                            ON
                                                       g.guest_no = b.guest_no
                      WHERE
                                 --b.booking_to < sysdate
                                 review_date >= booking_to
           )
ORDER BY
           v.review_date
;

/*
(iv) Show the total number of cabins at those resorts which have cabins with more than two bedrooms and
indicate how many cabins at the resort have more than two bedrooms.
The output must include the resort id, the resort name and the accommodation details in the format as
indicated below (your data will clearly be different). The output must be in resort name order. [6 marks]
*/
SELECT
           r.resort_id
         , resort_name
         , 'Has '
                      || to_char(COUNT(*),'99')
                      || ' cabins in total with '
                      ||
           (
                  SELECT
                         to_char(COUNT(*),'99')
                  FROM
                         cabin
                  WHERE
                         resort_id          = r.resort_id
                         AND cabin_bedrooms > 2
           )
                      || ' having more than 2 bedrooms' AS accommodation_available
FROM
           cabin c
           INNER JOIN
                      resort r
                      ON
                                 c.resort_id = r.resort_id
GROUP BY
           r.resort_id
         , resort_name
HAVING
           MAX(cabin_bedrooms) > 2
ORDER BY
           resort_name
;

/*
(v) Show the most popular resort(s) based on the number of bookings for a resort.
For the most popular resort(s) list the resort id, resort name, if the resort has a live in manager
display 'Yes', if not 'No' in a column headed 'live_in_manager', the resorts star rating (if the resort
has no ratings show 'No Ratings'), the managers name and phone number and the count of bookings which are
in the system for the resort. The output must be ordered by the resort id.Your output must have the form
shown below (your data will clearly be different). [8 marks]
*/
SELECT
           r.resort_id
         , r.resort_name
         , CASE r.resort_livein_manager
                      WHEN 'Y'
                                 THEN 'Yes'
                      WHEN 'N'
                                 THEN 'No'
           END                                                     AS live_in_manager
         , nvl(to_char(r.resort_star_rating, '9.9'), 'No Ratings') AS star_rating
         , m.manager_name
         , m.manager_phone
         , COUNT(b.booking_id) AS Number_of_bookings
FROM
           resort r
           INNER JOIN
                      booking b
                      ON
                                 b.resort_id = r.resort_id
           INNER JOIN
                      manager m
                      ON
                                 m.manager_id = r.manager_id
GROUP BY
           r.resort_id
         , r.resort_name
         , r.resort_livein_manager
         , r.resort_star_rating
         , m.manager_name
         , m.manager_phone
HAVING
           COUNT(b.booking_id) =
           (
                    SELECT
                             MAX(COUNT(b.booking_id))
                    FROM
                             booking b
                    GROUP BY
                             b.resort_id
           )
ORDER BY
           r.resort_id
;

/*
(vi) Based on the Town and POI data you have been supplied with, Monash Cabins would like to create a list
of points of interest (poi's) close to their various resorts to help guests who would like to tour the local
area.
The output must show the resort id, resort name and for each point of interest within 100 Km straight
line distance of the resort; the poi name, poi street address, poi town, poi state, poi opening time and
the straight line distance to the POI in a column called 'SEPARATION_IN_KMS'. Within 100 Km  is inclusive
(ie 100 Km from the resort or less). The output must be ordered by the resort name and for a given resort
by the separation in kms.
Your output must have the form shown below (your data will clearly be different). [10 marks]
*/
SELECT
         resort_id
       , resort_name
       , poi_name
       , poi_street_address
       , tp.town_name                                                                        AS poi_town
       , tp.town_state                                                                       AS poi_state
       , nvl(to_char(poi_open_time, 'hh:mi am'), 'Not Applicable')                           AS poi_opening_time
       , to_char(geodistance(tp.town_lat, tp.town_long, tr.town_lat, tr.town_long), '990.9') AS separation_in_kms
FROM
         town tp
         JOIN
                  point_of_interest poi
                  ON
                           tp.town_id = poi.town_id
         JOIN
                  ( resort r
                  JOIN
                           town tr
                           ON
                                    r.town_id = tr.town_id )
                  ON
                           geodistance(tr.town_lat, tr.town_long, tp.town_lat, tp.town_long) <= 100
ORDER BY
         resort_name
       , separation_in_kms
;