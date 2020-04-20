---------------------------------------------------------------------------------------------------
-- Q4. PL/SQL (20 marks)
---------------------------------------------------------------------------------------------------
/*
Your answers for these tasks must be placed in the supplied SQL Script Q4-mc-plsql.sql

For each of these questions, as part of your answer, you must create a set of SQL commands which will 
demonstrate the successful operation of your trigger (as an example see the file emp_dept-test-trigger.sql 
from the emp-dept trigger lab exercise) - these tests are part of the awarded marks for each question. 
Place these commands below your trigger definition for each of the tasks. Ensure your trigger definition 
finishes with a slash(/) and blank following line as detailed in the lab 11 notes.
*/

/*
(i) Write a trigger which will, from this point forward, automatically maintain the completed bookings 
attribute you added in Q3(ii).
[4 marks]
*/
DROP TRIGGER chk_if_resort_booked_by_guest;

CREATE OR REPLACE TRIGGER maintain_guest_bookings AFTER
    UPDATE OF booking_state ON booking
    FOR EACH ROW
    --WHEN (old.booking_from > sysdate)
DECLARE
    v_guest_bookings   NUMBER(5);
BEGIN
    IF
        :new.booking_from > SYSDATE AND :new.booking_state = 'C'
    THEN
        raise_application_error(-20003,'Future booking cannot have booking state as C (completed).');
    ELSE
        SELECT
            guest_bookings
        INTO
            v_guest_bookings
        FROM
            guest
        WHERE
            guest_no =:new.guest_no;

        IF
            :new.booking_state = 'C' AND :old.booking_state <> 'C'
        THEN
            UPDATE guest
                SET
                    guest_bookings = v_guest_bookings + 1
            WHERE
                guest_no =:new.guest_no;

        ELSIF :old.booking_state = 'C' AND :new.booking_state <> 'C' THEN
            UPDATE guest
                SET
                    guest_bookings = v_guest_bookings - 1
            WHERE
                guest_no =:new.guest_no;

        END IF;

    END IF;
END;
/

--TESTING TRIGGER 1

-- Checking the data in booking table

SELECT
    *
FROM
    booking
ORDER BY
    booking_id;

-- Checking the data in guest table.

SELECT
    guest_no,
    guest_name,
    guest_bookings
FROM
    guest
ORDER BY
    guest_no;

--Adding a new booking for guest 1

INSERT INTO booking VALUES (
    51,
    TO_DATE('30-sep-2019','DD-MON-YYYY'),
    TO_DATE('1-oct-2019','DD-MON-YYYY'),
    3,
    0,
    645.49,
    1,
    2,
    10,
    'P'
);

COMMIT;

-- Checking the data in booking table after the new booking has been added

SELECT
    *
FROM
    booking;

-- Checking the data in guest table after the new booking has been added

SELECT
    guest_no,
    guest_name,
    guest_bookings
FROM
    guest
ORDER BY
    guest_no;

--Updating the state of booking once the booking is completed.

UPDATE booking
    SET
        booking_state = 'C'
WHERE
    booking_id = 51;

COMMIT;

-- Checking the data in booking table after the new booking has been updated

SELECT
    *
FROM
    booking;

-- Checking the data in guest table after the new booking has been updated

SELECT
    guest_no,
    guest_name,
    guest_bookings
FROM
    guest;

--Updating the state of booking back to P to check the trigger

UPDATE booking
    SET
        booking_state = 'P'
WHERE
    booking_id = 51;

COMMIT;

-- Checking the data in booking table after the new booking has been updated again

SELECT
    *
FROM
    booking;

-- Checking the data in guest table after the new booking has been updated again

SELECT
    guest_no,
    guest_name,
    guest_bookings
FROM
    guest;

/*
(ii) Write a trigger which will prevent a review from being entered if the guest has not stayed at the 
resort they are adding a review for (ie. the stay has not been completed).
[6 marks]
*/

DROP TRIGGER chk_if_resort_booked_by_guest;

CREATE OR REPLACE TRIGGER chk_if_resort_booked_by_guest BEFORE
    INSERT ON review
    FOR EACH ROW
DECLARE
    v_review_stay_not_comp_prob   NUMBER(7);
BEGIN
    SELECT
        COUNT(*)
    INTO
        v_review_stay_not_comp_prob
    FROM
        booking
    WHERE
        resort_id =:new.resort_id
        AND   guest_no =:new.guest_no
        AND   booking_to <=:new.review_date
        AND   booking_state = 'C';

    IF
        v_review_stay_not_comp_prob = 0
    THEN
        raise_application_error(-20002,'SORRY, REVIEW REQUEST CANNOT BE COMPLETED FOR RESORT '
        ||:new.resort_id
        || ' AS YOU HAVE NOT YET COMPLETED YOUR STAY AT THIS RESORT.');
    END IF;

END;
/

--TESTING TRIGGER 2

-- Checking the data in booking table for guest 1

SELECT
    *
FROM
    booking
WHERE
    guest_no = 1
ORDER BY
    booking_from;

-- Checking the data in booking table for guest 1 and resort 7

SELECT
    *
FROM
    booking
WHERE
    guest_no = 1
    AND   resort_id = 7
ORDER BY
    resort_id;

--Adding a review in review table for guest 1 and resort 7. Cannot be done.

INSERT INTO review VALUES (
    16,
    'Writing review for resort 7 where I have never stayed.!',
    TO_DATE('21-oct-2019','DD-MON-YYYY'),
    5,
    1,
    7
);

-- Checking the data in booking table for guest 1 and resort 10

SELECT
    *
FROM
    booking
WHERE
    guest_no = 1
    AND   resort_id = 10
ORDER BY
    resort_id;

--Adding a review in review table for guest 1 and resort 10. Cannot be done.

INSERT INTO review VALUES (
    16,
    'Writing review for resort 10 where booking state for any of the bookings is not C.!',
    TO_DATE('26-nov-2019','DD-MON-YYYY'),
    5,
    1,
    10
);

-- Checking the data in booking table for guest 1 again.

SELECT
    *
FROM
    booking
WHERE
    guest_no = 1
ORDER BY
    booking_from;

-- Checking the data in booking table for guest 1 and resort 2.

SELECT
    *
FROM
    booking
WHERE
    guest_no = 1
    AND   resort_id = 2
ORDER BY
    resort_id;

--Adding a review in review table for guest 1 and resort 10. Cannot be done.

INSERT INTO review VALUES (
    16,
    'Good',
    SYSDATE,
    5,
    1,
    2
);

COMMIT;

-- Checking the data in review table for guest 1 and resort 2.

SELECT
    *
FROM
    review
WHERE
    guest_no = 1
    AND   resort_id = 2
ORDER BY
    resort_id;


/*
(iii) Monash Cabins has discovered a major weakness with their database design - it is possible for a 
booking to be added which overlaps/conflicts with a current booking. For example a booking may be made 
for a particular resort and cabin which starts before a currently recorded booking and ends in the middle 
of a current booking. Write a trigger which will prevent all overlaps/conflicts occuring (here you will 
need to carefully consider which situations could cause such overlaps/conflicts).
[10 marks]
*/

CREATE OR REPLACE TRIGGER chk_new_book_dates_for_cabin BEFORE
    INSERT ON booking
    FOR EACH ROW
DECLARE
    v_book_problem   NUMBER(7);
BEGIN
    SELECT
        COUNT(*)
    INTO
        v_book_problem
    FROM
        booking
    WHERE
        cabin_no =:new.cabin_no
        AND   resort_id =:new.resort_id
        AND   (
            (
                :new.booking_from < booking_from
                AND   :new.booking_to BETWEEN booking_from AND booking_to
            )
            OR    (
                :new.booking_from BETWEEN booking_from AND booking_to
                AND   :new.booking_to > booking_to
            )
            OR    (
                :new.booking_from BETWEEN booking_from AND booking_to
                AND   :new.booking_to BETWEEN booking_from AND booking_to
            )
            OR    (
                :new.booking_from < booking_from
                AND   :new.booking_to > booking_to
            )
        )
        AND   booking_state NOT IN (
            'C',
            'D'
        );

    IF
        v_book_problem > 0
    THEN
        raise_application_error(-20000,'SORRY, BOOKING REQUEST CANNOT BE COMPLETED AS THERE IS ALREADY A BOOKING FOR cabin_no='
        ||:new.cabin_no
        || ' AND resort_id='
        ||:new.resort_id
        || ' FOR THE SELECTED DATES.');

    END IF;

END;
/

--TESTING TRIGGER 3

-- Checking the data in booking table for resort 1 and cabin 4.

SELECT
    *
FROM
    booking
WHERE
    cabin_no = 4
    AND   resort_id = 1
ORDER BY
    booking_from;
    
-- Booking 7/12 - 17/12 

-- Adding a new booking that starts before and ends in an existing booking. Cannot be done.

INSERT INTO booking (
    booking_id,
    booking_from,
    booking_to,
    booking_noadults,
    booking_nochildren,
    booking_charge,
    guest_no,
    cabin_no,
    resort_id
) VALUES (
    52,
    TO_DATE('05-dec-2019','DD-MON-YYYY'),
    TO_DATE('10-dec-2019','DD-MON-YYYY'),
    4,
    0,
    787.45,
    4,
    4,
    1
);


-- Adding a new booking that starts inside and ends outside an existing booking. Cannot be done.

INSERT INTO booking (
    booking_id,
    booking_from,
    booking_to,
    booking_noadults,
    booking_nochildren,
    booking_charge,
    guest_no,
    cabin_no,
    resort_id
) VALUES (
    52,
    TO_DATE('10-dec-2019','DD-MON-YYYY'),
    TO_DATE('20-dec-2019','DD-MON-YYYY'),
    4,
    0,
    787.45,
    4,
    4,
    1
);

-- Adding a new booking that starts and ends within an existing booking. Cannot be done.

INSERT INTO booking (
    booking_id,
    booking_from,
    booking_to,
    booking_noadults,
    booking_nochildren,
    booking_charge,
    guest_no,
    cabin_no,
    resort_id
) VALUES (
    52,
    TO_DATE('10-dec-2019','DD-MON-YYYY'),
    TO_DATE('12-dec-2019','DD-MON-YYYY'),
    4,
    0,
    787.45,
    4,
    4,
    1
);

-- Adding a new booking that starts and ends outside (but overlaps) an existing booking. Cannot be done.

INSERT INTO booking (
    booking_id,
    booking_from,
    booking_to,
    booking_noadults,
    booking_nochildren,
    booking_charge,
    guest_no,
    cabin_no,
    resort_id
) VALUES (
    52,
    TO_DATE('05-dec-2019','DD-MON-YYYY'),
    TO_DATE('18-dec-2019','DD-MON-YYYY'),
    4,
    0,
    787.45,
    4,
    4,
    1
);

-- Adding a new booking that is valid

INSERT INTO booking (
    booking_id,
    booking_from,
    booking_to,
    booking_noadults,
    booking_nochildren,
    booking_charge,
    guest_no,
    cabin_no,
    resort_id
) VALUES (
    52,
    TO_DATE('18-dec-2019','DD-MON-YYYY'),
    TO_DATE('20-dec-2019','DD-MON-YYYY'),
    4,
    0,
    787.45,
    4,
    4,
    1
);

COMMIT;

-- Checking the data in booking table for resort 1 and cabin 4 after the new booking has been added.

SELECT
    *
FROM
    booking
WHERE
    cabin_no = 4
    AND   resort_id = 1
ORDER BY
    booking_from;

