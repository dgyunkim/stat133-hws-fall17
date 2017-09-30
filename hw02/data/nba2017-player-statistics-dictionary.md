# A data dictionary

- This data set is about records of NBA players in 2017.  
- It has 411 rows as number of players and 24 columns that shows records of each player.  

## Column labels
- `Player`: first and last names of player: **Character**   
- `Team`: 3-letter team abbreviation: **Character**   
- `Position`: player’s position: **Factor** with 5 levels
- `Experience`: years of experience in NBA (a value of R means rookie): **Character**
- `Salary`: player salary in dollars: **Double** with range 5145 - 30963450    
- `Rank`: Rank of player in his team: **Integer** with rage 1 - 23
- `Age`: Age of Player at the start of February 1st of that season: **Integer** with rage 19 - 40  
- `GP`: Games Played furing regular season: **Integer** with rage 1 - 82  
- `GS`: Games Started: **Integer** with rage 0 - 82
- `MIN`: Minutes Played during regular season: **Integer**c with rage 8 - 3048  
- `FGM`: Field Goals Made: **Integer** with rage 0 - 824  
- `FGA`: Field Goal Attempts: **Integer** with rage 1 - 1941
- `Points3`: 3-Point Field Goals: **Integer** with rage 0 - 324
- `Points3_atts`: 3-Point Field Goal Attempts: **Integer** with rage 0 - 789  
- `Points2`: 2-Point Field Goals: **Integer** with rage 0 - 730 
- `Points2_atts`: 2-Point Field Goal Attempts: **Integer** with rage 0 - 1421
- `FTM`: Free Throws Made: **Integer** with rage 0 - 746
- `FTA`: Free Throw Attempts: **Integer** with rage 0 - 881  
- `OREB`: Offensive Rebounds: **Integer** with rage 0 - 345  
- `DREB`: Defensive Rebounds: **Integer** with rage 1 - 817 
- `AST`: Assists: **Integer** with rage 0 - 906
- `STL`: Steals: **Integer** with rage 0 - 157  
- `BLK`: Blocks: **Integer** with rage 0 - 214
- `TO`: Turnovers: **Integer** with rage 0 - 464

## Sources
- <https://www.basketball-reference.com>
- [GS Warriors](https://www.basketball-reference.com/teams/GSW/2017.html)
