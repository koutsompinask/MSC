--create tables

CREATE TABLE League (
    league_name VARCHAR(100),  
    country VARCHAR(100) NOT NULL,
    PRIMARY KEY (league_name)
);

CREATE TABLE Stadium (
    stadium_name VARCHAR(100),
    length FLOAT(2) NOT NULL,
    width FLOAT(2) NOT NULL,
    capacity INTEGER NOT NULL,
    address VARCHAR(100) NOT NULL,
    PRIMARY KEY (stadium_name)
);

CREATE TABLE Team (
    vat CHAR(8),
    team_name VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    f_league_name VARCHAR(100),
    f_stadium_name VARCHAR(100),
    PRIMARY KEY (vat),
    FOREIGN KEY (f_league_name) REFERENCES League(league_name),
    FOREIGN KEY (f_stadium_name) REFERENCES Stadium(stadium_name)
);

CREATE TABLE Person (
    id CHAR(8),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    salary INTEGER,
    is_coach BOOLEAN NOT NULL,
    f_team_vat CHAR(8),
    PRIMARY KEY (id),
    FOREIGN KEY (f_team_vat) REFERENCES Team(vat)
);

CREATE TABLE Game (
    id INTEGER,
    f_home_team_vat CHAR(8),
    f_away_team_vat CHAR(8),
    result SMALLINT NOT NULL,
    date_of_game DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (f_home_team_vat) REFERENCES Team(vat),
    FOREIGN KEY (f_away_team_vat) REFERENCES Team(vat)
);

CREATE TABLE History (
    id INTEGER,
    f_team_vat CHAR(8),
    f_person_id CHAR(8),
    from_date DATE NOT NULL,
    to_date DATE,
    salary DECIMAL NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (f_team_vat) REFERENCES Team(vat),
    FOREIGN KEY (f_person_id) REFERENCES Person(id)
);

--insert values

insert into league values ('Super League','Greece');

insert into stadium
values
('Georgios Karaiskakis', 117.2, 50.1, 35000, 'Faliro'),
('OPAP Arena', 116.2, 49.2, 40000, 'Nea Philadelfia'),
('OAKA', 115.2, 54.3, 30000, 'Marousi'),
('Toumpa', 117.4, 52.4, 60000, 'Toumpa');

insert into team
values 
('1000000','AEK','Nea Philadelfia','Super League','OPAP Arena'),
('1000001','Panathinaikos','Athens','Super League','OAKA'),
('1000002','PAOK','Thessaloniki','Super League','Toumpa'),
('1000003','Olympiakos','Peireus','Super League','Georgios Karaiskakis');

insert into person
values
('AB100000','Livai','Garcia','1990-01-01',100000,false,'1000000'),
('AB100001','Antony','Martial','1995-08-16',2000000,false,'1000000'),
('AB100002','Fotis','Iwannidis','1995-01-01',3000000,false,'1000001'),
('AB100003','Tasos','Mpakasetas','1993-02-15',1500000,false,'1000001'),
('AB100004','Ciril','Despodov','1992-02-13',1500000,false,'1000002'),
('AB100005','Giannis','Konstantelias','2003-02-13',1000000,false,'1000002'),
('AB100006','David','Carmo','1992-03-15',3000000,false,'1000003'),
('AB100007','Konstantis','Tzolakis','2000-04-11',900000,false,'1000003'),
('AB123123','Lazaros','Christodoulopoulos','1990-10-12',0,false,NULL),
('CC111111','Razvan','Lucecku','1970-03-03',1000000,true,'1000002'),
('CC123123','Rui','Vitoria','1968-02-02',900000,true,'1000001'),
('CC222222','Jose','Medilibar','1965-04-04',1000000,true,'1000003'),
('CC333333','Matias','Almeida','1972-05-05',1000000,true,'1000000');

insert into History
values
(1,'1000000','AB100003','2016-09-01','2019-08-01',800000),
(2,'1000001','AB100003','2019-09-01','2020-08-01',1000000),
(3,'1000003','AB123123','2000-09-01','2002-08-01',100000),
(4,'1000001','AB123123','2002-09-01','2010-08-01',500000),
(5,'1000002','AB123123','2010-09-01','2012-08-01',800000),
(6,'1000001','AB123123','2012-09-01','2017-08-01',300000);

insert into Game
values
(1,'1000000', '1000001', 2, '2024-12-1'),
(2,'1000000', '1000002', 1, '2024-12-15'),
(3,'1000000', '1000003', 0, '2024-11-10'),
(4,'1000001', '1000000', 0, '2024-12-1'),
(5,'1000001', '1000002', 1, '2024-12-8'),
(6,'1000001', '1000003', 0, '2025-1-14'),
(7,'1000002', '1000000', 1, '2024-9-15'),
(8,'1000002', '1000001', 2, '2024-12-8'),
(9,'1000002', '1000003', 0, '2024-11-10'),
(10,'1000001', '1000000', 0, '2014-10-13'),
(11,'1000001', '1000003', 0, '2014-12-1'),
(12,'1000001', '1000002', 0, '2014-10-6'),
(16,'1000000', '1000002', 1, '2019-10-10');