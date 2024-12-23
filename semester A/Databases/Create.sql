CREATE TABLE League (
    league_name VARCHAR(100),  
    country VARCHAR(100),
    PRIMARY KEY (league_name)
);

CREATE TABLE Stadium (
    stadium_name VARCHAR(100),
    length FLOAT(2),
    width FLOAT(2),
    capacity INTEGER,
    address VARCHAR(100),
    PRIMARY KEY (stadium_name)
);

CREATE TABLE Team (
    vat CHAR(8),
    team_name VARCHAR(100),
    region VARCHAR(100),
    f_league_name VARCHAR(100),
    f_stadium_name VARCHAR(100),
    PRIMARY KEY (vat),
    FOREIGN KEY (f_league_name) REFERENCES League(league_name),
    FOREIGN KEY (f_stadium_name) REFERENCES Stadium(stadium_name)
);

CREATE TABLE Person (
    id CHAR(8),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    salary INTEGER,
    is_coach BOOLEAN,
    f_team_vat CHAR(8),
    PRIMARY KEY (id),
    FOREIGN KEY (f_team_vat) REFERENCES Team(vat)
);

CREATE TABLE Matches (
    f_home_team_vat CHAR(8),
    f_away_team_vat CHAR(8),
    result SMALLINT,
    date_of_match DATE,
    PRIMARY KEY (f_home_team_vat,f_away_team_vat),
    FOREIGN KEY (f_home_team_vat) REFERENCES Team(vat),
    FOREIGN KEY (f_away_team_vat) REFERENCES Team(vat)
);

CREATE TABLE History (
    ID INTEGER,
    f_team_vat CHAR(8),
    f_person_id CHAR(8),
    from_date DATE,
    to_date DATE,
    salary DECIMAL,
    PRIMARY KEY (ID),
    FOREIGN KEY (f_team_vat) REFERENCES Team(vat),
    FOREIGN KEY (f_person_id) REFERENCES Person(id)
);