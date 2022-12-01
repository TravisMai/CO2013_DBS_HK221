
-- 1. Create a procedure/function to print list of trainees come to the next episode (or debut if input episode is debut night) --

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
    SELECT a.Ep_no as 'Episode', b.Score as 'Result'
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
        SELECT 1 as Ep_no, format(AVG(mvt.Score),2) as 'Score'
        FROM mentorvaluatetrainee mvt
        WHERE (mvt.Syear, mvt.Ssn_trainee) = (InYear, InSsn)

        UNION 

        SELECT 2 as Ep_no, format(sit.No_of_votes,0) as 'Score'
        FROM stageincludetrainee sit
        WHERE (sit.SYear, sit.Ep_No, sit.Ssn_trainee) = (InYear, 2, InSsn)

        UNION


        SELECT 3 as Ep_no, format(sit.No_of_votes,0) as 'Score'
        FROM stageincludetrainee sit
        WHERE (sit.SYear, sit.Ep_No, sit.Ssn_trainee) = (InYear, 3, InSsn)

        UNION


        SELECT 4 as Ep_no, format(sit.No_of_votes,0) as 'Score'
        FROM stageincludetrainee sit
        WHERE (sit.SYear, sit.Ep_No, sit.Ssn_trainee) = (InYear, 4, InSsn)

        UNION

        SELECT 5 as Ep_no, format(sit.No_of_votes,0) as 'Score'
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