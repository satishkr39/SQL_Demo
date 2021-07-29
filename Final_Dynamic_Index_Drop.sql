-- Dynamic fetch all the index and drop each of them one by one 

DECLARE 
    @SchemaName SYSNAME,
    @DropThisIndex SYSNAME,
    @Column SYSNAME,
    @CheckThisTable SYSNAME,
    @LoopCounter INT,
    @IndexCount INT,
	@Column1 SYSNAME,
	@Column2 SYSNAME,
	@IndexFix INT,
	@IndexCounter INT,
	@CheckThisCol SYSNAME

-- to store our list of columns
DECLARE	@myColumnList TABLE(Name SYSNAME NULL)
SET @SchemaName = N'HumanResources'
SET @CheckThisTable = @SchemaName + '.' + N'EmployeeDepartmentHistory';
SET @LoopCounter = 1;
SET @Column1 = N'BusinessEntityID'
SET @Column = N'DepartmentID';
SET @Column2 = N'ShiftID'

SET @LoopCounter = 1;
SET @IndexCounter = 1;
-- To insert all our values
INSERT INTO @myColumnList VALUES (@Column), (@Column1), (@Column2)

PRINT 'Columns to check for Index'
SELECT * FROM @myColumnList
SET @IndexFix = @@ROWCOUNT

IF EXISTS(SELECT * FROM sys.tables WHERE Object_ID = Object_ID(@CheckThisTable))
    BEGIN --the column exists in the specified table Construct a temporary table that stores name of index to be dropped--		
		PRINT 'TABLE FOUND'
		IF OBJECT_ID(N'tempdb..#IndexList', N'U') IS NOT NULL  DROP TABLE #IndexList;  

		PRINT CONCAT('ROWS TO CHECK COUNT IS ', CAST(@IndexFix AS NVARCHAR))

		IF @IndexFix>0
		BEGIN
			--PRINT @IndexFix
			--PRINT @IndexCounter
			--PRINT 'IndexFix is > 0, Inside IF'
			--PRINT 'IndexCounter: '+CAST(@IndexCounter AS NVARCHAR)
			WHILE @IndexCounter < @IndexFix+1
                BEGIN
                        SELECT TOP(@IndexCounter) 
                            @CheckThisCol = Name
                        FROM @myColumnList;
						PRINT '=========Column checking========' +CAST(@CheckThisCol AS NVARCHAR)
				SELECT I.name AS IndexName
				INTO #IndexList
				FROM 
					sys.index_columns IC 
					INNER JOIN 
					sys.objects O
				ON  IC.[object_id]= O.[Object_ID]
					INNER JOIN
					sys.indexes I
				ON  IC.[object_id] = I.[object_id] AND
					IC.index_id = I.index_id
					INNER JOIN 
					sys.columns C 
				ON  IC.[object_id] = C.[object_id] AND
					IC.column_id = C.column_id
				WHERE O.[type] NOT IN ('S','IT') AND --we don't want anything to do with System or Internal Table
					IC.[INDEX_ID] <> 1 AND --neither Clustered Index
					IC.[object_id] = OBJECT_id(@CheckThisTable,'U') AND
					--C.name IN (SELECT * FROM @myColumnList WHERE Name is NOT NULL); -- Selecting our list of columns
					C.name = @CheckThisCol; -- Selecting our list of columns
				
				PRINT 'Select on temp table'
				SELECT * FROM #IndexList
				--Check how many times to loop through--
				SET @IndexCount = @@ROWCOUNT;
				PRINT CAST(@IndexCount AS NVARCHAR) + N' index(es) on the table [' + @CheckThisTable + N'] for the column [' +  @CheckThisCol + '] found'
				PRINT @IndexCount
				IF @IndexCount > 0 --there is at least one index(es) that are associated with the table and the column in question.  Begin loop--
					BEGIN
						WHILE @LoopCounter < @IndexCount+1
							BEGIN
								SELECT TOP(@LoopCounter) 
									@DropThisIndex = IndexName
								FROM #IndexList;
								--Execute Drop Index statement--
								PRINT N'Loop ' + CONVERT(NVARCHAR,@LoopCounter) + N': Dropping [' + @DropThisIndex + ']'
								PRINT @DropthisIndex
								BEGIN TRY
									PRINT 'Inside Try, Dropping Index Now'
									EXEC('DROP INDEX ' + @DropthisIndex + ' ON ' + @CheckThisTable);
								END TRY
								BEGIN CATCH
									PRINT 'Error in dropping'
								END CATCH
								SET @LoopCounter +=1;
							END;
					END;
					IF OBJECT_ID(N'tempdb..#IndexList', N'U') IS NOT NULL  DROP TABLE #IndexList;  
					SET @IndexCount = 0
					SET @IndexCounter +=1;
					SET @LoopCounter =0;
				END;
		END;
	END;