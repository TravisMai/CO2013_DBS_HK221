-- CREATE DATABASE --
DROP DATABASE reality_show;

CREATE DATABASE reality_show;

Use reality_show;

SET FOREIGN_KEY_CHECKs=0;
SET GLOBAL FOREIGN_KEY_CHECKs=0;

-- CREATE TABLE --

    -- Company --
    CREATE Table Company
    (
        Cnumber char(4) not NULL primary key,
        Name text not NULL,
        CAddress text,
        Phone numeric(10) not NULL UNIQUE,
        Edate date,
        CONSTRAINT CnumberCons CHECK (Cnumber LIKE 'C[0-9][0-9][0-9]')
    );


    -- Person --
    CREATE table Person(
        Ssn numeric(12,0) NOT NULL PRIMARY KEY,
        Fname text,
        Lname text,
        PAddress text,
        Phone  numeric(10) not NULL UNIQUE   
    );

    -- Trainee --
    CREATE table Trainee(
        Ssn numeric(12,0) NOT NULL PRIMARY KEY,
        DoB date,
        Photo varchar(2083),
        Company_ID char(4),
        foreign key (Ssn) references Person(Ssn) on delete cascade,
        foreign key (Company_ID) references Company(Cnumber) on delete set null
    );

    -- MC --
    CREATE table MC(
        Ssn numeric(12,0) NOT NULL PRIMARY KEY,
        foreign key (Ssn) REFERENCES person(Ssn) on delete CASCADE
    );


    -- Mentor --
    CREATE table Mentor(
        Ssn numeric(12,0) NOT NULL PRIMARY KEY,
        foreign key (Ssn) references person(ssn) on delete CASCADE
    );

    -- Song --
        -- Table for auto increament -- 
        CREATE table song_sequecing(
            Num INT NOT NULL AUTO_INCREMENT PRIMARY KEY
        );
        -- Table for song --
        CREATE table Song(
            Number varchar(5) not NULL PRIMARY KEY,
            Released_year year,
            Name text,
            Singer_SSN_first_performed numeric(12,0),
            FOREIGN KEY (Singer_SSN_first_performed) references Singer(Ssn) on DELETE set NULL
        );
        -- Create a trigger for auto INCREMENT --
        DELIMITER //
        CREATE TRIGGER Song_num_insert
        BEFORE INSERT ON song
        FOR EACH ROW
        BEGIN
            INSERT INTO song_sequecing VALUES (NULL);
            SET new.Number = CONCAT("S", LPAD(LAST_INSERT_ID(), 3, '0'));
        END;//
        DELIMITER ;

    -- Themesong --
    CREATE table ThemeSong(
        Song_ID varchar(5) not NULL PRIMARY KEY,
        FOREIGN KEY (Song_ID) references Song(number) on DELETE cascade
    );


    -- SongComposedBy --
    CREATE table SongComposedBy(
        Song_ID varchar(5) not NULL,
        Composer_Ssn numeric(12,0) not NULL,
        primary key (Song_ID, Composer_Ssn),
        FOREIGN KEY (Song_ID) REFERENCES Song(number),
        FOREIGN KEY (Composer_Ssn) references SongWriter(Ssn)
    );


    -- Singer --
    CREATE table Singer(
        Ssn numeric(12,0) NOT NULL PRIMARY KEY,
        Guest_ID INT,
        FOREIGN KEY (Ssn) REFERENCES Mentor(Ssn),
        FOREIGN KEY (Guest_ID) references InvitedGuest(guest_ID)
    );

    -- SingerSignatureSong --
    CREATE table SingerSignatureSong(
        Ssn numeric(12,0) not NULL PRIMARY KEY,
        Song_name text,
        FOREIGN KEY (Ssn) REFERENCES Singer(Ssn)
    );

    -- Producer --
    CREATE table Producer(
        Ssn numeric(12,0) NOT NULL PRIMARY KEY,
        FOREIGN KEY (Ssn) REFERENCES Mentor(Ssn) on DELETE cascade  
    );

    -- ProducerProgram --
    CREATE table ProducerProgram(
        Ssn numeric (12,0) not null,
        Program_name varchar(512),
        primary key (Ssn, Program_name),
        foreign key (Ssn) references Producer(Ssn) on DELETE cascade
    );

    -- SongWriter --
    CREATE table SongWriter(
        Ssn numeric (12,0) not null,
        primary key (Ssn),
        foreign key (Ssn) references Mentor(Ssn) on DELETE cascade
    );

    -- Season --
    CREATE table Season(
        SYear year primary key,
        Location text,
        Themesong_ID varchar(5),
        MC_Ssn NUMERIC(12,0) not null,
        FOREIGN KEY (Themesong_ID) REFERENCES ThemeSong(Song_ID) on delete set NULL,
        FOREIGN key (MC_Ssn) REFERENCES MC(Ssn) on DELETE cascade        
    );

    -- SeasonMentor --
    CREATE TABLE SeasonMentor(
        Syear year not null,
        Ssn_mentor NUMERIC(12,0) not null,
        PRIMARY KEY (Syear, Ssn_mentor),
        FOREIGN KEY (Syear) REFERENCES Season(Syear) on delete cascade,
        FOREIGN KEY (Ssn_mentor) REFERENCES Mentor(Ssn) on delete cascade
    );

    -- SeansonTrainee --
    CREATE TABLE SeasonTrainee(
        Syear year not NULL,
        Ssn_trainee NUMERIC(12,0) not NULL,
        PRIMARY KEY (Syear, Ssn_trainee),
        FOREIGN KEY (Syear) REFERENCES Season(Syear) on delete cascade,
        FOREIGN KEY (Ssn_trainee) REFERENCES Trainee(Ssn) on delete cascade
    );

    -- MentorValuateTrainee --
    CREATE TABLE MentorValuateTrainee(
        Syear year not NULL,
        Ssn_trainee NUMERIC(12,0) not null,
        Ssn_mentor NUMERIC(12,0) not null,
        Score INT(3),
        CONSTRAINT CheckScore CHECK (Score>=0 and Score <=100),
        PRIMARY KEY (Syear, Ssn_mentor, Ssn_trainee),
        FOREIGN KEY (Syear) REFERENCES Season(Syear) on delete cascade,
        FOREIGN KEY (Ssn_trainee) REFERENCES Trainee(Ssn) on delete cascade,
        FOREIGN KEY (Ssn_mentor) REFERENCES MentorMentor(Ssn) on delete cascade    
    );

    -- Episode --
    CREATE TABLE Episode(
        Syear year not NULL,
        Ep_No int(1) not NULL CHECK (Ep_No>=1 and Ep_no <=5),
        Name text,
        Datetime DATETIME,
        Duration int(3),
        Primary KEY (Syear, Ep_No),
        FOREIGN KEY (Syear) REFERENCES Season(Syear) on DELETE cascade
    );


    -- Stage --
    

    CREATE TABLE Stage(
        Syear year not NULL,
        Ep_No int(1) not NULL CHECK (Ep_No>=1 and Ep_no <=5),
        Stage_No INT(3) NOT NULL,
        Is_Group BOOLEAN NOT NULL, -- Yes: group, No: individual --
        Skill int(1) default 4 ,    
        Total_Votes INT, -- Derived attribute --
        Song_ID varchar(5) NOT NULL,
        CONSTRAINT CheckSkill CHECK (Skill>=1 and Skill<=4),
        PRIMARY KEY (Syear, ep_no, Stage_No),
        FOREIGN KEY (Syear, Ep_No) REFERENCES Episode(Syear, Ep_no) on delete cascade,
        FOREIGN KEY (Song_ID) REFERENCES Song(Number) on delete cascade
    );
    
    -- StageIncludeTrSainee --
    CREATE TABLE StageIncludeTrainee(
        SYear year NOT NULL,
        Ep_No INT(1) NOT NULL,
        Stage_No INT(3) NOT NULL,
        Ssn_trainee Numeric(12,0) NOT NULL,
        Role INT(1) NOT NULL DEFAULT 1,
            CHECK (Role>=1 and Role<=3),
        No_of_votes INT(3) 
            CHECK (No_of_votes >= 0 AND No_of_votes <=500),
        PRIMARY KEY(SYear, Ep_No, Stage_No, Ssn_Trainee),
        FOREIGN KEY (SYear, Ep_No, Stage_No) references Stage(Syear, Ep_No, Stage_no) on delete cascade,
        FOREIGN KEY (Ssn_trainee) REFERENCES Trainee(SsN) on delete cascade      
    );

    -- InvitedGuest --
    CREATE TABLE InvitedGuest(
        Guest_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY
    );

    -- Group --
    CREATE TABLE GGroup(
        Gname VARCHAR(100) NOT NULL PRIMARY KEY,
        No_of_member INT(2)
            CHECK (No_of_member >= 1 AND No_of_member <=20),
        Guest_ID INT NOT NULL,
        FOREIGN KEY (Guest_ID) references InvitedGuest(Guest_ID) ON DELETE CASCADE
    );

    -- GroupSignatureSong --
    CREATE TABLE GroupSignatureSong(
        Gname VARCHAR(100) NOT NULL,
        Song_name VARCHAR(100) NOT NULL,
        PRIMARY KEY (Gname,Song_name),
        FOREIGN KEY (Gname) References GGroup(Gname) ON DELETE CASCADE
    );

    -- GuestSupportStage --
    CREATE TABLE GuestSupportStage(
        Guest_ID INT NOT NULL,     
        Syear year not nULL,
        Ep_No INT(1) NOT NULL,
        Stage_No INT(3) NOT NULL,
        PRIMARY KEY (SYear, Ep_No, Stage_No),
        FOREIGN KEY (Guest_ID) REFERENCES InvitedGuest(Guest_ID) ON DELETE CASCADE,
        FOREIGN KEY (Syear, Ep_No, Stage_No) REFERENCES Stage(Syear, Ep_No, Stage_No) ON DELETE CASCADE

    );




-- ADD VALUE --

    -- Company --
    INSERT INTO Company VALUES
    ('C100', 'GHOST')

    -- Trainee --


    -- MC --
    INSERT INTO MC VALUES ('161616161616');
    INSERT INTO MC VALUES ('171717171717');
    INSERT INTO MC VALUES ('181818181818');
    INSERT INTO MC VALUES ('191919191919');
    -- Mentor --
    INSERT INTO Mentor VALUES ('')
    INSERT INTO Mentor VALUES ('')
    INSERT INTO Mentor VALUES ('')
    INSERT INTO Mentor VALUES ('')
    INSERT INTO Mentor VALUES ('')
    INSERT INTO Mentor VALUES ('')

    -- Song --


    -- Themesong --


    -- SongComposedBy --


    -- Singer --


    -- SingerSignatureSong --


    -- Producer --


    -- ProducerProgram --


    -- SongWriter --


    -- Season --


    -- SeasonMentor --


    -- SeansonTrainee --


    -- MentorValuateTrainee --


    -- Episode --


    -- Stage --


    -- StageIncludeTrainee --


    -- InvitedGuest --


    -- Group --


    -- GroupSignatureSong --


    -- GuestSupportStage --
    