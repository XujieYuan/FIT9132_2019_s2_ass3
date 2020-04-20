/* FIT9132 2019 S2 Assignment 3 Q1-Part A ANSWERS

   Student Name:Xujie Yuan 
    Student ID:29994675

   Comments to your marker:
   
*/

-- insert resorts
insert into resort values (1, 'Apolo', '781 Kings Avenue', 3168, 4.5, 'N', 1, 1);
insert into resort values (2, 'GoodNight', '61 Princes Avenue', 3158, 4, 'Y', 2, 3);
insert into resort values (3, 'GreatView', '32 Blackburn Road', 3149, 5, 'N', 3, 4);
insert into resort values (4, 'MoMo', '666 Marshell Avenue', 3177, 5, 'N', 14, 5);
insert into resort values (5, 'BlueStar', '17 Darling Road', 3189, 3.5, 'Y', 1, 1);
insert into resort values (6, 'Silver', '42 Glenbrook Avenue', 3123, null, 'Y', 18, 3);
insert into resort values (7, 'PlanB', '696 Griffin Road', 3145, null, 'N', 1, 5);
insert into resort values (8, 'SpringPalace', '888 Richmond Road', 3168, null, 'Y', 2, 3);
insert into resort values (9, 'Paradise', '123 Albert Road', 3145, null, 'N', 1, 5);
insert into resort values (10, 'PlanA', '666 Griffin Road', 3145, null, 'Y', 1, 1);
insert into resort values (11, 'PlanC', '777 Griffin Road', 3145, null, 'Y', 1, 4);

--insert cabins
insert into cabin values (1, 1, 2, 3, 'a big room');
insert into cabin values (2, 1, 2, 3, 'has beautiful view');
insert into cabin values (3, 2, 2, 3, 'a quiet room');
insert into cabin values (4, 3, 2, 2, 'nice decoration');
insert into cabin values (5, 4, 2, 2, 'wifi provided');
insert into cabin values (6, 1, 2, 2, 'has a TV');
insert into cabin values (7, 5, 4, 1, 'has a computer');
insert into cabin values (8, 5, 4, 1, 'has a TV');
insert into cabin values (9, 7, 3, 1, 'soft bed');
insert into cabin values (10, 7, 2, 4, 'free fruit');
insert into cabin values (11, 6, 1, 5, 'nice decoration');
insert into cabin values (12, 6, 1, 4, 'soft quilt');
insert into cabin values (13, 3, 1, 4, 'soft bed');
insert into cabin values (14, 4, 1, 6, 'a big room');
insert into cabin values (15, 3, 2, 6, 'a big room');
insert into cabin values (16, 2, 3, 5, 'a big room');
insert into cabin values (17, 2, 2, 3, 'a quiet room');
insert into cabin values (18, 2, 3, 3, 'wifi provided');
insert into cabin values (19, 7, 3, 3, 'has a TV');
insert into cabin values (20, 5, 2, 2, 'has beautiful view');
insert into cabin values (21, 5, 3, 2, 'a quiet room');
insert into cabin values (22, 5, 4, 1, 'a private room');
insert into cabin values (23, 2, 5, 3, 'a family room');
insert into cabin values (24, 3, 3, 1, 'a private room');

--insert bookings
insert into booking values (1, to_date('2019/01/20', 'YYYY/MM/DD'), to_date('2019/01/23', 'YYYY/MM/DD'), 2, 1, 129, 1, 18, 2);
insert into booking values (2, to_date('2019/01/21', 'YYYY/MM/DD'), to_date('2019/01/23', 'YYYY/MM/DD'), 2, 3, 229, 2, 16, 2);
insert into booking values (3, to_date('2019/02/02', 'YYYY/MM/DD'), to_date('2019/02/03', 'YYYY/MM/DD'), 2, 4, 239, 3, 15, 3);
insert into booking values (4, to_date('2019/01/09', 'YYYY/MM/DD'), to_date('2019/01/10', 'YYYY/MM/DD'), 4, 2, 239, 10, 15, 3);
insert into booking values (5, to_date('2019/01/15', 'YYYY/MM/DD'), to_date('2019/01/19', 'YYYY/MM/DD'), 4, 2, 239, 5, 15, 3);
insert into booking values (6, to_date('2019/01/15', 'YYYY/MM/DD'), to_date('2019/01/19', 'YYYY/MM/DD'), 2, 3, 229, 2, 11, 6);
insert into booking values (7, to_date('2019/01/20', 'YYYY/MM/DD'), to_date('2019/01/25', 'YYYY/MM/DD'), 2, 1, 169, 3, 1, 1);
insert into booking values (8, to_date('2019/01/05', 'YYYY/MM/DD'), to_date('2019/01/11', 'YYYY/MM/DD'), 2, 4, 239, 9, 14, 4);
insert into booking values (9, to_date('2019/02/02', 'YYYY/MM/DD'), to_date('2019/02/10', 'YYYY/MM/DD'), 2, 3, 249, 8, 11, 6);
insert into booking values (10, to_date('2019/02/02', 'YYYY/MM/DD'), to_date('2019/02/04', 'YYYY/MM/DD'), 3, 3, 299, 10, 14, 4);
insert into booking values (11, to_date('2019/02/03', 'YYYY/MM/DD'), to_date('2019/02/04', 'YYYY/MM/DD'), 3, 1, 229, 4, 10, 7);
insert into booking values (12, to_date('2019/02/02', 'YYYY/MM/DD'), to_date('2019/02/04', 'YYYY/MM/DD'), 3, 2, 299, 3, 16, 2);
insert into booking values (13, to_date('2019/03/11', 'YYYY/MM/DD'), to_date('2019/03/23', 'YYYY/MM/DD'), 3, 1, 299, 5, 10, 7);
insert into booking values (14, to_date('2019/03/15', 'YYYY/MM/DD'), to_date('2019/03/20', 'YYYY/MM/DD'), 2, 1, 159, 7, 23, 2);
insert into booking values (15, to_date('2019/03/20', 'YYYY/MM/DD'), to_date('2019/03/23', 'YYYY/MM/DD'), 2, 2, 179, 1, 12, 6);
insert into booking values (16, to_date('2019/03/20', 'YYYY/MM/DD'), to_date('2019/03/25', 'YYYY/MM/DD'), 2, 1, 129, 2, 19, 7);
insert into booking values (17, to_date('2019/03/23', 'YYYY/MM/DD'), to_date('2019/03/26', 'YYYY/MM/DD'), 2, 1, 129, 4, 17, 2);
insert into booking values (18, to_date('2019/05/20', 'YYYY/MM/DD'), to_date('2019/06/10', 'YYYY/MM/DD'), 2, 1, 139, 3, 18, 2);
insert into booking values (19, to_date('2019/06/30', 'YYYY/MM/DD'), to_date('2019/07/03', 'YYYY/MM/DD'), 2, 1, 149, 6, 19, 7);
insert into booking values (20, to_date('2019/12/20', 'YYYY/MM/DD'), to_date('2019/12/25', 'YYYY/MM/DD'), 2, 1, 189, 9, 17, 2);
insert into booking values (21, to_date('2020/01/20', 'YYYY/MM/DD'), to_date('2020/01/23', 'YYYY/MM/DD'), 2, 4, 259, 10, 14, 4);
insert into booking values (22, to_date('2020/01/20', 'YYYY/MM/DD'), to_date('2020/01/23', 'YYYY/MM/DD'), 2, 4, 259, 1, 15, 3);
insert into booking values (23, to_date('2020/08/20', 'YYYY/MM/DD'), to_date('2020/08/21', 'YYYY/MM/DD'), 3, 3, 269, 2, 15, 3);
insert into booking values (24, to_date('2020/10/01', 'YYYY/MM/DD'), to_date('2020/10/10', 'YYYY/MM/DD'), 3, 2, 289, 3, 11, 6);
insert into booking values (25, to_date('2020/11/03', 'YYYY/MM/DD'), to_date('2020/11/13', 'YYYY/MM/DD'), 4, 2, 299, 8, 14, 4);
insert into booking values (26, to_date('2020/11/22', 'YYYY/MM/DD'), to_date('2020/11/23', 'YYYY/MM/DD'), 2, 2, 229, 9, 12, 6);
insert into booking values (27, to_date('2020/11/29', 'YYYY/MM/DD'), to_date('2020/12/03', 'YYYY/MM/DD'), 2, 2, 229, 5, 13, 3);
insert into booking values (28, to_date('2020/12/03', 'YYYY/MM/DD'), to_date('2020/12/11', 'YYYY/MM/DD'), 3, 1, 229, 2, 12, 6);
insert into booking values (29, to_date('2020/12/25', 'YYYY/MM/DD'), to_date('2020/12/30', 'YYYY/MM/DD'), 2, 1, 199, 6, 1, 1);
insert into booking values (50, to_date('2019/01/22', 'YYYY/MM/DD'), to_date('2019/01/25', 'YYYY/MM/DD'), 2, 1, 129, 1, 18, 2);

--insert reviews
insert into review values (1, 'good', to_date('2019/01/30', 'YYYY/MM/DD'), 3, 1, 2);
insert into review values (2, 'great', to_date('2019/01/30', 'YYYY/MM/DD'), 4, 2, 2);
insert into review values (3, 'not good', to_date('2019/01/30', 'YYYY/MM/DD'), 2, 10, 3);
insert into review values (4, 'fantastic', to_date('2020/08/30', 'YYYY/MM/DD'), 5, 2, 3);
insert into review values (5, 'good', to_date('2019/02/25', 'YYYY/MM/DD'), 3, 8, 6);
insert into review values (6, 'good', to_date('2019/02/10', 'YYYY/MM/DD'), 3, 4, 7);
insert into review values (7, 'great', to_date('2019/03/10', 'YYYY/MM/DD'), 4, 10, 3);
insert into review values (8, 'great', to_date('2019/02/20', 'YYYY/MM/DD'), 4, 3, 2);
insert into review values (9, 'fantastic', to_date('2019/03/30', 'YYYY/MM/DD'), 5, 5, 7);
insert into review values (10, 'bad', to_date('2019/03/28', 'YYYY/MM/DD'), 1, 7, 2);
insert into review values (11, 'not good', to_date('2019/03/27', 'YYYY/MM/DD'), 2, 1, 6);
insert into review values (12, 'not good', to_date('2019/07/11', 'YYYY/MM/DD'), 2, 3, 2);
insert into review values (13, 'bad', to_date('2020/02/13', 'YYYY/MM/DD'), 1, 1, 3);
insert into review values (14, 'great', to_date('2020/09/01', 'YYYY/MM/DD'), 4, 2, 3);
insert into review values (15, 'great', to_date('2020/10/18', 'YYYY/MM/DD'), 4, 3, 6);
insert into review values (16, 'good', to_date('2020/11/14', 'YYYY/MM/DD'), 3, 8, 4);
insert into review values (17, 'good', to_date('2020/11/24', 'YYYY/MM/DD'), 3, 9, 6);
insert into review values (18, 'fantastic', to_date('2020/12/18', 'YYYY/MM/DD'), 5, 2, 6);
insert into review values (19, 'nice memory', to_date('2019/01/18', 'YYYY/MM/DD'), 5, 4, 7);
insert into review values (20, 'will not come back', to_date('2019/01/02', 'YYYY/MM/DD'), 1, 3, 2);
insert into review values (21, 'OK only', to_date('2019/01/08', 'YYYY/MM/DD'), 3, 5, 7);

commit;