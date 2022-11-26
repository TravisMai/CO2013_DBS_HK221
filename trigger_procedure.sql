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


-- II. Store Procedure/Function --
-- 1. Create a procedure/function to print list of trainees come to the next episode (or debut if input episode is debut night) --


-- Tham khảo code từ: https://stackoverflow.com/questions/15969614/in-sql-how-to-select-the-top-2-rows-for-each-group --
DELIMITER //

CREATE OR REPLACE PROCEDURE next_ep_list
(InYear year, InEp int(1))
BEGIN
	IF (InEp = 1) THEN
        SELECT s.Ssn_trainee, AVG(m.Score)
        FROM stageincludetrainee s JOIN mentorvaluatetrainee m
        ON s.SYear = m.Syear AND s.Ssn_trainee = m.Ssn_trainee
        WHERE (s.SYear, s.Ep_No) = (InYear, InEp)
        GROUP BY s.Ssn_trainee
        ORDER BY AVG(m.Score) DESC
        LIMIT 30; 
    END IF;
    IF (InEp = 2) THEN
    	SELECT s.Ssn_trainee, s.No_of_votes
        FROM stageincludetrainee s
        WHERE (s.SYear, s.Ep_No) = (InYear, InEp)
        ORDER BY s.No_of_votes DESC
        LIMIT 20;
    END IF;
    IF (InEp = 3) THEN
    	
        SELECT sit.Ssn_trainee, sit.No_of_votes
        FROM stageincludetrainee sit
        WHERE (sit.SYear, sit.Ep_No) = (InYear, InEp)
        AND sit.Ssn_trainee NOT IN(
            SELECT lgt1.Ssn_trainee
            FROM(
                SELECT * FROM stageincludetrainee sit
                WHERE (sit.SYear, sit.Ep_No, sit.Stage_No) IN (
                    SELECT s.Syear, s.Ep_No, s.Stage_No
                    FROM stage s
                    WHERE(s.SYear, s.Ep_No) = (InYear,InEp)
                    AND (s.Total_Votes) IN(
                        SELECT MIN(s.Total_Votes)
                        FROM stage s 
                        WHERE (s.SYear, s.Ep_No) = (InYear,InEp)
                        GROUP BY s.Song_ID
                    )
                )
            )AS lgt1
            WHERE (
                SELECT 	COUNT(*) 
                FROM(
                    SELECT * FROM stageincludetrainee sit
                    WHERE (sit.SYear, sit.Ep_No, sit.Stage_No) IN (
                        SELECT s.Syear, s.Ep_No, s.Stage_No
                        FROM stage s
                        WHERE(s.SYear, s.Ep_No) = (InYear,InEp)
                        AND (s.Total_Votes) IN(
                            SELECT MIN(s.Total_Votes)
                            FROM stage s 
                            WHERE (s.SYear, s.Ep_No) = (InYear,InEp)
                            GROUP BY s.Song_ID
                  		)
                	)
                ) AS lgt2
                WHERE lgt2.Stage_No = lgt1.Stage_No AND 
                      lgt2.No_of_votes <= lgt1.No_of_votes
			) <= 2
		)
		ORDER BY sit.No_of_votes; 
    END IF;
    IF (InEp = 4) THEN
    	SELECT s.Ssn_trainee, s.No_of_votes
        FROM stageincludetrainee s
        WHERE (s.SYear, s.Ep_No) = (InYear, InEp)
        ORDER BY s.No_of_votes DESC
        LIMIT 10;
    END IF;
    IF (InEp = 5) THEN
    	SELECT s.Ssn_trainee, s.No_of_votes
        FROM stageincludetrainee s
        WHERE (s.SYear, s.Ep_No) = (InYear, InEp)
        AND s.Stage_No IN(
            SELECT stage.Stage_No
            FROM stage
            WHERE (stage.Syear, stage.Ep_No, stage.Is_Group) = (InYear, InEp, 0)
        )
        ORDER BY s.No_of_votes DESC
        LIMIT 5;
    END IF;
END;
//
DELIMITER ;

-- 2. Create a procedure/function to retrieve the result of a trainee in a season --
DELIMITER //
CREATE OR REPLACE PROCEDURE trainee_result
(InYear year, InSsn decimal(12,0))
BEGIN
    SELECT a.Ep_no as 'Episode', b.Score as 'Num of votes/ avg score'
    FROM(
        SELECT 1 as Ep_no, NULL as 'Score'
        UNION ALL
        SELECT 2 as Ep_no, NULL as 'Score'
        UNION ALL
        SELECT 3 as Ep_no, NULL as 'Score'
        UNION ALL 
        SELECT 4 as Ep_no, NULL as 'Score'
        UNION ALL
        SELECT 5 as Ep_no, NULL as 'Score'
    ) AS a
    LEFT JOIN(
        SELECT 1 as Ep_no, AVG(mvt.Score) as 'Score'
        FROM mentorvaluatetrainee mvt
        WHERE (mvt.Syear, mvt.Ssn_trainee) = (InYear, InSsn)

        UNION 

        SELECT 2 as Ep_no, sit.No_of_votes as 'Score'
        FROM stageincludetrainee sit
        WHERE (sit.SYear, sit.Ep_No, sit.Ssn_trainee) = (InYear, 2, InSsn)

        UNION


        SELECT 3 as Ep_no, sit.No_of_votes as 'Score'
        FROM stageincludetrainee sit
        WHERE (sit.SYear, sit.Ep_No, sit.Ssn_trainee) = (InYear, 3, InSsn)

        UNION


        SELECT 4 as Ep_no, sit.No_of_votes as 'Score'
        FROM stageincludetrainee sit
        WHERE (sit.SYear, sit.Ep_No, sit.Ssn_trainee) = (InYear, 4, InSsn)

        UNION

        SELECT 5 as Ep_no, sit.No_of_votes as 'Score'
        FROM stageincludetrainee sit
        WHERE sit.Ssn_trainee = InSsn
        AND sit.Stage_No IN(
            SELECT s.Stage_No
            FROM stage s
            WHERE (s.Syear, s.Ep_No, s.Is_Group) = (InYear, 5, 0)
        )
    ) as b
    ON a.Ep_no = b.Ep_no;
END;
//
DELIMITER ;