use formula1;

#Cartesian Product 
select C.car_ID as CarNumber, C.car_Version as CarVersion,A.datee as AccidentDate
from Car C, Accident A
where C.car_ID=A.car_ID and C.yearr=2021;

#Natural Join
select D.positionn as DriverPosition, D.namee as DriverName, R.race_Name  as RaceName
from Driver D natural join Participates P natural join Race R
where R.region like 'Asia' and D.positionn <=5;
 
#Theta Join On
select D.building_Number as BuildingNB, S.sponsor_Name as SponsorName, D.nb_of_Employees as NBofEmployees
from Department D join Sponsor S on(D.budget<=S.investment_Amount)
where D.team_ID=3
order by D.building_Number;

#Theta Join Using
select D.namee as DriverName, D.team_ID as TeamID, C.car_ID as CarNumber, R.race_Name as RaceName,S.points as Points
from Car C join Driver D using(car_ID) join Standings S on(D.ID=S.driver_ID) join Race R using(race_ID)
where (C.car_Version like '% W12%' or C.car_Version like '%RB16B') and R.region = 'Middle East';

#Self Join
#select parts_ID
#from Car_Parts
#where part_Name like 'engine' and versionn like 'V6'
#except
#select C1.parts_ID
#from Car_Parts C1, Car_Parts C2
#where C1.parts_ID!=C2.parts_ID and C1.health<C2.health and C1.versionn=C2.versionn and part_Name like 'engine' and versionn like 'V6' ;

#Distinct
select distinct M.namee as MechanicName, levell as MechanicLevel, C.car_Version
from Fixes natural join Mechanic M natural join Car C
where  C.car_Version like '% W12%';

#Like
select distinct T.team_Name as TeamName, R.race_Name as RaceName, R.datee as RaceDate
from Race R natural join Participates P natural join Driver D natural join Team T
where R.circuit_Name like '%Silverstone%' ;

#Order By
select D.positionn as DriverPosition, D.namee as DriverName, C.car_ID as CarNumber
from Driver D natural join Car C
where D.nationality='British' or D.nationality='French'
order by D.positionn;

#Union
select parts_ID as PartsID
from Car_Parts
where part_Name like 'Chassis' and versionn like 'V5'
union
select parts_ID as PartsID
from Car_Parts
where part_Name like 'Engine' and versionn like 'V5';

#Intersect

#select parts_ID
#from Car_Parts CP natural join Damages D natural join Car C
#where CP.part_Name like 'Sidepod' and versionn like 'V3' and C.car_ID=3 or C.car_ID=4  and health>=70
#intersect
#select parts_ID
#from Car_Parts CP natural join Damages D natural join Car C
#where CP.part_Name like 'Chassis' and versionn like 'V3' and C.car_ID=3 or C.car_ID=4 and health>=70;

#Except

#select Sponsor_ID
#from Sponsor
#where true
#except
#select S1.Sponsor_ID
#from Sponsor S1 natural join Sponsor S2
#where (S1.contract_End-S1.contract_Start)<(S2.contract_End-S2.contract_Start);

#Aggregate function without Group By
select D.positionn as DriverPosition,D.namee as DriverName, D.dob as DriverDOB
from Driver D natural join Car C
where  C.yearr=2021 and D.dob=(select min(dob)
			  from Driver
			  where positionn between 1 and 3)
	   or D.dob=(select max(dob)
				 from Driver
                 where positionn between 1 and 3);
 

#Aggregate function with Group By
select D.typee as DepartmentType, max(D.budget) as DepartmentBudget
from Department D 
where D.nb_of_Employees>150
group by D.typee;

#Aggregate function with Group By and Having
select T.team_Name as TeamID, min(D.contract_End) as DriversContractEnd
from Team T join Driver D using (team_ID)
group by T.team_Name
having avg(D.positionn)<10;