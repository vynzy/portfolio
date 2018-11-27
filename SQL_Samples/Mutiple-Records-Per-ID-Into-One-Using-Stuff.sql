--This query takes multiple records from one column and tranforms them into one semi-colon separated list value
--An aggregate column of all transferred credit hours is also created
CREATE TABLE #Transfer
( StudentID INT NOT NULL
, Colleges VARCHAR(200) NOT NULL
, Transfer_Hours NUMERIC(6,2) NULL
)
;

INSERT INTO #Transfer
SELECT StudentID
     , Colleges = STUFF(
             (SELECT '; ' + Descrip 
              FROM #Stage_Transfer t1 --Target population first put into #Stage_Transfer table
              WHERE t1.StudentID = t2.StudentID
              FOR XML PATH (''))
             , 1, 1, '')
	 , SUM(Transfer_hours) --All tranferred credit hours
  FROM #Stage_Transfer t2
GROUP BY StudentID
ORDER BY StudentID
;