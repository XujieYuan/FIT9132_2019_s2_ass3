/*
(b) For the following tasks, your SQL must correctly manage transactions and use sequences to generate 
new primary keys for numeric primary key values (under no circumstances may a new primary key value be 
hard coded as a number or value). Your answers for these tasks must be placed in the supplied SQL Script 
Q1b-mc-dm.sql
*/

/*
(i) Create a sequence which will allow entry of data into the RESORT table - the sequence must begin at 
100 and go up in steps of 1 (i.e., the first value is 100, the next 101, etc.)
[1 mark]
*/
CREATE SEQUENCE resort_seq START WITH 100 INCREMENT BY 1;


/*
(ii) Monash Cabins is doing very good business these days because of a booming economy and their highly 
competitive rates. They have now opened a new resort called Awesome Resort to catch up with the demand. 
The details of the new resort to be added to the MC database are as follows:
Street Address                    	: 50 Awesome Road
Postcode                            : 4830
Town Latitude                     	: -20.7256
Town Longitude                  	: 139.4927
 
The manager of Awesome Resorts will be Garrott Gooch (Ph: 6002318099) who will not be a live in manager.                                                                                     	
 
To start with, there will only be two cabins at Awesome Resorts. The details of the two cabins are as follows:

Cabin 1 Bedrooms                    : 3
Cabin 1 Sleeping Capacity           : 6
Cabin 1 Description                 : Free wi-Fi. kitchen with 400 ltr refrigerator, stove, microwave, pots, 
                                      pans, silverware, toaster, electric kettle, TV and utensils
Cabin 2 Bedrooms                    : 2
Cabin 2 Sleeping Capacity           : 4
Cabin 2 Description                 : Free wi-Fi. kitchen with 280 ltr refrigerator, stove, pots, pans, 
                                    silverware, toaster, electric kettle, TV and utensils

You should use appropriate new cabin numbers for this resort when adding the cabins to the MC database.
[5 marks]
*/
INSERT INTO resort VALUES (
    resort_seq.NEXTVAL,
    'Awesome Resort',
    '50 Awesome Road',
    '4830',
    NULL,
    'N',
    (
        SELECT
            town_id
        FROM
            town
        WHERE
            town_lat = -20.7256
            AND   town_long = 139.4927
    ),
    (
        SELECT
            manager_id
        FROM
            manager
        WHERE
            manager_phone = '6002318099'
    )
);
-- should not use Garrott Gooch in the SQL condition to get manager_id value, 
-- name is not necessarily unique.

INSERT INTO cabin VALUES (
    1,
    resort_seq.CURRVAL,
    3,
    6,
    'Free wi-Fi. kitchen with 400 ltr refrigerator, stove, microwave, pots, pans, silverware, toaster, electric kettle, TV and utensils.'
);

INSERT INTO cabin VALUES (
    2,
    resort_seq.CURRVAL,
    2,
    4,
    'Free wi-Fi. kitchen with 280 ltr refrigerator, stove, pots, pans, silverware, toaster, electric kettle, TV and utensils.'
);

COMMIT;

-- To demonstrate outcome, not required as part of solution
select * from resort order by resort_id;
select * from cabin where resort_id = 100;

/*
(iii) A few weeks after opening the new resort, MC has decided to replace the manager. The new resident 
manager of Awesome Resorts will be Fonsie Tillard (Ph: 9636535741).
[2 marks]
*/
UPDATE resort
    SET
        resort_livein_manager = 'Y',
        manager_id = (
            SELECT
                manager_id
            FROM
                manager
            WHERE
                manager_phone = '9636535741'
        )
WHERE
    town_id = (
        SELECT
            town_id
        FROM
            town
        WHERE
            town_lat = -20.7256
            AND   town_long = 139.4927
    )
    AND   resort_name = 'Awesome Resort';
-- should not use Fonsie Tillard in the SQL condition to get manager_id value,
-- name is not necessarily unique.

COMMIT;

-- To demonstrate outcome, not required as part of solution
select * from resort where resort_id = 100;

/*
(iv) After several months, the newly opened resort hasn't had any bookings and MC has now decided to close 
this resort. Remove this resort from the database. Note that more cabins may have been added to this resort 
since it was opened.
[2 marks]
*/

-- Must use ONLY ONE DELETE statement for deleting *all* the cabins
DELETE FROM cabin
WHERE
    resort_id = (
        SELECT
            resort_id
        FROM
            resort
        WHERE
            resort_name = 'Awesome Resort'
            AND   town_id = (
                SELECT
                    town_id
                FROM
                    town
                WHERE
                    town_lat = -20.7256
                    AND   town_long = 139.4927
            )
    );

DELETE FROM resort
WHERE
    resort_name = 'Awesome Resort'
    AND   town_id = (
        SELECT
            town_id
        FROM
            town
        WHERE
            town_lat = -20.7256
            AND   town_long = 139.4927
    );

-- Must have only one COMMIT statement, delete of cabins and resort is one transaction
COMMIT;

-- To demonstrate outcome, not required as part of solution
select * from resort order by resort_id;
select * from cabin where resort_id = 100;
