use formula1;

#Set Membership
select C.car_ID as CarNumber,C.car_Version as CarVersion ,A.datee as AccidentDate
from Car C natural join Accident A
where C.car_ID in (select P.car_ID
					from Race R natural join Participates P
					where R.weather like 'Rainy' and A.datee=R.datee);

#Set Comparison and 2 or more nesting levels
select  D.namee as DriverName, T.team_Name as TeamName
from Team T natural join Driver D
where D.ID in (select D.ID
				from Driver D natural join Sponsors S
                where S.sponsor_ID in(select sponsor_ID
									  from Sponsor
                                      where investment_Amount>=ALL(select investment_Amount
																   from Sponsor)));

#Set Cardinality
select R.race_Name as RaceName, R.circuit_Name as CircuitName
from Race R
where R.region like 'Europe' and 
			Exists(select *
					from Pitstops P
					where P.race_ID=R.race_ID and duration<22);

#Division Operation
#select C.car_ID
#from Car C
#where not exists(select CP.parts_ID
#				 from Car_Parts CP natural join Damages D
#                 where D.car_ID=C.car_ID
#                 except
#                 select CP.parts_ID
#                 from Car_Parts CP natural join Car_Parts CP2 natural join Damages D
#                 where D.car_ID=C.car_ID and CP.health<CP2.health and CP2.health>80 and CP.parts_ID!=CP2.parts_ID);

#From Statement Nested Query
select T.team_ID as TeamID, T.building_Number as BuildingNB,T.budget as DepartmentsBudget, T.nb_of_Employees as NBEmployes
from (select building_Number, team_ID, budget, nb_of_Employees
	  from Department 
      where nb_of_Employees>=ALL(select nb_of_Employees
									   from Department)) as T;




select circuit_Name as CircuitName, max(accident_Count) as MaxAccidents
from(
    select R.circuit_Name, count(A.Accident_ID) as accident_Count
    from Race R natural join Participates P
		join Accident A on (P.car_ID=A.car_ID and R.datee=A.datee)
    group by R.circuit_Name) as circuit_Accidents
group by circuit_Name
order by MaxAccidents;

# nested in select
select namee as Driver_Name, (select count(*)
				from standings as s
                where s.driver_ID = D.ID)as number_Of_Races
from Driver as D
where team_ID <=5 ;


#Update Containing Case
update Mechanic M
set M.levell=case
					when(select count(*)
						 from Car C natural join Driver D natural join Fixes f
						 where M.ID=F.mechanic_ID and D.positionn between 1 and 3)<5
					then (select count(*)
						 from Car C natural join Driver D natural join Fixes f
						 where M.ID=F.mechanic_ID and D.positionn between 1 and 3)
					else 5
			end
where M.ID>0;
 
#Outer Join
select CP.parts_ID as PartsID, E.ID as EngineerID, E.job as EngineerJob, E.profession as EngineerProffesion, F.engineer_ID as fEngineerID,
 F.building_Number as BuildingNumber, CP.part_Name as PartName, CP.versionn as PartVersion,CP.typee as PartType, CP.health as PartHealth
from (select ID , job, profession
	  from Engineer 
      where nationality='German' or nationality='Spanish') as E
	  left outer join fabricates F on(F.engineer_ID=E.ID ) left outer join Car_Parts CP using(parts_ID)
      where CP.health>80 or CP.health is NULL;

#Assertion
#create Assertion teams_number
#check (max((select count(*) from Driver group by team_ID))=2 
#		and 2=min((select count(*) from Driver group by team_ID));

#View
create view Race_Highlights(positionn, race_Name, namee, nb_of_Accidents)
		as select D.positionn,R.race_Name, D.namee, (select count(*)
												  from Accident A
												  where A.car_ID=D.car_ID and A.datee=R.datee)
		from (select race_Name, datee from Race) as R
        natural join Participates P
        natural join (select namee, positionn, car_ID from Driver) as D
        where D.positionn between 1 and 3
        group by R.race_Name;



Delimiter //
create trigger CalculateTotalPointsForTeam
after insert on Standings
FOR EACH ROW
BEGIN
    declare team_points integer  ;
    
    select sum(points) into team_points
    from Standings as S join Driver as D on (s.driver_ID = D.ID)
    where D.team_ID in (
        select distinct team_ID
        from Standings as S join Driver as D on (s.driver_ID = D.ID)
        where driver_ID = NEW.driver_ID
    );

    update Team
    set total_points = team_points
    WHERE team_ID in (
        select distinct team_ID
        from Standings as S join Driver as D on (s.driver_ID = D.ID)
        where driver_ID = NEW.driver_ID
    );
end ;
//
delimiter ;
DELIMITER //
CREATE FUNCTION GetDriverPosition(driverIdParam INT)
RETURNS INT
NO SQL
BEGIN
    DECLARE newPosition INT;

    SELECT ROW_NUMBER() OVER (ORDER BY TotalPoints DESC) INTO newPosition
    FROM (
        SELECT driver_ID, SUM(Points) AS TotalPoints
        FROM Standings
        WHERE driver_ID = driverIdParam
        GROUP BY driver_ID
    ) driver_totals;

    RETURN newPosition;
END;
//
DELIMITER ;

# procedure
# DELIMITER //

# CREATE PROCEDURE UpdateAllDriverPositions()
# BEGIN
#    DECLARE NewPosition INT;

#    FOR D_ID IN (SELECT ID FROM Driver) DO

  #      SET NewPosition = GetDriverPosition(D_ID);

   
  #      UPDATE Driver
  #      SET positionn = NewPosition
 #       WHERE ID = D_ID;
  #  END FOR;
#END //

#DELIMITER ;
