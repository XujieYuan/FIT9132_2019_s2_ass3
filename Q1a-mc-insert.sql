---------------------------------------------------------------------------------------------------
-- Q1. Data Manipulation (20 marks)
---------------------------------------------------------------------------------------------------
/*
(a) Load selected tables with your own additional test data: using the supplied Q1a-mc-insert.sql script 
file, and the SQL commands which will insert, as a minimum, the following sample data -
5 RESORTS,
20 CABINS,
25 BOOKINGS
15 REVIEWS

Please note, these are the minimum number of entries you must insert; you are encouraged to insert more 
to provide a richer data set to draw from. The primary key values for this data must be hardcoded values 
(ie. not make use of sequences) and consist of values below 100. Dates used should be chosen after the 1st 
January 2019. 

For this task ONLY, you may lookup and include values for the loaded tables/data directly where required. 

The script must contain a single COMMIT statement as the last line of the script, ie. all listed actions 
should be treated as a single transaction.

In carrying out this task you must not add any further data to tables which were previously populated by 
the supplied schema ﬁle.
For all subsequent questions (Q1b onwards) you are not permitted to manually:
- lookup a value in the database, obtain its primary key or the highest/lowest value in a column, or
- calculate values external to the database eg. on a calculator and then use such values in your 
answers.
 
You must ONLY use the data as provided in the text of the questions. Where a particular case for a word is 
provided you must use that case. You may divide names such as Garrot Gooch into a first name of Garrot and 
a last name of Gooch, if required. Failure to adhere to this requirement will result in a mark of 0 for the
relevant question.

[10 marks]
*/

--RESORTS
INSERT INTO resort VALUES (1, 'Byron Bay Exclusive Resort', '1 Karma Road', '2481', 4.6, 'Y', 1, 3);
INSERT INTO resort VALUES (2, 'Amazing Resort', '5B Lincoln Way', '3564', 4, 'N', 9, 3);
INSERT INTO resort VALUES (3, 'Alice Springs Resort', '1 Wonderland Road', '0870', 5, 'N', 5, 1);
INSERT INTO resort VALUES (4, 'Broome Awesome Resort', '1 Crystal Clear Road', '6725', 5, 'Y', 6, 1);
INSERT INTO resort VALUES (5, 'Byron Bay Super Resort', '675 Lennon Street', '2481', 3, 'N', 1, 3);
INSERT INTO resort VALUES (6, 'Gympie Luxury Resort', '1234 Gympie Hwy', '4570', NULL, 'Y', 4, 5);
INSERT INTO resort VALUES (7, 'Taree Exclusive Resort', '78 Station Road', '2430', 5, 'Y', 8, 4);
INSERT INTO resort VALUES (8, 'King Resort at Kingaroy', '23A Town Road', '4610', NULL, 'N', 3, 5);
INSERT INTO resort VALUES (9, 'Queen Resort', '45 Mount Isa Road', '4825', 2.5, 'N', 7, 5);
INSERT INTO resort VALUES (10, 'Mudgee Budget Resort', '40 Moonlight Road', '2850', NULL, 'N', 2, 4);


--CABINS
INSERT INTO cabin VALUES (1, 1, 2, 5,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (2, 1, 3, 6,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (3, 1, 2, 5,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (4, 1, 3, 7,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (5, 1, 2, 5,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (6, 1, 3, 7,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (7, 1, 2, 4,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (9, 1, 2, 5,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (10, 1, 4, 7,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (11, 1, 2, 5,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (12, 1, 3, 7,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (14, 1, 2, 4,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (15, 1, 1, 2,'spacious living room/dining areas, modern kitchen, updated bathroom, large bedroom with firm memory-foam beds and upscale bedding. Fresh linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (16, 1, 1, 2,'spacious living room/dining areas, modern kitchen, updated bathroom, large bedroom with firm memory-foam beds and upscale bedding. Fresh linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (1, 3, 1, 2,'wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available. Queen or double hide-a-bed in living room.');
INSERT INTO cabin VALUES (2, 3, 1, 2,'wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available. Queen or double hide-a-bed in living room.');
INSERT INTO cabin VALUES (3, 3, 2, 5,'wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available. queen or double hide-a-bed in living room.');
INSERT INTO cabin VALUES (4, 3, 2, 4,'wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available. queen or double hide-a-bed in living room.');
INSERT INTO cabin VALUES (5, 3, 2, 4,'wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available. Queen or double hide-a-bed in living room.');
INSERT INTO cabin VALUES (6, 3, 2, 5,'Wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available. Queen or double hide-a-bed in living room.');
INSERT INTO cabin VALUES (1, 4, 1, 2,'bedrooms with firm memory-foam beds and bedding. Linens, blankets, towels, and pillows provided.');
INSERT INTO cabin VALUES (2, 4, 1, 3,'bedrooms with firm memory-foam beds and bedding. Linens, blankets, towels, and pillows provided.');
INSERT INTO cabin VALUES (3, 4, 2, 5,'bedrooms with firm memory-foam beds and bedding. Linens, blankets, towels, and pillows provided.');
INSERT INTO cabin VALUES (1, 2, 2, 5,'Free wi-fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (2, 2, 2, 5,'Free wi-fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (3, 2, 2, 5,'Free wi-fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (1, 5, 3, 6,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (2, 5, 2, 4,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (3, 5, 1, 2,'spacious living room/dining area, modern kitchen, updated bathroom, large bedroom with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (4, 5, 1, 3,'spacious living room/dining area, modern kitchen, updated bathroom, large bedroom with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (5, 5, 2, 4,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (6, 5, 1, 3,'spacious living room/dining area, modern kitchen, updated bathroom, large Bedroom with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (7, 5, 1, 3,'spacious living room/dining area, modern kitchen, updated bathroom, Large bedroom with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (8, 5, 2, 4,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (9, 5, 3, 7,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (10, 5, 3, 7,'spacious living room/dining areas, modern kitchen, updated bathrooms, large bedrooms with firm memory-foam beds and upscale bedding. Linens, blankets, towels, and pillows provided. Picnic tables, fire rings, and charcoal and gas grills provided.');
INSERT INTO cabin VALUES (1, 10, 1, 2,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');
INSERT INTO cabin VALUES (2, 10, 2, 6,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');
INSERT INTO cabin VALUES (3, 10, 3, 7,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');
INSERT INTO cabin VALUES (1, 6, 3, 6,'Free Wi-Fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (2, 6, 2, 5,'Free wi-fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (3, 6, 1, 2,'Free wi-fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (4, 6, 1, 3,'Free wi-fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (1, 7, 2, 4,'wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available.');
INSERT INTO cabin VALUES (2, 7, 2, 5,'wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available.');
INSERT INTO cabin VALUES (3, 7, 1, 2,'wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available.');
INSERT INTO cabin VALUES (4, 7, 3, 5,'wood burning fireplace and kitchen with refrigerator, stove/oven, microwave, pots and pans, silverware, toaster, electric coffee pot, and utensils. Cribs, high chairs and roll-a-ways available.');
INSERT INTO cabin VALUES (1, 9, 1, 2,'Free wi-fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (2, 9, 2, 4,'Free Wi-Fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (3, 9, 2, 5,'Free wi-fi. kitchen with refrigerator, stove, microwave, pots and pans, silverware, toaster and utensils.');
INSERT INTO cabin VALUES (1, 8, 3, 7,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');
INSERT INTO cabin VALUES (2, 8, 3, 6,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');
INSERT INTO cabin VALUES (3, 8, 1, 2,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');
INSERT INTO cabin VALUES (4, 8, 1, 3,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');
INSERT INTO cabin VALUES (5, 8, 2, 4,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');
INSERT INTO cabin VALUES (6, 8, 2, 4,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');
INSERT INTO cabin VALUES (7, 8, 2, 5,'kitchen with refrigerator and stove/oven. wood burning fireplace. free Wi-Fi.');


--BOOKINGS
INSERT INTO booking VALUES (1, TO_DATE('01-jun-2019', 'DD-MON-YYYY'), TO_DATE('03-jun-2019', 'DD-MON-YYYY'), 2, 0, 120.50, 3, 1, 9);
INSERT INTO booking VALUES (2, TO_DATE('01-jun-2019', 'DD-MON-YYYY'), TO_DATE('07-jun-2019', 'DD-MON-YYYY'), 2, 2, 710.45, 5, 1, 1);
INSERT INTO booking VALUES (3, TO_DATE('06-jun-2019', 'DD-MON-YYYY'), TO_DATE('05-jul-2019', 'DD-MON-YYYY'), 1, 4, 2020.45, 2, 6, 1);
INSERT INTO booking VALUES (4, TO_DATE('06-nov-2019', 'DD-MON-YYYY'), TO_DATE('08-nov-2019', 'DD-MON-YYYY'), 3, 3, 407.45, 1, 2, 10);
INSERT INTO booking VALUES (5, TO_DATE('07-dec-2019', 'DD-MON-YYYY'), TO_DATE('17-dec-2019', 'DD-MON-YYYY'), 2, 4, 1098.67, 5, 4, 1);
INSERT INTO booking VALUES (6, TO_DATE('07-jul-2019', 'DD-MON-YYYY'), TO_DATE('18-jul-2019', 'DD-MON-YYYY'), 4, 2, 876.56, 7, 6, 1);
INSERT INTO booking VALUES (7, TO_DATE('14-jul-2019', 'DD-MON-YYYY'), TO_DATE('21-jul-2019', 'DD-MON-YYYY'), 2, 2, 1575.80, 6, 3, 2);
INSERT INTO booking VALUES (8, TO_DATE('18-jul-2019', 'DD-MON-YYYY'), TO_DATE('20-jul-2019', 'DD-MON-YYYY'), 2, 1, 435.65, 8, 5, 3);
INSERT INTO booking VALUES (9, TO_DATE('10-jul-2019', 'DD-MON-YYYY'), TO_DATE('27-jul-2019', 'DD-MON-YYYY'), 2, 1, 675.87, 10, 2, 4);
INSERT INTO booking VALUES (10, TO_DATE('22-jul-2019', 'DD-MON-YYYY'), TO_DATE('25-jul-2019', 'DD-MON-YYYY'), 4, 1, 956.45, 9, 3, 2);
INSERT INTO booking VALUES (11, TO_DATE('01-jul-2019', 'DD-MON-YYYY'), TO_DATE('04-jul-2019', 'DD-MON-YYYY'), 2, 0, 221.65, 1, 16, 1);
INSERT INTO booking VALUES (12, TO_DATE('16-jul-2019', 'DD-MON-YYYY'), TO_DATE('19-jul-2019', 'DD-MON-YYYY'), 1, 3, 564.24, 3, 5, 5);
INSERT INTO booking VALUES (13, TO_DATE('18-jul-2019', 'DD-MON-YYYY'), TO_DATE('22-jul-2019', 'DD-MON-YYYY'), 2, 2, 723.17, 4, 4, 3);
INSERT INTO booking VALUES (14, TO_DATE('03-jul-2019', 'DD-MON-YYYY'), TO_DATE('07-jul-2019', 'DD-MON-YYYY'), 5, 2, 754.31, 5, 3, 10);
INSERT INTO booking VALUES (15, TO_DATE('07-aug-2019', 'DD-MON-YYYY'), TO_DATE('10-aug-2019', 'DD-MON-YYYY'), 2, 3, 765.45, 6, 3, 4);
INSERT INTO booking VALUES (16, TO_DATE('10-jul-2019', 'DD-MON-YYYY'), TO_DATE('11-jul-2019', 'DD-MON-YYYY'), 2, 3, 450.34, 1, 9, 1);
INSERT INTO booking VALUES (17, TO_DATE('11-jul-2019', 'DD-MON-YYYY'), TO_DATE('17-jul-2019', 'DD-MON-YYYY'), 2, 1, 897.98, 3, 3, 3);
INSERT INTO booking VALUES (18, TO_DATE('13-jul-2019', 'DD-MON-YYYY'), TO_DATE('15-jul-2019', 'DD-MON-YYYY'), 3, 2, 754.89, 5, 1, 2);
INSERT INTO booking VALUES (19, TO_DATE('03-aug-2019', 'DD-MON-YYYY'), TO_DATE('06-aug-2019', 'DD-MON-YYYY'), 2, 4, 786.35, 9, 9, 5);
INSERT INTO booking VALUES (20, TO_DATE('08-aug-2019', 'DD-MON-YYYY'), TO_DATE('10-aug-2019', 'DD-MON-YYYY'), 3, 0, 329.45, 7, 7, 5);
INSERT INTO booking VALUES (21, TO_DATE('15-aug-2019', 'DD-MON-YYYY'), TO_DATE('18-aug-2019', 'DD-MON-YYYY'), 2, 0, 317.80, 8, 1, 10);
INSERT INTO booking VALUES (22, TO_DATE('17-aug-2019', 'DD-MON-YYYY'), TO_DATE('24-aug-2019', 'DD-MON-YYYY'), 2, 2, 1298.00, 10, 5, 3);
INSERT INTO booking VALUES (23, TO_DATE('19-aug-2019', 'DD-MON-YYYY'), TO_DATE('22-aug-2019', 'DD-MON-YYYY'), 4, 2, 1098.87, 4, 1, 5);
INSERT INTO booking VALUES (24, TO_DATE('18-aug-2019', 'DD-MON-YYYY'), TO_DATE('21-aug-2019', 'DD-MON-YYYY'), 3, 3, 546.45, 6, 1, 6);
INSERT INTO booking VALUES (25, TO_DATE('01-aug-2019', 'DD-MON-YYYY'), TO_DATE('05-aug-2019', 'DD-MON-YYYY'), 3, 0, 300.00, 5, 2, 9);
INSERT INTO booking VALUES (26, TO_DATE('07-aug-2019', 'DD-MON-YYYY'), TO_DATE('11-aug-2019', 'DD-MON-YYYY'), 4, 1, 867.56, 1, 2, 2);
INSERT INTO booking VALUES (27, TO_DATE('25-aug-2019', 'DD-MON-YYYY'), TO_DATE('30-aug-2019', 'DD-MON-YYYY'), 3, 2, 865.34, 3, 1, 6);
INSERT INTO booking VALUES (28, TO_DATE('01-sep-2019', 'DD-MON-YYYY'), TO_DATE('04-sep-2019', 'DD-MON-YYYY'), 4, 0, 454.35, 6, 1, 7);
INSERT INTO booking VALUES (29, TO_DATE('03-sep-2019', 'DD-MON-YYYY'), TO_DATE('04-sep-2019', 'DD-MON-YYYY'), 2, 3, 187.67, 2, 2, 7);
INSERT INTO booking VALUES (30, TO_DATE('18-aug-2019', 'DD-MON-YYYY'), TO_DATE('21-aug-2019', 'DD-MON-YYYY'), 2, 0, 200.67, 4, 1, 3);
INSERT INTO booking VALUES (31, TO_DATE('24-aug-2019', 'DD-MON-YYYY'), TO_DATE('28-aug-2019', 'DD-MON-YYYY'), 2, 0, 240.00, 5, 1, 9);
INSERT INTO booking VALUES (32, TO_DATE('14-sep-2019', 'DD-MON-YYYY'), TO_DATE('20-sep-2019', 'DD-MON-YYYY'), 2, 4, 1856.45, 8, 1, 6);
INSERT INTO booking VALUES (33, TO_DATE('27-aug-2019', 'DD-MON-YYYY'), TO_DATE('03-sep-2019', 'DD-MON-YYYY'), 3, 1, 675.89, 5, 1, 1);
INSERT INTO booking VALUES (34, TO_DATE('22-aug-2019', 'DD-MON-YYYY'), TO_DATE('25-aug-2019', 'DD-MON-YYYY'), 2, 2, 564.34, 9, 3, 4);
INSERT INTO booking VALUES (35, TO_DATE('29-aug-2019', 'DD-MON-YYYY'), TO_DATE('30-aug-2019', 'DD-MON-YYYY'), 1, 2, 213.65, 7, 7, 5);
INSERT INTO booking VALUES (36, TO_DATE('04-sep-2019', 'DD-MON-YYYY'), TO_DATE('10-sep-2019', 'DD-MON-YYYY'), 2, 3, 765.54, 10, 2, 2);
INSERT INTO booking VALUES (37, TO_DATE('02-oct-2019', 'DD-MON-YYYY'), TO_DATE('10-oct-2019', 'DD-MON-YYYY'), 4, 2, 1600.65, 2, 9, 5);
INSERT INTO booking VALUES (38, TO_DATE('10-dec-2019', 'DD-MON-YYYY'), TO_DATE('12-dec-2019', 'DD-MON-YYYY'), 4, 1, 345.34, 3, 2, 6);
INSERT INTO booking VALUES (39, TO_DATE('25-aug-2019', 'DD-MON-YYYY'), TO_DATE('29-aug-2019', 'DD-MON-YYYY'), 2, 3, 1598.00, 6, 12, 1);
INSERT INTO booking VALUES (40, TO_DATE('28-aug-2019', 'DD-MON-YYYY'), TO_DATE('02-sep-2019', 'DD-MON-YYYY'), 4, 0, 400.00, 3, 3, 9);
INSERT INTO booking VALUES (41, TO_DATE('29-aug-2019', 'DD-MON-YYYY'), TO_DATE('03-sep-2019', 'DD-MON-YYYY'), 2, 3, 765.67, 10, 6, 3);
INSERT INTO booking VALUES (42, TO_DATE('05-sep-2019', 'DD-MON-YYYY'), TO_DATE('07-sep-2019', 'DD-MON-YYYY'), 2, 3, 430.54, 6, 2, 7);
INSERT INTO booking VALUES (43, TO_DATE('10-sep-2019', 'DD-MON-YYYY'), TO_DATE('20-sep-2019', 'DD-MON-YYYY'), 1, 4, 1200.67, 5, 6, 1);
INSERT INTO booking VALUES (44, TO_DATE('20-sep-2019', 'DD-MON-YYYY'), TO_DATE('24-sep-2019', 'DD-MON-YYYY'), 2, 3, 783.65, 9, 4, 7);
INSERT INTO booking VALUES (45, TO_DATE('03-oct-2019', 'DD-MON-YYYY'), TO_DATE('09-oct-2019', 'DD-MON-YYYY'), 4, 0, 787.45, 4, 1, 7);
INSERT INTO booking VALUES (46, TO_DATE('07-oct-2019', 'DD-MON-YYYY'), TO_DATE('13-oct-2019', 'DD-MON-YYYY'), 3, 2, 564.34, 3, 3, 4);
INSERT INTO booking VALUES (47, TO_DATE('08-dec-2019', 'DD-MON-YYYY'), TO_DATE('10-dec-2019', 'DD-MON-YYYY'), 1, 4, 564.34, 7, 6, 3);
INSERT INTO booking VALUES (48, TO_DATE('03-oct-2019', 'DD-MON-YYYY'), TO_DATE('07-oct-2019', 'DD-MON-YYYY'), 2, 1, 543.39, 9, 1, 1);
INSERT INTO booking VALUES (49, TO_DATE('03-nov-2019', 'DD-MON-YYYY'), TO_DATE('05-nov-2019', 'DD-MON-YYYY'), 4, 0, 200.00, 2, 2, 9);
INSERT INTO booking VALUES (50, TO_DATE('10-nov-2019', 'DD-MON-YYYY'), TO_DATE('14-nov-2019', 'DD-MON-YYYY'), 3, 0, 645.49, 7, 2, 10);


--REVIEWS
INSERT INTO review VALUES(1, 'Excellent resort and good staff!', TO_DATE('04-aug-2019', 'DD-MON-YYYY'), 5, 3, 9);
INSERT INTO review VALUES(2, 'Great location and GOOD service!', TO_DATE('10-aug-2019', 'DD-MON-YYYY'), 5, 2, 1);
INSERT INTO review VALUES(3, 'Very friendly staff. Clean cabins! :-)', TO_DATE('19-aug-2019', 'DD-MON-YYYY'), 5, 7, 1);
INSERT INTO review VALUES(4, 'Good but expensive!', TO_DATE('22-aug-2019', 'DD-MON-YYYY'), 4, 6, 2);
INSERT INTO review VALUES(5, 'all good!', TO_DATE('29-aug-2019', 'DD-MON-YYYY'), 5, 10, 4);
INSERT INTO review VALUES(6, 'Kitchen was not very clean, overall very good experience.', TO_DATE('01-sep-2019', 'DD-MON-YYYY'), 3, 1, 1);
INSERT INTO review VALUES(7, 'Great place to stay!', TO_DATE('10-sep-2019', 'DD-MON-YYYY'), 5, 3, 3);
INSERT INTO review VALUES(8, 'will not come back!', TO_DATE('15-sep-2019', 'DD-MON-YYYY'), 1, 1, 9);
INSERT INTO review VALUES(9, 'Excellent service!', TO_DATE('01-oct-2019', 'DD-MON-YYYY'), 5, 10, 1);
INSERT INTO review VALUES(10, 'Exceptinal cabins and service!', TO_DATE('01-oct-2019', 'DD-MON-YYYY'), 5, 9, 4);
INSERT INTO review VALUES(11, 'not a good experience!', TO_DATE('02-oct-2019', 'DD-MON-YYYY'), 2, 4, 9);
INSERT INTO review VALUES(12, 'Value for money.', TO_DATE('02-oct-2019', 'DD-MON-YYYY'), 3, 7, 5);
INSERT INTO review VALUES(13, 'clean rooms and great kitchen. :-)', TO_DATE('03-oct-2019', 'DD-MON-YYYY'), 5, 4, 7);
INSERT INTO review VALUES(14, 'Stay was OK only.', TO_DATE('03-oct-2019', 'DD-MON-YYYY'), 2, 10, 9);
INSERT INTO review VALUES(15, 'Enjoyed the stay!', TO_DATE('03-oct-2019', 'DD-MON-YYYY'), 5, 9, 1);

-- The script must contain a single COMMIT statement as the last line of the script, 
-- ie. all listed actions should be treated as a single transaction.
COMMIT;

