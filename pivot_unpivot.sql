--pivot and unpivot

 CREATE TABLE Grades(
  [Student] VARCHAR(50),
  [Subject] VARCHAR(50),
  [Marks]   INT
)
GO
 
INSERT INTO Grades VALUES 
('Jacob','Mathematics',100),
('Jacob','Science',95),
('Jacob','Geography',90),
('Amilee','Mathematics',90),
('Amilee','Science',90),
('Amilee','Geography',100)
GO


 
 
 SELECT * FROM GradesPivotTable


 select * from GradesPivotTable
 unpivot(
 marksss
 for subjessct in (Mathematics, Science, Geography)
 ) as X



select * into GradesPivotTable from (
select * from Grades 
PIVOT (
SUM(Marks) for Subject in (Mathematics, Science, Geography)
) as A
) B


-- PIVOT SYNTAX
SELECT * FROM DBO.TABLE_NAME
PIVOT(
AggregateFunction(ColumnToBeAggregated) FOR pivotColumn 
IN (PivotColumnValues)
)

-- UNPIVOT SYNTAX
select * from PivotTable
unpivot(
marks -- our column name, any 
for subject--(our defined column name, any) 
in (Mathematics, Science, Geography) -- specific column name only
) as X