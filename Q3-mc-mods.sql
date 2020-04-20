---------------------------------------------------------------------------------------------------
-- Q3. Design Modifications (20 marks)
---------------------------------------------------------------------------------------------------
/*
Your answers for these tasks must be placed in the supplied SQL Script Q3-mc-mods.sql

These tasks should be attempted only after Q1 and Q2 have been successfully completed. They are to be 
completed on the "live" database ie. the database with the data loaded from your previous work. For this 
question you must not make use of any PL/SQL
*/

/*
(i) Monash Cabins would like to add an attribute to the booking table which they can use to flag the state 
of a booking - this attribute will have a value of either (C, D, F or P) where these mean:

C - Completed Booking, guest has completed their stay and left the resort 
D - Booking has been cancelled
F - Future Booking
P - Guest is on the resort premises (ie currently staying at the resort) 

This attribute must be initialised based on the data which is currently stored in the system. You may 
assume that none of the current booking entries represent cancelled bookings. All new bookings after 
implementing this requirement must automatically be assigned a value of 'F'.
[6 marks]
*/
ALTER TABLE booking ADD (
    booking_state   CHAR(1) DEFAULT 'F'
        CONSTRAINT booking_state_chk CHECK ( booking_state IN (
            'C',
            'D',
            'F',
            'P'
        ) )
);

COMMENT ON COLUMN booking.booking_state IS
    'Booking State';
    

-- Should not have UPDATE statement for code D (cancelled) as no cancellations have been made
-- nor code F (future) set up as default.
UPDATE booking
    SET
        booking_state = 'C'
WHERE
    booking_to < SYSDATE;

UPDATE booking
    SET
        booking_state = 'P'
WHERE
    SYSDATE BETWEEN booking_from AND booking_to;

/*
--OR USE CASE STATEMENT INSTEAD OF ABOVE 2 UPDATE STATEMENTS

UPDATE booking
    SET
        booking_state = (
            CASE
                WHEN booking_to < SYSDATE                      THEN 'C'
                WHEN SYSDATE BETWEEN booking_from AND booking_to THEN 'P'
            END
        );
*/
       
COMMIT; 

ALTER TABLE booking MODIFY
    booking_state NOT NULL;

-- To demonstrate outcome, not required as part of solution
select * from booking order by booking_id;

/*
(ii) Monash Cabins would like to be able to easily determine the number of completed bookings any particular
guest has had with the company. A completed booking is one in which the guest has booked and stayed at an MC
resort and the stay is over, as listed in (i) above.  

Add a new attribute which will record the number of completed bookings a guest has had with the company. 

This attribute must be initialised to the correct current number of completed stays based on the data which 
is currently stored in the system.
[6 marks]
*/
--APPROACH 1
--alter table guest drop column guest_bookings;
ALTER TABLE guest ADD (
    guest_bookings   NUMBER(5)
);

COMMENT ON COLUMN guest.guest_bookings IS
    'Guest Bookings';
    
UPDATE guest g
    SET
        guest_bookings = (
            SELECT
                COUNT(*) AS total_book
            FROM
                booking
            WHERE
                guest_no = g.guest_no
                AND   booking_to < SYSDATE
        );

COMMIT; 


ALTER TABLE guest MODIFY
    guest_bookings DEFAULT 0 NOT NULL;

-- To demonstrate outcome, not required as part of solution
select * from guest order by guest_no;

/*
--APPROACH 2
--alter table guest drop column guest_bookings;
ALTER TABLE guest ADD (
    guest_bookings   NUMBER(5) DEFAULT 0 NOT NULL
);

UPDATE guest g
    SET
        guest_bookings = (
            SELECT
                COUNT(*) AS total_book
            FROM
                booking
            WHERE
                guest_no = g.guest_no
                AND   booking_state = 'C'
        );
        

COMMIT; 
*/


/*
(iii) Monash Cabins has found that having a single manager for each resort is causing problems for the 
larger popular resorts. As a consequence they have decided to appoint multiple managers to a resort, where 
necessary. 

Where multiple managers are assigned, the company wishes to designate a role for each of the different 
managers such as Bookings Manager (BM), Cleaning Manager (CM) and Maintenance Manager (MM) - this range of 
manager roles will be added to as the need arises and is intended to be able to be changed easily. Each role
code will have exactly 2 letters.

Where a resort has only a single manager a role will not be assigned.

The popular resort(s) that will require more than manager is only one at this stage which is Byron Bay 
Exclusive Resort with town latitude: 28.6474 and town longitude: 153.6020. This resort will have the current
manager manage bookings and Garrott Gooch (Ph: 6002318099) will manage cleaning and Fonsie Tillard 
(Ph: 9636535741) will manage maintenance.

Change the database to satisfy this requirement. Note: You should aim to use as few DDL and DML statements 
as possible to achieve this requirement.
[8 marks]
*/
DROP TABLE resort_manager PURGE;

-- Inefficient to place live-in manager in RESORT_MANAGER will generate more nulls
CREATE TABLE resort_manager
    AS
        SELECT
            resort_id,
            manager_id
        FROM
            resort;

COMMENT ON COLUMN resort_manager.resort_id IS
    'Resort ID ';

COMMENT ON COLUMN resort_manager.manager_id IS
    'Manager ID';

ALTER TABLE resort_manager ADD (
    role_id CHAR(2)
);

COMMENT ON COLUMN resort_manager.role_id IS
    'Type of Role';
    
ALTER TABLE resort_manager ADD CONSTRAINT resort_manager_pk PRIMARY KEY ( resort_id,
manager_id );


DROP TABLE role PURGE;

CREATE TABLE role (
    role_id     CHAR(2),
    role_name   VARCHAR(20)  NOT NULL
);

COMMENT ON COLUMN role.role_id IS
    'Type of Role';
    
COMMENT ON COLUMN role.role_name IS
    'Role Name';

ALTER TABLE role ADD CONSTRAINT role_pk PRIMARY KEY ( role_id);

INSERT INTO role VALUES (
    'BM',
    'Bookings Manager'
);

INSERT INTO role VALUES (
    'CM',
    'Cleaning Manager'
);

INSERT INTO role VALUES (
    'MM',
    'Maintenance Manager'
);

COMMIT;

ALTER TABLE resort_manager
    ADD CONSTRAINT resort_manager_resort_fk FOREIGN KEY ( resort_id )
        REFERENCES resort ( resort_id );

ALTER TABLE resort_manager
    ADD CONSTRAINT resort_manager_manager_fk FOREIGN KEY ( manager_id )
        REFERENCES manager ( manager_id );

ALTER TABLE resort_manager
    ADD CONSTRAINT resort_manager_role_fk FOREIGN KEY ( role_id )
        REFERENCES role ( role_id );
    

UPDATE resort_manager
    SET
        role_id = 'BM'
WHERE
    resort_id = (
        SELECT
            resort_id
        FROM
            resort
        WHERE
            resort_name = 'Byron Bay Exclusive Resort'
            AND   town_id = (
                SELECT
                    town_id
                FROM
                    town
                WHERE
                    town_lat = -28.6474
                    AND   town_long = 153.6020
            )
    );   


INSERT INTO resort_manager VALUES (
    (
        SELECT
            resort_id
        FROM
            resort
        WHERE
            resort_name = 'Byron Bay Exclusive Resort'
            AND   town_id = (
                SELECT
                    town_id
                FROM
                    town
                WHERE
                    town_lat = -28.6474
                    AND   town_long = 153.6020
            )
    ),
    (
        SELECT
            manager_id
        FROM
            manager
        WHERE
            manager_phone = '6002318099'
    ),
    'CM'
);


INSERT INTO resort_manager VALUES (
    (
        SELECT
            resort_id
        FROM
            resort
        WHERE
            resort_name = 'Byron Bay Exclusive Resort'
            AND   town_id = (
                SELECT
                    town_id
                FROM
                    town
                WHERE
                    town_lat = -28.6474
                    AND   town_long = 153.6020
            )
    ),
    (
        SELECT
            manager_id
        FROM
            manager
        WHERE
            manager_phone = '9636535741'
    ),
    'MM'
);

COMMIT;


-- No need to DROP COLUMN manager_id from RESORT, re-used to record the live-in manager
-- Recording of live in manager id in resort table
alter table resort modify (manager_id null);

update resort set manager_id = null where RESORT_LIVEIN_MANAGER = 'N';
COMMIT;

alter table resort drop column resort_livein_manager;

COMMENT ON COLUMN resort.manager_id IS
    'Live in Manager identifier';

-- To demonstrate outcome, not required as part of solution
select * from resort order by resort_id;
select * from resort_manager order by resort_id, manager_id;
