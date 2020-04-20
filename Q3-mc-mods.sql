/* FIT9132 2019 S2 Assignment 3 Q3 ANSWERS

   Student Name:Xujie Yuan
    Student ID:29994675

   Comments to your marker:
   
*/
SELECT
    *
FROM
    resort;

/* (i)*/

ALTER TABLE booking ADD (
    booking_state CHAR(1) DEFAULT 'F'
);

ALTER TABLE booking
    ADD CONSTRAINT chk_booking_state CHECK ( booking_state IN (
        'C',
        'D',
        'F',
        'P'
    ) );

COMMENT ON COLUMN booking.booking_state IS
    'C Completed Booking, guest has completed their stay and left the resort\n D Booking has been cancelled\n F Future Booking \n P Guest is on the resort premises (ie currently staying at the resort'
    ;

UPDATE booking
SET
    booking_state = 'C'
WHERE
    booking.booking_to < SYSDATE;

UPDATE booking
SET
    booking_state = 'F'
WHERE
    booking.booking_from > SYSDATE;

UPDATE booking
SET
    booking_state = 'P'
WHERE
    booking.booking_from > SYSDATE
    AND booking_to < SYSDATE;

/* (ii)*/

ALTER TABLE guest ADD (
    completed_bookings NUMBER
);

UPDATE guest g
SET
    completed_bookings = (
        SELECT
            COUNT(booking_state)
        FROM
            booking
        WHERE
            booking_state = 'C'
            AND guest_no = g.guest_no
        GROUP BY
            guest_no
    );

/* (iii)*/

DROP TABLE role CASCADE CONSTRAINTS;

CREATE TABLE role (
    role_code     CHAR(2) PRIMARY KEY,
    description   VARCHAR2(20) NOT NULL
);

DROP TABLE appointment CASCADE CONSTRAINTS;

CREATE TABLE appointment (
    resort_id    NUMBER(4) NOT NULL,
    manager_id   NUMBER(4) NOT NULL,
    role_code    CHAR(2),
    CONSTRAINT appointment_pk PRIMARY KEY ( resort_id,
                                            manager_id ),
    CONSTRAINT appointment_resort FOREIGN KEY ( resort_id )
        REFERENCES resort ( resort_id ),
    CONSTRAINT appointment_manager FOREIGN KEY ( manager_id )
        REFERENCES manager ( manager_id ),
    CONSTRAINT appointment_role FOREIGN KEY ( role_code )
        REFERENCES role ( role_code )
);

INSERT INTO role VALUES (
    'CM',
    'Clean Manager'
);

INSERT INTO role VALUES (
    'BM',
    'Booking Manager'
);

INSERT INTO role VALUES (
    'MM',
    'Maintainance Manager'
);

INSERT INTO appointment (
    resort_id,
    manager_id
)
    SELECT
        r.resort_id,
        r.manager_id
    FROM
        resort    r
        JOIN manager   m
        ON r.manager_id = m.manager_id;

ALTER TABLE resort DROP COLUMN manager_id;

INSERT INTO resort VALUES (
    resort_seq.NEXTVAL,
    'Byron Bay Exclusive Resort',
    '555 SSS ROAD',
    9876,
    NULL,
    'N',
    (
        SELECT
            town_id
        FROM
            town
        WHERE
            town_lat = - 28.6474
            AND town_long = 153.6020
    )
);

INSERT INTO appointment VALUES (
    resort_seq.CURRVAL,
    3,
    NULL
);

UPDATE appointment
SET
    role_code = 'BM'
WHERE
    resort_id = (
        SELECT
            r.resort_id
        FROM
            resort   r
            JOIN town     t
            ON r.town_id = t.town_id
        WHERE
            resort_name = 'Byron Bay Exclusive Resort'
            AND town_lat = - 28.6474
            AND town_long = 153.6020
    );

INSERT INTO appointment VALUES (
    (
        SELECT
            r.resort_id
        FROM
            resort   r
            JOIN town     t
            ON r.town_id = t.town_id
        WHERE
            resort_name = 'Byron Bay Exclusive Resort'
            AND town_lat = - 28.6474
            AND town_long = 153.6020
    ),
    (
        SELECT
            manager_id
        FROM
            manager
        WHERE
            manager_phone = 6002318099
    ),
    'BM'
);

INSERT INTO appointment VALUES (
    (
        SELECT
            r.resort_id
        FROM
            resort   r
            JOIN town     t
            ON r.town_id = t.town_id
        WHERE
            resort_name = 'Byron Bay Exclusive Resort'
            AND town_lat = - 28.6474
            AND town_long = 153.6020
    ),
    (
        SELECT
            manager_id
        FROM
            manager
        WHERE
            manager_phone = 9636535741
    ),
    'MM'
);