-- Trigger check Company number --
DELIMITER //

CREATE OR REPLACE TRIGGER check_CNumber
AFTER INSERT ON company
FOR EACH ROW
BEGIN
	IF (new.Cnumber NOT RLIKE '[C][0-9][0-9][0-9]') THEN
    	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = 'Not correct Company Number';
   	END IF;
END;
//
DELIMITER ;

DELIMITER //

CREATE OR REPLACE TRIGGER check_CNumber
AFTER UPDATE ON company
FOR EACH ROW
BEGIN
	IF (new.Cnumber NOT RLIKE '[C][0-9][0-9][0-9]') THEN
    	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = 'Not correct Company Number';
   	END IF;
END;
//
DELIMITER ;



-- 1. Trigger to check constraint -- 
-- a. Trainee can participate 3 seasons at most --
DELIMITER //

CREATE OR REPLACE TRIGGER at_most_three_season
AFTER INSERT ON seasontrainee
FOR EACH ROW
BEGIN
	DECLARE Total_year int;
	SELECT count(s.Syear) INTO Total_year FROM seasontrainee s WHERE s.Ssn_trainee = new.Ssn_trainee GROUP BY s.Ssn_trainee;
    IF (Total_year >= 3) THEN
   		SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = 'Max 3 season';
    END IF;
END;

//
DELIMITER ;

DELIMITER //

CREATE OR REPLACE TRIGGER at_most_three_season_update
AFTER UPDATE ON seasontrainee
FOR EACH ROW
BEGIN
	DECLARE Total_year int;
	SELECT count(s.Syear) INTO Total_year FROM seasontrainee s WHERE s.Ssn_trainee = new.Ssn_trainee GROUP BY s.Ssn_trainee;
    IF (Total_year >= 3) THEN
   		SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = 'Max 3 season';
    END IF;
END;

//
DELIMITER ;

-- b. If a trainee success to join in a debut night, then he/she cannot register as a trainee of later seasons --
DELIMITER //

CREATE OR REPLACE TRIGGER join_debut_night
AFTER INSERT ON seasontrainee
FOR EACH ROW
BEGIN
	DECLARE Debut_season year;
    DECLARE errorMessage text;
    SELECT s.SYear INTO Debut_season FROM stageincludetrainee s
    WHERE s.Ep_No = 5 and s.Ssn_trainee = new.Ssn_trainee;
    IF (debut_season IS NOT NULL) THEN
    	IF (new.Syear > debut_season) THEN
        	SET errorMessage = concat("Joined debut night on ", debut_season);
        	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = errorMessage;
        END IF;
   	END IF;
END;

//
DELIMITER ; 

DELIMITER //

CREATE OR REPLACE TRIGGER join_debut_night_update
AFTER UPDATE ON seasontrainee
FOR EACH ROW
BEGIN
	DECLARE Debut_season year;
    DECLARE errorMessage text;
    SELECT s.SYear INTO Debut_season FROM stageincludetrainee s
    WHERE s.Ep_No = 5 and s.Ssn_trainee = new.Ssn_trainee;
    IF (debut_season IS NOT NULL) THEN
    	IF (new.Syear > debut_season) THEN
        	SET errorMessage = concat("Joined debut night on ", debut_season);
        	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = errorMessage;
        END IF;
   	END IF;
END;

//
DELIMITER ; 

-- 2. Write trigger to calculate the total number of votes of a group (derived attribute of table 19) --
-- when number of votes of a member (no_of_votes of table 20) is updated --
DELIMITER //

CREATE OR REPLACE TRIGGER Update_total_vote
AFTER UPDATE ON stageincludetrainee
FOR EACH ROW
BEGIN
	DECLARE different int;
    SET different = new.No_of_votes - old.No_of_votes;
	UPDATE stage s
    SET s.Total_Votes = s.Total_Votes + different
    WHERE (s.Syear,s.Ep_No,s.Stage_No) = (new.Syear, new.Ep_no, new.Stage_No);
END;

//
DELIMITER ;

DELIMITER //

CREATE OR REPLACE TRIGGER Insert_total_vote
AFTER INSERT ON stageincludetrainee
FOR EACH ROW
BEGIN
	DECLARE new_vote int;
    SET new_vote = new.No_of_votes;
	UPDATE stage s
    SET s.Total_Votes = s.Total_Votes + new_vote
    WHERE (s.Syear,s.Ep_No,s.Stage_No) = (new.Syear, new.Ep_no, new.Stage_No);
END;

//
DELIMITER ;

-- 3. Write trigger to ensure that a trainee has : --
-- a. at most one group stage in episode 2, 3, 4 --
DELIMITER //
CREATE OR REPLACE TRIGGER group_stage_check
AFTER INSERT ON stageincludetrainee
FOR EACH ROW
BEGIN
	DECLARE group_stage_joined int(3);
    SELECT count(sit.Stage_No) INTO group_stage_joined
    FROM stageincludetrainee sit join stage s
    ON (sit.SYear, sit.Ep_No, sit.Stage_No) = (s.Syear, s.Ep_No, s.Stage_No)
    WHERE sit.Syear = new.Syear AND sit.Ep_No = new.Ep_No AND new.Ep_no != 1 AND new.Ep_no != 5 AND s.Is_Group = 1;
    IF (group_stage_joined > 1) THEN 
    	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = "Already joined a group stage";
    END IF;
END;

//
DELIMITER ;

DELIMITER //
CREATE OR REPLACE TRIGGER group_stage_check_update
AFTER update ON stageincludetrainee
FOR EACH ROW
BEGIN
	DECLARE group_stage_joined int(3);
    SELECT count(sit.Stage_No) INTO group_stage_joined
    FROM stageincludetrainee sit join stage s
    ON (sit.SYear, sit.Ep_No, sit.Stage_No) = (s.Syear, s.Ep_No, s.Stage_No)
    WHERE sit.Syear = new.Syear AND sit.Ep_No = new.Ep_No AND new.Ep_no != 1 AND new.Ep_no != 5 AND s.Is_Group = 1;
    IF (group_stage_joined > 1) THEN 
    	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = "Already joined a group stage";
    END IF;
END;

//
DELIMITER ;

-- b. at most one group stage and one individual stage in episode 5 --

DELIMITER //
CREATE OR REPLACE TRIGGER stage_five_check
AFTER INSERT ON stageincludetrainee
FOR EACH ROW
BEGIN
	DECLARE group_stage_joined int(3);
    DECLARE indi_stage_joined int(3);
    
    SELECT count(sit.Stage_No) INTO group_stage_joined
    FROM stageincludetrainee sit join stage s
    ON (sit.SYear, sit.Ep_No, sit.Stage_No) = (s.Syear, s.Ep_No, s.Stage_No)
    WHERE sit.Syear = new.Syear AND sit.Ep_no = 5 AND s.Is_Group = 1;
    
    SELECT count(sit.Stage_No) INTO indi_stage_joined
    FROM stageincludetrainee sit join stage s
    ON (sit.SYear, sit.Ep_No, sit.Stage_No) = (s.Syear, s.Ep_No, s.Stage_No)
    WHERE sit.Syear = new.Syear AND sit.Ep_no = 5 AND s.Is_Group = 0;
    
    IF (group_stage_joined > 1) THEN 
    	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = "Already joined a group stage";
    END IF;
    
    IF (indi_stage_joined > 1) THEN 
    	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = "Already joined a individual stage";
    END IF;
    
END;

//
DELIMITER ;

DELIMITER //
CREATE OR REPLACE TRIGGER stage_five_check_update
AFTER UPDATE ON stageincludetrainee
FOR EACH ROW
BEGIN
	DECLARE group_stage_joined int(3);
    DECLARE indi_stage_joined int(3);
    
    SELECT count(sit.Stage_No) INTO group_stage_joined
    FROM stageincludetrainee sit join stage s
    ON (sit.SYear, sit.Ep_No, sit.Stage_No) = (s.Syear, s.Ep_No, s.Stage_No)
    WHERE sit.Syear = new.Syear AND sit.Ep_no = 5 AND s.Is_Group = 1;
    
    SELECT count(sit.Stage_No) INTO indi_stage_joined
    FROM stageincludetrainee sit join stage s
    ON (sit.SYear, sit.Ep_No, sit.Stage_No) = (s.Syear, s.Ep_No, s.Stage_No)
    WHERE sit.Syear = new.Syear AND sit.Ep_no = 5 AND s.Is_Group = 0;
    
    IF (group_stage_joined > 1) THEN 
    	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = "Already joined a group stage";
    END IF;
    
    IF (indi_stage_joined > 1) THEN 
    	SIGNAL SQLSTATE '45000' SET
            	MESSAGE_TEXT = "Already joined a individual stage";
    END IF;
    
END;

//
DELIMITER ;