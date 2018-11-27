--Loop through all records in a temp table until all have been updated
DECLARE @Evaldate DATE = CONVERT(DATE,GETDATE())
DECLARE @Counter2 INT = 0 --Set @Counter1 initally to zero
SET @Counter2 = (
				 SELECT MIN(DocumentID) --Set @Counter1 to the minimum ID
				   FROM #TempTable1
				  WHERE DocumentID > @Counter2
				)

WHILE @Counter2 IS NOT NULL

	BEGIN
	
	  UPDATE Document
	     SET Document.DocumentID = TempTable1.ID
	       , Document.DateLastMod = @Evaldate
		   , Document.UserID = 1
	    FROM dbo.Document Document WITH (NOLOCK)
	    JOIN #TempTable1 TempTable1
	      ON Document.DocumentID = TempTable1.DocumentID
	   WHERE Document.DocumentID = @Counter2
	    
		 SET @Counter2 = (
						  SELECT 
								 MIN(DocumentID) --When MIN(DocumentID) reaches maximum, MIN(DocumentID) will return NULL and exit the WHILE loop
						    FROM #TempTable1
						   WHERE DocumentID > @Counter2
						 )
	END
;