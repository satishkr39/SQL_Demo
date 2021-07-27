DECLARE @count int
DECLARE @TableName Varchar(50)
DECLARE @TableName_1 Varchar(50)
DECLARE @column_name Varchar(50)
DECLARE @table_schema Varchar(20)
DECLARE @SMT varchar(500)
DECLARE @backup_smt varchar(100)

SET @TableName=''
SET @TableName_1=''
SET @column_name=''
SET @table_schema=''


SET @count = (select COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName
	and column_name=@column_name
	and table_schema=@table_schema
)

PRINT(@count)
PRINT(@TableName)
if (@count >= 0)
 begin 
	IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = @table_schema AND  TABLE_NAME = @TableName+'bkup_0727'))
	BEGIN
			-- Perform action
	END

	IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = @table_schema AND  TABLE_NAME = @TableName_1+'bkup_0727'))
	BEGIN
					-- Perform action
	END

	set @smt='ALTER TABLE '+ @table_schema+'.'+@TableName +' ADD '+@column_name+' BIT NULL'
	PRINT(@SMT)
	exec (@smt)
PRINT 'Success:'+ @TableName +' Table Altered'
 end 
else 
  begin 
  PRINT 'Failed:'+ @TableName +'Table Not Altered'
  end 
GO