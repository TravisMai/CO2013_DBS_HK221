-- CREATE DATABASE --
DROP DATABASE reality_show;

CREATE DATABASE reality_show;

Use reality_show;

SET FOREIGN_KEY_CHECKs=0;
SET GLOBAL FOREIGN_KEY_CHECKs=0;

-- CREATE TABLE --

    -- Company --
    CREATE Table Company(
        Cnumber char(4) not NULL primary key,
        Name text not NULL,
        CAddress text,
        Phone numeric(10) not NULL UNIQUE,
        Edate date
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
    INSERT INTO `company` (`Cnumber`, `Name`, `CAddress`, `Phone`, `Edate`) VALUES
    ('C100', 'Ghost', 'Dien Bien Phu Street, District 10, HCMC', '8361869275', '1992-08-19'),
    ('C101', 'Ancient ', 'Nguyen Van Khoi Street, District Go Vap, HCMC', '1285102784', '1978-03-24'),
    ('C102', 'Deviant', 'Ly Thai To Street, District 10, HCMC', '9768256719', '1984-06-13'),
    ('C103', 'Asgard', 'Bui Thi Xuan Street, District 1, HCMC', '3958269132', '2000-11-05');


    -- Person --
    INSERT INTO `person` (`Ssn`, `Fname`, `Lname`, `PAddress`, `Phone`) VALUES
    ('111120180001', 'Johnny', 'Dang', 'Dong Van Cong Street, District 2, HCMC', '354887693'),
    ('111120180002', 'Luon', 'Vuituoi', 'Cong Quynh Street, District 1, HCMC', '354887694'),
    ('111120180003', 'Leo', 'Nguyen', 'Ly Thuong Kiet Street, District 10, HCMC', '354887695'),
    ('111120180004', 'Daniel', 'Wellington', 'Ky Con Street, District 1, HCMC', '354887696'),
    ('111120180005', 'Julliet', 'Johnson', 'Tran Hung Dao Street, District 1, HCMC', '354887697'),
    ('111120180006', 'Romeo', 'Smith', 'Tran Dinh Xu Street, District 1, HCMC', '354887698'),
    ('111120180007', 'Walter', 'White', 'Le Loi Street, District 1, HCMC', '354887699'),
    ('111120180008', 'Don', 'Brown', 'Nguyen Hue Street, District 1, HCMC', '354887700'),
    ('111120180009', 'Boba', 'Green', 'Tran Hung Dao Street, District 5, HCMC', '354887701'),
    ('111120180010', 'Samael', 'Morning', 'Ho Hao Hon Street, District 1, HCMC', '354887702'),
    ('111120180011', 'Lucifer', 'Morningstar', 'Le Lai Street, District 1, HCMC', '354887703'),
    ('111120180012', 'Don', 'Chisao', 'Nguyen Du Street, District 1, HCMC', '354887704'),
    ('111120180013', 'Tom', 'Vecna', 'Tran Hung Dao Street, District 1, HCMC', '354887705'),
    ('111120180014', 'Jerry', 'Peterson', 'Tran Dinh Xu Street, District 1, HCMC', '354887706'),
    ('111120180015', 'Sam', 'Waltersom', 'Le Loi Street, District 1, HCMC', '354887707'),
    ('111120180016', 'Ching', 'Sunat', 'Nguyen Hue Street, District 1, HCMC', '354887708'),
    ('111120180017', 'Sinat', 'San', 'Tran Hung Dao Street, District 5, HCMC', '354887709'),
    ('111120180018', 'Mohamale', 'Christ', 'Ho Hao Hon Street, District 1, HCMC', '354887710'),
    ('111120180019', 'John', 'Smith', 'Le Lai Street, District 1, HCMC', '354887711'),
    ('111120180020', 'Dat', 'Tran', 'Nguyen Du Street, District 1, HCMC', '354887712'),
    ('111120180021', 'Khoa', 'Nguyen', 'Dong Van Cong Street, District 2, HCMC', '354887713'),
    ('111120180022', 'Minh', 'Tran', 'Cong Quynh Street, District 1, HCMC', '354887714'),
    ('111120180023', 'Thien', 'Ly', 'Ly Thuong Kiet Street, District 10, HCMC', '354887715'),
    ('111120180024', 'Nguyen', 'Le', 'Ky Con Street, District 1, HCMC', '354887716'),
    ('111120180025', 'Nghia', 'Dinh', 'Tran Hung Dao Street, District 1, HCMC', '354887717'),
    ('111120180026', 'Hao', 'Mai', 'Tran Dinh Xu Street, District 1, HCMC', '354887718'),
    ('111120180027', 'Ron', 'Wesley', 'Le Loi Street, District 1, HCMC', '354887719'),
    ('111120180028', 'Emma', 'Watson', 'Nguyen Hue Street, District 1, HCMC', '354887720'),
    ('111120180029', 'Harry', 'Stone', 'Tran Hung Dao Street, District 5, HCMC', '354887721'),
    ('111120180030', 'Charles', 'Tree', 'Ho Hao Hon Street, District 1, HCMC', '354887722'),
    ('111120180031', 'Sam', 'Leaf', 'Dong Van Cong Street, District 2, HCMC', '354888822'),
    ('111120180032', 'Ching', 'Ly', 'Cong Quynh Street, District 1, HCMC', '354888823'),
    ('111120180033', 'Sinat', 'Pham', 'Ly Thuong Kiet Street, District 10, HCMC', '354888824'),
    ('111120180034', 'Mohamale', 'John', 'Ky Con Street, District 1, HCMC', '354888825'),
    ('111120180035', 'John', 'Robert', 'Tran Hung Dao Street, District 1, HCMC', '354888826'),
    ('111120180036', 'Dat', 'Michael', 'Tran Dinh Xu Street, District 1, HCMC', '354888827'),
    ('111120180037', 'Khoa', 'William', 'Le Loi Street, District 1, HCMC', '354888828'),
    ('111120180038', 'Minh', 'David', 'Ly Thuong Kiet Street, District 10, HCMC', '354888829'),
    ('111120180039', 'Thien', 'Richard', 'Ky Con Street, District 1, HCMC', '354888830'),
    ('111120180040', 'Nguyen', 'Joseph', 'Tran Hung Dao Street, District 1, HCMC', '354888831'),
    ('111120190001', 'Ella', 'Ice', 'Le Lai Street, District 1, HCMC', '354887723'),
    ('111120190002', 'Ellizabeth', 'Queenie', 'Nguyen Du Street, District 1, HCMC', '354887724'),
    ('111120190003', 'Jane', 'Root', 'Tran Hung Dao Street, District 1, HCMC', '354887725'),
    ('111120190004', 'Ngan', 'Roof', 'Tran Dinh Xu Street, District 1, HCMC', '354887726'),
    ('111120190005', 'Thuy', 'Phan', 'Le Loi Street, District 1, HCMC', '354887727'),
    ('111120190006', 'Duy', 'Tham', 'Nguyen Hue Street, District 1, HCMC', '354887728'),
    ('111120190007', 'Tri', 'Leaf', 'Tran Hung Dao Street, District 5, HCMC', '354887729'),
    ('111120190008', 'Hieu', 'Ly', 'Ho Hao Hon Street, District 1, HCMC', '354887730'),
    ('111120190009', 'Hoa', 'Pham', 'Le Lai Street, District 1, HCMC', '354887731'),
    ('111120190010', 'Teo', 'John', 'Dong Van Cong Street, District 2, HCMC', '354887732'),
    ('111120190011', 'Ti', 'Robert', 'Cong Quynh Street, District 1, HCMC', '354887733'),
    ('111120190012', 'Tan', 'Michael', 'Ly Thuong Kiet Street, District 10, HCMC', '354887734'),
    ('111120190013', 'Tai', 'William', 'Ky Con Street, District 1, HCMC', '354887735'),
    ('111120190014', 'Chuong', 'David', 'Tran Hung Dao Street, District 1, HCMC', '354887736'),
    ('111120190015', 'Vy', 'Richard', 'Tran Dinh Xu Street, District 1, HCMC', '354887737'),
    ('111120190016', 'Nam', 'Joseph', 'Le Loi Street, District 1, HCMC', '354887738'),
    ('111120190017', 'Quan', 'Charles', 'Nguyen Hue Street, District 1, HCMC', '354887739'),
    ('111120190018', 'Sang', 'Thomas', 'Tran Hung Dao Street, District 5, HCMC', '354887740'),
    ('111120190019', 'Chieu', 'Ti', 'Ho Hao Hon Street, District 1, HCMC', '354887741'),
    ('111120190020', 'Toi', 'Tan', 'Le Lai Street, District 1, HCMC', '354887742'),
    ('111120190021', 'Khuya', 'Tai', 'Nguyen Du Street, District 1, HCMC', '354887743'),
    ('111120190022', 'Jacob', 'Chuong', 'Tran Hung Dao Street, District 1, HCMC', '354887744'),
    ('111120190023', 'Oliver', 'Jakiechan', 'Tran Dinh Xu Street, District 1, HCMC', '354887745'),
    ('111120190024', 'John', 'Jack', 'Le Loi Street, District 1, HCMC', '354887746'),
    ('111120190025', 'Robert', 'Harrison', 'Nguyen Hue Street, District 1, HCMC', '354887747'),
    ('111120190026', 'Michael', 'Jacobinet', 'Tran Hung Dao Street, District 5, HCMC', '354887748'),
    ('111120190027', 'William', 'Charlie', 'Ho Hao Hon Street, District 1, HCMC', '354887749'),
    ('111120190028', 'David', 'Thomas', 'Le Lai Street, District 1, HCMC', '354887750'),
    ('111120190029', 'Richard', 'George', 'Nguyen Du Street, District 1, HCMC', '354887751'),
    ('111120190030', 'Joseph', 'Oscar', 'Dong Van Cong Street, District 2, HCMC', '354887752'),
    ('111120190031', 'Oliver', 'Jake', 'Ho Hao Hon Street, District 1, HCMC', '354888853'),
    ('111120190032', 'John', 'Jacksonie', 'Le Loi Street, District 1, HCMC', '354888854'),
    ('111120190033', 'Robert', 'Harry', 'Tran Hung Dao Street, District 1, HCMC', '354888855'),
    ('111120190034', 'Michael', 'Jacob', 'Tran Dinh Xu Street, District 1, HCMC', '354888856'),
    ('111120190035', 'Ti', 'Charlie', 'Le Loi Street, District 1, HCMC', '354888857'),
    ('111120190036', 'Tan', 'Thomas', 'Nguyen Hue Street, District 1, HCMC', '354888858'),
    ('111120190037', 'Tai', 'George', 'Tran Dinh Xu Street, District 1, HCMC', '354888859'),
    ('111120190038', 'Charles', 'Chieu', 'Le Loi Street, District 1, HCMC', '354888860'),
    ('111120190039', 'Thomas', 'Toi', 'Nguyen Hue Street, District 1, HCMC', '354888861'),
    ('111120190040', 'Ti', 'Khuya', 'Le Lai Street, District 1, HCMC', '354888862'),
    ('222220180001', 'Charles', 'James', 'Cong Quynh Street, District 1, HCMC', '354887753'),
    ('222220180002', 'Thomas', 'William', 'Ly Thuong Kiet Street, District 10, HCMC', '354887754'),
    ('222220180003', 'Margaret', 'Emma', 'Le Lai Street, District 1, HCMC', '354887755'),
    ('222220180004', 'Olivia', 'Samantha', 'Nguyen Du Street, District 1, HCMC', '354887756'),
    ('222220190001', 'Isla', 'Bethany', 'Tran Hung Dao Street, District 1, HCMC', '354887757'),
    ('222220190002', 'Emily', 'Elizabeth', 'Tran Dinh Xu Street, District 1, HCMC', '354887758'),
    ('222220190003', 'Poppy', 'Joanne', 'Le Loi Street, District 1, HCMC', '354887759'),
    ('222220190004', 'Ava', 'Megan', 'Nguyen Hue Street, District 1, HCMC', '354887760'),
    ('333320180001', 'Patricia', 'Elizabeth', 'Tran Hung Dao Street, District 5, HCMC', '354887761'),
    ('333320190001', 'Jennifer', 'Linda', 'Ho Hao Hon Street, District 1, HCMC', '354887762');


    -- Trainee --
    INSERT INTO `trainee` (`Ssn`, `DoB`, `Photo`, `Company_ID`) VALUES
    ('111120180001', '1998-02-11', 'uploads/5.png', 'C100'),
    ('111120180002', '1999-10-23', 'uploads/5.png', 'C101'),
    ('111120180003', '1985-05-07', 'uploads/5.png', 'C102'),
    ('111120180004', '2002-10-07', 'uploads/5.png', 'C103'),
    ('111120180005', '1997-02-11', 'uploads/5.png', 'NULL'),
    ('111120180006', '1996-03-12', 'uploads/5.png', 'C100'),
    ('111120180007', '1995-04-11', 'uploads/5.png', 'C101'),
    ('111120180008', '1994-05-10', 'uploads/5.png', 'C102'),
    ('111120180009', '1993-06-08', 'uploads/5.png', 'C103'),
    ('111120180010', '1992-07-07', 'uploads/5.png', 'NULL'),
    ('111120180011', '1991-08-06', 'uploads/5.png', 'C100'),
    ('111120180012', '1990-09-04', 'uploads/5.png', 'C101'),
    ('111120180013', '1989-10-03', 'uploads/5.png', 'C102'),
    ('111120180014', '1988-11-01', 'uploads/5.png', 'C103'),
    ('111120180015', '1987-12-01', 'uploads/5.png', 'NULL'),
    ('111120180016', '1986-12-30', 'uploads/5.png', 'C100'),
    ('111120180017', '1998-02-11', 'uploads/5.png', 'C101'),
    ('111120180018', '1999-10-23', 'uploads/5.png', 'C102'),
    ('111120180019', '1985-05-07', 'uploads/5.png', 'C103'),
    ('111120180020', '2002-10-07', 'uploads/5.png', 'NULL'),
    ('111120180021', '1997-02-11', 'uploads/5.png', 'C100'),
    ('111120180022', '1996-03-12', 'uploads/5.png', 'C101'),
    ('111120180023', '1995-04-11', 'uploads/5.png', 'C102'),
    ('111120180024', '1994-05-10', 'uploads/5.png', 'C103'),
    ('111120180025', '1993-06-08', 'uploads/5.png', 'NULL'),
    ('111120180026', '1992-07-07', 'uploads/5.png', 'C100'),
    ('111120180027', '1991-08-06', 'uploads/5.png', 'C101'),
    ('111120180028', '1990-09-04', 'uploads/5.png', 'C102'),
    ('111120180029', '1989-10-03', 'uploads/5.png', 'C103'),
    ('111120180030', '1988-11-01', 'uploads/5.png', 'NULL'),
    ('111120180031', '1989-10-04', 'uploads/5.png', 'C100'),
    ('111120180032', '1988-11-02', 'uploads/5.png', 'C101'),
    ('111120180033', '1989-10-05', 'uploads/5.png', 'C102'),
    ('111120180034', '1988-11-03', 'uploads/5.png', 'C103'),
    ('111120180035', '1989-10-06', 'uploads/5.png', 'NULL'),
    ('111120180036', '1988-11-04', 'uploads/5.png', 'C100'),
    ('111120180037', '1989-10-07', 'uploads/5.png', 'C101'),
    ('111120180038', '1988-11-05', 'uploads/5.png', 'C102'),
    ('111120180039', '1989-10-08', 'uploads/5.png', 'C103'),
    ('111120180040', '1988-11-06', 'uploads/5.png', 'NULL'),
    ('111120190001', '1987-12-01', 'uploads/5.png', 'C100'),
    ('111120190002', '1986-12-30', 'uploads/5.png', 'C101'),
    ('111120190003', '1998-02-11', 'uploads/5.png', 'C102'),
    ('111120190004', '1999-10-23', 'uploads/5.png', 'C103'),
    ('111120190005', '1985-05-07', 'uploads/5.png', 'NULL'),
    ('111120190006', '2002-10-07', 'uploads/5.png', 'C100'),
    ('111120190007', '1997-02-11', 'uploads/5.png', 'C101'),
    ('111120190008', '1996-03-12', 'uploads/5.png', 'C102'),
    ('111120190009', '1995-04-11', 'uploads/5.png', 'C103'),
    ('111120190010', '1994-05-10', 'uploads/5.png', 'NULL'),
    ('111120190011', '1993-06-08', 'uploads/5.png', 'C100'),
    ('111120190012', '1992-07-07', 'uploads/5.png', 'C101'),
    ('111120190013', '1991-08-06', 'uploads/5.png', 'C102'),
    ('111120190014', '1990-09-04', 'uploads/5.png', 'C103'),
    ('111120190015', '1989-10-03', 'uploads/5.png', 'NULL'),
    ('111120190016', '1988-11-01', 'uploads/5.png', 'C100'),
    ('111120190017', '1987-12-01', 'uploads/5.png', 'C101'),
    ('111120190018', '1986-12-30', 'uploads/5.png', 'C102'),
    ('111120190019', '1998-02-11', 'uploads/5.png', 'C103'),
    ('111120190020', '1999-10-23', 'uploads/5.png', 'NULL'),
    ('111120190021', '1985-05-07', 'uploads/5.png', 'C100'),
    ('111120190022', '2002-10-07', 'uploads/5.png', 'C101'),
    ('111120190023', '1997-02-11', 'uploads/5.png', 'C102'),
    ('111120190024', '1996-03-12', 'uploads/5.png', 'C103'),
    ('111120190025', '1995-04-11', 'uploads/5.png', 'NULL'),
    ('111120190026', '1994-05-10', 'uploads/5.png', 'C100'),
    ('111120190027', '1993-06-08', 'uploads/5.png', 'C101'),
    ('111120190028', '1992-07-07', 'uploads/5.png', 'C102'),
    ('111120190029', '1991-08-06', 'uploads/5.png', 'C103'),
    ('111120190030', '1990-09-04', 'uploads/5.png', 'NULL'),
    ('111120190031', '1991-08-07', 'uploads/5.png', 'C100'),
    ('111120190032', '1990-09-05', 'uploads/5.png', 'C101'),
    ('111120190033', '1991-08-08', 'uploads/5.png', 'C102'),
    ('111120190034', '1990-09-06', 'uploads/5.png', 'C103'),
    ('111120190035', '1991-08-09', 'uploads/5.png', 'NULL'),
    ('111120190036', '1990-09-07', 'uploads/5.png', 'C100'),
    ('111120190037', '1991-08-10', 'uploads/5.png', 'C101'),
    ('111120190038', '1990-09-08', 'uploads/5.png', 'C102'),
    ('111120190039', '1991-08-11', 'uploads/5.png', 'C103'),
    ('111120190040', '1990-09-09', 'uploads/5.png', 'NULL');    


    -- MC --
    INSERT INTO `mc` (`Ssn`) VALUES
    ('111120180022'),
    ('111120180023'),
    ('333320180001'),
    ('333320190001');


    -- Mentor --
    INSERT INTO `mentor` (`Ssn`) VALUES
    ('222220180001'),
    ('222220180002'),
    ('222220180003'),
    ('222220180004'),
    ('222220190001'),
    ('222220190002'),
    ('222220190003'),
    ('222220190004');


    -- Song --
    INSERT INTO `song` (`Number`, `Released_year`, `Name`, `Singer_SSN_first_performed`) VALUES
    ('S001', 2018, 'Themesong 2018', NULL),
    ('S002', 2019, 'Themesong 2019', NULL),
    ('S003', 2018, 'Perfect', NULL),
    ('S004', 2020, 'Intentions', '222220180001'),
    ('S005', 2010, 'Misery', '222220180002'),
    ('S006', 2015, 'Lean On', '222220180003'),
    ('S007', 1999, 'Unstoppable', NULL),
    ('S008', 2000, 'Data', NULL),
    ('S009', 2001, 'Sensitive', NULL),
    ('S010', 2002, 'Happy birthday to you', NULL);

    
    -- Themesong --
    INSERT INTO `themesong` (`Song_ID`) VALUES
    ('S001'),
    ('S002');


    -- SongComposedBy --
    INSERT INTO `songcomposedby` (`Song_ID`, `Composer_Ssn`) VALUES
    ('S001', '222220190001'),
    ('S002', '222220190002'),
    ('S003', '222220190003'),
    ('S004', '222220190001'),
    ('S005', '222220190002'),
    ('S006', '222220190003');


    -- Singer --
    INSERT INTO `singer` (`Ssn`, `Guest_ID`) VALUES
    ('222220180003', 0),
    ('222220180001', 1),
    ('222220180002', 2);


    -- SingerSignatureSong --
    INSERT INTO `singersignaturesong` (`Ssn`, `Song_name`) VALUES
    ('222220180001', 'Hello'),
    ('222220180002', 'I believe I can fly'),
    ('222220180003', 'The Earth');


    -- Producer --
    INSERT INTO `producer` (`Ssn`) VALUES
    ('222220180004'),
    ('222220190004');


    -- ProducerProgram --
    INSERT INTO `producerprogram` (`Ssn`, `Program_name`) VALUES
    ('222220180004', 'Dark Pictures'),
    ('222220180004', 'LoveYou3000'),
    ('222220190004', 'Mementos'),
    ('222220190004', 'Persona ');


    -- SongWriter --
    INSERT INTO `songwriter` (`Ssn`) VALUES
    ('222220190001'),
    ('222220190002'),
    ('222220190003');


    -- Season --
    INSERT INTO `season` (`SYear`, `Location`, `Themesong_ID`, `MC_Ssn`) VALUES
    (2018, 'Hanoi', 'S001', '333320180001'),
    (2019, 'HCMC', 'S002', '333320190001');


    -- SeasonMentor --
    INSERT INTO `seasonmentor` (`Syear`, `Ssn_mentor`) VALUES
    (2018, '222220180001'),
    (2018, '222220180002'),
    (2018, '222220180003'),
    (2018, '222220180004'),
    (2019, '222220190001'),
    (2019, '222220190002'),
    (2019, '222220190003'),
    (2019, '222220190004');


    -- SeansonTrainee --
    INSERT INTO `seasontrainee` (`Syear`, `Ssn_trainee`) VALUES
    (2018, '111120180001'),
    (2018, '111120180002'),
    (2018, '111120180003'),
    (2018, '111120180004'),
    (2018, '111120180005'),
    (2018, '111120180006'),
    (2018, '111120180007'),
    (2018, '111120180008'),
    (2018, '111120180009'),
    (2018, '111120180010'),
    (2018, '111120180011'),
    (2018, '111120180012'),
    (2018, '111120180013'),
    (2018, '111120180014'),
    (2018, '111120180015'),
    (2018, '111120180016'),
    (2018, '111120180017'),
    (2018, '111120180018'),
    (2018, '111120180019'),
    (2018, '111120180020'),
    (2018, '111120180021'),
    (2018, '111120180022'),
    (2018, '111120180023'),
    (2018, '111120180024'),
    (2018, '111120180025'),
    (2018, '111120180026'),
    (2018, '111120180027'),
    (2018, '111120180028'),
    (2018, '111120180029'),
    (2018, '111120180030'),
    (2018, '111120180031'),
    (2018, '111120180032'),
    (2018, '111120180033'),
    (2018, '111120180034'),
    (2018, '111120180035'),
    (2018, '111120180036'),
    (2018, '111120180037'),
    (2018, '111120180038'),
    (2018, '111120180039'),
    (2018, '111120180040'),
    (2019, '111120190001'),
    (2019, '111120190002'),
    (2019, '111120190003'),
    (2019, '111120190004'),
    (2019, '111120190005'),
    (2019, '111120190006'),
    (2019, '111120190007'),
    (2019, '111120190008'),
    (2019, '111120190009'),
    (2019, '111120190010'),
    (2019, '111120190011'),
    (2019, '111120190012'),
    (2019, '111120190013'),
    (2019, '111120190014'),
    (2019, '111120190015'),
    (2019, '111120190016'),
    (2019, '111120190017'),
    (2019, '111120190018'),
    (2019, '111120190019'),
    (2019, '111120190020'),
    (2019, '111120190021'),
    (2019, '111120190022'),
    (2019, '111120190023'),
    (2019, '111120190024'),
    (2019, '111120190025'),
    (2019, '111120190026'),
    (2019, '111120190027'),
    (2019, '111120190028'),
    (2019, '111120190029'),
    (2019, '111120190030'),
    (2019, '111120190031'),
    (2019, '111120190032'),
    (2019, '111120190033'),
    (2019, '111120190034'),
    (2019, '111120190035'),
    (2019, '111120190036'),
    (2019, '111120190037'),
    (2019, '111120190038'),
    (2019, '111120190039'),
    (2019, '111120190040');


    -- MentorValuateTrainee --
    INSERT INTO `mentorvaluatetrainee` (`Syear`, `Ssn_mentor`, `Ssn_trainee`, `Score`) VALUES
    (2018, '222220180001', '111120180001', 20),
    (2018, '222220180002', '111120180001', 73),
    (2018, '222220180003', '111120180001', 91),
    (2018, '222220180004', '111120180001', 10),
    (2018, '222220180001', '111120180002', 5),
    (2018, '222220180002', '111120180002', 21),
    (2018, '222220180003', '111120180002', 17),
    (2018, '222220180004', '111120180002', 46),
    (2018, '222220180001', '111120180003', 78),
    (2018, '222220180002', '111120180003', 14),
    (2018, '222220180003', '111120180003', 33),
    (2018, '222220180004', '111120180003', 1),
    (2018, '222220180001', '111120180004', 21),
    (2018, '222220180002', '111120180004', 46),
    (2018, '222220180003', '111120180004', 94),
    (2018, '222220180004', '111120180004', 58),
    (2018, '222220180001', '111120180005', 43),
    (2018, '222220180002', '111120180005', 30),
    (2018, '222220180003', '111120180005', 48),
    (2018, '222220180004', '111120180005', 87),
    (2018, '222220180001', '111120180006', 70),
    (2018, '222220180002', '111120180006', 64),
    (2018, '222220180003', '111120180006', 11),
    (2018, '222220180004', '111120180006', 85),
    (2018, '222220180001', '111120180007', 21),
    (2018, '222220180002', '111120180007', 47),
    (2018, '222220180003', '111120180007', 55),
    (2018, '222220180004', '111120180007', 28),
    (2018, '222220180001', '111120180008', 6),
    (2018, '222220180002', '111120180008', 4),
    (2018, '222220180003', '111120180008', 68),
    (2018, '222220180004', '111120180008', 84),
    (2018, '222220180001', '111120180009', 61),
    (2018, '222220180002', '111120180009', 32),
    (2018, '222220180003', '111120180009', 44),
    (2018, '222220180004', '111120180009', 83),
    (2018, '222220180001', '111120180010', 95),
    (2018, '222220180002', '111120180010', 21),
    (2018, '222220180003', '111120180010', 67),
    (2018, '222220180004', '111120180010', 7),
    (2018, '222220180001', '111120180011', 12),
    (2018, '222220180002', '111120180011', 9),
    (2018, '222220180003', '111120180011', 81),
    (2018, '222220180004', '111120180011', 3),
    (2018, '222220180001', '111120180012', 83),
    (2018, '222220180002', '111120180012', 2),
    (2018, '222220180003', '111120180012', 19),
    (2018, '222220180004', '111120180012', 34),
    (2018, '222220180001', '111120180013', 37),
    (2018, '222220180002', '111120180013', 74),
    (2018, '222220180003', '111120180013', 98),
    (2018, '222220180004', '111120180013', 18),
    (2018, '222220180001', '111120180014', 12),
    (2018, '222220180002', '111120180014', 18),
    (2018, '222220180003', '111120180014', 58),
    (2018, '222220180004', '111120180014', 20),
    (2018, '222220180001', '111120180015', 89),
    (2018, '222220180002', '111120180015', 81),
    (2018, '222220180003', '111120180015', 89),
    (2018, '222220180004', '111120180015', 49),
    (2018, '222220180001', '111120180016', 31),
    (2018, '222220180002', '111120180016', 46),
    (2018, '222220180003', '111120180016', 35),
    (2018, '222220180004', '111120180016', 98),
    (2018, '222220180001', '111120180017', 99),
    (2018, '222220180002', '111120180017', 9),
    (2018, '222220180003', '111120180017', 39),
    (2018, '222220180004', '111120180017', 13),
    (2018, '222220180001', '111120180018', 35),
    (2018, '222220180002', '111120180018', 80),
    (2018, '222220180003', '111120180018', 29),
    (2018, '222220180004', '111120180018', 95),
    (2018, '222220180001', '111120180019', 65),
    (2018, '222220180002', '111120180019', 38),
    (2018, '222220180003', '111120180019', 2),
    (2018, '222220180004', '111120180019', 4),
    (2018, '222220180001', '111120180020', 1),
    (2018, '222220180002', '111120180020', 90),
    (2018, '222220180003', '111120180020', 53),
    (2018, '222220180004', '111120180020', 49),
    (2018, '222220180001', '111120180021', 46),
    (2018, '222220180002', '111120180021', 53),
    (2018, '222220180003', '111120180021', 72),
    (2018, '222220180004', '111120180021', 77),
    (2018, '222220180001', '111120180022', 48),
    (2018, '222220180002', '111120180022', 20),
    (2018, '222220180003', '111120180022', 15),
    (2018, '222220180004', '111120180022', 12),
    (2018, '222220180001', '111120180023', 78),
    (2018, '222220180002', '111120180023', 73),
    (2018, '222220180003', '111120180023', 92),
    (2018, '222220180004', '111120180023', 35),
    (2018, '222220180001', '111120180024', 6),
    (2018, '222220180002', '111120180024', 42),
    (2018, '222220180003', '111120180024', 41),
    (2018, '222220180004', '111120180024', 11),
    (2018, '222220180001', '111120180025', 63),
    (2018, '222220180002', '111120180025', 66),
    (2018, '222220180003', '111120180025', 0),
    (2018, '222220180004', '111120180025', 24),
    (2018, '222220180001', '111120180026', 60),
    (2018, '222220180002', '111120180026', 52),
    (2018, '222220180003', '111120180026', 72),
    (2018, '222220180004', '111120180026', 43),
    (2018, '222220180001', '111120180027', 96),
    (2018, '222220180002', '111120180027', 46),
    (2018, '222220180003', '111120180027', 6),
    (2018, '222220180004', '111120180027', 49),
    (2018, '222220180001', '111120180028', 82),
    (2018, '222220180002', '111120180028', 27),
    (2018, '222220180003', '111120180028', 76),
    (2018, '222220180004', '111120180028', 95),
    (2018, '222220180001', '111120180029', 2),
    (2018, '222220180002', '111120180029', 68),
    (2018, '222220180003', '111120180029', 82),
    (2018, '222220180004', '111120180029', 5),
    (2018, '222220180001', '111120180030', 11),
    (2018, '222220180002', '111120180030', 12),
    (2018, '222220180003', '111120180030', 52),
    (2018, '222220180004', '111120180030', 70),
    (2018, '222220180001', '111120180031', 0),
    (2018, '222220180002', '111120180031', 0),
    (2018, '222220180003', '111120180031', 0),
    (2018, '222220180004', '111120180031', 0),
    (2018, '222220180001', '111120180032', 0),
    (2018, '222220180002', '111120180032', 0),
    (2018, '222220180003', '111120180032', 0),
    (2018, '222220180004', '111120180032', 0),
    (2018, '222220180001', '111120180033', 0),
    (2018, '222220180002', '111120180033', 0),
    (2018, '222220180003', '111120180033', 0),
    (2018, '222220180004', '111120180033', 0),
    (2018, '222220180001', '111120180034', 0),
    (2018, '222220180002', '111120180034', 0),
    (2018, '222220180003', '111120180034', 0),
    (2018, '222220180004', '111120180034', 0),
    (2018, '222220180001', '111120180035', 0),
    (2018, '222220180002', '111120180035', 0),
    (2018, '222220180003', '111120180035', 0),
    (2018, '222220180004', '111120180035', 0),
    (2018, '222220180001', '111120180036', 0),
    (2018, '222220180002', '111120180036', 0),
    (2018, '222220180003', '111120180036', 0),
    (2018, '222220180004', '111120180036', 0),
    (2018, '222220180001', '111120180037', 0),
    (2018, '222220180002', '111120180037', 0),
    (2018, '222220180003', '111120180037', 0),
    (2018, '222220180004', '111120180037', 0),
    (2018, '222220180001', '111120180038', 0),
    (2018, '222220180002', '111120180038', 0),
    (2018, '222220180003', '111120180038', 0),
    (2018, '222220180004', '111120180038', 0),
    (2018, '222220180001', '111120180039', 0),
    (2018, '222220180002', '111120180039', 0),
    (2018, '222220180003', '111120180039', 0),
    (2018, '222220180004', '111120180039', 0),
    (2018, '222220180001', '111120180040', 0),
    (2018, '222220180002', '111120180040', 0),
    (2018, '222220180003', '111120180040', 0),
    (2018, '222220180004', '111120180040', 0),
    (2019, '222220190001', '111120190001', 11),
    (2019, '222220190002', '111120190001', 99),
    (2019, '222220190003', '111120190001', 77),
    (2019, '222220190004', '111120190001', 60),
    (2019, '222220190001', '111120190002', 43),
    (2019, '222220190002', '111120190002', 68),
    (2019, '222220190003', '111120190002', 39),
    (2019, '222220190004', '111120190002', 56),
    (2019, '222220190001', '111120190003', 44),
    (2019, '222220190002', '111120190003', 3),
    (2019, '222220190003', '111120190003', 6),
    (2019, '222220190004', '111120190003', 48),
    (2019, '222220190001', '111120190004', 52),
    (2019, '222220190002', '111120190004', 99),
    (2019, '222220190003', '111120190004', 69),
    (2019, '222220190004', '111120190004', 92),
    (2019, '222220190001', '111120190005', 41),
    (2019, '222220190002', '111120190005', 41),
    (2019, '222220190003', '111120190005', 73),
    (2019, '222220190004', '111120190005', 16),
    (2019, '222220190001', '111120190006', 33),
    (2019, '222220190002', '111120190006', 32),
    (2019, '222220190003', '111120190006', 15),
    (2019, '222220190004', '111120190006', 85),
    (2019, '222220190001', '111120190007', 67),
    (2019, '222220190002', '111120190007', 21),
    (2019, '222220190003', '111120190007', 38),
    (2019, '222220190004', '111120190007', 42),
    (2019, '222220190001', '111120190008', 0),
    (2019, '222220190002', '111120190008', 26),
    (2019, '222220190003', '111120190008', 34),
    (2019, '222220190004', '111120190008', 23),
    (2019, '222220190001', '111120190009', 14),
    (2019, '222220190002', '111120190009', 33),
    (2019, '222220190003', '111120190009', 1),
    (2019, '222220190004', '111120190009', 94),
    (2019, '222220190001', '111120190010', 2),
    (2019, '222220190002', '111120190010', 39),
    (2019, '222220190003', '111120190010', 50),
    (2019, '222220190004', '111120190010', 96),
    (2019, '222220190001', '111120190011', 58),
    (2019, '222220190002', '111120190011', 47),
    (2019, '222220190003', '111120190011', 68),
    (2019, '222220190004', '111120190011', 57),
    (2019, '222220190001', '111120190012', 68),
    (2019, '222220190002', '111120190012', 35),
    (2019, '222220190003', '111120190012', 93),
    (2019, '222220190004', '111120190012', 27),
    (2019, '222220190001', '111120190013', 64),
    (2019, '222220190002', '111120190013', 68),
    (2019, '222220190003', '111120190013', 6),
    (2019, '222220190004', '111120190013', 83),
    (2019, '222220190001', '111120190014', 55),
    (2019, '222220190002', '111120190014', 12),
    (2019, '222220190003', '111120190014', 60),
    (2019, '222220190004', '111120190014', 87),
    (2019, '222220190001', '111120190015', 40),
    (2019, '222220190002', '111120190015', 81),
    (2019, '222220190003', '111120190015', 95),
    (2019, '222220190004', '111120190015', 97),
    (2019, '222220190001', '111120190016', 40),
    (2019, '222220190002', '111120190016', 57),
    (2019, '222220190003', '111120190016', 85),
    (2019, '222220190004', '111120190016', 87),
    (2019, '222220190001', '111120190017', 100),
    (2019, '222220190002', '111120190017', 85),
    (2019, '222220190003', '111120190017', 1),
    (2019, '222220190004', '111120190017', 91),
    (2019, '222220190001', '111120190018', 20),
    (2019, '222220190002', '111120190018', 59),
    (2019, '222220190003', '111120190018', 72),
    (2019, '222220190004', '111120190018', 23),
    (2019, '222220190001', '111120190019', 35),
    (2019, '222220190002', '111120190019', 53),
    (2019, '222220190003', '111120190019', 51),
    (2019, '222220190004', '111120190019', 60),
    (2019, '222220190001', '111120190020', 99),
    (2019, '222220190002', '111120190020', 27),
    (2019, '222220190003', '111120190020', 6),
    (2019, '222220190004', '111120190020', 97),
    (2019, '222220190001', '111120190021', 100),
    (2019, '222220190002', '111120190021', 37),
    (2019, '222220190003', '111120190021', 77),
    (2019, '222220190004', '111120190021', 40),
    (2019, '222220190001', '111120190022', 74),
    (2019, '222220190002', '111120190022', 49),
    (2019, '222220190003', '111120190022', 95),
    (2019, '222220190004', '111120190022', 75),
    (2019, '222220190001', '111120190023', 75),
    (2019, '222220190002', '111120190023', 62),
    (2019, '222220190003', '111120190023', 77),
    (2019, '222220190004', '111120190023', 15),
    (2019, '222220190001', '111120190024', 28),
    (2019, '222220190002', '111120190024', 37),
    (2019, '222220190003', '111120190024', 26),
    (2019, '222220190004', '111120190024', 69),
    (2019, '222220190001', '111120190025', 67),
    (2019, '222220190002', '111120190025', 1),
    (2019, '222220190003', '111120190025', 42),
    (2019, '222220190004', '111120190025', 1),
    (2019, '222220190001', '111120190026', 77),
    (2019, '222220190002', '111120190026', 25),
    (2019, '222220190003', '111120190026', 53),
    (2019, '222220190004', '111120190026', 91),
    (2019, '222220190001', '111120190027', 5),
    (2019, '222220190002', '111120190027', 0),
    (2019, '222220190003', '111120190027', 67),
    (2019, '222220190004', '111120190027', 35),
    (2019, '222220190001', '111120190028', 58),
    (2019, '222220190002', '111120190028', 41),
    (2019, '222220190003', '111120190028', 51),
    (2019, '222220190004', '111120190028', 48),
    (2019, '222220190001', '111120190029', 12),
    (2019, '222220190002', '111120190029', 93),
    (2019, '222220190003', '111120190029', 84),
    (2019, '222220190004', '111120190029', 69),
    (2019, '222220190001', '111120190030', 53),
    (2019, '222220190002', '111120190030', 6),
    (2019, '222220190003', '111120190030', 12),
    (2019, '222220190004', '111120190030', 68),
    (2019, '222220190001', '111120190031', 0),
    (2019, '222220190002', '111120190031', 0),
    (2019, '222220190003', '111120190031', 0),
    (2019, '222220190004', '111120190031', 0),
    (2019, '222220190001', '111120190032', 0),
    (2019, '222220190002', '111120190032', 0),
    (2019, '222220190003', '111120190032', 0),
    (2019, '222220190004', '111120190032', 0),
    (2019, '222220190001', '111120190033', 0),
    (2019, '222220190002', '111120190033', 0),
    (2019, '222220190003', '111120190033', 0),
    (2019, '222220190004', '111120190033', 0),
    (2019, '222220190001', '111120190034', 0),
    (2019, '222220190002', '111120190034', 0),
    (2019, '222220190003', '111120190034', 0),
    (2019, '222220190004', '111120190034', 0),
    (2019, '222220190001', '111120190035', 0),
    (2019, '222220190002', '111120190035', 0),
    (2019, '222220190003', '111120190035', 0),
    (2019, '222220190004', '111120190035', 0),
    (2019, '222220190001', '111120190036', 0),
    (2019, '222220190002', '111120190036', 0),
    (2019, '222220190003', '111120190036', 0),
    (2019, '222220190004', '111120190036', 0),
    (2019, '222220190001', '111120190037', 0),
    (2019, '222220190002', '111120190037', 0),
    (2019, '222220190003', '111120190037', 0),
    (2019, '222220190004', '111120190037', 0),
    (2019, '222220190001', '111120190038', 0),
    (2019, '222220190002', '111120190038', 0),
    (2019, '222220190003', '111120190038', 0),
    (2019, '222220190004', '111120190038', 0),
    (2019, '222220190001', '111120190039', 0),
    (2019, '222220190002', '111120190039', 0),
    (2019, '222220190003', '111120190039', 0),
    (2019, '222220190004', '111120190039', 0),
    (2019, '222220190001', '111120190040', 0),
    (2019, '222220190002', '111120190040', 0),
    (2019, '222220190003', '111120190040', 0),
    (2019, '222220190004', '111120190040', 0);


    -- Episode --
    INSERT INTO `episode` (`Syear`, `Ep_No`, `Name`, `Datetime`, `Duration`) VALUES
    (2018, 1, '2018_ep1', '2018-01-11 19:00:00', 90),
    (2018, 2, '2018_ep2', '2018-02-12 19:00:00', 90),
    (2018, 3, '2018_ep3', '2018-03-16 19:00:00', 90),
    (2018, 4, '2018_ep4', '2018-04-17 19:00:00', 90),
    (2018, 5, '2018_ep5', '2018-05-19 19:00:00', 90),
    (2019, 1, '2019_ep1', '2019-07-05 19:00:00', 90),
    (2019, 2, '2019_ep2', '2019-08-06 19:00:00', 90),
    (2019, 3, '2019_ep3', '2019-09-07 19:00:00', 90),
    (2019, 4, '2019_ep4', '2019-10-09 19:00:00', 90),
    (2019, 5, '2019_ep5', '2019-11-10 19:00:00', 90);


    -- Stage --
    -- INSERT INTO `stage` (`Syear`, `Ep_No`, `Stage_No`, `Is_Group`, `Skill`, `Total_Votes`, `Song_ID`) VALUES
    -- (2018, 1, 801, 0, 4, NULL, 'S001'),
    -- (2018, 2, 821, 1, 1, 1343, 'S003'),
    -- (2018, 2, 822, 1, 1, 465, 'S004'),
    -- (2018, 2, 823, 1, 2, 999, 'S005'),
    -- (2018, 2, 824, 1, 2, 1153, 'S006'),
    -- (2018, 2, 825, 1, 3, 563, 'S007'),
    -- (2018, 2, 826, 1, 3, 802, 'S008'),
    -- (2018, 3, 831, 1, 4, 1956, 'S009'),
    -- (2018, 3, 832, 1, 4, 603, 'S009'),
    -- (2018, 3, 833, 1, 4, 1667, 'S010'),
    -- (2018, 3, 834, 1, 4, 789, 'S010'),
    -- (2018, 4, 841, 1, 4, 1085, 'S005'),
    -- (2018, 4, 842, 1, 4, 1061, 'S006'),
    -- (2018, 4, 843, 1, 4, 991, 'S007'),
    -- (2018, 4, 844, 1, 4, 646, 'S008'),
    -- (2018, 5, 850, 0, 1, NULL, 'S006'),
    -- (2018, 5, 851, 0, 3, NULL, 'S007'),
    -- (2018, 5, 852, 0, 4, NULL, 'S008'),
    -- (2018, 5, 853, 0, 2, NULL, 'S009'),
    -- (2018, 5, 854, 0, 1, NULL, 'S009'),
    -- (2018, 5, 855, 0, 3, NULL, 'S010'),
    -- (2018, 5, 856, 0, 4, NULL, 'S010'),
    -- (2018, 5, 857, 0, 3, NULL, 'S005'),
    -- (2018, 5, 858, 0, 2, NULL, 'S006'),
    -- (2018, 5, 859, 0, 3, NULL, 'S007'),
    -- (2018, 5, 860, 1, 4, NULL, 'S008'),
    -- (2018, 5, 861, 1, 4, NULL, 'S009');
    INSERT INTO Stage VALUES('2018',1,801,0,4,NULL,"S001"),('2018',2,821,1,1,1343,"S003"),('2018',2,822,1,1,465,"S004"),('2018',2,823,1,2,999,"S005"),('2018',2,824,1,2,1153,"S006"),('2018',2,825,1,3,563,"S007"),('2018',2,826,1,3,802,"S008"),('2018',3,831,1,4,1956,"S009"),('2018',3,832,1,4,603,"S009"),('2018',3,833,1,4,1667,"S010"),('2018',3,834,1,4,789,"S010"),('2018',4,841,1,4,1085,"S005"),('2018',4,842,1,4,1061,"S006"),('2018',4,843,1,4,991,"S007"),('2018',4,844,1,4,646,"S008"),('2018',5,850,0,1,NULL,"S006"),('2018',5,851,0,3,NULL,"S007"),('2018',5,852,0,4,NULL,"S008"),('2018',5,853,0,2,NULL,"S009"),('2018',5,854,0,1,NULL,"S009"),('2018',5,855,0,3,NULL,"S010"),('2018',5,856,0,4,NULL,"S010"),('2018',5,857,0,3,NULL,"S005"),('2018',5,858,0,2,NULL,"S006"),('2018',5,859,0,3,NULL,"S007"),('2018',5,860,1,4,NULL,"S008"),('2018',5,861,1,4,NULL,"S009"),('2019',1,901,0,4,NULL,"S002");


    -- -- StageIncludeTrainee --
    -- INSERT INTO `stageincludetrainee` (`SYear`, `Ep_No`, `Stage_No`, `Ssn_trainee`, `Role`, `No_of_votes`) VALUES
    -- (2018, 1, 801, '111120180001', 1, NULL),
    -- (2018, 1, 801, '111120180002', 1, NULL),
    -- (2018, 1, 801, '111120180003', 1, NULL),
    -- (2018, 1, 801, '111120180004', 1, NULL),
    -- (2018, 1, 801, '111120180005', 1, NULL),
    -- (2018, 1, 801, '111120180006', 1, NULL),
    -- (2018, 1, 801, '111120180007', 1, NULL),
    -- (2018, 1, 801, '111120180008', 1, NULL),
    -- (2018, 1, 801, '111120180009', 1, NULL),
    -- (2018, 1, 801, '111120180010', 1, NULL),
    -- (2018, 1, 801, '111120180011', 1, NULL),
    -- (2018, 1, 801, '111120180012', 1, NULL),
    -- (2018, 1, 801, '111120180013', 1, NULL),
    -- (2018, 1, 801, '111120180014', 1, NULL),
    -- (2018, 1, 801, '111120180015', 1, NULL),
    -- (2018, 1, 801, '111120180016', 1, NULL),
    -- (2018, 1, 801, '111120180017', 1, NULL),
    -- (2018, 1, 801, '111120180018', 1, NULL),
    -- (2018, 1, 801, '111120180019', 1, NULL),
    -- (2018, 1, 801, '111120180020', 1, NULL),
    -- (2018, 1, 801, '111120180021', 1, NULL),
    -- (2018, 1, 801, '111120180022', 1, NULL),
    -- (2018, 1, 801, '111120180023', 1, NULL),
    -- (2018, 1, 801, '111120180024', 1, NULL),
    -- (2018, 1, 801, '111120180025', 1, NULL),
    -- (2018, 1, 801, '111120180026', 1, NULL),
    -- (2018, 1, 801, '111120180027', 1, NULL),
    -- (2018, 1, 801, '111120180028', 1, NULL),
    -- (2018, 1, 801, '111120180029', 1, NULL),
    -- (2018, 1, 801, '111120180030', 1, NULL),
    -- (2018, 1, 801, '111120180031', 1, NULL),
    -- (2018, 1, 801, '111120180032', 1, NULL),
    -- (2018, 1, 801, '111120180033', 1, NULL),
    -- (2018, 1, 801, '111120180034', 1, NULL),
    -- (2018, 1, 801, '111120180035', 1, NULL),
    -- (2018, 1, 801, '111120180036', 1, NULL),
    -- (2018, 1, 801, '111120180037', 1, NULL),
    -- (2018, 1, 801, '111120180038', 1, NULL),
    -- (2018, 1, 801, '111120180039', 1, NULL),
    -- (2018, 1, 801, '111120180040', 1, NULL),
    -- (2018, 2, 821, '111120180001', 2, 360),
    -- (2018, 2, 821, '111120180002', 3, 65),
    -- (2018, 2, 821, '111120180003', 1, 1),
    -- (2018, 2, 821, '111120180004', 1, 497),
    -- (2018, 2, 821, '111120180005', 1, 420),
    -- (2018, 2, 822, '111120180006', 2, 1),
    -- (2018, 2, 822, '111120180007', 3, 383),
    -- (2018, 2, 822, '111120180008', 1, 33),
    -- (2018, 2, 822, '111120180009', 1, 1),
    -- (2018, 2, 822, '111120180010', 1, 47),
    -- (2018, 2, 823, '111120180011', 2, 50),
    -- (2018, 2, 823, '111120180012', 3, 1),
    -- (2018, 2, 823, '111120180013', 1, 461),
    -- (2018, 2, 823, '111120180014', 1, 486),
    -- (2018, 2, 823, '111120180015', 1, 1),
    -- (2018, 2, 824, '111120180016', 2, 297),
    -- (2018, 2, 824, '111120180017', 3, 432),
    -- (2018, 2, 824, '111120180018', 1, 1),
    -- (2018, 2, 824, '111120180019', 1, 52),
    -- (2018, 2, 824, '111120180020', 1, 371),
    -- (2018, 2, 825, '111120180021', 2, 1),
    -- (2018, 2, 825, '111120180022', 3, 358),
    -- (2018, 2, 825, '111120180023', 1, 47),
    -- (2018, 2, 825, '111120180024', 1, 1),
    -- (2018, 2, 825, '111120180025', 1, 156),
    -- (2018, 2, 826, '111120180026', 2, 245),
    -- (2018, 2, 826, '111120180027', 3, 1),
    -- (2018, 2, 826, '111120180028', 1, 91),
    -- (2018, 2, 826, '111120180029', 1, 464),
    -- (2018, 2, 826, '111120180030', 1, 1),
    -- (2018, 3, 831, '111120180001', 2, 331),
    -- (2018, 3, 831, '111120180002', 3, 470),
    -- (2018, 3, 831, '111120180004', 1, 424),
    -- (2018, 3, 831, '111120180005', 1, 308),
    -- (2018, 3, 831, '111120180007', 1, 423),
    -- (2018, 3, 832, '111120180008', 2, 183),
    -- (2018, 3, 832, '111120180010', 3, 120),
    -- (2018, 3, 832, '111120180011', 1, 150),
    -- (2018, 3, 832, '111120180013', 1, 100),
    -- (2018, 3, 832, '111120180014', 1, 50),
    -- (2018, 3, 833, '111120180016', 2, 274),
    -- (2018, 3, 833, '111120180017', 3, 279),
    -- (2018, 3, 833, '111120180019', 1, 454),
    -- (2018, 3, 833, '111120180020', 1, 399),
    -- (2018, 3, 833, '111120180022', 1, 261),
    -- (2018, 3, 834, '111120180023', 2, 184),
    -- (2018, 3, 834, '111120180025', 3, 151),
    -- (2018, 3, 834, '111120180026', 1, 198),
    -- (2018, 3, 834, '111120180028', 1, 130),
    -- (2018, 3, 834, '111120180029', 1, 126),
    -- (2018, 4, 841, '111120180001', 2, 360),
    -- (2018, 4, 841, '111120180002', 3, 198),
    -- (2018, 4, 841, '111120180004', 1, 455),
    -- (2018, 4, 841, '111120180005', 1, 72),
    -- (2018, 4, 842, '111120180007', 2, 351),
    -- (2018, 4, 842, '111120180008', 3, 472),
    -- (2018, 4, 842, '111120180010', 1, 137),
    -- (2018, 4, 842, '111120180011', 1, 101),
    -- (2018, 4, 843, '111120180016', 2, 426),
    -- (2018, 4, 843, '111120180017', 3, 455),
    -- (2018, 4, 843, '111120180019', 1, 26),
    -- (2018, 4, 843, '111120180020', 1, 84),
    -- (2018, 4, 844, '111120180022', 2, 151),
    -- (2018, 4, 844, '111120180023', 3, 342),
    -- (2018, 4, 844, '111120180025', 1, 98),
    -- (2018, 4, 844, '111120180026', 1, 55),
    -- (2018, 5, 850, '111120180001', 1, 419),
    -- (2018, 5, 851, '111120180002', 1, 437),
    -- (2018, 5, 852, '111120180004', 1, 402),
    -- (2018, 5, 853, '111120180007', 1, 445),
    -- (2018, 5, 854, '111120180008', 1, 149),
    -- (2018, 5, 855, '111120180010', 1, 400),
    -- (2018, 5, 856, '111120180016', 1, 251),
    -- (2018, 5, 857, '111120180017', 1, 70),
    -- (2018, 5, 858, '111120180022', 1, 13),
    -- (2018, 5, 859, '111120180023', 1, 277),
    -- (2018, 5, 860, '111120180001', 2, NULL),
    -- (2018, 5, 860, '111120180002', 3, NULL),
    -- (2018, 5, 860, '111120180004', 1, NULL),
    -- (2018, 5, 860, '111120180007', 1, NULL),
    -- (2018, 5, 860, '111120180008', 1, NULL),
    -- (2018, 5, 861, '111120180010', 2, NULL),
    -- (2018, 5, 861, '111120180016', 3, NULL),
    -- (2018, 5, 861, '111120180017', 1, NULL),
    -- (2018, 5, 861, '111120180022', 1, NULL),
    -- (2018, 5, 861, '111120180023', 1, NULL);
    INSERT INTO StageIncludeTrainee VALUES('2018',1,801,111120180001,1,NULL),('2018',1,801,111120180002,1,NULL),('2018',1,801,111120180003,1,NULL),('2018',1,801,111120180004,1,NULL),('2018',1,801,111120180005,1,NULL),('2018',1,801,111120180006,1,NULL),('2018',1,801,111120180007,1,NULL),('2018',1,801,111120180008,1,NULL),('2018',1,801,111120180009,1,NULL),('2018',1,801,111120180010,1,NULL),('2018',1,801,111120180011,1,NULL),('2018',1,801,111120180012,1,NULL),('2018',1,801,111120180013,1,NULL),('2018',1,801,111120180014,1,NULL),('2018',1,801,111120180015,1,NULL),('2018',1,801,111120180016,1,NULL),('2018',1,801,111120180017,1,NULL),('2018',1,801,111120180018,1,NULL),('2018',1,801,111120180019,1,NULL),('2018',1,801,111120180020,1,NULL),('2018',1,801,111120180021,1,NULL),('2018',1,801,111120180022,1,NULL),('2018',1,801,111120180023,1,NULL),('2018',1,801,111120180024,1,NULL),('2018',1,801,111120180025,1,NULL),('2018',1,801,111120180026,1,NULL),('2018',1,801,111120180027,1,NULL),('2018',1,801,111120180028,1,NULL),('2018',1,801,111120180029,1,NULL),('2018',1,801,111120180030,1,NULL),('2018',1,801,111120180031,1,NULL),('2018',1,801,111120180032,1,NULL),('2018',1,801,111120180033,1,NULL),('2018',1,801,111120180034,1,NULL),('2018',1,801,111120180035,1,NULL),('2018',1,801,111120180036,1,NULL),('2018',1,801,111120180037,1,NULL),('2018',1,801,111120180038,1,NULL),('2018',1,801,111120180039,1,NULL),('2018',1,801,111120180040,1,NULL),('2018',2,821,111120180001,2,360),('2018',2,821,111120180002,3,65),('2018',2,821,111120180003,1,1),('2018',2,821,111120180004,1,497),('2018',2,821,111120180005,1,420),('2018',2,822,111120180006,2,1),('2018',2,822,111120180007,3,383),('2018',2,822,111120180008,1,33),('2018',2,822,111120180009,1,1),('2018',2,822,111120180010,1,47),('2018',2,823,111120180011,2,50),('2018',2,823,111120180012,3,1),('2018',2,823,111120180013,1,461),('2018',2,823,111120180014,1,486),('2018',2,823,111120180015,1,1),('2018',2,824,111120180016,2,297),('2018',2,824,111120180017,3,432),('2018',2,824,111120180018,1,1),('2018',2,824,111120180019,1,52),('2018',2,824,111120180020,1,371),('2018',2,825,111120180021,2,1),('2018',2,825,111120180022,3,358),('2018',2,825,111120180023,1,47),('2018',2,825,111120180024,1,1),('2018',2,825,111120180025,1,156),('2018',2,826,111120180026,2,245),('2018',2,826,111120180027,3,1),('2018',2,826,111120180028,1,91),('2018',2,826,111120180029,1,464),('2018',2,826,111120180030,1,1),('2018',3,831,111120180001,2,331),('2018',3,831,111120180002,3,470),('2018',3,831,111120180004,1,424),('2018',3,831,111120180005,1,308),('2018',3,831,111120180007,1,423),('2018',3,832,111120180008,2,183),('2018',3,832,111120180010,3,120),('2018',3,832,111120180011,1,150),('2018',3,832,111120180013,1,100),('2018',3,832,111120180014,1,50),('2018',3,833,111120180016,2,274),('2018',3,833,111120180017,3,279),('2018',3,833,111120180019,1,454),('2018',3,833,111120180020,1,399),('2018',3,833,111120180022,1,261),('2018',3,834,111120180023,2,184),('2018',3,834,111120180025,3,151),('2018',3,834,111120180026,1,198),('2018',3,834,111120180028,1,130),('2018',3,834,111120180029,1,126),('2018',4,841,111120180001,2,360),('2018',4,841,111120180002,3,198),('2018',4,841,111120180004,1,455),('2018',4,841,111120180005,1,72),('2018',4,842,111120180007,2,351),('2018',4,842,111120180008,3,472),('2018',4,842,111120180010,1,137),('2018',4,842,111120180011,1,101),('2018',4,843,111120180016,2,426),('2018',4,843,111120180017,3,455),('2018',4,843,111120180019,1,26),('2018',4,843,111120180020,1,84),('2018',4,844,111120180022,2,151),('2018',4,844,111120180023,3,342),('2018',4,844,111120180025,1,98),('2018',4,844,111120180026,1,55),('2018',5,850,111120180001,1,419),('2018',5,851,111120180002,1,437),('2018',5,852,111120180004,1,402),('2018',5,853,111120180007,1,445),('2018',5,854,111120180008,1,149),('2018',5,855,111120180010,1,400),('2018',5,856,111120180016,1,251),('2018',5,857,111120180017,1,70),('2018',5,858,111120180022,1,13),('2018',5,859,111120180023,1,277),('2018',5,860,111120180001,2,NULL),('2018',5,860,111120180002,3,NULL),('2018',5,860,111120180004,1,NULL),('2018',5,860,111120180007,1,NULL),('2018',5,860,111120180008,1,NULL),('2018',5,861,111120180010,2,NULL),('2018',5,861,111120180016,3,NULL),('2018',5,861,111120180017,1,NULL),('2018',5,861,111120180022,1,NULL),('2018',5,861,111120180023,1,NULL),('2019',1,901,111120190001,1,NULL),('2019',1,901,111120190002,1,NULL),('2019',1,901,111120190003,1,NULL),('2019',1,901,111120190004,1,NULL),('2019',1,901,111120190005,1,NULL),('2019',1,901,111120190006,1,NULL),('2019',1,901,111120190007,1,NULL),('2019',1,901,111120190008,1,NULL),('2019',1,901,111120190009,1,NULL),('2019',1,901,111120190010,1,NULL),('2019',1,901,111120190011,1,NULL),('2019',1,901,111120190012,1,NULL),('2019',1,901,111120190013,1,NULL),('2019',1,901,111120190014,1,NULL),('2019',1,901,111120190015,1,NULL),('2019',1,901,111120190016,1,NULL),('2019',1,901,111120190017,1,NULL),('2019',1,901,111120190018,1,NULL),('2019',1,901,111120190019,1,NULL),('2019',1,901,111120190020,1,NULL),('2019',1,901,111120190021,1,NULL),('2019',1,901,111120190022,1,NULL),('2019',1,901,111120190023,1,NULL),('2019',1,901,111120190024,1,NULL),('2019',1,901,111120190025,1,NULL),('2019',1,901,111120190026,1,NULL),('2019',1,901,111120190027,1,NULL),('2019',1,901,111120190028,1,NULL),('2019',1,901,111120190029,1,NULL),('2019',1,901,111120190030,1,NULL),('2019',1,901,111120190031,1,NULL),('2019',1,901,111120190032,1,NULL),('2019',1,901,111120190033,1,NULL),('2019',1,901,111120190034,1,NULL),('2019',1,901,111120190035,1,NULL),('2019',1,901,111120190036,1,NULL),('2019',1,901,111120190037,1,NULL),('2019',1,901,111120190038,1,NULL),('2019',1,901,111120190039,1,NULL),('2019',1,901,111120190040,1,NULL);

    -- InvitedGuest --
    INSERT INTO `invitedguest` (`Guest_ID`) VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8);


    -- Group --
    INSERT INTO `ggroup` (`Gname`, `No_of_member`, `Guest_ID`) VALUES
    ('Beatles', 6, 6),
    ('Cters', 5, 8),
    ('MenInBlack', 5, 5),
    ('Walkers', 4, 7);


    -- GroupSignatureSong --
    INSERT INTO `groupsignaturesong` (`Gname`, `Song_name`) VALUES
    ('Beatles', 'Hello'),
    ('Cters', 'Despacito'),
    ('MenInBlack', 'See You Again'),
    ('Walkers', 'Faded');


    -- GuestSupportStage --
    INSERT INTO `guestsupportstage` (`Guest_ID`, `Syear`, `Ep_No`, `Stage_No`) VALUES
    (2, 2018, 4, 841),
    (4, 2018, 4, 842),
    (6, 2018, 4, 843),
    (8, 2018, 4, 844);


-- Add table for system --

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', ''),
(6, 'short_name', 'BKast'),
(11, 'logo', 'uploads/VFRESH.png'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/banner_img2.jpg'),
(15, 'small_logo', 'uploads/sheaf-of-rice.png'),
(16, 'banner', 'please give us the bezt score you have');

ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

CREATE TABLE `vendor_list` (
  `id` int(30) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` text NOT NULL,
  `contact` text NOT NULL,
  `email` text DEFAULT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `vendor_list` (`id`, `code`, `name`, `contact`, `email`, `username`, `password`, `avatar`, `status`, `delete_flag`, `date_created`, `date_updated`) VALUES
(5, '202210-00001', 'sManager', '0912345678', 'nghia.maiemches@hcmut.edu.vn', 'sManager', '6f253286e4e82bcc67d95a527bd5ffc4', 'uploads/vendors/5.png?v=1666107634', 1, 0, '2022-10-14 18:40:27', '2022-10-18 22:40:34');

ALTER TABLE `vendor_list`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `vendor_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;