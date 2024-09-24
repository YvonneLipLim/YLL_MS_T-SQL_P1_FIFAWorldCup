--Query Top 4 Teams Per World Cup Year
--Step 1: Create a View for Top3TeamsPerWorldCup
CREATE VIEW Top4_Winning_Teams AS
WITH CombinedData AS (
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '2022' AS Year
    FROM FIFA.dbo.Year2022
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '2018' AS Year
    FROM FIFA.dbo.Year2018
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '2014' AS Year
    FROM FIFA.dbo.Year2014
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '2010' AS Year
    FROM FIFA.dbo.Year2010
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '2006' AS Year
    FROM FIFA.dbo.Year2006
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '2002' AS Year
    FROM FIFA.dbo.Year2002
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1998' AS Year
    FROM FIFA.dbo.Year1998
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1994' AS Year
    FROM FIFA.dbo.Year1994
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1990' AS Year
    FROM FIFA.dbo.Year1990
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1986' AS Year
    FROM FIFA.dbo.Year1986
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1982' AS Year
    FROM FIFA.dbo.Year1982
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1978' AS Year
    FROM FIFA.dbo.Year1978
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1974' AS Year
    FROM FIFA.dbo.Year1974
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1970' AS Year
    FROM FIFA.dbo.Year1970
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1966' AS Year
    FROM FIFA.dbo.Year1966
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1962' AS Year
    FROM FIFA.dbo.Year1962
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1958' AS Year
    FROM FIFA.dbo.Year1958
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1954' AS Year
    FROM FIFA.dbo.Year1954
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1950' AS Year
    FROM FIFA.dbo.Year1950
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1938' AS Year
    FROM FIFA.dbo.Year1938
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1934' AS Year
    FROM FIFA.dbo.Year1934
    UNION ALL
    SELECT [Position], [Team], [Win], [Draw], [Loss], [Goals_For] AS GoalsScored, [Goals_Against] AS GoalsLoss, [Points], '1930' AS Year
    FROM FIFA.dbo.Year1930
)
SELECT Year, Team, Win, Draw, Loss, GoalsScored, GoalsLoss, Points, TeamRank
FROM (
    SELECT *, RANK() OVER (PARTITION BY Year ORDER BY Position ASC) AS TeamRank
    FROM CombinedData
) RankedTeams
WHERE TeamRank <= 4;


--Query Top 4 Team for each World Cup
SELECT [Year],
    MAX(CASE WHEN TeamRank = 1 THEN Team END) AS Champion,
    MAX(CASE WHEN TeamRank = 2 THEN Team END) AS "Runners_Up",
    MAX(CASE WHEN TeamRank = 3 THEN Team END) AS "Third_Place",
    MAX(CASE WHEN TeamRank = 4 THEN Team END) AS "Forth_Place"
FROM dbo.Top4_Winning_Teams
GROUP BY Year
ORDER BY [Year] DESC;
