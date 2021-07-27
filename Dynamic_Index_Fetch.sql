-- Dynamic fetch all the index and drop each of them one by one 

DECLARE 
    @SchemaName SYSNAME,
    @DropThisIndex SYSNAME,
    @Column SYSNAME,
    @CheckThisTable SYSNAME,
    @LoopCounter INT,
    @IndexCount INT

SET @SchemaName = N'HumanResources'
SET @CheckThisTable = @SchemaName + '.' + N'EmployeeDepartmentHistory';
SET @Column = N'DepartmentID';
SET @LoopCounter = 1;

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = @Column AND Object_ID = Object_ID(@CheckThisTable))
	
    BEGIN --the column exists in the specified table Construct a temporary table that stores name of index to be dropped--
        SELECT 
            I.name AS IndexName
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
            C.name = @Column;

        --Check how many times to loop through--
        SET @IndexCount = @@ROWCOUNT;
        PRINT CAST(@IndexCount AS NVARCHAR) + N' index(es) on the table [' + @CheckThisTable + N'] for the column [' +  @Column + '] found'

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
                        --EXEC('DROP INDEX ' + @DropthisIndex + ' ON ' + @CheckThisTable);
                        SET @LoopCounter +=1;
                    END;
            END;             
    END
ELSE --no column found in the specified table.  Are the input corrects?  
    PRINT 'The column [' + @Column + '] in the table [' + @CheckThisTable + '] wasn''t found' ;

