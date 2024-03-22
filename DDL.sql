create database formula1;
use formula1;
create table Engineer ( 
	ID integer, 
	namee varchar(40) not null,
	address varchar(40),
	dob Date,
	nationality varchar(40), 
	job varchar(40), 
	profession varchar(40),
    primary key(ID),
	check( ID >=0));
  

create table Mechanic ( 
	ID int, 
    namee varchar(40) not null, 
    address varchar(40), 
    dob Date, 
    nationality varchar(40), 
    levell int default 0,
    check (levell between 0 and 5),
    primary key (ID),
    check( ID >=0));
    
create table Car_Parts(
	parts_ID integer, 
    part_Name varchar(40),
	versionn varchar(40), 
    typee varchar(40), 
    health Integer,
    primary key(parts_ID),
    check(health>= 0 and health<=100),
    check( parts_ID >=0)
    );

create table Car(
	car_ID int, 
    car_Version varchar(40), 
    yearr int,
    primary key(car_ID),
	check(car_ID>= 0 and car_ID<=100),
     check( car_ID >=0)
);

create table Race(
	race_ID int,
	datee date, 
    weather varchar(40), 
    race_Name varchar(40), 
    circuit_Name varchar(40), 
    region varchar(40), 
    city varchar(40), 
    country varchar(40),
    primary key(race_ID),
     check( race_ID >=0)
    );
    
create table Accident(
	car_ID int, 
    accident_ID int,
	datee date,
    primary key(accident_ID, car_ID),
    foreign key(car_ID)references Car(car_ID),
     check( accident_ID >=0)
   );

create table Team_Principal(
	ID int,
    namee varchar(40), 
    address varchar(40), 
    dob date, 
    nationality varchar(40), 
    contract_End date, 
    contract_Start date ,
	primary key(ID),
     check(ID >=0));


create table Team(
	team_ID int,
    team_principal_ID int not null,
    headquarters varchar(40), 
    team_Name  varchar(50),
    engine_Supplier varchar(40), 
    main_Sponsor varchar(40),
    total_Points int default 0,
	primary key (team_ID),
	foreign key (team_principal_ID) references Team_Principal(ID),
	check( team_ID >=0)
    );
    
create table Driver(
	ID int,
	team_ID int not null ,
    car_ID int,
    namee varchar(40), 
    address varchar(40), 
    dob varchar(40), 
    nationality varchar(40), 
    contract_End date, 
    contract_Start DATE, 
    positionn int default 0,
    primary key(ID),
    foreign key(team_ID) references Team(team_ID),
    foreign key(car_ID) references Car(car_ID),
    check (positionn>=0 and positionn<=20),
	check( ID >=0)
    );

create table Standings(
	standings_ID int, 
    race_Result int,
    points int default 0,
    race_ID int,
    driver_ID int,
    check (points>=0),
	primary key(standings_ID),
    foreign key(race_ID) references Race(race_ID),
	foreign key(driver_ID) references Driver(ID),
     check( standings_ID >=0)
    );
    


create table Race_Engineer(
	ID int,
	driver_ID int not null ,
    namee varchar(40), 
    address varchar(40), 
    dob Date, 
    nationality varchar(40), 
    job varchar(40),
    primary key (ID),
    foreign key(driver_ID) references Driver(ID),
     check( ID >=0)
    );    

create table Sponsor(
	sponsor_ID int,
    primary key(sponsor_ID),
	sponsor_Name varchar(40), 
    contract_Start date, 
    investment_Amount int, 
    contract_End date,
     check(sponsor_ID >=0));

create table Department(
	building_Number int,
	team_ID int not null,
    typee varchar(40), 
    budget double, 
    nb_of_Employees int,
     primary key(building_Number),
	foreign key(team_ID) references Team(team_ID),
     check( building_Number >=0)
     );
     
     
    
create table PitStops(
	race_ID int,
    timee date, 
    duration float, 
    type_of_Old varchar(40),  
    type_of_New varchar(40),
	primary key(race_ID),
	foreign key(race_ID) references Race(race_ID),
	index idx_timee (timee) ,
	index idx_duration (duration)
     );



CREATE TABLE Works_in (
    building_Number INTEGER,
    engineer_ID INTEGER,
    PRIMARY KEY (building_Number , engineer_ID),
    FOREIGN KEY (building_Number)
        REFERENCES Department (building_Number),
	FOREIGN KEY (engineer_ID)
        REFERENCES Engineer (ID)
); 
CREATE TABLE Participates (
    race_ID INTEGER,
    car_ID INTEGER,
    PRIMARY KEY (race_ID , car_ID),
    FOREIGN KEY (race_ID)
        REFERENCES Race (race_ID),
    FOREIGN KEY (car_ID)
        REFERENCES Car (car_ID)
);
CREATE TABLE Sponsors (
    sponsor_ID INTEGER,
    car_ID INTEGER,
    PRIMARY KEY (sponsor_ID , car_ID),
    FOREIGN KEY (car_ID)
        REFERENCES Car (car_ID),
    FOREIGN KEY (sponsor_ID)
        REFERENCES Sponsor (sponsor_ID)
);
CREATE TABLE Fixes (
    mechanic_ID INTEGER,
    car_ID INTEGER,
    PRIMARY KEY (mechanic_ID , car_ID),
    FOREIGN KEY (mechanic_ID)
        REFERENCES Mechanic (ID),
    FOREIGN KEY (car_ID)
        REFERENCES Car (car_ID)
);
CREATE TABLE Damages (
    parts_ID INTEGER,
    car_ID INTEGER,
    accident_ID INTEGER,
    PRIMARY KEY (parts_ID , car_ID , accident_ID),
    FOREIGN KEY (parts_ID)
        REFERENCES Car_Parts (parts_ID),
    FOREIGN KEY (car_ID)
        REFERENCES car (car_ID),
    FOREIGN KEY (accident_ID)
        REFERENCES accident (accident_ID)
);
CREATE TABLE Fabricates (
    parts_ID INTEGER,
    engineer_ID INTEGER,
    building_Number INTEGER,
    FOREIGN KEY (building_Number)
        REFERENCES Department (building_Number),
    FOREIGN KEY (engineer_ID)
        REFERENCES Engineer (ID),
    FOREIGN KEY (parts_ID)
        REFERENCES Car_Parts (parts_ID)
);
CREATE TABLE monitors (
    team_principal_ID INT,
    race_ID INT,
    car_ID INT,
    PRIMARY KEY (team_principal_ID , race_ID , car_ID),
    FOREIGN KEY (team_principal_ID)
        REFERENCES Team_Principal (ID),
    FOREIGN KEY (race_ID)
        REFERENCES Race (race_ID),
    FOREIGN KEY (car_ID)
        REFERENCES Car (car_ID)
);




