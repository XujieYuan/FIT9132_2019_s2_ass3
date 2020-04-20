/* FIT9132 2019 S2 Assignment 3 Q4 ANSWERS

   Student Name:Xujie Yuan
    Student ID:29994675

   Comments to your marker:
   
*/

/* (i)*/
CREATE OR REPLACE TRIGGER maintain_booking AFTER
    UPDATE OF booking_state ON booking
    FOR EACH ROW
    WHEN ( new.booking_state = 'C' )
BEGIN
    UPDATE guest
    SET
        completed_bookings = completed_bookings + 1
    WHERE
        guest_no = :new.guest_no;

END;
/

/*test 1*/
--guest_no=7--
set echo on 

SELECT
    *
FROM
    guest;

INSERT INTO booking VALUES (
    31,
    TO_DATE('2019/01/21', 'YYYY/MM/DD'),
    TO_DATE('2019/02/21', 'YYYY/MM/DD'),
    2,
    2,
    188,
    7,
    21,
    5,
    'F'
);

UPDATE booking
SET
    booking_state = 'C'
WHERE
    booking_id = 31;

SELECT
    *
FROM
    guest;

ROLLBACK;

set echo off
    
/* (ii)*/

CREATE OR REPLACE TRIGGER prevent_review BEFORE
    INSERT ON review
    FOR EACH ROW
DECLARE
    min_booking_to DATE;
BEGIN
    SELECT
        MIN(booking_to)
    INTO min_booking_to
    FROM
        booking
    WHERE
        guest_no = :new.guest_no
        AND resort_id = :new.resort_id
    GROUP BY
        resort_id;

    IF :new.review_date < min_booking_to THEN
        raise_application_error(-20000, 'The stay has not been completed!');
    END IF;

END;
/

/*test 2*/

set echo on

INSERT INTO review VALUES (
    30,
    '666',
    TO_DATE('2019/01/02', 'YYYY/MM/DD'),
    4,
    1,
    2
);

INSERT INTO review VALUES (
    31,
    'Wonderful!',
    TO_DATE('2019/07/01', 'YYYY/MM/DD'),
    3,
    6,
    7
);

ROLLBACK;

set echo off

/* (iii)*/

CREATE OR REPLACE TRIGGER check_conflict BEFORE
    INSERT ON booking
    FOR EACH ROW
DECLARE
    conflict_exist NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO conflict_exist
    FROM
        booking
    WHERE
        EXISTS (
            SELECT
                booking_id
            FROM
                booking
            WHERE
                ( :new.booking_from <= booking_from
                  AND booking_to <= :new.booking_to )
                OR ( booking_from <= :new.booking_from
                     AND :new.booking_from <= booking_to
                     AND booking_to <= :new.booking_to )
                OR ( :new.booking_from <= booking_from
                     AND booking_from <= :new.booking_to
                     AND :new.booking_to <= booking_to )
                OR ( booking_from <= :new.booking_from
                     AND :new.booking_to <= booking_to )
                AND cabin_no = :new.cabin_no
        );

    IF conflict_exist > 0 THEN
        raise_application_error(-20000, 'overlaping and conflict booking for #' || :new.cabin_no);
    END IF;

END;
/

/*test 3*/

SET ECHO ON

INSERT INTO booking VALUES (
    38,
    TO_DATE('03/01/2019', 'DD/MM/YYYY'),
    TO_DATE('04/01/2019', 'DD/MM/YYYY'),
    2,
    0,
    200,
    1,
    1,
    1,
    'C'
);

INSERT INTO booking VALUES (
    39,
    TO_DATE('01/01/2019', 'DD/MM/YYYY'),
    TO_DATE('05/01/2019', 'DD/MM/YYYY'),
    2,
    0,
    200,
    1,
    2,
    1,
    'C'
);

INSERT INTO booking VALUES (
    40,
    TO_DATE('02/01/2019', 'DD/MM/YYYY'),
    TO_DATE('06/01/2019', 'DD/MM/YYYY'),
    2,
    0,
    200,
    1,
    3,
    1,
    'C'
);

INSERT INTO booking VALUES (
    41,
    TO_DATE('01/01/2019', 'DD/MM/YYYY'),
    TO_DATE('06/01/2019', 'DD/MM/YYYY'),
    2,
    0,
    200,
    1,
    4,
    1,
    'C'
);

SELECT
    *
FROM
    booking;

ROLLBACK;

SET ECHO OFF

