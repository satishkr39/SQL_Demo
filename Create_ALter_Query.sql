DECLARE @count int
DECLARE @TableName Varchar(50)
DECLARE @TableName_bkup Varchar(50)
DECLARE @column_name Varchar(50)
DECLARE @table_schema Varchar(20)
DECLARE @REFERENCE_TABLE Varchar(20)
DECLARE @REFERENCE_SCHEMA Varchar(20)
DECLARE @REFERENCE_Columns Varchar(30)
DECLARE @ref_count int
DECLARE @SMT varchar(500)
DECLARE @SMT_drop varchar(500)
DECLARE	@smt_delete varchar(500)
DECLARE	@smt_del varchar(500)
DECLARE @smt_alter varchar(500)
DECLARE @smt_insert varchar(500)
DECLARE @smt_exec_proc varchar(500)
DECLARE @count_column INT

SET @TableName=''
SET @column_name=''
SET @table_schema=''

SET @TableName_bkup=''

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = @table_schema 
                 AND  TABLE_NAME = @TableName_bkup))
BEGIN
    SET @smt_drop = 'DROP TABLE '+@TABLE_SCHEMA+'.'+@TableName_bkup
	PRINT(@smt_drop)
	EXEC(@smt_drop)
END

-- take bakup   
SET @count = (select COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName
	and table_schema=@table_schema
)
SET @TableName = (select DISTINCT Table_Name 
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName
	and table_schema=@table_schema
)

if (@count >= 0)
 begin 
	set @smt='SELECT * INTO  '+ @table_schema+'.'+@TableName_bkup +' FROM '+@table_schema+'.'+@TableName
	print(@smt)
	EXEC(@smt)
	
	
	
	SET @smt_del = 'DELETE FROM '+@table_schema+'.'+@TableName
	PRINT(@smt_del)
	EXEC(@smt_del)
		
	SET @count_column = (select COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName
	and table_schema=@table_schema
	AND column_name=@column_name
	)
	if(@count_column<=0)
	BEGIN
		SET @smt_alter = 'ALTER TABLE ' +@table_schema+'.'+@TableName+' ADD '+@column_name+' INT NOT NULL'
		PRINT(@smt_alter)
		EXEC(@smt_alter)
		PRINT('Table Altered : Column Added')
	END
	ELSE
	BEGIN
		PRINT('Table Not Altered: Column Not Added')
	END
	
	PRINT 'Success:'+ @TableName +' Job Complete'
 end 
else 
  begin 
  PRINT 'Failed:'+ @TableName +'Job Failed'
  end 
GO

