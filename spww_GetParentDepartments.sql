CREATE OR ALTER PROCEDURE [dbo].[spww_GetParentDepartments] @DepartmentPositionsID int
 AS
 BEGIN
 DECLARE @OwnerId int

 SELECT @OwnerId = D.OwnerID
 FROM DepartmentPositions D WITH (NOLOCK)
 WHERE D.DepartmentPositionsID = @DepartmentPositionsID 
   

;WITH Rec AS
(
   SELECT *,  0 AS Depth
   FROM DepartmentPositions WITH (NOLOCK)
   WHERE DepartmentPositionsID = @OwnerId 
   
   UNION ALL
   
   SELECT C.*,  Depth+1 AS Depth
   FROM DepartmentPositions c WITH (NOLOCK)
   INNER JOIN Rec p on C.DepartmentPositionsID = P.OwnerID AND C.DepartmentPositionsID<>IsNull(C.OwnerID,0) 
) 


SELECT *
FROM Rec
WHERE ItemType=1
ORDER BY [Depth] DESC

END
GO
