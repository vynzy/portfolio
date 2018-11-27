/* Each semester has an ID and a description, but not an Academic year. 
This code will create a column for academic year based on the Description column.
Each description is the year, followed by a space, followed by the semester name (Fall, Spring, Summer),
 followed by a space, then the word Semester. For example: 2019 Fall Semester
Academic year is formatted as YYYY-YY (including hyphen).

Example:
 
academic_year | Descrip
2019-20 | 2019 Fall Semester
2019-20 | 2020 Spring Semester
2019-20 | 2020 Summer Semester
*/
CONCAT( 
	     --This grabs the 1ST HALF of the academic year pertaining to the term  
	     CONVERT(
	     VARCHAR(4),
			/*PARSENAME can grab words when separated by a period. It has two arguments: ColumnName/Object and a number.
			  REPLACE replaces all the spaces in DESCRIP with a period. 
			  Use REPLACE as the first argument in PARSENAME to replace all spaces in the Column with a period (include RTRIM so there are no extra periods).
			  The 2nd argument is a number, and it is the #-to-last word (select string in reverse order).*/
	     (
	     CASE 
			--When the second-to-last word in [Descrip] = Fall, grab the third-to-last word, which is the academic year
	     WHEN PARSENAME(REPLACE(RTRIM(Descrip),' ','.'),2) = 'Fall'
	     THEN PARSENAME(REPLACE(RTRIM(Descrip),' ','.'),3)
			/*Else when the second-to-last word in Descrip IS NOT Fall, then grab the third-to-last word, which is the academic year,
			  convert it to an INT, then subtract a year because Spring and Summer occur in the 2nd half of the academic year,
			  so you need the prior year*/
	     ELSE CONVERT(int,PARSENAME(REPLACE(RTRIM(Descrip),' ','.'),3))-1
	     END)
	     )
	   , '-' --This is the hyphen between the academic years
	   , 
		--This grabs the 2ND HALF of the academic year pertaining to the term
	     CONVERT(
	     VARCHAR(2),
	     (	
	     CASE
			/*When the second-to-last word in [Descrip] = Fall, grab the third-to-last word, which is the academic year,
			  convert it to an INT, then add +1 because Fall occurs in the 1st half of the Academic Year, then only return the last two
			  numbers of the year*/
	     WHEN PARSENAME(REPLACE(RTRIM(Descrip),' ','.'),2) = 'Fall'
	     THEN RIGHT(CONVERT(int,PARSENAME(REPLACE(RTRIM(Descrip),' ','.'),3))+1,2)
			/*Else when the second-to-last word in Descrip IS NOT Fall, then grab the third-to-last word, which is the academic year,
			  then only return the last two numbers of the year*/
	     ELSE RIGHT(PARSENAME(REPLACE(RTRIM(Descrip),' ','.'),3),2)
	     END)
	     )
       ) AS academic_year