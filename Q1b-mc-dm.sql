/* FIT9132 2019 S2 Assignment 3 Q1-Part B ANSWERS

   Student Name:Xujie Yuan
    Student ID:29994675

   Comments to your marker:
   
*/

DROP SEQUENCE resort_seq;

DROP SEQUENCE cabin_seq;

/* (i)*/

CREATE SEQUENCE resort_seq START WITH 100 INCREMENT BY 1;

/* (ii)*/
/*resort*/

INSERT INTO resort VALUES (
    resort_seq.NEXTVAL,
    'Awesome Resort',
    '50 Awesome Road',
    4830,
    NULL,
    'N',
    (
        SELECT
            town_id
        FROM
            town
        WHERE
            town_lat = - 20.7256
            AND town_long = 139.4927
    ),
    (
        SELECT
            manager_id
        FROM
            manager
        WHERE
            manager_phone = 6002318099
    )
);

/*cabin*/

CREATE SEQUENCE cabin_seq START WITH 1 INCREMENT BY 1;

INSERT INTO cabin VALUES (
    cabin_seq.NEXTVAL,
    resort_seq.CURRVAL,
    3,
    6,
    'Free wi-Fi. kitchen with 400 ltr refrigerator, stove, microwave, pots, pans, 
silverware, toaster, electric kettle, TV and utensils'
);

INSERT INTO cabin VALUES (
    cabin_seq.NEXTVAL,
    resort_seq.CURRVAL,
    2,
    4,
    'Free wi-Fi. kitchen with 280 ltr refrigerator, stove, pots, pans, 
silverware, toaster, electric kettle, TV and utensils'
);
/* (iii)*/

UPDATE resort
SET
    manager_id = (
        SELECT
            manager_id
        FROM
            manager
        WHERE
            manager_phone = 9636535741
    )
WHERE
    resort_name = 'Awesome Resort'
    AND town_id = (
        SELECT
            town_id
        FROM
            town
        WHERE
            town_lat = - 20.7256
            AND town_long = 139.4927
    );

/* (iv)*/
/*delete cabins*/

DELETE FROM cabin
WHERE
    resort_id = (
        SELECT
            resort_id
        FROM
            resort   r
            JOIN town     t
            ON r.town_id = t.town_id
        WHERE
            resort_name = 'Awesome Resort'
            AND town_lat = - 20.7256
            AND town_long = 139.4927
    );
/*delete resorts*/

DELETE FROM resort
WHERE
    resort_name = 'Awesome Resort'
    AND town_id = (
        SELECT
            town_id
        FROM
            town
        WHERE
            town_lat = - 20.7256
            AND town_long = 139.4927
    );