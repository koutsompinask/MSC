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

CREATE TABLE Match (
    f_home_team_vat CHAR(8),
    f_away_team_vat CHAR(8),
    result SMALLINT NOT NULL,
    date_of_match DATE NOT NULL,
    PRIMARY KEY (f_home_team_vat,f_away_team_vat),
    FOREIGN KEY (f_home_team_vat) REFERENCES Team(vat),
    FOREIGN KEY (f_away_team_vat) REFERENCES Team(vat)
);

CREATE TABLE History (
    ID INTEGER,
    f_team_vat CHAR(8),
    f_person_id CHAR(8),
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    salary DECIMAL NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (f_team_vat) REFERENCES Team(vat),
    FOREIGN KEY (f_person_id) REFERENCES Person(id)
);