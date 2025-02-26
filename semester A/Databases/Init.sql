
--insert values

insert into league values ('Super League','Greece');

insert into stadium
values
('Georgios Karaiskakis', 117.2, 50.1, 35000, 'Faliro');

insert into stadium
values
('OPAP Arena', 116.2, 49.2, 40000, 'Nea Philadelfia');

insert into stadium
values
('OAKA', 115.2, 54.3, 30000, 'Marousi');

insert into stadium
values
('Toumpa', 117.4, 52.4, 60000, 'Toumpa');

insert into team
values 
('1000000','AEK','Nea Philadelfia','Super League','OPAP Arena');

insert into team
values 
('1000001','Panathinaikos','Athens','Super League','OAKA');

insert into team
values 
('1000002','PAOK','Thessaloniki','Super League','Toumpa');

insert into team
values 
('1000003','Olympiakos','Peireus','Super League','Georgios Karaiskakis');

insert into person
values
('AB100000','Livai','Garcia',TO_DATE('1990-01-01','YYYY-MM-DD'),100000,0,'1000000');

insert into person
values
('AB100001','Antony','Martial',TO_DATE('1995-08-16','YYYY-MM-DD'),2000000,0,'1000000');

insert into person
values
('AB100002','Fotis','Iwannidis',TO_DATE('1995-01-01','YYYY-MM-DD'),3000000,0,'1000001');

insert into person
values
('AB100003','Tasos','Mpakasetas',TO_DATE('1993-02-15','YYYY-MM-DD'),1500000,0,'1000001');

insert into person
values
('AB100008','Facundo','Pelistry',TO_DATE('1999-02-12','YYYY-MM-DD'),2000000,0,'1000001');

insert into person
values
('AB100004','Ciril','Despodov',TO_DATE('1992-02-13','YYYY-MM-DD'),1500000,0,'1000002');

insert into person
values
('AB100005','Giannis','Konstantelias',TO_DATE('2003-02-13','YYYY-MM-DD'),1000000,0,'1000002');

insert into person
values
('AB100006','David','Carmo',TO_DATE('1992-03-15','YYYY-MM-DD'),3000000,0,'1000003');

insert into person
values
('AB100007','Konstantis','Tzolakis',TO_DATE('2000-04-11','YYYY-MM-DD'),900000,0,'1000003');

insert into person
values
('AB123123','Lazaros','Christodoulopoulos',TO_DATE('1990-10-12','YYYY-MM-DD'),0,0,NULL);

insert into person
values
('CC111111','Razvan','Lucecku',TO_DATE('1970-03-03','YYYY-MM-DD'),1000000,1,'1000002');

insert into person
values
('CC123123','Rui','Vitoria',TO_DATE('1968-02-02','YYYY-MM-DD'),900000,1,'1000001');

insert into person
values
('CC222222','Jose','Medilibar',TO_DATE('1965-04-04','YYYY-MM-DD'),1000000,1,'1000003');

insert into person
values
('CC333333','Matias','Almeida',TO_DATE('1972-05-05','YYYY-MM-DD'),1000000,1,'1000000');

insert into person
values
('CC111111','Razvan','Lucecku',TO_DATE('1970-03-03','YYYY-MM-DD'),1000000,1,'1000002');

insert into person
values
('CC123123','Rui','Vitoria',TO_DATE('1968-02-02','YYYY-MM-DD'),900000,1,'1000001');

insert into person
values
('CC222222','Jose','Medilibar',TO_DATE('1965-04-04','YYYY-MM-DD'),1000000,1,'1000003');

insert into person
values
('CC333333','Matias','Almeida',TO_DATE('1972-05-05','YYYY-MM-DD'),1000000,1,'1000000');

insert into History
values
(1,'1000000','AB100003',TO_DATE('2016-09-01','YYYY-MM-DD'),TO_DATE('2019-08-01','YYYY-MM-DD'),800000);

insert into History
values
(2,'1000001','AB100003',TO_DATE('2019-09-01','YYYY-MM-DD'),TO_DATE('2020-08-01','YYYY-MM-DD'),1000000);

insert into History
values
(3,'1000003','AB123123',TO_DATE('2000-09-01','YYYY-MM-DD'),TO_DATE('2002-08-01','YYYY-MM-DD'),100000);

insert into History
values
(4,'1000001','AB123123',TO_DATE('2002-09-01','YYYY-MM-DD'),TO_DATE('2010-08-01','YYYY-MM-DD'),500000);

insert into History
values
(5,'1000002','AB123123',TO_DATE('2010-09-01','YYYY-MM-DD'),TO_DATE('2012-08-01','YYYY-MM-DD'),800000);

insert into History
values
(6,'1000001','AB123123',TO_DATE('2012-09-01','YYYY-MM-DD'),TO_DATE('2017-08-01','YYYY-MM-DD'),300000);

insert into Game
values
(1,'1000000', '1000001', 2, TO_DATE('2024-12-01','YYYY-MM-DD'));

insert into Game
values
(2,'1000000', '1000002', 1, TO_DATE('2024-12-15','YYYY-MM-DD'));

insert into Game
values
(3,'1000000', '1000003', 0, TO_DATE('2024-11-10','YYYY-MM-DD'));

insert into Game
values
(4,'1000001', '1000000', 0, TO_DATE('2024-12-01','YYYY-MM-DD'));

insert into Game
values
(5,'1000001', '1000002', 1, TO_DATE('2024-12-08','YYYY-MM-DD'));

insert into Game
values
(6,'1000001', '1000003', 0, TO_DATE('2025-01-14','YYYY-MM-DD'));

insert into Game
values
(7,'1000002', '1000000', 1, TO_DATE('2024-09-15','YYYY-MM-DD'));

insert into Game
values
(8,'1000002', '1000001', 2, TO_DATE('2024-12-08','YYYY-MM-DD'));

insert into Game
values
(9,'1000002', '1000003', 0, TO_DATE('2024-11-10','YYYY-MM-DD'));

insert into Game
values
(10,'1000001', '1000000', 0, TO_DATE('2014-10-13','YYYY-MM-DD'));

insert into Game
values
(11,'1000001', '1000003', 0, TO_DATE('2014-12-01','YYYY-MM-DD'));

insert into Game
values
(12,'1000001', '1000002', 0, TO_DATE('2014-10-06','YYYY-MM-DD'));

insert into Game
values
(16,'1000000', '1000002', 1, TO_DATE('2019-10-10','YYYY-MM-DD'));