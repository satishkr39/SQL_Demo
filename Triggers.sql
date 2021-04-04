/******************* DML Triggers *********************/
-- Triggers are set of queries which get executed when some data are inserted, updated or deleted from some table. 
-- There are 2 special triggers in Triggers. INSERTED and DELETED. The Inserted shows all the values that are being inserted
-- and deleted shows all the values that are being removed. 

-- Creating a demo trigger

CREATE OR ALTER TRIGGER 
	studentTrigger
ON 
	Student
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	IF @@ROWCOUNT>0
	BEGIN
		SELECT * FROM INSERTED
		SELECT * FROM DELETED
	END

	IF UPDATE(Name) -- This runs when there is an update in column Name of student table. 
	BEGIN
		SELECT * FROM INSERTED
		SELECT * FROM DELETED
	END
END
GO

SELECT * FROM Student WHERE Roll = 12;
BEGIN TRANSACTION
	INSERT INTO Student(Name, Roll, Mobile) VALUES('Sapna', 12, 2342) -- As we have defined a trigger for this table. Whenever we try
ROLLBACK TRANSACTION					-- to insert the values the the trigger will be called and it will print data inserted or deleted
GO

DELETE FROM Student WHERE Roll = 12; -- When no rows are deleted then the trigger doesn't print any rows bcoz of If implementation.
-- @@NESTLEVEL is a Global variable that shows how many levels of nesting we are going into triggers. to get the nest level,
-- we have to insert in trigger statements as SELECT @@NESTLEVEL AS 'Nest_Level'
-- maximum of 32 levvel of nesting is allowed.
-- @@ROWCOUNT returns the number of rows effected. It's global variable. 
-- When we want to handle more than one rows in Trigger, we need to use JOINS in our trigger queries. And in that we need to join
-- our tables into the deleted/inserted table and then process them.

-- Disable a Trigger
DISABLE TRIGGER TriggerName ON TableName;